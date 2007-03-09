From: "John Utz" <John.Utz@dmx.com>
Subject: [PATCH] ac97_patch.c - enable 'Smart 5.1' on VIA
 vt1617a ac97 codec - Version 3
Date: Fri, 9 Mar 2007 12:55:27 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8C8@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0262755411=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

--===============0262755411==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7628D.4453DF0D"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7628D.4453DF0D
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


This version superseeds the patches presented 070223 and 070228

Setting this new control to the setting 'Surr LFE/C Mic3' allows 6 =
channel output to be played using the following command:

aplay -Dhw:0,1 chan-id.wav

Note that the existing control Alternate Level to Surround Out may have =
to be disabled to hear the surround output.

Changelog Entry

=3D=3D=3D=3D

[PATCH] ALSA: Smart 5.1 for VIA 1617a codec

This patch provides a single 8 way enum called 'Smart 5.1 Select' with =
some reasonable names for each enum that allows the user to choose which =
of the 8 possible settings for vt1617a's version of what via calls =
'Smart 5.1'.

Signed-off-by: John Utz <john.utz@dmx.com>

------_=_NextPart_001_01C7628D.4453DF0D
Content-Type: text/html;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>[PATCH] ac97_patch.c - enable 'Smart 5.1' on VIA vt1617a ac97 =
codec - Version 3</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>This version superseeds the patches presented 070223 =
and 070228<BR>
<BR>
Setting this new control to the setting 'Surr LFE/C Mic3' allows 6 =
channel output to be played using the following command:<BR>
<BR>
aplay -Dhw:0,1 chan-id.wav<BR>
<BR>
Note that the existing control Alternate Level to Surround Out may have =
to be disabled to hear the surround output.<BR>
<BR>
Changelog Entry<BR>
<BR>
=3D=3D=3D=3D<BR>
<BR>
[PATCH] ALSA: Smart 5.1 for VIA 1617a codec<BR>
<BR>
This patch provides a single 8 way enum called 'Smart 5.1 Select' with =
some reasonable names for each enum that allows the user to choose which =
of the 8 possible settings for vt1617a's version of what via calls =
'Smart 5.1'.<BR>
<BR>
Signed-off-by: John Utz &lt;john.utz@dmx.com&gt;</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7628D.4453DF0D--



--===============0262755411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0262755411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0262755411==--
