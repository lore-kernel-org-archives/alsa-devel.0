From: "Pete Barnard" <petebarnard@tiscali.co.uk>
Subject: Sound Going Wrong
Date: Sat, 20 Sep 2003 15:00:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <01d101c37f7f$982a77c0$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01CE_01C37F87.DE831170"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_01CE_01C37F87.DE831170
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I have written a sound server using ALSA drivers which samples stereo =
sound at 16khz and writes each channel to a unix pipe.  I am using a =
sonogram to display the sound (which simply reads the pipe).  =
Occasionally I get buffer underruns which I have put a fix in so that =
the sound server recovers.  Most of the time the sonogram displays the =
sound as it should but I have noticed that if I leave the soundserver =
and sonogram on for a long period (in the region of a day but the length =
of time varies) the sonogram displays extra horizontal lines and I know =
it isn't right.   If I stop and restart the soundserver these extra =
horizontal lines go away and the thing carries on as normal.  There has =
also been a situation when these horizontal lines have been present but =
they went away by themself (without having to stop and restart) ... =
almost as if something went back in to sync.

Just wondered if anybody had any insight as to what could be happening =
because I haven't.  And it's difficult to de-bug as the problem occurs =
so rarely.

Regards,

Pete




------=_NextPart_000_01CE_01C37F87.DE831170
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have written a sound server using =
ALSA drivers=20
which samples stereo sound at 16khz and writes each channel to a unix=20
pipe.&nbsp; I am using a sonogram to display the sound (which simply =
reads the=20
pipe).&nbsp; Occasionally I get buffer underruns which I have put a fix =
in so=20
that the sound server recovers.&nbsp; Most of the time the sonogram =
displays the=20
sound as it should but I have noticed that if I leave the soundserver =
and=20
sonogram on for a long period (in the region of a day but the length of =
time=20
varies) the sonogram displays extra horizontal lines and I know it isn't =

right.&nbsp; &nbsp;If I stop and restart the soundserver these extra =
horizontal=20
lines go away and the thing carries on as normal.&nbsp; There has also =
been a=20
situation when these horizontal lines have been present but they went =
away by=20
themself (without having to stop and&nbsp;restart) ... almost as if =
something=20
went back in to sync.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Just wondered if anybody had any =
insight as to what=20
could be happening because I haven't.&nbsp; And it's difficult to de-bug =
as the=20
problem occurs so rarely.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Pete</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_01CE_01C37F87.DE831170--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
