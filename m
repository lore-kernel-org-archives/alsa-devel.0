From: Jordi Mallach <jordi@debian.org>
Subject: Re: building jack
Date: Sun, 20 Apr 2003 22:02:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030420200233.GA32364@nubol.int.oskuro.net>
References: <20030420151813.GA20213@nubol.int.oskuro.net> <20030420172344.2d10e4af.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030420172344.2d10e4af.mista.tapas@gmx.net>
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


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2003 at 05:23:44PM +0200, Florian Schmidt wrote:
> You are missing the jack header files.

Oops.

Ok, it compiles now, but it won't install.

/usr/bin/make -C src/pcm/ext install-jack DESTDIR=3D/tmp/alsa-lib/debian/tmp
make[1]: Entering directory `/tmp/alsa-lib/src/pcm/ext'
/bin/sh ../../../mkinstalldirs /tmp/alsa-lib/debian/tmp/usr/lib/alsa-lib
mkdir /tmp/alsa-lib/debian/tmp/usr/lib/alsa-lib
/bin/sh ../../../libtool --mode=3Dinstall   libasound_module_pcm_jack.la /t=
mp/alsa-lib/debian/tmp/usr/lib/alsa-lib/libasound_module_pcm_jack.la
libtool: install: you must specify a destination

Makefile.am reads:

        $(LIBTOOL) --mode=3Dinstall $(pkglibLTLIBRARIES_INSTALL) $(INSTALL_=
STRIP_FLAG) libasound_module_pcm_jack.la $(DESTDIR)$(pkglibdir)/libasound_m=
odule_pcm_jack.la

but pkglib_LTLIBRARIES_INSTALL isn't defined.

Is this a typo in Makefile.am?

Thanks,
Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ovzZJYSUupF6Il4RApJAAKDUJCMCqxmp4QI5ZDtr7j/AekHFXwCcC48s
vNG7M1spCbk+Kpcc7tZpfDM=
=ybMP
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
