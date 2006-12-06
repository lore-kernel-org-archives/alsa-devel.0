From: Sound4 - Camille Gonnet <camille@sound4.biz>
Subject: Creating a new hardware
Date: Wed, 06 Dec 2006 13:00:59 +0100
Message-ID: <4576B0FB.6060402@sound4.biz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0985296884=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0985296884==
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Times New Roman, Times, serif">Hello,<br>
<br>
If this is not the right place to send these questions, please tell me
where I should ask !<br>
<br>
I'm creating a company in the sound processing domain. It is for a very
specific domain : audio broadcasting (radio FM, AM, TV, internet radio,
...).<br>
The hardware is ready, but I need to finish my programmable logic
inside the board.<br>
This card will be able to playback and capture, but this is not only a
standard audio board, there is a huge DSP processing inside, and the
card can work from connectors audio input/outputs without PCI access at
all.<br>
<br>
I made my own pci driver to access my DSP, and everything worked fine.<br>
Now I am working on the ALSA driver, but I didn't understand
everything, and it doesn't work.<br>
I don't know which way I should take ! Like vx222 (interrupt manual
copy) or like rme9652 (.copy operator) ?<br>
As I need to fix my hardware, I would like to make it correct for ALSA.<br>
Here is how it works for the moment, and how I would like to let it !<br>
<br>
I have 2 buffers for playback and 2 for capture. They work in the same
way.<br>
The 4 are mapped on the same address range.<br>
We can write only on an empty buffer for playback, and read from a
ready buffer for capture.<br>
Buffers are toggled automatically (double-buffering) : <br>
&nbsp;&nbsp;&nbsp; - one hidden sending audio playback , the other for filling thru
PCI the playback buffer,<br>
&nbsp;&nbsp;&nbsp; - one hidden&nbsp; receiving audio for capture, the other for reading
thru PCI the capture buffer.<br>
An interrupt is generated (and stays active) when there is at least one
free buffer for playback.<br>
</font><font face="Times New Roman, Times, serif">An interrupt is
generated (and stays active) when there is at least one ready buffer
for capture.<br>
I also have a sticky flag to know if playback has underrun or capture
has overrun.<br>
</font><font face="Times New Roman, Times, serif">Buffers are very
small (85 samples stereo 24 bits on three bytes), and a buffer is
considered <br>
&nbsp;&nbsp;&nbsp; - not empty for playback (ie can be send) when last position is
written<br>
&nbsp;&nbsp;&nbsp; - not ready for capture (ie can be recorded) when last position is
read<br>
Buffers are pci resource ioremapped.<br>
I don't have pointer of current hardware position, but I could add one
if necessary.<br>
<br>
I didn't find informations or forums to help me and I don't know where
to search. I am pretty new in Linux development.<br>
Please help me to make my board efficient with ALSA.<br>
<br>
Thanks a lot for your help,<br>
<br>
<br>
Camille Gonnet<br>
Hardware developper, DSP programmer &amp; driver writer.<br>
<a href="http://www.sound4.biz">http://www.sound4.biz</a><br>
<br>
</font>
</body>
</html>


--===============0985296884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0985296884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0985296884==--
