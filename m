From: "Steve DeRosier" <derosier@pianodisc.com>
Subject: RE: Setting up Alsa by hand on an embedded system
Date: Wed, 21 Dec 2005 18:47:02 -0800
Message-ID: <DB99F0250CDF5F438C525F4695C888DC0DA00F@exchange01-srv.pianodisc.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C606A1.FC93D750"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Smoot <davidsmoot@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C606A1.FC93D750
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Try an asound.conf file in /etc
=20
To start, I'd try:=20
---cutline---
default
{
  type hw
  card 0
  device 0=20
}
---cutline---
=20
But, you'll need it to match your specs.  Examine /proc/asound for your =
particular card and device params.  Also, refer to the asound.conf =
instructions on the website.  I'm not an asound.conf expert so ask again =
after experimenting, if you still can't get it to work.
=20
- Steve

-----Original Message-----
From: David Smoot [mailto:davidsmoot@gmail.com]
Sent: Wednesday, December 21, 2005 5:36 PM
To: alsa-devel@lists.sourceforge.net
Subject: [Alsa-devel] Setting up Alsa by hand on an embedded system


OK, I tried this question about a month ago but I did not make it clear =
I think.

I need to add the ability to record and playback audio on the embedded =
linux platform my company uses.  Being embedded, I do not have a full =
Linux distribution.  I have to set up ALSA by hand.  I can't simply =
untar the alsa package and do ./configure followed by make.=20

Here's what I have done so far:
Rebuilt the kernel to have support for alsa and my chipset (an Intel =
ICH5 that uses the AC97 codec).
added the /dev/snd/ device nodes (I skipped the midi nodes because I do =
not need them=20
copied libasound.so.2.0.0. from my host development box to the lib path =
on my embedded box.  I added all the symlinks pointing to this library.

So I started by compiling some of the simple test programs, specifically =
the ones from the LinuxJournal article on ALSA ( =
http://www.linuxjournal.com/article/6735).  The 4 sample programs run =
just fine on my host system.  On my embedded system the command to open =
the PCM device fails with:=20
ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default
unable to open pcm device: No such file or directory

So I changed device name in the code from "default" to "plug:0,0" and it =
still fails with the same message (but reads "plug:0,0" instead of =
default).=20

So what am I doing wrong?  Do I need a configuration file somewhere?  Do =
I need to use a different argument for the PCM open?  Any suggestions?
David




------_=_NextPart_001_01C606A1.FC93D750
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META content=3D"MSHTML 6.00.3790.218" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =
size=3D2>Try an=20
asound.conf file in /etc</FONT></SPAN></DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =
size=3D2>To=20
start, I'd try: </FONT></SPAN></DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =

size=3D2>---cutline---</FONT></SPAN></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><FONT color=3D#0000ff><SPAN=20
class=3D937134102-22122005>d</SPAN><SPAN=20
class=3D937134102-22122005>efault</SPAN></FONT></FONT></FONT></DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =

size=3D2>{</FONT></SPAN></DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =
size=3D2>&nbsp;=20
type hw</FONT></SPAN></DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =
size=3D2>&nbsp;=20
card 0</FONT></SPAN></DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =
size=3D2>&nbsp;=20
device 0 </FONT></SPAN></DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =

size=3D2>}</FONT></SPAN></DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =

size=3D2>---cutline---</FONT></SPAN></DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =
size=3D2>But,=20
you'll need it to match your specs.&nbsp; Examine /proc/asound for your=20
particular card and device params.&nbsp; Also, refer to the asound.conf=20
instructions on the website.&nbsp; I'm not an asound.conf expert so ask =
again=20
after experimenting, if you still can't get it to =
work.</FONT></SPAN></DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D937134102-22122005><FONT face=3DArial color=3D#0000ff =
size=3D2>-=20
Steve</FONT></SPAN></DIV>
<BLOCKQUOTE>
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> David Smoot=20
  [mailto:davidsmoot@gmail.com]<BR><B>Sent:</B> Wednesday, December 21, =
2005=20
  5:36 PM<BR><B>To:</B> =
alsa-devel@lists.sourceforge.net<BR><B>Subject:</B>=20
  [Alsa-devel] Setting up Alsa by hand on an embedded=20
  system<BR><BR></FONT></DIV>OK, I tried this question about a month ago =
but I=20
  did not make it clear I think.<BR><BR>I need to add the ability to =
record and=20
  playback audio on the embedded linux platform my company uses.&nbsp; =
Being=20
  embedded, I do not have a full Linux distribution.&nbsp; I have to set =
up ALSA=20
  by hand.&nbsp; I can't simply untar the alsa package and do =
./configure=20
  followed by make. <BR><BR>Here's what I have done so far:<BR>Rebuilt =
the=20
  kernel to have support for alsa and my chipset (an Intel ICH5 that =
uses the=20
  AC97 codec).<BR>added the /dev/snd/ device nodes (I skipped the midi =
nodes=20
  because I do not need them <BR>copied libasound.so.2.0.0. from my host =

  development box to the lib path on my embedded box.&nbsp; I added all =
the=20
  symlinks pointing to this library.<BR><BR>So I started by compiling =
some of=20
  the simple test programs, specifically the ones from the LinuxJournal =
article=20
  on ALSA ( <A=20
  =
href=3D"http://www.linuxjournal.com/article/6735">http://www.linuxjournal=
.com/article/6735</A>).&nbsp;=20
  The 4 sample programs run just fine on my host system.&nbsp; On my =
embedded=20
  system the command to open the PCM device fails with: <BR>ALSA lib=20
  pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default<BR>unable to =
open pcm=20
  device: No such file or directory<BR><BR>So I changed device name in =
the code=20
  from "default" to "plug:0,0" and it still fails with the same message =
(but=20
  reads "plug:0,0" instead of default). <BR><BR>So what am I doing =
wrong?&nbsp;=20
  Do I need a configuration file somewhere?&nbsp; Do I need to use a =
different=20
  argument for the PCM open?&nbsp; Any=20
suggestions?<BR>David<BR><BR></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C606A1.FC93D750--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
