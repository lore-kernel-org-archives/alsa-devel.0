From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: patch: ac97_patch.c - enable 'Smart 5.1' on VIA
 vt1617a ac97 codec - Version 2
Date: Wed, 28 Feb 2007 13:02:34 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8BD@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8BC@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0341361778=="
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
To: John Utz <John.Utz@dmxmusic.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0341361778==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75B7B.D91EAD25"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75B7B.D91EAD25
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Note that this is in relation to bug 0002908

this patch has been attached to that bug as well.


-----Original Message-----
From: alsa-devel-bounces@lists.sourceforge.net on behalf of John Utz
Sent: Wed 2/28/2007 12:52 PM
To: alsa-devel@lists.sourceforge.net
Subject: [Alsa-devel] patch: ac97_patch.c - enable 'Smart 5.1' on VIA =
vt1617a ac97 codec - Version 2
=20
Greetings;

This version superseeds the patch presented 070223 (that patch was not =
accepted)

This patch provides a single 8 way enum called 'Smart 5.1 Select' with =
some reasonable names for each enum that allows the user to choose which =
of the 8 possible settings for vt1617a's version of what via calls =
'Smart 5.1'.

Setting this new control to the setting 'Surr LFE/C Mic3' allows 6 =
channel output to be played using the following command:

aplay -Dhw:0,1 chan-id.wav

Note that the existing control Alternate Level to Surround Out may have =
to be disabled to hear the surround output.

Signed off by John Utz


------_=_NextPart_001_01C75B7B.D91EAD25
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
<TITLE>RE: [Alsa-devel] patch: ac97_patch.c - enable 'Smart 5.1' on VIA =
vt1617a ac97 codec - Version 2</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Note that this is in relation to bug 0002908<BR>
<BR>
this patch has been attached to that bug as well.<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: alsa-devel-bounces@lists.sourceforge.net on behalf of John Utz<BR>
Sent: Wed 2/28/2007 12:52 PM<BR>
To: alsa-devel@lists.sourceforge.net<BR>
Subject: [Alsa-devel] patch: ac97_patch.c - enable 'Smart 5.1' on VIA =
vt1617a ac97 codec - Version 2<BR>
<BR>
Greetings;<BR>
<BR>
This version superseeds the patch presented 070223 (that patch was not =
accepted)<BR>
<BR>
This patch provides a single 8 way enum called 'Smart 5.1 Select' with =
some reasonable names for each enum that allows the user to choose which =
of the 8 possible settings for vt1617a's version of what via calls =
'Smart 5.1'.<BR>
<BR>
Setting this new control to the setting 'Surr LFE/C Mic3' allows 6 =
channel output to be played using the following command:<BR>
<BR>
aplay -Dhw:0,1 chan-id.wav<BR>
<BR>
Note that the existing control Alternate Level to Surround Out may have =
to be disabled to hear the surround output.<BR>
<BR>
Signed off by John Utz<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75B7B.D91EAD25--



--===============0341361778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0341361778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0341361778==--
