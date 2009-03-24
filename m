From: Tim Blechmann <tim@klingt.org>
Subject: Re: [PATCH] alsa: lx6464es - driver for the
 digigram	lx6464es interface
Date: Tue, 24 Mar 2009 12:23:20 +0100
Message-ID: <20090324122320.53f78c9b@thinkpad>
References: <s5hvdq05xjb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1134366045316290540=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id C61C4103800
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 12:24:58 +0100 (CET)
In-Reply-To: <s5hvdq05xjb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--===============1134366045316290540==
Content-Type: multipart/signed; boundary="Sig_/dm8X21wTvI/6RtHgb95ofCx";
 protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/dm8X21wTvI/6RtHgb95ofCx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

hi takashi,

i tried to address the issues ...

Tim Blechmann (1):
  alsa: lx6464es - driver for the digigram lx6464es interface

 include/linux/pci_ids.h       |    5 +
 sound/pci/Kconfig             |   10 +
 sound/pci/Makefile            |    1 +
 sound/pci/lx6464es/Makefile   |    2 +
 sound/pci/lx6464es/lx6464es.c | 1152 ++++++++++++++++++++++++++++++++
 sound/pci/lx6464es/lx6464es.h |  114 ++++
 sound/pci/lx6464es/lx_core.c  | 1442 +++++++++++++++++++++++++++++++++++++=
++++
 sound/pci/lx6464es/lx_core.h  |  242 +++++++
 sound/pci/lx6464es/lx_defs.h  |  376 +++++++++++
 9 files changed, 3344 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/lx6464es/Makefile
 create mode 100644 sound/pci/lx6464es/lx6464es.c
 create mode 100644 sound/pci/lx6464es/lx6464es.h
 create mode 100644 sound/pci/lx6464es/lx_core.c
 create mode 100644 sound/pci/lx6464es/lx_core.h
 create mode 100644 sound/pci/lx6464es/lx_defs.h

--Sig_/dm8X21wTvI/6RtHgb95ofCx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknIwqgACgkQdL+4qsZfVsvXKgCgm6OWR6ix03b1IlPpchkLR3vx
VRIAnRubqIDuOxbjVlz5mwz+Z2kNI5J5
=RHYz
-----END PGP SIGNATURE-----

--Sig_/dm8X21wTvI/6RtHgb95ofCx--

--===============1134366045316290540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1134366045316290540==--
