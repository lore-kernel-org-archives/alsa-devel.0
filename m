From: "John Matthews" <jm169@ohm.york.ac.uk>
Subject: Via 82xx drivers
Date: Thu, 9 Sep 2004 12:11:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003501c4965d$c8647c10$c400a8c0@imspc02>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0032_01C49666.29D4D0A0"
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

This is a multi-part message in MIME format.

------=_NextPart_000_0032_01C49666.29D4D0A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to develop a complete system / distribution using the via =
"mini-itx" platform.  The idea is that we take in sensor positions from =
analog sensors and output sounds based on the position of these sensors. =
This setup is used for music therapy, with disabled children producing =
music using, for example, ultrasonic position sensors (amongst other =
types of sensor). I've written some code to accept input from the alsa =
sequencer and act as a midi router, and I'm using fluidsynth as an =
output synthesiser.

The mini-itx board is a very small form factor fully integrated pc =
motherboard  with a via c3 processor.  The sound controller on this =
board is part of a via 8235 southbridge.

The snd-via82xx alsa module works fine on this board, apart from the =
fact that it is very, very noisy - unusably so.  There is a background =
drone and whenever the processor does something you get "clunky" noises, =
which i'm pretty sure aren't xruns.  I have tested it using fluidsynth =
and very large buffer sizes, to eliminate the possibility of xruns.  I =
have ensured everything in the alsamixer is turned down.

Particularly, when a note is turned off in fluidsynth, shortly after you =
get a pop.=20

I have tried using all of the via82xx driver's options, ie. =
dxs_support=3D0,1,2,3, ac_97_quirk=3D0,1,2,3,4 to no avail.  I have also =
tried passing no-hlt to the kernel, which helps just a little.

Interestingly the 2.4 kernel OSS drivers do the same.  VIAs own OSS =
drivers do not, and are very quiet, but their latency is quite high.  =
The source is available to all of these drivers. The windows drivers are =
fairly quiet as well.

I am pretty sure this is a problem with the alsa drivers using this =
particular chip, as I have a few friends who are experienced with alsa =
attempting to use the same board with similar problems.  Also, I have =
used the same setup (fluidsynth / alsa) on a via 8233a based board and =
it worked fine.

It could be as simple as an unnaccesible mixer channel being left =
unmuted.

Has anyone else experienced this problem?  Does anyone have any tips or =
advice?

I would really like to fix this, as I am a professional programmer, =
though I have no experience of linux device drivers, and only a little =
experience in linux generally.  Is there a guide to how alsa drivers =
work anywhere?  Any information which would help me sort this would be =
gratefully recieved,

Thanks,

John Matthews.
------=_NextPart_000_0032_01C49666.29D4D0A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1458" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm trying to develop a complete system =
/=20
distribution using the via "mini-itx" platform.&nbsp; The idea is that =
we take=20
in sensor positions from analog sensors and output sounds based on the =
position=20
of these sensors.&nbsp;This setup is used for music therapy, with =
disabled=20
children producing music using, for example,&nbsp;ultrasonic position =
sensors=20
(amongst other types of sensor).</FONT><FONT face=3DArial =
size=3D2>&nbsp;I've=20
written some code to accept input from the alsa sequencer and act as a =
midi=20
router, and I'm using fluidsynth as an output synthesiser.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The mini-itx board is a very small form =
factor=20
fully integrated pc motherboard&nbsp; with a via c3 processor.&nbsp; The =
sound=20
controller on this board is part of&nbsp;a via 8235 =
southbridge.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The snd-via82xx alsa module works fine =
on this=20
board, apart from the fact that it is very, very noisy - unusably =
so.&nbsp;=20
There is a background drone and whenever the processor does something =
you get=20
"clunky" noises, which i'm pretty sure aren't xruns.&nbsp; I have tested =
it=20
using fluidsynth and&nbsp;very large buffer sizes, to eliminate the =
possibility=20
of xruns.&nbsp; I have ensured everything in the alsamixer is turned=20
down.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Particularly, when a note is turned off =
in=20
fluidsynth, shortly after you get a pop. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have tried using all of the via82xx =
driver's=20
options, ie. dxs_support=3D0,1,2,3, ac_97_quirk=3D0,1,2,3,4 to no =
avail.&nbsp; I=20
have also tried passing no-hlt to the kernel, which helps just a=20
little.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Interestingly the 2.4 kernel OSS =
drivers do the=20
same.&nbsp; VIAs own OSS drivers do not, and are very quiet,&nbsp;but =
their=20
latency is&nbsp;quite high.&nbsp; The source is available to all of =
these=20
drivers. The windows drivers are fairly quiet as well.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am pretty sure this is a problem with =
the alsa=20
drivers using&nbsp;this particular chip, as I have a few friends who are =

experienced with alsa attempting to use the same board with similar=20
problems.&nbsp; Also, I have used the same setup (fluidsynth / alsa) on =
a via=20
8233a based board and it worked fine.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>It could be as simple as an =
unnaccesible&nbsp;mixer=20
channel being left unmuted.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Has anyone else experienced this =
problem?&nbsp;=20
Does anyone have any tips or advice?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I would really like to fix this, as I =
am a=20
professional programmer, though I have no experience of linux device =
drivers,=20
and only a little experience in linux generally.&nbsp; Is there a guide =
to how=20
alsa drivers work anywhere?&nbsp; Any information which would help me =
sort this=20
would be gratefully recieved,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>John =
Matthews.</FONT></DIV></BODY></HTML>

------=_NextPart_000_0032_01C49666.29D4D0A0--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
