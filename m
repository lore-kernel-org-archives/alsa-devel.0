From: noreply@alsa-project.org
Subject: [ALSA - driver 0000365]: No audio with Asus p4p800-vm
Date: Wed, 7 Jul 2004 22:02:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8a817f2981f0815741bfce8220792368@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7B421247
	for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2004 22:02:29 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A BUGNOTE has been added to this bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0365
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                Anlar
Assigned To:               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     365
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo - up to date stable
Kernel Version:             2.6.7
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             07-04-2004 20:53 CEST
Last Modified:              07-07-2004 22:02 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    No audio with Asus p4p800-vm
Description:=20
I have new Asus P4P800-VM motherboard (865G) that has i8x0 (x=3D1?) (ADI1=
980)
builtin. Alsa does seem to initialize, the required modules load and
something gets fed to the device but nothing comes out. I have played
around with the mixer volumes and done other known usual stuff as well.

A googling session revealed that some people have had success with this
motherboard but most of the people have failed. I thought that something
on this motherboard might be non-standard and require attention.=20

(If it is trivial, something t be added to the wikis. I doubt though sinc=
e
couple guys have tried already and none of them were complete newbies.)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 Anlar - 07-06-2004 22:04 CEST=20
----------------------------------------------------------------------
Tried also with 2004-06-02 cvs version. Still playing mute. This sound ch=
ip
isn't listed as one that requires some "quirks" thingy, whatever that
means..

Something interesting in dmesg though:
ALSA /tmp/alsa/alsa-driver/alsa-kernel/pci/ac97/ac97_codec.c:1922: AC'97 =
0
analog subsections not ready
intel8x0_measure_ac97_clock: measured 49414 usecs
intel8x0: clocking to 48000

"not ready"?=20

Did some extensive googling.. Check these out?
http://www.mail-archive.com/freebsd-hackers@freebsd.org/msg41462.html
http://www.mail-archive.com/freebsd-hackers@freebsd.org/msg42365.html

Something of help there?

----------------------------------------------------------------------
 Anlar - 07-07-2004 17:32 CEST=20
----------------------------------------------------------------------
I did the
ac97_quirk=3D 0-4
thingy just in case.. This time while playing with mixer I heard couple
faint cracks when I unmuted the channels. Very faint.

Tried something older, with a kernel 2.6.2 provided alsa. Still silent.

edited on: 07-07-04 17:32

----------------------------------------------------------------------
 Anlar - 07-07-2004 22:02 CEST=20
----------------------------------------------------------------------
Played around with Knoppix, couldn't get working with its 2.4.26. Not eve=
n
on OSS, it seems to be btw failing too.=20

Updated the motherboard bios to the newest version, no improvement.

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
07-04-04 20:53 Anlar          New Bug                                    =
 =20
07-04-04 20:53 Anlar          Distribution              =3D> Gentoo - up =
to date
stable
07-04-04 20:53 Anlar          Kernel Version            =3D> 2.6.7       =
   =20
07-04-04 20:54 Anlar          Bug Monitored: Anlar                       =
 =20
07-06-04 22:04 Anlar          Bugnote Added: 0001387                     =
 =20
07-06-04 22:29 Anlar          File Added: asound.state                   =
 =20
07-06-04 22:58 Anlar          Bugnote Added: 0001389                     =
 =20
07-06-04 22:59 Anlar          Bugnote Edited: 0001389                    =
 =20
07-07-04 17:32 Anlar          Bugnote Edited: 0001389                    =
 =20
07-07-04 22:02 Anlar          Bugnote Added: 0001394                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
