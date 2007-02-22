From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: are the alsa wiki instructions for mercurial
 correct?
Date: Thu, 22 Feb 2007 09:06:27 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8A5@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8A2@sea-exch-01.na.corp.dmxmusic.com>
	<1172110844.3728.1.camel@razman.gruemaster.com>
	<45DD5E45.6090107@ingomueller.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0306543555=="
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
To: =?iso-8859-1?Q?Ingo_M=FCller?= <alsa@ingomueller.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0306543555==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C756A3.E9DE3CC8"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C756A3.E9DE3CC8
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Ingo, i created a wiki account for myself and fixed it



-----Original Message-----
From: alsa-devel-bounces@lists.sourceforge.net on behalf of Ingo =
M=FCller
Sent: Thu 2/22/2007 1:11 AM
To: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] are the alsa wiki instructions for mercurial =
correct?
=20


Tobin Davis schrieb:
> use http://hg.alsa-project.org/alsa-driver and
> http://hg.alsa-project.org/alsa-kernel.
>=20
> The wiki is wrong (and hasn't been updated).
>=20
> Tobin
>=20

It'd be GREAT if you could bring it up-to-date! I can't do it because I
simply don't now how it works. Thanks in advance...

Regards, Ingo


> On Wed, 2007-02-21 at 17:13 -0800, John Utz wrote:
>=20
>> i executed the following steps from the wiki:
>>
>> # Get a copy of the repository
>> cd alsa-hg
>>
>> hg clone http://hg-mirror.alsa-project.org/alsa-driver alsa-driver
>> hg clone http://hg-mirror.alsa-project.org/alsa-kernel alsa-kernel
>>
>> # Get latest
>>
>> cd alsa-driver
>> hg pull -u
>>
>> cd alsa-kernel
>> hg pull -u
>>
>> # Create a working copy
>> hg clone alsa-driver alsa-driver-fixbug1
>> cd alsa-driver-fixbug1
>>
>>
>>
>> However, all that i seem to be pulling down is the stub file and not
>> the real iplementations
>>
>> ie:
>>
>> [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} \;
>> -rw-r--r-- 1 jutz jutz 74 Feb 21
>> 17:07 ./alsa-driver/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21
>> 17:17 ./alsa-driver-2908/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21
>> 17:13 ./alsa-kernel-2908/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21
>> 17:07 ./alsa-kernel/pci/ac97/ac97_patch.c
>>
>>
>> these are just the files that include the 'real' implementations:
>>
>> [jutz@localhost alsa-hg]$ more alsa-driver/pci/ac97/ac97_patch.c
>> #define __NO_VERSION__
>> #include "../../alsa-kernel/pci/ac97/ac97_patch.c"
>>
>>
>> am i doing something wrong or is mercurial missing some stuff?


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



------_=_NextPart_001_01C756A3.E9DE3CC8
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

<P><FONT SIZE=3D2>Ingo, i created a wiki account for myself and fixed =
it<BR>
<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: alsa-devel-bounces@lists.sourceforge.net on behalf of Ingo =
M=FCller<BR>
Sent: Thu 2/22/2007 1:11 AM<BR>
To: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] are the alsa wiki instructions for mercurial =
correct?<BR>
<BR>
<BR>
<BR>
Tobin Davis schrieb:<BR>
&gt; use <A =
HREF=3D"http://hg.alsa-project.org/alsa-driver">http://hg.alsa-project.or=
g/alsa-driver</A> and<BR>
&gt; <A =
HREF=3D"http://hg.alsa-project.org/alsa-kernel">http://hg.alsa-project.or=
g/alsa-kernel</A>.<BR>
&gt;<BR>
&gt; The wiki is wrong (and hasn't been updated).<BR>
&gt;<BR>
&gt; Tobin<BR>
&gt;<BR>
<BR>
It'd be GREAT if you could bring it up-to-date! I can't do it because =
I<BR>
simply don't now how it works. Thanks in advance...<BR>
<BR>
Regards, Ingo<BR>
<BR>
<BR>
&gt; On Wed, 2007-02-21 at 17:13 -0800, John Utz wrote:<BR>
&gt;<BR>
&gt;&gt; i executed the following steps from the wiki:<BR>
&gt;&gt;<BR>
&gt;&gt; # Get a copy of the repository<BR>
&gt;&gt; cd alsa-hg<BR>
&gt;&gt;<BR>
&gt;&gt; hg clone <A =
HREF=3D"http://hg-mirror.alsa-project.org/alsa-driver">http://hg-mirror.a=
lsa-project.org/alsa-driver</A> alsa-driver<BR>
&gt;&gt; hg clone <A =
HREF=3D"http://hg-mirror.alsa-project.org/alsa-kernel">http://hg-mirror.a=
lsa-project.org/alsa-kernel</A> alsa-kernel<BR>
&gt;&gt;<BR>
&gt;&gt; # Get latest<BR>
&gt;&gt;<BR>
&gt;&gt; cd alsa-driver<BR>
&gt;&gt; hg pull -u<BR>
&gt;&gt;<BR>
&gt;&gt; cd alsa-kernel<BR>
&gt;&gt; hg pull -u<BR>
&gt;&gt;<BR>
&gt;&gt; # Create a working copy<BR>
&gt;&gt; hg clone alsa-driver alsa-driver-fixbug1<BR>
&gt;&gt; cd alsa-driver-fixbug1<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt; However, all that i seem to be pulling down is the stub file =
and not<BR>
&gt;&gt; the real iplementations<BR>
&gt;&gt;<BR>
&gt;&gt; ie:<BR>
&gt;&gt;<BR>
&gt;&gt; [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l =
{} \;<BR>
&gt;&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21<BR>
&gt;&gt; 17:07 ./alsa-driver/pci/ac97/ac97_patch.c<BR>
&gt;&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21<BR>
&gt;&gt; 17:17 ./alsa-driver-2908/pci/ac97/ac97_patch.c<BR>
&gt;&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21<BR>
&gt;&gt; 17:13 ./alsa-kernel-2908/pci/ac97/ac97_patch.c<BR>
&gt;&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21<BR>
&gt;&gt; 17:07 ./alsa-kernel/pci/ac97/ac97_patch.c<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt; these are just the files that include the 'real' =
implementations:<BR>
&gt;&gt;<BR>
&gt;&gt; [jutz@localhost alsa-hg]$ more =
alsa-driver/pci/ac97/ac97_patch.c<BR>
&gt;&gt; #define __NO_VERSION__<BR>
&gt;&gt; #include =
&quot;../../alsa-kernel/pci/ac97/ac97_patch.c&quot;<BR>
&gt;&gt;<BR>
&gt;&gt;<BR>
&gt;&gt; am i doing something wrong or is mercurial missing some =
stuff?<BR>
<BR>
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
------_=_NextPart_001_01C756A3.E9DE3CC8--



--===============0306543555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0306543555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0306543555==--
