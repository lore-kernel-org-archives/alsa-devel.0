From: "Nambiar, Anil" <NambiarA@sharpsec.com>
Subject: Alsa-lib problem
Date: Tue, 9 Aug 2005 17:57:02 -0400
Message-ID: <6A09F73E2878E447BF6B87C43162C827021545A4@excwa1b2.sharpsec.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C59D2D.45D1A606"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C59D2D.45D1A606
Content-Type: text/plain

Hi,

            I am developing ALSA based sound driver for our arm based soc.
The driver is built as part of the kernel rather than as a loadable module.
If I run a simple wave player which has OSS based interface, it works fine.
Even mplayer works fine in OSS emulation mode. But if I run any native alsa
based player it gives error opening the device. For eg: running 'aplay -D
default demo.wav" give the following error: 

ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown PCM default

aplay: main:533: audio open error: No such file or directory

 

The /dev/snd/ looks like this:

drwxr-xr-x    2 root     root         4096 Aug  9  2005 .

drwxr-xr-x    6 root     root         4096 Aug  9  2005 ..

crw-rw-rw-    1 root     root     116,   0 Aug  9  2005 controlC0

crw-rw-rw-    1 root     root     116,  24 Aug  9  2005 pcmC0D0c

crw-rw-rw-    1 root     root     116,  16 Aug  9  2005 pcmC0D0p

crw-rw-rw-    1 root     root     116,   1 Aug  9  2005 seq

crw-rw-rw-    1 root     root     116,  33 Aug  9  2005 timer

 

            If I do "cat demo.wav > dev/snd/pcmC0D0p", it prints the 'open'
msg in my driver. So it seems like the devices I have created are able to
link to my driver. But using alsa-lib it doen't even print the 'open' msg in
the driver. So looks like Alsa-lib does not link to my driver. 

I would appreciate if someone could point and tell me if I'm missing
something as this is the first time I'm developing Alsa device driver. Do I
have to create any configuration files on the root file system? I'm using
the linux kernel 2.6.12.3 and the latest Alsa-lib 1.0.9. 

 

Thanks,

AniL


------_=_NextPart_001_01C59D2D.45D1A606
Content-Type: text/html

<html>

<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=US-ASCII">


<meta name=Generator content="Microsoft Word 10 (filtered)">

<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=EN-US link=blue vlink=purple>

<div class=Section1>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>Hi,</span></font></p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am
developing ALSA based sound driver for our arm based soc. The driver is built
as part of the kernel rather than as a loadable module. If I run a simple wave
player which has </span></font>OSS based interface, it works fine. Even mplayer
works fine in OSS emulation mode. But if I run any native alsa based player it gives
error opening the device. For eg: running 'aplay -D default demo.wav"
give the following error: </p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>ALSA lib pcm.c:2090:(snd_pcm_open_noupdate) Unknown PCM default</span></font></p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>aplay: main:533: audio open error: No such file or directory</span></font></p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>The /dev/snd/ looks like this:</span></font></p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>drwxr-xr-x&nbsp;&nbsp;&nbsp; 2 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
4096 </span></font>Aug&nbsp; 9&nbsp; 2005 .</p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>drwxr-xr-x&nbsp;&nbsp;&nbsp; 6 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
4096 </span></font>Aug&nbsp; 9&nbsp; 2005 ..</p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>crw-rw-rw-&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;
116,&nbsp;&nbsp; 0 </span></font>Aug&nbsp; 9&nbsp; 2005 controlC0</p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>crw-rw-rw-&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;
116,&nbsp; 24 </span></font>Aug&nbsp; 9&nbsp; 2005 pcmC0D0c</p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>crw-rw-rw-&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;
116,&nbsp; 16 </span></font>Aug&nbsp; 9&nbsp; 2005 pcmC0D0p</p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>crw-rw-rw-&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;
116,&nbsp;&nbsp; 1 </span></font>Aug&nbsp; 9&nbsp; 2005 seq</p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>crw-rw-rw-&nbsp;&nbsp;&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;
116,&nbsp; 33 </span></font>Aug&nbsp; 9&nbsp; 2005 timer</p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If I
do "cat demo.wav &gt; dev/snd/pcmC0D0p", it prints the 'open'
msg in my driver. So it seems like the devices I have created are able to link
to my driver. But using alsa-lib it doen't even print the 'open'
msg in the driver. So looks like Alsa-lib does not link to my driver. </span></font></p>

<p class=MsoNormal style='text-indent:.5in'><font size=3 face="Times New Roman"><span
style='font-size:12.0pt'>I would appreciate if someone could point and tell me
if I'm missing something as this is the first time I'm developing Alsa
device driver. Do I have to create any configuration files on the root file
system? I'm using the linux kernel 2.6.12.3 and the latest Alsa-lib 1.0.9.
</span></font></p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>&nbsp;</span></font></p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>Thanks,</span></font></p>

<p class=MsoNormal><font size=3 face="Times New Roman"><span style='font-size:
12.0pt'>AniL</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C59D2D.45D1A606--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
