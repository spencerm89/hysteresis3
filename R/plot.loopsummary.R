plot.loopsummary <- function (a,split.line=TRUE,xlim=NULL,ylim=NULL,putNumber=FALSE,values=NULL,main=NULL,show=NULL,...) {
  ti <- (1:101)*pi/50
  Input <- a$values["b.x","Estimate"]*cos(ti)+a$values["cx","Estimate"]
  if (a$extended.classical==FALSE) Output <- a$values["b.y","Estimate"]*cos(ti)^a$values["n","Estimate"]+a$values["retention","Estimate"]*sin(ti)^a$values["m","Estimate"]+a$values["cy","Estimate"]
  else Output <- sign(cos(ti))*a$values["b.y","Estimate"]*abs(cos(ti))^a$values["n","Estimate"]+a$values["retention","Estimate"]*sin(ti)^a$values["m","Estimate"]+a$values["cy","Estimate"]
  if (is.null(xlim)) xlim <-c(min(c(a$x,Input)),max(c(a$x,Input)))
  if (is.null(ylim)) ylim <- c(min(c(a$y,Output)),max(c(a$y,Output)))                           
  if (is.null(values)) plot(Output~Input,type="l",ylim=ylim,xlim=xlim,main=main,...)
  else {
    if (values=="inherent") {
      plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
      title(line=3, paste(main),cex=1.2)
      mtext(paste(
        "b.x=",format(a$values["b.x","Estimate"],digits=3)," b.y=",format(a$values["b.y","Estimate"],digits=3)),side=3,line=1.85,cex=0.75)
      mtext(paste("cx=",format(a$values["cx","Estimate"],digits=3)," cy=",format(a$values["cy","Estimate"],digits=3)),side=3,line=0.95,cex=0.75)
      mtext(paste("Retention=",format(a$values["retention","Estimate"],digits=3)),side=3,line=0.0,cex=0.75)
    }
    
    if (values=="hysteresis") {
      plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
      title(line=3, paste(main),cex=1.2)
      mtext(paste(
        "b.x=",format(a$values["b.x","Estimate"],digits=3)," b.y=",format(a$values["b.y","Estimate"],digits=3)," cx=",format(a$values["cx","Estimate"],digits=3)),side=3,line=1.85,cex=0.75)
      mtext(paste("cy=",format(a$values["cy","Estimate"],digits=3)," Area=",format(a$values["area","Estimate"],digits=3)," Lag=",format(a$values["lag","Estimate"],digits=3)),side=3,line=0.95,cex=0.75)
      mtext(paste("Retention=",format(a$values["retention","Estimate"],digits=3)," Coercion=",format(a$values["coercion","Estimate"],digits=3)),side=3,line=0.0,cex=0.75)
    }
    
    if (values=="hysteresis.all") {
      plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
      title(line=3, paste(main),cex=1.2)
      mtext(paste(
        "b.x=",format(a$values["b.x","Estimate"],digits=3)," b.y=",format(a$values["b.y","Estimate"],digits=3)," cx=",format(a$values["cx","Estimate"],digits=3)," cy=",format(a$values["cy","Estimate"],digits=3)),side=3,line=1.85,cex=0.75)
      mtext(paste("Area=",format(a$values["area","Estimate"],digits=3)," Lag=",format(a$values["lag","Estimate"],digits=3)," Retention=",format(a$values["retention","Estimate"],digits=3)," Split Angle=",format(a$values["split.angle","Estimate"],digits=3)),side=3,line=0.95,cex=0.75)
      mtext(paste("Coercion=",format(a$values["coercion","Estimate"],digits=3)," Hysteresis x=",format(a$values["hysteresis.x","Estimate"],digits=3)," Hysteresis y=",format(a$values["hysteresis.y","Estimate"],digits=3)),side=3,line=0.0,cex=0.75)
    }
  
  if (values=="derived") {
    plot(Output~Input,type="l",ylim=ylim,xlim=xlim,...)
    title(line=3, paste(main),cex=1.2)
    mtext(paste(
      "Coercion=",format(a$values["coercion","Estimate"],digits=3)," Area=",format(a$values["area","Estimate"],digits=3)),side=3,line=1.85,cex=0.75)
    mtext(paste("Lag=",format(a$values["lag","Estimate"],digits=3)," Split Angle=",format(a$values["split.angle","Estimate"],digits=3)),side=3,line=0.95,cex=0.75)
    mtext(paste("Hysteresis x=",format(a$values["hysteresis.x","Estimate"],digits=3)," Hysteresis y=",format(a$values["hysteresis.y","Estimate"],digits=3)),side=3,line=0.0,cex=0.75)
  }
  }
  
  if (any(show %in% c("b.x","b.y"))) segments(a$values["cx","Estimate"],a$values["cy","Estimate"],a$values["cx","Estimate"]+a$values["b.x","Estimate"],a$values["cy","Estimate"]+a$values["b.y","Estimate"],col="blue")
  if (any(show=="retention")) segments(a$values["cx","Estimate"],a$values["cy","Estimate"],a$values["cx","Estimate"],a$values["cy","Estimate"]+a$values["retention","Estimate"],col="purple")
  if (any(show=="coercion")) segments(a$values["cx","Estimate"],a$values["cy","Estimate"],a$values["cx","Estimate"]+a$values["coercion","Estimate"],a$values["cy","Estimate"],col="green")
  
  
  points(a$y~a$x,pch=1,cex=0.85)
  if (split.line==TRUE) {
  if (a$extended.classical==FALSE) split.line <- a$values["b.y","Estimate"]*cos(ti)^a$values["n","Estimate"]+a$values["cy","Estimate"]
  else split.line <- sign(cos(ti))*a$values["b.y","Estimate"]*abs(cos(ti))^a$values["n","Estimate"]+a$values["cy","Estimate"]
  lines(Input,split.line,lty=2)}
  if(putNumber==TRUE) text(a$x,a$y,as.character(format(1:length(a$y),digits=4)))
}