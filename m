From: "marion rundell" <mrundell@gmail.com>
Subject: Re: Need help with Audio out from an Embedded
	system...Linux 2.4.
Date: Wed, 24 Jan 2007 07:20:18 -0600
Message-ID: <00b401c73fba$65801bf0$1402a8c0@pcc41100>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2041067163=="
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

--===============2041067163==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00B1_01C73F88.19AC68A0"

This is a multi-part message in MIME format.

------=_NextPart_000_00B1_01C73F88.19AC68A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I am new to this forum and new to Linux, so please forgive mistakes I =
might make in the following explanation of what I am trying to obtain.

My goal is to have COAX SPDIF out of an embedded unit, or a USB digital =
signal that will output to an M-Audio Audiophile USB (or other =
intermediate device) which can then send COAX SPDIF to an audio =
receiver.

I am using an Aaeon AEC6820, embedded system, with USB 1.1 out (or the =
option of a pcmcia card (not bus)).  The Chipset in this device is the =
VT82C686B

I am trying to get COAX SPDIF out from this system either by using an =
external USB device (Audiophile USB by M-audio or other device) or by =
internal SPDIF out.

I am using Linux 2.4, and I have read that Linux 2.4 was certainly =
supporting SPDIF for some devices.  The question I have is will Linux =
2.4 support COAX SPDIF  for the M-Audio.  If not, what device could I =
use to get  COAX SPDIF out?  So far, from the M-audio we cannot get =
clean sound out...it pops and sputters and sometimes doesn't put sound =
out at all.=20

Using the M-audio device connected to a USB 1.1 port, we are able to =
hear clean analog sound, although not as good as we would expect from =
SPDIF from the external device...like the M-Audio Audiophile USB.  =
Digital optical can be delivered by the AEC6820 from a USB 1.1 =
port...but has a lot of jitter.

I would like to know if I can get the embedded device with the  =
VT82C686B to output by USB 1.1 or pcmcia card (not bus) to the M-Audio =
Audiophile USB device  to get clean SPDIF out of the M-Audio device to =
an audio receiver.

I want COAX SPDIF out of an embedded Linux system (either directly or =
through an output that can be converted by an external M-Audio =
Audiophile USB or other device).  I do not manage the embedded system, I =
am not an admin but I can access the system to change the driver =
information or add a patch as necessary. This embedded system is based =
on a Linux 2.4.x.x operating system.

This is what I know:

1.  Direct optical out of the embedded system (AEC6820) works but the =
sound is full of jitter.

2.  USB 1.1 out of the embedded system (AEC6820) will send a signal to =
the M-audio Audiophile USB...but the sound is not stable (although =
sometimes it works).

If this chipset based on a Linux 2.4 platform will not output a COAX =
SPDIF...by way of a pcmcia card or USB 1.1, or output a signal that can =
be converted by the M-audio Audiophile USB to COAX SPDIF, I am thinking =
of trying to upgrade the embedded system from the AEC6820 to an AEC6830 =
on the same Linux 2.4 platform.  The upgraded box does have a direct =
SPDIF jack out. =20
The chipset in the upgraded box is the following:

The AEC-6830 is inside CPU board(GENE-6350) which uses the ALC650 =
chipset for audio and SPDIF function.=20


The manufacturer of both boxes does not support Linux, so they don't =
know if I can get SPDIF to work from the AEC6820 using the VT82C686B.  =
And they don't know if I can get  Linux 2.4 to work on the AEC-6830. =20

In summary I would like to know the following:

1.  Is there a way to get the older VT82C686B chipset to work better?

2.  If I upgrade to the new AEC6830 (chipset ALC650), would it be =
supported on a Linux 2.4 platform (or will I have to try to recompile to =
a newer version of Linux)?

3.  Is there any way to get stable sound out of the Audiophile USB (or =
some other intermediate device that would output COAX SPDIF) while not =
recompiling the kernel?=20

Thank you in advance for any assistance.

Marion
mrundell@gmail.com


------=_NextPart_000_00B1_01C73F88.19AC68A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.5730.11" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am new to this forum and new to =
Linux, so please=20
forgive mistakes I might make in the following explanation of what I am =
trying=20
to obtain.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My goal is to have COAX SPDIF out of an =
embedded=20
unit, or a USB digital signal that will output to an M-Audio Audiophile =
USB (or=20
other intermediate device) which can then send COAX SPDIF to an audio=20
receiver.<BR></FONT></DIV>
<DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2>I am using an Aaeon AEC6820, embedded =
system, with=20
USB 1.1 out (or the option of a pcmcia card (not bus)).&nbsp; The =
Chipset in=20
this device is the VT82C686B</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am trying to get COAX SPDIF out from =
this system=20
either by using an external USB device (Audiophile USB by M-audio or =
other=20
device) or by internal SPDIF out.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am using Linux 2.4, and I have read =
that Linux=20
2.4 was certainly supporting SPDIF for some devices.&nbsp; The question =
I have=20
is will Linux 2.4 support COAX SPDIF&nbsp; for the M-Audio.&nbsp; If =
not, what=20
device could I use to get&nbsp; COAX SPDIF out?&nbsp; So far, from the =
M-audio=20
we cannot get clean sound out...it pops and sputters and sometimes =
doesn't put=20
sound out at all.&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Using the M-audio device connected to a =
USB 1.1=20
port, we are able to hear clean analog sound, although not as good as we =
would=20
expect from SPDIF from the external device...like the M-Audio Audiophile =

