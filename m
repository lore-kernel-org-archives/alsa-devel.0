From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: are the alsa wiki instructions for mercurial
 correct?
Date: Thu, 22 Feb 2007 09:08:20 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8A6@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8A2@sea-exch-01.na.corp.dmxmusic.com>
	<s5hvehu797j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0124680636=="
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0124680636==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C756A4.735E2194"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C756A4.735E2194
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable




-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Thu 2/22/2007 2:55 AM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] are the alsa wiki instructions for mercurial =
correct?
=20
At Wed, 21 Feb 2007 17:13:55 -0800,
John Utz wrote:
>=20
> However, all that i seem to be pulling down is the stub file and not =
the real
> iplementations
>=20
> ie:
>=20
> [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} \;
> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-driver/pci/ac97/ac97_patch.c
> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:17 =
./alsa-driver-2908/pci/ac97/ac97_patch.c
> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:13 =
./alsa-kernel-2908/pci/ac97/ac97_patch.c
> -rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-kernel/pci/ac97/ac97_patch.c
>=20
> these are just the files that include the 'real' implementations:
>=20
> [jutz@localhost alsa-hg]$ more alsa-driver/pci/ac97/ac97_patch.c
> #define __NO_VERSION__
> #include "../../alsa-kernel/pci/ac97/ac97_patch.c"
>=20
> am i doing something wrong or is mercurial missing some stuff?

The real codes are found in alsa-kernel tree.  These are synced with
the linux kernel tree.  When you run hgconfigure script, it makes
symlink from alsa-driver/alsa-kernel pointing that directory.


Takashi




Please look at the file info, the files in both the alsa-driver and =
alsa-kernel are identical, the ones in the alsa-kernel should be the =
full sized ones, not copies of the stub file

is there something that i am failing to understand?

tnx!

johnu

------_=_NextPart_001_01C756A4.735E2194
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
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: Takashi Iwai [<A =
HREF=3D"mailto:tiwai@suse.de">mailto:tiwai@suse.de</A>]<BR>
Sent: Thu 2/22/2007 2:55 AM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] are the alsa wiki instructions for mercurial =
correct?<BR>
<BR>
At Wed, 21 Feb 2007 17:13:55 -0800,<BR>
John Utz wrote:<BR>
&gt;<BR>
&gt; However, all that i seem to be pulling down is the stub file and =
not the real<BR>
&gt; iplementations<BR>
&gt;<BR>
&gt; ie:<BR>
&gt;<BR>
&gt; [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} =
\;<BR>
&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-driver/pci/ac97/ac97_patch.c<BR>
&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21 17:17 =
./alsa-driver-2908/pci/ac97/ac97_patch.c<BR>
&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21 17:13 =
./alsa-kernel-2908/pci/ac97/ac97_patch.c<BR>
&gt; -rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-kernel/pci/ac97/ac97_patch.c<BR>
&gt;<BR>
&gt; these are just the files that include the 'real' =
implementations:<BR>
&gt;<BR>
&gt; [jutz@localhost alsa-hg]$ more =
alsa-driver/pci/ac97/ac97_patch.c<BR>
&gt; #define __NO_VERSION__<BR>
&gt; #include &quot;../../alsa-kernel/pci/ac97/ac97_patch.c&quot;<BR>
&gt;<BR>
&gt; am i doing something wrong or is mercurial missing some stuff?<BR>
<BR>
The real codes are found in alsa-kernel tree.&nbsp; These are synced =
with<BR>
the linux kernel tree.&nbsp; When you run hgconfigure script, it =
makes<BR>
symlink from alsa-driver/alsa-kernel pointing that directory.<BR>
<BR>
<BR>
Takashi<BR>
<BR>
<BR>
<BR>
<BR>
Please look at the file info, the files in both the alsa-driver and =
alsa-kernel are identical, the ones in the alsa-kernel should be the =
full sized ones, not copies of the stub file<BR>
<BR>
is there something that i am failing to understand?<BR>
<BR>
tnx!<BR>
<BR>
johnu<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C756A4.735E2194--



--===============0124680636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0124680636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0124680636==--
