From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
Subject: configure and compile errors (possibly because of gcc 3.3)
Date: Thu, 19 Jun 2003 13:29:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030619132925.68cb59bd.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Mj+zPHD61'0/R1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=.Mj+zPHD61'0/R1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I cannot get the latest alsa-driver to compile.
First, I get a configure-error:
[...]
checking whether time.h and sys/time.h may both be included... yes
checking whether gcc needs -traditional... no
checking for current directory... /home/hanno/tmp/alsa-driver-0.9.4-alt
checking cross compile...=20
checking for directory with kernel source...
/lib/modules/2.4.21-ac1/build checking for kernel version... 2.4.21-ac1
checking for GCC version... Kernel compiler: gcc-Version 3.3 (Gentoo
Linux 1.4, PVR 3.3) Used compiler: gcc (GCC) 3.3 (Gentoo Linux 1.4, PVR
3.3) Fatal error: Compiler type does not match
Decoded kernel compiler: type=3Dgcc-Version version=3D3.3
Decoded used compiler: type=3Dgcc version=3D3.3
Please, send ./configure output to <alsa-devel@alsa-project.org>

Well, the kernel compiler and the used compiler are definitely the same.

Anyway, after changing the configure-script not to check the compiler, I
get a compile error. I tried to fix it, but I didn't find a reason for
it:
[...]
gcc -D__KERNEL__ -DMODULE=3D1
-I/home/hanno/tmp/alsa-driver-0.9.4-alt/include=20
-I/lib/modules/2.4.21-ac1/build/include -O2 -mpreferred-stack-boundary=3D2
-march=3Di686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD=20
-DKBUILD_BASENAME=3Dserial_u16550   -c -o serial-u16550.o serial-u16550.c
gcc -D__KERNEL__ -DMODULE=3D1
-I/home/hanno/tmp/alsa-driver-0.9.4-alt/include=20
-I/lib/modules/2.4.21-ac1/build/include -O2 -mpreferred-stack-boundary=3D2
-march=3Di686 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD=20
-DKBUILD_BASENAME=3Dserialmidi   -c -o serialmidi.o serialmidi.c
serialmidi.c: In function `open_tty': serialmidi.c:158: error: invalid
operands to binary > make[1]: *** [serialmidi.o] Fehler 1
make[1]: Leaving directory
`/home/hanno/tmp/alsa-driver-0.9.4-alt/drivers' make: *** [compile]
Fehler 1


So what can I do? How can I help to fix these issues?

--=20
Hanno B=F6ck - hanno@gmx.de


--=.Mj+zPHD61'0/R1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+8Z6ar2QksT29OyARAnghAJ946yTu/vnxQfy35dI/gFCkN64AEACcClJB
QMAnChCOzIbWMFT+vQcJg4k=
=AWl7
-----END PGP SIGNATURE-----

--=.Mj+zPHD61'0/R1--


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
