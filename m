From: Jordi Mallach <jordi@debian.org>
Subject: building jack
Date: Sun, 20 Apr 2003 17:18:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030420151813.GA20213@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I've tried to build the jack plugin for alsa-lib, but I can't. Both in
CVS and 0.9.2, jack.h appears to be missing and the compile fails.

gcc -DHAVE_CONFIG_H -I. -I. -I../../../include -I../../../include -I../../.=
=2E/src/pcm -O2 -Wall -W -pipe -g -MT pcm_jack.lo -MD -MP -MF .deps/pcm_jac=
k.Tpo -c pcm_jack.c  -fPIC -DPIC -o pcm_jack.lo
pcm_jack.c:36:23: jack/jack.h: No such file or directory
pcm_jack.c:68: syntax error before "jack_port_t"
pcm_jack.c:68: warning: no semicolon at end of struct or union
pcm_jack.c:69: warning: type defaults to `int' in declaration of `client'
pcm_jack.c:69: warning: data definition has no type or storage class
[...]

Any idea?

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+oro1JYSUupF6Il4RAi8sAKDDWVl4zvHSTK4k2qa30HRyiMybqACgziTK
I9xrfgpofvjquRfYWOuFxC4=
=/j7i
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
