From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: are the alsa wiki instructions for mercurial
 correct?
Date: Thu, 22 Feb 2007 09:05:07 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8A4@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8A2@sea-exch-01.na.corp.dmxmusic.com>
	<1172110844.3728.1.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2063273000=="
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
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============2063273000==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C756A3.A70E32B2"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C756A3.A70E32B2
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

fixed now eh!

easily done!


-----Original Message-----
From: Tobin Davis [mailto:tdavis@dsl-only.net]
Sent: Wed 2/21/2007 6:20 PM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] are the alsa wiki instructions for mercurial =
correct?
=20
use http://hg.alsa-project.org/alsa-driver and
http://hg.alsa-project.org/alsa-kernel.

The wiki is wrong (and hasn't been updated).

Tobin

On Wed, 2007-02-21 at 17:13 -0800, John Utz wrote:

> i executed the following steps from the wiki:
>=20
> # Get a copy of the repository
> cd alsa-hg
>=20
> hg clone http://hg-mirror.alsa-project.org/alsa-driver alsa-driver
> hg clone http://hg-mirror.alsa-project.org/alsa-kernel alsa-kernel
>=20
> # Get latest
>=20
> cd alsa-driver
> hg pull -u
>=20
> cd alsa-kernel
> hg pull -u
>=20
> # Create a working copy
> hg clone alsa-driver alsa-driver-fixbug1
> cd alsa-driver-fixbug1
>=20
>=20
>=20
> However, all that i seem to be pulling down is the stub file and not
> the real iplementations
>=20
> ie:
>=20
> [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} \;
> -rw-r--r-- 1 jutz jutz 74 Feb 21
> 17:07 ./alsa-driver/pci/ac97/ac97_patch.c
> -rw-r--r-- 1 jutz jutz 74 Feb 21
> 17:17 ./alsa-driver-2908/pci/ac97/ac97_patch.c
> -rw-r--r-- 1 jutz jutz 74 Feb 21
> 17:13 ./alsa-kernel-2908/pci/ac97/ac97_patch.c
> -rw-r--r-- 1 jutz jutz 74 Feb 21
> 17:07 ./alsa-kernel/pci/ac97/ac97_patch.c
>=20
>=20
> these are just the files that include the 'real' implementations:
>=20
> [jutz@localhost alsa-hg]$ more alsa-driver/pci/ac97/ac97_patch.c
> #define __NO_VERSION__
> #include "../../alsa-kernel/pci/ac97/ac97_patch.c"
>=20
>=20
> am i doing something wrong or is mercurial missing some stuff?
>=20
>=20
> =
-------------------------------------------------------------------------=

> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to =
share your
> opinions on IT & business topics through brief surveys-and earn cash
> =
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________ Alsa-devel mailing =
list Alsa-devel@lists.sourceforge.net =
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=20
Tobin Davis <tdavis@dsl-only.net>


------_=_NextPart_001_01C756A3.A70E32B2
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
<TITLE>RE: [Alsa-devel] are the alsa wiki instructions for mercurial =
correct?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>fixed now eh!<BR>
<BR>
easily done!<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Tobin Davis [<A =
HREF=3D"mailto:tdavis@dsl-only.net">mailto:tdavis@dsl-only.net</A>]<BR>
Sent: Wed 2/21/2007 6:20 PM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] are the alsa wiki instructions for mercurial =
correct?<BR>
<BR>
use <A =
HREF=3D"http://hg.alsa-project.org/alsa-driver">http://hg.alsa-project.or=
g/alsa-driver</A> and<BR>
<A =
HREF=3D"http://hg.alsa-project.org/alsa-kernel">http://hg.alsa-project.or=
g/alsa-kernel</A>.<BR>
<BR>
The wiki is wrong (and hasn't been updated).<BR>
<BR>
Tobin<BR>
<BR>
On Wed, 2007-02-21 at 17:13 -0800, John Utz wrote:<BR>
<BR>
&gt; i executed the following steps from the wiki:<BR>
&gt;<BR>
&gt; # Get a copy of the repository<BR>
&gt; cd alsa-hg<BR>
&gt;<BR>
&gt; hg clone <A =
HREF=3D"http://hg-mirror.alsa-project.org/alsa-driver">http://hg-mirror.a=
lsa-project.org/alsa-driver</A> alsa-driver<BR>
&gt; hg clone <A =
HREF=3D"http://hg-mirror.alsa-project.org/alsa-kernel">http://hg-mirror.a=
lsa-project.org/alsa-kernel</A> alsa-kernel<BR>
&gt;<BR>
&gt; # Get latest<BR>
&gt;<BR>
&gt; cd alsa-driver<BR>
&gt; hg pull -u<BR>
&gt;<BR>
&gt; cd alsa-kernel<BR>
&gt; hg pull -u<BR>
&gt;<BR>
&gt; # Create a working copy<BR>
&gt; hg clone alsa-driver alsa-driver-fixbug1<BR>
&gt; cd alsa-driver-fixbug1<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; However, all that i seem to be pulling down is the stub file and =
not<BR>
&gt; the real iplementations<BR>
&gt;<BR>
&gt; ie:<BR>
&gt;<BR>
&gt; [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} =
\;<BR>
&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21<BR>
&gt; 17:07 ./alsa-driver/pci/ac97/ac97_patch.c<BR>
&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21<BR>
&gt; 17:17 ./alsa-driver-2908/pci/ac97/ac97_patch.c<BR>
&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21<BR>
&gt; 17:13 ./alsa-kernel-2908/pci/ac97/ac97_patch.c<BR>
&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21<BR>
&gt; 17:07 ./alsa-kernel/pci/ac97/ac97_patch.c<BR>
&gt;<BR>
&gt;<BR>
&gt; these are just the files that include the 'real' =
implementations:<BR>
&gt;<BR>
&gt; [jutz@localhost alsa-hg]$ more =
alsa-driver/pci/ac97/ac97_patch.c<BR>
&gt; #define __NO_VERSION__<BR>
&gt; #include &quot;../../alsa-kernel/pci/ac97/ac97_patch.c&quot;<BR>
&gt;<BR>
&gt;<BR>
&gt; am i doing something wrong or is mercurial missing some stuff?<BR>
&gt;<BR>
&gt;<BR>
&gt; =
-------------------------------------------------------------------------=
<BR>
&gt; Take Surveys. Earn Cash. Influence the Future of IT<BR>
&gt; Join SourceForge.net's Techsay panel and you'll get the chance to =
share your<BR>
&gt; opinions on IT &amp; business topics through brief surveys-and earn =
cash<BR>
&gt; <A =
HREF=3D"http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforg=
e&CID=3DDEVDEV">http://www.techsay.com/default.php?page=3Djoin.php&p=3Dso=
urceforge&CID=3DDEVDEV</A><BR>
&gt; _______________________________________________ Alsa-devel mailing =
list Alsa-devel@lists.sourceforge.net <A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://=
lists.sourceforge.net/lists/listinfo/alsa-devel</A><BR>
<BR>
--<BR>
Tobin Davis &lt;tdavis@dsl-only.net&gt;<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C756A3.A70E32B2--



--===============2063273000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2063273000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2063273000==--
