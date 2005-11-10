From: "Sverker Abrahamsson" <sverker@abrahamsson.com>
Subject: Loopback, cards, devices and substreams
Date: Thu, 10 Nov 2005 23:49:19 +0100
Message-ID: <02eb01c5e648$fc7bc210$3c01010a@Fiona>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_02E8_01C5E651.5DE93070"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_02E8_01C5E651.5DE93070
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
I'm working on a loopback device based on a patch that was posted =
earlier this year for making the dummy driver a loopback. Unforturnatly =
the aloop driver doesn't work at all, it just oops my kernel. Snd-dummy =
on the other hand works fine as loopback with the patch, as long as I =
only run one instance (because there is only one buffer, I think).

I'm trying to figure out how the card, device and substeams belong =
together. I want to be able to have as many loopbacks as possible, =
specified by module parameters of course. I've managed to load the =
driver to two "cards" by using an option line in modprobe.conf so that =
part is quite straight forward. What I don't quite get is the devices =
and substreams.

My idea is that I should be able to have one loopback per device, i.e. 4 =
loopbacks per card (of which there can be maximum 8). Substreams, as I =
understood it would not help me since having multiple streams from a =
capture device just means that I can have several apps capturing from =
the same device, but all getting the same content. Correct?

I hope that someone of you can enlight me on these questions
/Sverker
------=_NextPart_000_02E8_01C5E651.5DE93070
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2769" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I'm working on a loopback device based =
on a patch=20
that was posted earlier this year for making the dummy driver a =
loopback.=20
Unforturnatly the aloop driver doesn't work at all, it just oops my =
kernel.=20
Snd-dummy on the other hand works fine as loopback with the patch, as =
long as I=20
only run one instance (because there is only one buffer, I =
think).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm trying to figure out how the card, =
device and=20
substeams belong together. I want to be able to have as many loopbacks =
as=20
possible, specified by module parameters of course. I've managed to load =
the=20
driver to two "cards" by using an option line in modprobe.conf so that =
part is=20
quite straight forward. What I don't quite get is the devices and=20
substreams.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My idea is that I should be able to =
have one=20
loopback per device, i.e. 4 loopbacks per card (of which there can be =
maximum=20
8). Substreams, as I understood it would not help me since having =
multiple=20
streams from a capture device just means that I can have several apps =
capturing=20
from the same device, but all getting the same content. =
Correct?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I hope that someone of you can enlight =
me on these=20
questions</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>/Sverker</FONT></DIV></BODY></HTML>

------=_NextPart_000_02E8_01C5E651.5DE93070--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
