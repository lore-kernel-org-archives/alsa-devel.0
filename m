From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: build failures in asihpi (was: ALSA 1.0.12rc1 release)
Date: Sun, 2 Jul 2006 01:17:59 +0200
Message-ID: <20060701231759.GQ24584@neu.nirvana>
References: <Pine.LNX.4.61.0606231231370.10283@tm8103-a.perex-int.cz>
Reply-To: ALSA development <alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1921640774=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from junior.physik.fu-berlin.de (at1-old.physik.fu-berlin.de
	[160.45.32.86])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 89148239
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Jul 2006 01:18:04 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0606231231370.10283@tm8103-a.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1921640774==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JQ29orswtRjjfiJM"
Content-Disposition: inline


--JQ29orswtRjjfiJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 23, 2006 at 12:32:34PM +0200, Jaroslav Kysela wrote:
> Hi,
>=20
> 	all packages except alsa-oss (no changes) were released. Enjoy!
>=20
> 						Jaroslav

I'm having troubles compiling this on x86_64 distributions (from
2.6.10 to 2.6.17 based kernels). The build fails on
pci/asihpi/hpimod.c (see below). I also had to modify some #include <>
to #include "" in pci/asihpi/hpi56301.c (dpi56301.h & boot4ka.h)

Thanks!

  CC [M]  /builddir/alsa-driver-1.0.12rc1/pci/ali5451/ali5451.o
  LD [M]  /builddir/alsa-driver-1.0.12rc1/pci/ali5451/snd-ali5451.o
  CC [M]  /builddir/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.o
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c: In function 'snd_card_=
asihpi_playback_hw_params':
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:352: warning: cast from=
 pointer to integer of different size
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c: In function 'snd_card_=
asihpi_playback_copy':
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:563: warning: cast from=
 pointer to integer of different size
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c: In function 'snd_card_=
asihpi_capture_hw_params':
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:683: warning: cast from=
 pointer to integer of different size
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c: In function 'snd_card_=
asihpi_capture_copy':
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:876: warning: cast from=
 pointer to integer of different size
  CC [M]  /builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.o
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c: In function 'hpi_ioctl=
':
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c:255: warning: cast to p=
ointer from integer of different size
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c:260: warning: cast from=
 pointer to integer of different size
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c: In function 'adapter_p=
robe':
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c:461: warning: cast from=
 pointer to integer of different size
In file included from /builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c:5=
72:
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h: At top level:
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:30: error: initialize=
r element is not constant
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:30: error: (near init=
ialization for 'asihpi_pci_tbl[0].driver_data')
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:36: error: initialize=
r element is not constant
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:36: error: (near init=
ialization for 'asihpi_pci_tbl[1].driver_data')
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:42: error: initialize=
r element is not constant
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:42: error: (near init=
ialization for 'asihpi_pci_tbl[2].driver_data')
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:47: error: initialize=
r element is not constant
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:47: error: (near init=
ialization for 'asihpi_pci_tbl[3].driver_data')
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:52: error: initialize=
r element is not constant
/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:52: error: (near init=
ialization for 'asihpi_pci_tbl[4].driver_data')
make[4]: *** [/builddir/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.o] Error 1
make[3]: *** [/builddir/alsa-driver-1.0.12rc1/pci/asihpi] Error 2
make[2]: *** [/builddir/alsa-driver-1.0.12rc1/pci] Error 2
make[1]: *** [_module_/builddir/alsa-driver-1.0.12rc1] Error 2


--=20
Axel.Thimm at ATrpms.net

--JQ29orswtRjjfiJM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEpwKnQBVS1GOamfERAu4GAJ9b8LJQUhJBX+mX+VjkDTyPaNHxBQCfY8h6
eiVhR+XpQsJaPegCdBjWGYY=
=dLCq
-----END PGP SIGNATURE-----

--JQ29orswtRjjfiJM--


--===============1921640774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1921640774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1921640774==--
