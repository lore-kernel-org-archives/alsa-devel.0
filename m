From: bugtrack@alsa-project.org
Subject: =?iso-8859-1?q?=5BALSA_-_driver_0002117=5D=3A_No_5?=
 =?iso-8859-1?q?=2E1-support_f=FCr_VIA8237x/1617_based_soundsystems_=28i?=
 =?iso-8859-1?q?=2Ee=2E_VIA_EPIA_SP8000-Board=29?=
Date: Tue, 30 May 2006 11:51:16 +0200
Message-ID: <504520b2a20525b1d4dee1ab48a3c8c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6804A141
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 11:51:16 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D2117> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                Flipsen1977
Assigned To:                =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Issue ID:                   2117
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             05-12-2006 09:42 CEST
Last Modified:              05-30-2006 11:51 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    No 5.1-support f=FCr VIA8237x/1617 based sounds=
ystems
(i.e. VIA EPIA SP8000-Board)
Description: =

I've installed the latest via82xx-module, 2-channel works fine, but
6-channel isn't available at all.

alsamixer shows all the channels, they are unmuted und up at 90-100%, but
center/lfe und rear speakers don't work. I've been missing an opportunity
to switch the line-in and mic-in to output. As I read in some articles
there isn't yet support for this chipset.

Is there already something done?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 doobedoobedo - 05-26-06 20:56 =

----------------------------------------------------------------------
Here you go, hope it helps. I'm quite willing to do any
experimenting/testing you think may be useful...

----------------------------------------------------------------------
 Flipsen1977 - 05-30-06 11:51 =

----------------------------------------------------------------------
Posted my files, too. If you need something more, tell us!

Issue History
Date Modified  Username       Field                    Change              =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
05-12-06 09:42 Flipsen1977    New Issue                                    =

05-12-06 09:42 Flipsen1977    Distribution              =3D> Debian        =
  =

05-12-06 09:42 Flipsen1977    Kernel Version            =3D> 2.6.15        =
  =

05-12-06 16:03 tiwai          Note Added: 0009775                          =

05-15-06 14:27 Flipsen1977    Note Added: 0009823                          =

05-15-06 22:17 Flipsen1977    Note Edited: 0009823                         =

05-26-06 02:45 doobedoobedo   Note Added: 0009970                          =

05-26-06 14:49 tiwai          Note Added: 0009977                          =

05-26-06 20:50 doobedoobedo   File Added: somefile                         =

05-26-06 20:50 doobedoobedo   File Added: ac97#0-0                         =

05-26-06 20:51 doobedoobedo   File Added: ac97#0-0+regs                    =

05-26-06 20:56 doobedoobedo   Note Added: 0009980                          =

05-27-06 12:22 doobedoobedo   Issue Monitored: doobedoobedo                =
    =

05-30-06 11:38 Flipsen1977    File Added: 1617A                            =

05-30-06 11:49 Flipsen1977    File Added: ac97#0-0+regs_flipsen            =
     =

  =

05-30-06 11:49 Flipsen1977    File Added: ac97#0-0_flipsen                 =
   =

05-30-06 11:51 Flipsen1977    Note Added: 0010019                          =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
