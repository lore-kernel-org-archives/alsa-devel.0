From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: 1.0.11rc5 on 2.4.22: riptide.c: structure has no member named `dev'
Date: Thu, 13 Apr 2006 23:39:16 +0200
Message-ID: <20060413213916.GB23511@neu.nirvana>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from junior.physik.fu-berlin.de (junior.physik.fu-berlin.de [160.45.32.227])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E06618A
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 23:39:21 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the riptide driver in 1.0.11rc5 fails on 2.4.22 with

make  -C riptide modules
make[2]: Entering directory `/builddir/alsa-driver-1.0.11rc5/pci/riptide'
/usr/bin/gcc32 -D__KERNEL__ -DMODULE=3D1 -I/builddir/alsa-driver-1.0.11rc5/=
include  -I/amd/heretic/0/data_nobkp/bach/bach-kernel/fc1-i386/2.4.22-1.219=
9.nptl_53.rhfc1.at-i686/include -O2 -mpreferred-stack-boundary=3D2 -march=
=3Di686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer -Wno-trigrap=
hs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwith=
prefix include -DMODVERSIONS -include /amd/heretic/0/data_nobkp/bach/bach-k=
ernel/fc1-i386/2.4.22-1.2199.nptl_53.rhfc1.at-i686/include/linux/modversion=
s.h  -DKBUILD_BASENAME=3Driptide   -c -o riptide.o riptide.c
In file included from riptide.c:1:
=2E./../alsa-kernel/pci/riptide/riptide.c: In function `riptide_reset':
=2E./../alsa-kernel/pci/riptide/riptide.c:1272: structure has no member nam=
ed `dev'
make[2]: *** [riptide.o] Error 1

Thanks!
--=20
Axel.Thimm at ATrpms.net

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEPsUEQBVS1GOamfERAhwqAKCH7tKwVjIpKwAMD2ckJp6Y/CnOigCffmlj
nh8/YWjYAEyr2v2q76zI6bw=
=ogIG
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
