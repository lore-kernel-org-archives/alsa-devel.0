From: "Joerg Amann" <Joerg.Amann@inka.de>
Subject: AC3 out with ENS1371 (Reg 0x1c bit 1)
Date: Mon, 27 May 2002 18:40:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <033c01c2059d$37985650$6465020a@optiplex>
Reply-To: "Joerg Amann" <Joerg.Amann@novanetwork.de>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0339_01C205AD.FAE57CE0"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_0339_01C205AD.FAE57CE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have installed alsa 0.9.0beta12 and PCM out over SPDIF is working =
fine,
bat I cant get AC3 to work (using ac3play, ac3dec or ac3spdif).
All I get is the noise of data. I think the SPDIF frames are not tagged
as non audio. From the tech specs =
(http://www.resus.univ-mrs.fr/~mikael/Data/Misc/es1373.ps.gz or
http://www.resus.univ-mrs.fr/~mikael/Data/Misc/es1373_spec.zip as Word =
Doc)
I get the info the it is possible to set the Info via Register 0x1C bit =
1. In the driver source I can=B4t
find any line touching Reg 0x1C.
Is it used by the alsa driver ? Is it possible to implement it ?


Greetings

Joerg


------=_NextPart_000_0339_01C205AD.FAE57CE0
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
<DIV><FONT face=3DArial size=3D2>I have installed alsa 0.9.0beta12 and =
PCM out over=20
SPDIF is working fine,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>bat I cant get AC3 to work (using =
ac3play, ac3dec=20
or ac3spdif).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>All I get is the noise of data. I think =
the SPDIF=20
frames are not tagged</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>as non audio. From the tech specs (<A=20
href=3D"http://www.resus.univ-mrs.fr/~mikael/Data/Misc/es1373.ps.gz">http=
://www.resus.univ-mrs.fr/~mikael/Data/Misc/es1373.ps.gz</A>&nbsp;or</FONT=
></DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"http://www.resus.univ-mrs.fr/~mikael/Data/Misc/es1373_spec.zip">h=
ttp://www.resus.univ-mrs.fr/~mikael/Data/Misc/es1373_spec.zip</A>&nbsp;as=
=20
Word Doc)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I get the info the it is possible to =
set the Info=20
via Register 0x1C bit 1. In the&nbsp;driver source I =
can=B4t</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>find any line&nbsp;touching Reg =
0x1C.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Is it used by the alsa driver ? Is it =
possible to=20
implement it ?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Greetings</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Joerg</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0339_01C205AD.FAE57CE0--


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
