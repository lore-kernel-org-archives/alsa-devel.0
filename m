From: "John Utz" <John.Utz@dmxmusic.com>
Subject: SUCCESS!!! RE: why would i *not* be able to update a
 register in ac97#0-0+regs when it's read write?
Date: Wed, 21 Feb 2007 11:11:54 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8A0@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF896@sea-exch-01.na.corp.dmxmusic.co
	m> <75b66ecd0702161724ncd340a8o1feea138fa98963c@mail.gmail.com>
	<F8FB97052F1BEF409F7842E960E49B5AAAF897@sea-exch-01.na.corp.dmxmusic.
	com> <75b66ecd0702161801l3e1492c3j37e001bbf57eaac9@mail.gmail.com>
	<F8FB97052F1BEF409F7842E960E49B5AAAF899@sea-exch-01.na.corp.dmxmusic.
	com> <1172042945.16851.1175709177@webmail.messagingengine.com>
	<F8FB97052F1BEF409F7842E960E49B5AAAF89E@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0900221094=="
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
To: John Utz <John.Utz@dmxmusic.com>, Clemens Ladisch <cladisch@fastmail.net>, Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0900221094==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C755EC.BFBFA845"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C755EC.BFBFA845
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable




-----Original Message-----
From: alsa-devel-bounces@lists.sourceforge.net on behalf of John Utz
Sent: Wed 2/21/2007 9:44 AM
To: Clemens Ladisch; Lee Revell
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] why would i *not* be able to update a register =
in ac97#0-0+regs when it's read write?
=20



-----Original Message-----
From: Clemens Ladisch [mailto:cladisch@fastmail.net]
Sent: Tue 2/20/2007 11:29 PM
To: John Utz; Lee Revell
Cc: alsa-devel@lists.sourceforge.net
Yup, that did it!

 chan-id.wav now calls out on the surround and center/lfe outputs with =
the vt1618 so we now actually have a reasonable hope of shipping our =
product.

Thankyou very much for your assistance, patch to follow in the next few =
days assuming that i receive no managerial grief.



Subject: Re: [Alsa-devel] why would i *not* be able to update a register =
in ac97#0-0+regs when it's read write?
=20
> Nothing changed, i can still write to many registers but not the 1 =
that i
> am attempting to change: 60h UAJ Control; Does the '(Page ID =3D 00h)'
> alter how i need to access the register?

Yes, you have to set the correct page in the Audio Interrupt and Paging
register (24h); see the AC97_PAGE_* defines in ac97_codec.h.

Thankyou Clemens, i thought there might be something to it, but i wasnt =
sure what.

This should be a big help


HTH
Clemens




------_=_NextPart_001_01C755EC.BFBFA845
Content-Type: text/html;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>SUCCESS!!! RE: [Alsa-devel] why would i *not* be able to update a =
register in ac97#0-0+regs when it's read write?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: alsa-devel-bounces@lists.sourceforge.net on behalf of John Utz<BR>
Sent: Wed 2/21/2007 9:44 AM<BR>
To: Clemens Ladisch; Lee Revell<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] why would i *not* be able to update a register =
in ac97#0-0+regs when it's read write?<BR>
<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Clemens Ladisch [<A =
HREF=3D"mailto:cladisch@fastmail.net">mailto:cladisch@fastmail.net</A>]<B=
R>
Sent: Tue 2/20/2007 11:29 PM<BR>
To: John Utz; Lee Revell<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Yup, that did it!<BR>
<BR>
&nbsp;chan-id.wav now calls out on the surround and center/lfe outputs =
with the vt1618 so we now actually have a reasonable hope of shipping =
our product.<BR>
<BR>
Thankyou very much for your assistance, patch to follow in the next few =
days assuming that i receive no managerial grief.<BR>
<BR>
<BR>
<BR>
Subject: Re: [Alsa-devel] why would i *not* be able to update a register =
in ac97#0-0+regs when it's read write?<BR>
<BR>
&gt; Nothing changed, i can still write to many registers but not the 1 =
that i<BR>
&gt; am attempting to change: 60h UAJ Control; Does the '(Page ID =3D =
00h)'<BR>
&gt; alter how i need to access the register?<BR>
<BR>
Yes, you have to set the correct page in the Audio Interrupt and =
Paging<BR>
register (24h); see the AC97_PAGE_* defines in ac97_codec.h.<BR>
<BR>
Thankyou Clemens, i thought there might be something to it, but i wasnt =
sure what.<BR>
<BR>
This should be a big help<BR>
<BR>
<BR>
HTH<BR>
Clemens<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C755EC.BFBFA845--



--===============0900221094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0900221094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0900221094==--
