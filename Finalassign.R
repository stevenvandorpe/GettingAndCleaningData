library(plyr)
library(data.table)
testdata <- file('UCI HAR Dataset/test/X_test.txt', open='r')
traindata <- file('UCI HAR Dataset/train/X_train.txt', open='r')
testdatay <- file('UCI HAR Dataset/test/y_test.txt', open='r')
traindatay <- file('UCI HAR Dataset/train/y_train.txt', open='r')
testtable1 <- read.table(testdata, header=FALSE)
traintable1 <- read.table(traindata, header=FALSE)
testtable2 <- read.table(testdatay, header=FALSE)
traintable2 <- read.table(traindatay, header=FALSE)
testtable2[testtable2==1] <- "WALKING"
testtable2[testtable2==2] <- "JUMP"
testtable2[testtable2==3] <- "DROWN"
testtable2[testtable2==4] <- "DIE"
testtable2[testtable2==5] <- "FLY"
testtable2[testtable2==6] <- "RUSH"
traintable2[traintable2==1] <- "WALKING"
traintable2[traintable2==2] <- "JUMP"
traintable2[traintable2==3] <- "DROWN"
traintable2[traintable2==4] <- "DIE"
traintable2[traintable2==5] <- "FLY"
traintable2[traintable2==6] <- "RUSH"


testtable1 <- cbind(testtable2,testtable1)
traintable1 <- cbind(traintable2, traintable1)

testtable <- data.frame(testtable1)
traintable <- data.frame(traintable1)
close(testdata)
close(traindata)
close(testdatay)
close(traindatay)
finalframe <- rbind(testtable, traintable)
finalframe <- finalframe[,1:5]
#finalframe <- rename(finalframe, Activity=V1, Mean1=V1.1, Mean2=V1.2)
colnames(finalframe) <- c("ACTIVITY","MEAN1","MEAN2","std1","std2")
library(reshape2); 
finalframe <- data.table(finalframe)
print(finalframe[1:20,])
overview <- finalframe[,list(mean(MEAN1 + MEAN2),mean(std1+std2)),by="ACTIVITY"]
colnames(overview) <- c("ACTIVITY","MEANMEAN", "MEANSTD")
print(overview)
                 