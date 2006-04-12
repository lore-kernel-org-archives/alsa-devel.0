From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Missing definition for DMA_31BIT_MASK on older kernels
Date: Thu, 13 Apr 2006 00:25:16 +0200
Message-ID: <20060412222516.GJ13693@neu.nirvana>
Reply-To: alsa-devel@alsa-project.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from junior.physik.fu-berlin.de (junior.physik.fu-berlin.de [160.45.32.227])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E653154
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 00:25:46 +0200 (MEST)
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


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

alsa-kernel/pci/ali5451/ali5451.c uses DMA_31BIT_MASK which for the
latest kernels is defined in include/linux/dma-mapping.h. Previous
kernels don't have this constant defined.

E.g. on 2.6.12:

  LD [M]  /builddir/alsa-driver-1.0.11rc5/pci/ac97/snd-ak4531-codec.o
  CC [M]  /builddir/alsa-driver-1.0.11rc5/pci/ali5451/ali5451.o
In file included from /builddir/alsa-driver-1.0.11rc5/pci/ali5451/ali5451.c=
:1:
/builddir/alsa-driver-1.0.11rc5/pci/ali5451/../../alsa-kernel/pci/ali5451/a=
li5451.c: In function `ali_resume':
/builddir/alsa-driver-1.0.11rc5/pci/ali5451/../../alsa-kernel/pci/ali5451/a=
li5451.c:2054: warning: ignoring return value of `pci_enable_device', decla=
red with attribute warn_unused_result
In file included from /builddir/alsa-driver-1.0.11rc5/pci/ali5451/ali5451.c=
:1:
/builddir/alsa-driver-1.0.11rc5/pci/ali5451/../../alsa-kernel/pci/ali5451/a=
li5451.c: In function `snd_ali_create':
/builddir/alsa-driver-1.0.11rc5/pci/ali5451/../../alsa-kernel/pci/ali5451/a=
li5451.c:2224: error: `DMA_31BIT_MASK' undeclared (first use in this functi=
on)
/builddir/alsa-driver-1.0.11rc5/pci/ali5451/../../alsa-kernel/pci/ali5451/a=
li5451.c:2224: error: (Each undeclared identifier is reported only once
/builddir/alsa-driver-1.0.11rc5/pci/ali5451/../../alsa-kernel/pci/ali5451/a=
li5451.c:2224: error: for each function it appears in.)
make[4]: *** [/builddir/alsa-driver-1.0.11rc5/pci/ali5451/ali5451.o] Error 1
make[3]: *** [/builddir/alsa-driver-1.0.11rc5/pci/ali5451] Error 2
make[2]: *** [/builddir/alsa-driver-1.0.11rc5/pci] Error 2
make[1]: *** [_module_/builddir/alsa-driver-1.0.11rc5] Error 2
--=20
Axel.Thimm at ATrpms.net

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEPX5MQBVS1GOamfERAtrrAJ0cMLoz2YbHH7B8tlPNjQ3Tg4NzWQCfUqJ+
lMOGkmpdVXCJ2wHCbcSOH8s=
=O/uz
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
