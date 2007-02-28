From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: Problem to compile : Undefined reference
Date: Wed, 28 Feb 2007 09:18:55 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8BA@sea-exch-01.na.corp.dmxmusic.com>
References: <50fdad60702280603v63503c8o78dd71b5872fc0c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0174168611=="
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
To: Nyx <keres.nyx@gmail.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0174168611==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75B5C.B8C693F9"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75B5C.B8C693F9
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

That would indicate that you are not linking against libasound

does your compile statement include the line

-lasound, ie:

gcc -o myapp myapp.c -lasound



-----Original Message-----
From: alsa-devel-bounces@lists.sourceforge.net on behalf of Nyx
Sent: Wed 2/28/2007 6:03 AM
To: alsa-devel
Subject: [Alsa-devel]  Problem to compile : Undefined reference
=20
Hi,

I want to develop some applications (VUmeter and Peakmeter) with
ALSA-API. So, I tried to compile an example from
http://equalarea.com/paul/alsa-audio.html#playex but I have some
errors like : "
example.o(.text+0x30c): In function `main':
: undefined reference to `snd_strerror'
example.o(.text+0x340): In function `main':
: undefined reference to `snd_pcm_close'
[..]"

Do you have an idea where these errors come from ?

Thank you
--=20
Ker

-------------------------------------------------------------------------=

Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel



------_=_NextPart_001_01C75B5C.B8C693F9
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
<TITLE>RE: [Alsa-devel]  Problem to compile : Undefined =
reference</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>That would indicate that you are not linking against =
libasound<BR>
<BR>
does your compile statement include the line<BR>
<BR>
-lasound, ie:<BR>
<BR>
gcc -o myapp myapp.c -lasound<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: alsa-devel-bounces@lists.sourceforge.net on behalf of Nyx<BR>
Sent: Wed 2/28/2007 6:03 AM<BR>
To: alsa-devel<BR>
Subject: [Alsa-devel]&nbsp; Problem to compile : Undefined reference<BR>
<BR>
Hi,<BR>
<BR>
I want to develop some applications (VUmeter and Peakmeter) with<BR>
ALSA-API. So, I tried to compile an example from<BR>
<A =
HREF=3D"http://equalarea.com/paul/alsa-audio.html#playex">http://equalare=
a.com/paul/alsa-audio.html#playex</A> but I have some<BR>
errors like : &quot;<BR>
example.o(.text+0x30c): In function `main':<BR>
: undefined reference to `snd_strerror'<BR>
example.o(.text+0x340): In function `main':<BR>
: undefined reference to `snd_pcm_close'<BR>
[..]&quot;<BR>
<BR>
Do you have an idea where these errors come from ?<BR>
<BR>
Thank you<BR>
--<BR>
Ker<BR>
<BR>
-------------------------------------------------------------------------=
<BR>
Take Surveys. Earn Cash. Influence the Future of IT<BR>
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your<BR>
opinions on IT &amp; business topics through brief surveys-and earn =
cash<BR>
<A =
HREF=3D"http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforg=
e&CID=3DDEVDEV">http://www.techsay.com/default.php?page=3Djoin.php&p=3Dso=
urceforge&CID=3DDEVDEV</A><BR>
_______________________________________________<BR>
Alsa-devel mailing list<BR>
Alsa-devel@lists.sourceforge.net<BR>
<A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://=
lists.sourceforge.net/lists/listinfo/alsa-devel</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75B5C.B8C693F9--



--===============0174168611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0174168611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0174168611==--
