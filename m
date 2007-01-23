From: "marion rundell" <mrundell@gmail.com>
Subject: Re: Does Linux 2.4.x.x support spdif out by way of
	either pcmcia (card...not bus) or USB 1.1
Date: Tue, 23 Jan 2007 12:26:31 -0600
Message-ID: <002301c73f1c$02298c60$2301a8c0@clpp.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1839272048=="
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

This is a multi-part message in MIME format.

--===============1839272048==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0020_01C73EE9.B64CFF70"

This is a multi-part message in MIME format.

------=_NextPart_000_0020_01C73EE9.B64CFF70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am using an Aaeon AEC6820, embedded system, with USB 1.1 out (or the =
option of a pcmcia card (not bus)).  I am trying to get spdif out to =
send to an audio receiver...or to an M-Audio device to covert the signal =
to spdif.  I am using Linux 2.4.x.x and don't know if it supports spdif. =
 We are able to get analog out, and optical (with jitter) out.  The =
spdif conversion in the M-Audio device has popping, sometimes no sound, =
etc.  The chipset is supported...but I don't know if it will output =
spdif...at least I don't know how to write the driver to do so.

The chipset is  VT82C686B.

On a new XP system with USB 2 out, I can get spdif by changing the bit =
rate to 24 instead of 16, and by cutting off one of the analog signals.  =
This seems to be a bandwidth problem to me.

1.   We know drivers for the M-audio work (we have analog).

2.  We know they output digital optical, and we know that their USB 1.1 =
outputs a signal that is converted in the M-Audio (Audiophile USB) to =
analog. =20

3.  By turning off one of the analog signals in Windows XP, we are able =
to select 24 bit and SPDIF works. =20

What I am looking for is a mechanism to program to cut off the M Audio =
analog driver for either analog in or analog out, cut ON the 24 bit rate =
sampling and voila...SPDIF should work.  This seems pretty simple to me, =
after I read your patch for M-Audio on the Linux platform.  They won't =
let me work on it because of their "secret" information within.  It is a =
relatively new method of using a computer based music system for =
them...so they do not want to give out their administrative password or =
username to allow me to go in and try to change the drivers.  They must =
do it, or the answer is no. =20

I want to provide them with as much information as possible to be sure =
they do fix the problem.  I cannot imagine that I am the only person =
complaining of have a really nice sounding piano...with terrible =
accompanying instruments. They have even admitted that they are getting =
this request more and more frequently.  They are just NOT motivated to =
do anything. If I can give them the way to get this to work, they will =
use it. =20

They are not interested in writing the patch to make this work...I know =
it will work...this is what is so frustrating for me...I can't get in to =
try it, they are not motivated to do it, yet I know it will work.

Please let me know if you have any suggestions, and thank you again for =
your reply.

Marion=20
mrundell@gmail.com


------=_NextPart_000_0020_01C73EE9.B64CFF70
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial>I am using an Aaeon AEC6820, embedded system, =
with USB 1.1=20
out (or the option of a pcmcia card (not bus)).&nbsp; I am trying to get =
spdif=20
out to send to an audio receiver...or to an M-Audio device to covert the =
signal=20
to spdif.&nbsp; I am using Linux 2.4.x.x and don't know if it supports=20
spdif.&nbsp; We are able to get analog out, and optical (with jitter) =
out.&nbsp;=20
The spdif conversion in the M-Audio device has popping, sometimes no =
sound,=20
etc.&nbsp; The chipset is supported...but I don't know if it =
will&nbsp;output=20
spdif...at least I don't know how to write the driver to do =
so.</FONT></DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial>The chipset is&nbsp;&nbsp;<FONT=20
color=3D#000080>VT82C686B.</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>On a new XP system with USB 2 out, I can get spdif by changing the =
bit rate=20
to 24 instead of 16, and by cutting off one of the analog signals.&nbsp; =
This=20
seems to be a bandwidth problem to me.</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>1.&nbsp;&nbsp; We know drivers for the =
M-audio work=20
(we have analog).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>2.&nbsp; We know they output digital =
optical, and=20
we know that their USB 1.1 outputs a signal that is converted in the =
M-Audio=20
(Audiophile USB) to analog.&nbsp; </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>3.&nbsp; By turning off one of the =
analog signals=20
in Windows XP, we are able to select 24 bit and SPDIF works.&nbsp; =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>What I am looking for is a mechanism to =
program to=20
cut off the M Audio analog driver for either analog in or analog out, =
cut ON the=20
24 bit rate sampling and voila...SPDIF should work.&nbsp; =
This&nbsp;seems pretty=20
simple to me, after I read your patch for M-Audio&nbsp;on the&nbsp;Linux =

platform.&nbsp; They won't let me work on it because of their "secret"=20
information within.&nbsp; It is a relatively new method of using a =
computer=20
based music system for them...so they do not want to give out their=20
administrative password or username to allow me to go in and try to =
change the=20
drivers.&nbsp; They must do it, or the answer is no.&nbsp; </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I want to provide them with as much =
information as=20
possible to be sure they do fix the problem.&nbsp; I cannot imagine that =
I am=20
the only person complaining of have a really nice sounding piano...with =
terrible=20
accompanying instruments. They have even admitted that they are getting =
this=20
request more and more frequently.&nbsp; They are just NOT motivated to =
do=20
anything. If I can give them the way to get this to work, they will use=20
it.&nbsp; </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>They are not interested in writing the =
patch to=20
make this work...I know it will work...this is what is so frustrating =
for me...I=20
can't get in to try it, they are not motivated to do it, yet I know it =
will=20
work.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Please let me know if you have any =
suggestions, and=20
thank you again for your reply.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Marion</FONT>&nbsp;</DIV>
<DIV><A =
href=3D"mailto:mrundell@gmail.com">mrundell@gmail.com</A><BR></DIV>
<DIV></FONT><FONT face=3DArial =
size=3D2></FONT>&nbsp;</DIV></DIV></BODY></HTML>

------=_NextPart_000_0020_01C73EE9.B64CFF70--



--===============1839272048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1839272048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1839272048==--
