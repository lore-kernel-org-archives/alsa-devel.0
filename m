From: "John Utz" <John.Utz@dmxmusic.com>
Subject: does a 3 way 2 register equivalent of AC97_ENUM_DOUBLE
 exist? (VT1617a stuff)
Date: Tue, 27 Feb 2007 09:56:44 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8B8@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0886345393=="
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

--===============0886345393==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75A98.A48E7AFB"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75A98.A48E7AFB
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Hello;

I submitted a patch last friday that manipulates 3 bits. Mr. Iwai =
indicated that he would prefer to have this patch resubmitted as an 8 =
way enum.

However, the macro that i was planning on using for this =
(AC97_ENUM_DOUBLE) appears to only work with 2 bits located on 1 =
register, whereas my problem is 3 bits located on 2 registers.

Can anybody point me to an example of using/creating a control that =
works with this set of inputs?

tnx!

johnu=20

------_=_NextPart_001_01C75A98.A48E7AFB
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
<TITLE>does a 3 way 2 register equivalent of AC97_ENUM_DOUBLE exist? =
(VT1617a stuff)</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Hello;<BR>
<BR>
I submitted a patch last friday that manipulates 3 bits. Mr. Iwai =
indicated that he would prefer to have this patch resubmitted as an 8 =
way enum.<BR>
<BR>
However, the macro that i was planning on using for this =
(AC97_ENUM_DOUBLE) appears to only work with 2 bits located on 1 =
register, whereas my problem is 3 bits located on 2 registers.<BR>
<BR>
Can anybody point me to an example of using/creating a control that =
works with this set of inputs?<BR>
<BR>
tnx!<BR>
<BR>
johnu </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75A98.A48E7AFB--



--===============0886345393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0886345393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0886345393==--
