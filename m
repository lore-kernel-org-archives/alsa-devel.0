From: Prakash Punnoor <prakash@punnoor.de>
Subject: alsa-lib(-1.0.10) sets wrong path for pkg-config --cflags
Date: Tue, 27 Dec 2005 09:25:47 +0100
Message-ID: <200512270925.47901.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1227785.yoaztxQSO3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.126.177])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 84D9D16F
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2005 09:22:10 +0100 (MET)
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

--nextPart1227785.yoaztxQSO3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

pkg-config alsa --cflags returns

=2DI/usr/include/alsa

which is wrong, as you are supposed to include alsa in userspace via
#include <alsa/asoundlib.h> and not via #include <asoundlib.h>, right?

So alsa --cflags should either return nothing or -I/usr/include. Of course
above "works" with gentoo, as alsa headers are installed in standard locati=
on,
so they are found via standard include.

I am also not so sure whether pkg-config alsa --libs returns way too much=20
libs.
(-lasound -lm -ldl -lpthread)

Unless you are linking statically (-static) you really only need -lasound,=
=20
unless you use explicitly use dlopen/math/pthread. But as --libs should=20
return libs needed only by linking to alsa non-statically, I guess returnin=
g=20
=2Dlasound should be enough.

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1227785.yoaztxQSO3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDsPqLxU2n/+9+t5gRAkDfAKCbdMhwqSaiLhT4nz2NFLj5sfHHRwCdH8QU
UdEJfio9vNmz94AbAg/z798=
=8A0k
-----END PGP SIGNATURE-----

--nextPart1227785.yoaztxQSO3--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
