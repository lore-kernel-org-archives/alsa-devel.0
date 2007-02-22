From: "John Utz" <John.Utz@dmxmusic.com>
Subject: are the alsa wiki instructions for mercurial correct?
Date: Wed, 21 Feb 2007 17:13:55 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8A2@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1426392760=="
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

--===============1426392760==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7561E.B8B5895E"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7561E.B8B5895E
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

i executed the following steps from the wiki:

# Get a copy of the repository
cd alsa-hg

hg clone http://hg-mirror.alsa-project.org/alsa-driver alsa-driver
hg clone http://hg-mirror.alsa-project.org/alsa-kernel alsa-kernel

# Get latest

cd alsa-driver
hg pull -u

cd alsa-kernel
hg pull -u

# Create a working copy
hg clone alsa-driver alsa-driver-fixbug1
cd alsa-driver-fixbug1



However, all that i seem to be pulling down is the stub file and not the =
real iplementations

ie:

[jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} \;
-rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-driver/pci/ac97/ac97_patch.c
-rw-r--r-- 1 jutz jutz 74 Feb 21 17:17 =
./alsa-driver-2908/pci/ac97/ac97_patch.c
-rw-r--r-- 1 jutz jutz 74 Feb 21 17:13 =
./alsa-kernel-2908/pci/ac97/ac97_patch.c
-rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-kernel/pci/ac97/ac97_patch.c


these are just the files that include the 'real' implementations:

[jutz@localhost alsa-hg]$ more alsa-driver/pci/ac97/ac97_patch.c
#define __NO_VERSION__
#include "../../alsa-kernel/pci/ac97/ac97_patch.c"


am i doing something wrong or is mercurial missing some stuff?

------_=_NextPart_001_01C7561E.B8B5895E
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
<TITLE>are the alsa wiki instructions for mercurial correct?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>i executed the following steps from the wiki:<BR>
<BR>
# Get a copy of the repository<BR>
cd alsa-hg<BR>
<BR>
hg clone <A =
HREF=3D"http://hg-mirror.alsa-project.org/alsa-driver">http://hg-mirror.a=
lsa-project.org/alsa-driver</A> alsa-driver<BR>
hg clone <A =
HREF=3D"http://hg-mirror.alsa-project.org/alsa-kernel">http://hg-mirror.a=
lsa-project.org/alsa-kernel</A> alsa-kernel<BR>
<BR>
# Get latest<BR>
<BR>
cd alsa-driver<BR>
hg pull -u<BR>
<BR>
cd alsa-kernel<BR>
hg pull -u<BR>
<BR>
# Create a working copy<BR>
hg clone alsa-driver alsa-driver-fixbug1<BR>
cd alsa-driver-fixbug1<BR>
<BR>
<BR>
<BR>
However, all that i seem to be pulling down is the stub file and not the =
real iplementations<BR>
<BR>
ie:<BR>
<BR>
[jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} =
\;<BR>
-rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-driver/pci/ac97/ac97_patch.c<BR>
-rw-r--r-- 1 jutz jutz 74 Feb 21 17:17 =
./alsa-driver-2908/pci/ac97/ac97_patch.c<BR>
-rw-r--r-- 1 jutz jutz 74 Feb 21 17:13 =
./alsa-kernel-2908/pci/ac97/ac97_patch.c<BR>
-rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 =
./alsa-kernel/pci/ac97/ac97_patch.c<BR>
<BR>
<BR>
these are just the files that include the 'real' implementations:<BR>
<BR>
[jutz@localhost alsa-hg]$ more alsa-driver/pci/ac97/ac97_patch.c<BR>
#define __NO_VERSION__<BR>
#include &quot;../../alsa-kernel/pci/ac97/ac97_patch.c&quot;<BR>
<BR>
<BR>
am i doing something wrong or is mercurial missing some stuff?</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7561E.B8B5895E--



--===============1426392760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1426392760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1426392760==--
