From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: are the alsa wiki instructions for mercurial
 correct?
Date: Thu, 22 Feb 2007 13:53:28 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8AA@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8A2@sea-exch-01.na.corp.dmxmusic.com>
	<s5hvehu797j.wl%tiwai@suse.de>
	<F8FB97052F1BEF409F7842E960E49B5AAAF8A6@sea-exch-01.na.corp.dmxmusic.com>
	<45DE0D18.3080505@ingomueller.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0782587990=="
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

--===============0782587990==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C756CC.043BFA16"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C756CC.043BFA16
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

:-)

Ahh,

I didnt realize that there where two of them.....


-----Original Message-----
From: alsa-devel-bounces@lists.sourceforge.net on behalf of Ingo =
M=FCller
Sent: Thu 2/22/2007 1:37 PM
To: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] are the alsa wiki instructions for mercurial =
correct?
=20
I just realized that we weren't talking about the same wiki :-D You sure
now the unofficial wiki at http://alsa.opensrc.org/... Thanks a lot
anyway! I'm currently working on the other wiki, so if the licences
permit it, I'll copy your text to this one, too...

Regards, Ingo



John Utz schrieb:
>=20
>=20
> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thu 2/22/2007 2:55 AM
> To: John Utz
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] are the alsa wiki instructions for mercurial =
correct?
> =20
> At Wed, 21 Feb 2007 17:13:55 -0800,
> John Utz wrote:
>> However, all that i seem to be pulling down is the stub file and not =
the real
>> iplementations
>>
>> ie:
>>
>> [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} \;
>> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-driver/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:17 =
./alsa-driver-2908/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:13 =
./alsa-kernel-2908/pci/ac97/ac97_patch.c
>> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-kernel/pci/ac97/ac97_patch.c
>>
>> these are just the files that include the 'real' implementations:
>>
>> [jutz@localhost alsa-hg]$ more alsa-driver/pci/ac97/ac97_patch.c
>> #define __NO_VERSION__
>> #include "../../alsa-kernel/pci/ac97/ac97_patch.c"
>>
>> am i doing something wrong or is mercurial missing some stuff?
>=20
> The real codes are found in alsa-kernel tree.  These are synced with
> the linux kernel tree.  When you run hgconfigure script, it makes
> symlink from alsa-driver/alsa-kernel pointing that directory.
>=20
>=20
> Takashi
>=20
>=20
>=20
>=20
> Please look at the file info, the files in both the alsa-driver and =
alsa-kernel are identical, the ones in the alsa-kernel should be the =
full sized ones, not copies of the stub file
>=20
> is there something that i am failing to understand?
>=20
> tnx!
>=20
> johnu
>=20


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



------_=_NextPart_001_01C756CC.043BFA16
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

<P><FONT SIZE=3D2>:-)<BR>
<BR>
Ahh,<BR>
<BR>
I didnt realize that there where two of them.....<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: alsa-devel-bounces@lists.sourceforge.net on behalf of Ingo =
M=FCller<BR>
Sent: Thu 2/22/2007 1:37 PM<BR>
To: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] are the alsa wiki instructions for mercurial =
correct?<BR>
<BR>
I just realized that we weren't talking about the same wiki :-D You =
sure<BR>
now the unofficial wiki at <A =
HREF=3D"http://alsa.opensrc.org/">http://alsa.opensrc.org/</A>... Thanks =
a lot<BR>
anyway! I'm currently working on the other wiki, so if the licences<BR>
permit it, I'll copy your text to this one, too...<BR>
<BR>
Regards, Ingo<BR>
<BR>
<BR>
<BR>
John Utz schrieb:<BR>
&gt;<BR>
&gt;<BR>
&gt; -----Original Message-----<BR>
&gt; From: Takashi Iwai [<A =
HREF=3D"mailto:tiwai@suse.de">mailto:tiwai@suse.de</A>]<BR>
&gt; Sent: Thu 2/22/2007 2:55 AM<BR>
&gt; To: John Utz<BR>
&gt; Cc: alsa-devel@lists.sourceforge.net<BR>
&gt; Subject: Re: [Alsa-devel] are the alsa wiki instructions for =
mercurial correct?<BR>
&gt;&nbsp;<BR>
&gt; At Wed, 21 Feb 2007 17:13:55 -0800,<BR>
&gt; John Utz wrote:<BR>
&gt;&gt; However, all that i seem to be pulling down is the stub file =
and not the real<BR>
&gt;&gt; iplementations<BR>
&gt;&gt;<BR>
&gt;&gt; ie:<BR>
&gt;&gt;<BR>
&gt;&gt; [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l =
{} \;<BR>
&gt;&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-driver/pci/ac97/ac97_patch.c<BR>
&gt;&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21 17:17 =
./alsa-driver-2908/pci/ac97/ac97_patch.c<BR>
&gt;&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21 17:13 =
./alsa-kernel-2908/pci/ac97/ac97_patch.c<BR>
&gt;&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-kernel/pci/ac97/ac97_patch.c<BR>
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
&gt;&gt; am i doing something wrong or is mercurial missing some =
stuff?<BR>
&gt;<BR>
&gt; The real codes are found in alsa-kernel tree.&nbsp; These are =
synced with<BR>
&gt; the linux kernel tree.&nbsp; When you run hgconfigure script, it =
makes<BR>
&gt; symlink from alsa-driver/alsa-kernel pointing that directory.<BR>
&gt;<BR>
&gt;<BR>
&gt; Takashi<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; Please look at the file info, the files in both the alsa-driver and =
alsa-kernel are identical, the ones in the alsa-kernel should be the =
full sized ones, not copies of the stub file<BR>
&gt;<BR>
&gt; is there something that i am failing to understand?<BR>
&gt;<BR>
&gt; tnx!<BR>
&gt;<BR>
&gt; johnu<BR>
&gt;<BR>
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
------_=_NextPart_001_01C756CC.043BFA16--



--===============0782587990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0782587990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0782587990==--