USB.&nbsp; Digital optical can be delivered by the AEC6820 from a USB =
1.1=20
port...but has a lot of jitter.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I&nbsp;would like to know if I can get=20
the&nbsp;embedded device with the&nbsp;&nbsp;VT82C686B to output by USB =
1.1 or=20
pcmcia card&nbsp;(not bus)&nbsp;to the M-Audio Audiophile USB =
device&nbsp; to=20
get clean SPDIF out of the M-Audio device to an audio =
receiver.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D580365408-24012007>I&nbsp;want COAX=20
SPDIF out of an embedded Linux system (either directly&nbsp;or through =
an output=20
that can be converted by an external M-Audio&nbsp;Audiophile USB or =
other=20
device).&nbsp; I do not manage the embedded system, I am not an admin =
but I can=20
access the system to change the driver information or add a patch as =
necessary.=20
This embedded system is based on a Linux 2.4.x.x operating=20
system.</SPAN></FONT></DIV>
<DIV><FONT size=3D2><FONT face=3DArial><SPAN =
class=3D580365408-24012007></SPAN><SPAN=20
class=3D580365408-24012007></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D580365408-24012007>This =
is what I=20
know:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2><FONT face=3DArial><SPAN =
class=3D580365408-24012007>1.&nbsp;=20
</SPAN><SPAN class=3D580365408-24012007>Direct optical out of the =
embedded system=20
(AEC6820) works but the sound is full of =
jitter.</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D580365408-24012007>2.&nbsp; USB 1.1 out=20
of the embedded system (AEC6820)&nbsp;will send a signal to the M-audio=20
Audiophile USB...but the sound is not stable (although sometimes it=20
works).</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D580365408-24012007>If =
this chipset=20
based on a Linux 2.4 platform will not output a COAX SPDIF...by way of a =
pcmcia=20
card or USB 1.1, or output a signal that can be converted by the M-audio =

Audiophile USB to COAX SPDIF, I am thinking of trying to upgrade the =
embedded=20
system from the AEC6820 to an AEC6830 on the same Linux 2.4 =
platform.&nbsp; The=20
upgraded box does have a direct SPDIF jack out.&nbsp; =
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D580365408-24012007>The =
chipset in the=20
upgraded box is the following:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D580365408-24012007><FONT color=3D#000080><FONT =
size=3D2><FONT=20
face=3DArial><FONT color=3D#000000>The AEC-6830 is inside CPU =
board(GENE-6350) which=20
uses the ALC650 chipset for audio and SPDIF function.</FONT> =
<?xml:namespace=20
prefix =3D o ns =3D "urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></FONT></FONT></FONT>
<P class=3DMsoNormal></SPAN><FONT size=3D2><SPAN =
class=3D580365408-24012007><SPAN=20
lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: =
Arial"><o:p></o:p></SPAN></SPAN></FONT></P></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D580365408-24012007><FONT face=3DArial size=3D2>The =
manufacturer of=20
both boxes does not support Linux, so they don't know if I can get SPDIF =
to work=20
from the AEC6820 using the VT82C686B.&nbsp; And they don't know if I can =

get&nbsp; Linux 2.4 to work on the AEC-6830.&nbsp; </FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D580365408-24012007>In =
summary I would=20
like to know the following:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D580365408-24012007>1.&nbsp; Is there a=20
way to get the older VT82C686B chipset to work =
better?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D580365408-24012007>2.&nbsp; If I=20
upgrade to the new AEC6830 (chipset ALC650), would it be supported on a =
Linux=20
2.4 platform (or will I have to try to recompile to a newer version of=20
Linux)?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D580365408-24012007>3.&nbsp; Is there=20
any way to get stable sound out of the Audiophile USB (or some=20
other&nbsp;intermediate device that would output&nbsp;COAX SPDIF) while =
not=20
recompiling the kernel?&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D580365408-24012007>Thank =
you in advance=20
for any assistance.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007>Marion</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D580365408-24012007><A=20
href=3D"mailto:mrundell@gmail.com">mrundell@gmail.com</A></SPAN></FONT></=
DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D580365408-24012007></SPAN></FONT>&nbsp;</DIV></DIV></DIV></DIV></=
DIV></BODY></HTML>

------=_NextPart_000_00B1_01C73F88.19AC68A0--



--===============2041067163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2041067163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2041067163==--
