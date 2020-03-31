# Random Forest Classification

# Importing the dataset
dataset = read.csv('MedSchoolAdmit.csv')

# Encoding categorical variables
library(mltools)
library(data.table)
dataset_1h <- one_hot(as.data.table(dataset))
dataset_1h = dataset_1h[, 1:11]

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset_1h$AppStatus_A, SplitRatio = 0.75)
training_set = subset(dataset_1h, split == TRUE)
test_set = subset(dataset_1h, split == FALSE)

# Feature Scaling
training_set[, 3] = scale(training_set[, 3])
training_set[, 4] = scale(training_set[, 4])
training_set[, 5] = scale(training_set[, 5])
training_set[, 6] = scale(training_set[, 6])
training_set[, 7] = scale(training_set[, 7])
training_set[, 8] = scale(training_set[, 8])
training_set[, 9] = scale(training_set[, 9])
training_set[, 10] = scale(training_set[, 10])

test_set[, 3] = scale(test_set[, 3])
test_set[, 4] = scale(test_set[, 4])
test_set[, 5] = scale(test_set[, 5])
test_set[, 6] = scale(test_set[, 6])
test_set[, 7] = scale(test_set[, 7])
test_set[, 8] = scale(test_set[, 8])
test_set[, 9] = scale(test_set[, 9])
test_set[, 10] = scale(test_set[, 10])

# Fitting the Classification to the Traning Set 
#install.packages('randomForest')
library(randomForest)
classifier = randomForest(x=training_set[, -11], y=training_set$AppStatus_A, ntree=100)

# Predicting the Test set Results 
y_pred = predict(classifier, newdata = test_set[, -11])
y_pred = data.frame(y_pred)
y_pred = apply(y_pred, 1, function(x) ifelse(x > .5, 1, x))
y_pred = data.frame(y_pred)
y_pred = apply(y_pred, 1, function(x) ifelse(x <= .5, 0, x))
y_pred = data.frame(y_pred)

# Making confusion matrix
cm = table(test_set[,11], y_pred)
