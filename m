From: Martin Dausel <dauselm@idmt.fraunhofer.de>
Subject: hdsp: output fader control via command line
Date: Mon, 19 Jan 2004 10:38:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400BA58C.3050400@idmt.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
<title></title>
Hello,<br>
i want to initialize my hdsp 9652 at startup to unmute the outputs
without using hdspmixer. <br>
<br>
Before the output fader controls were removed from the alsa control
interface i used this script:<br>
<br>
********************************************************<br>
<blockquote>#!/bin/bash<br>
&nbsp;<br>
i=0<br>
j=0<br>
count=26<br>
count2=52<br>
until [ $i -gt $count ]; do<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; # inner loop delete all routing<br>
&nbsp;&nbsp;&nbsp; j=0<br>
&nbsp;&nbsp;&nbsp; until [ $j -gt $count2 ]; do<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amixer cset numid=5 $j,$i,0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j=`expr $j + 1`<br>
&nbsp;&nbsp;&nbsp; done<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; # set default routing software output n routes to hardware output n<br>
&nbsp;&nbsp;&nbsp; amixer cset numid=5 `expr $i + 26`,$i,32768<br>
&nbsp;&nbsp;&nbsp; i=`expr $i + 1`<br>
  <br>
&nbsp;&nbsp;&nbsp; # set ouput faders to 0dB<br>
&nbsp;&nbsp;&nbsp; amixer cset iface=MIXER,name='Chn',index=$i 32768<br>
done<br>
</blockquote>
**********************************************************<br>
<br>
Using the current alsa driver i can't use the line "amixer cset
iface=MIXER,name='Chn',index=$i 32768".<br>
Is there any alternative (excluding hdspmixer)?<br>
<br>
It would be very nice if there would be an parameter for the snd-hdsp
module to control if the ouptuts are muted or at 0dB ( in a way like
the "line_outs_monitor" parameter ).<br>
<br>
Is it possible to initialize the hdsp with a saved hdspmixer setting
without using hdspmixer or better said without running X.<br>
<br>
Thanks, Martin<br>
</body>
</html>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
