From: Andreas Hubmer <andreas@hubmer.at>
Subject: Re: USB Audio Device: Philips Audio Set
Date: Tue, 27 Feb 2007 19:06:13 +0100
Message-ID: <45E47315.1040602@hubmer.at>
References: <45E42E88.9080403@hubmer.at>
	<1172597266.6053.1176801163@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0187412443=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1172597266.6053.1176801163@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--===============0187412443==
Content-Type: multipart/alternative;
	boundary="------------020102060802050901010302"

This is a multi-part message in MIME format.
--------------020102060802050901010302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Clemens Ladisch schrieb am 2007-02-27 18:27:
> Andreas Hubmer wrote:
>   
>> I have a Philips mini hifi-system named "Philips FWM589" that can be
>> used as an usb sound card. It is recognized as USB Audio device but I'm
>> not able to get it to work.
>> The module snd-usb-audio is loaded and in gnome a message pops up that a
>> new audio device was found. In the gnome audio preferences a new device
>> "USB Audio" is shown but the test sound doesn't work.
>>     
>
> Many USB audio devices have strange or non-standard mixer controls.
> Please show the output of "amixer -c 1 contents".
>   
numid=3,iface=MIXER,name='Tone Control - Bass'
  ; type=INTEGER,access=rw---,values=1,min=0,max=48,step=0
  : values=24
numid=4,iface=MIXER,name='Tone Control - Treble'
  ; type=INTEGER,access=rw---,values=1,min=0,max=48,step=0
  : values=24
numid=1,iface=MIXER,name='PCM Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=2,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=656,step=0
  : values=656,656
numid=7,iface=MIXER,name='PCM Capture Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=8,iface=MIXER,name='PCM Capture Volume'
  ; type=INTEGER,access=rw---,values=1,min=0,max=15,step=0
  : values=12
numid=5,iface=MIXER,name='Auto Gain Control'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=6,iface=MIXER,name='Bass Boost'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off

> Regards,
> Clemens
>   
Regards,
Andreas

--------------020102060802050901010302
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Clemens Ladisch schrieb am 2007-02-27 18:27:
<blockquote
 cite="mid1172597266.6053.1176801163@webmail.messagingengine.com"
 type="cite">
  <pre wrap="">Andreas Hubmer wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have a Philips mini hifi-system named "Philips FWM589" that can be
used as an usb sound card. It is recognized as USB Audio device but I'm
not able to get it to work.
The module snd-usb-audio is loaded and in gnome a message pops up that a
new audio device was found. In the gnome audio preferences a new device
"USB Audio" is shown but the test sound doesn't work.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Many USB audio devices have strange or non-standard mixer controls.
Please show the output of "amixer -c 1 contents".
  </pre>
</blockquote>
numid=3,iface=MIXER,name='Tone Control - Bass'<br>
&nbsp; ; type=INTEGER,access=rw---,values=1,min=0,max=48,step=0<br>
&nbsp; : values=24<br>
numid=4,iface=MIXER,name='Tone Control - Treble'<br>
&nbsp; ; type=INTEGER,access=rw---,values=1,min=0,max=48,step=0<br>
&nbsp; : values=24<br>
numid=1,iface=MIXER,name='PCM Playback Switch'<br>
&nbsp; ; type=BOOLEAN,access=rw---,values=1<br>
&nbsp; : values=on<br>
numid=2,iface=MIXER,name='PCM Playback Volume'<br>
&nbsp; ; type=INTEGER,access=rw---,values=2,min=0,max=656,step=0<br>
&nbsp; : values=656,656<br>
numid=7,iface=MIXER,name='PCM Capture Switch'<br>
&nbsp; ; type=BOOLEAN,access=rw---,values=1<br>
&nbsp; : values=on<br>
numid=8,iface=MIXER,name='PCM Capture Volume'<br>
&nbsp; ; type=INTEGER,access=rw---,values=1,min=0,max=15,step=0<br>
&nbsp; : values=12<br>
numid=5,iface=MIXER,name='Auto Gain Control'<br>
&nbsp; ; type=BOOLEAN,access=rw---,values=1<br>
&nbsp; : values=off<br>
numid=6,iface=MIXER,name='Bass Boost'<br>
&nbsp; ; type=BOOLEAN,access=rw---,values=1<br>
&nbsp; : values=off<br>
<br>
<blockquote
 cite="mid1172597266.6053.1176801163@webmail.messagingengine.com"
 type="cite">
  <pre wrap="">Regards,
Clemens
  </pre>
</blockquote>
Regards,<br>
Andreas<br>
</body>
</html>

--------------020102060802050901010302--


--===============0187412443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0187412443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0187412443==--
