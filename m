From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: alsa-driver 1.0.18 doesn't built on PPC 2.6.27	and
	2.6.28
Date: Tue, 4 Nov 2008 18:27:11 +0100
Message-ID: <20081104172711.GB8872@bilbo.home.lxtec.de>
References: <20081104134434.GA4122@bilbo.home.lxtec.de>
	<s5hr65rqwu6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0081375210399499109=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 07D1D1037FF
	for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2008 18:27:21 +0100 (CET)
In-Reply-To: <s5hr65rqwu6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org


--===============0081375210399499109==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Takashi Iwai [081104 17:40 +0100]
> At Tue, 4 Nov 2008 14:44:34 +0100,
> Elimar Riesebieter wrote:
> >=20
> >=20
> > Hi all,
> >=20
> > please note the following error:
> >=20
> > /usr/bin/make -C /usr/src/linux-2.6.27.2 SUBDIRS=3D/usr/src/modules/als=
a-driver  CPP=3D"gcc-4.3 -E" CC=3D"gcc-4.3" modules
> > make[4]: Entering directory `/usr/src/linux-2.6.27.2'
> >   CC [M]  /usr/src/modules/alsa-driver/acore/hwdep.o
> > In file included from /usr/src/linux-2.6.27.2/arch/powerpc/include/asm/=
system.h:528,
> >                  from include/linux/list.h:7,
> >                  from include/linux/module.h:9,
> >                  from /usr/src/modules/alsa-driver/include/adriver.h:26,
> >                  from /usr/src/modules/alsa-driver/acore/hwdep.c:1:
> > include/asm-generic/cmpxchg-local.h: In function '__cmpxchg_local_gener=
ic':
> > include/asm-generic/cmpxchg-local.h:23: error: implicit declaration of =
function 'local_irq_save'
> > include/asm-generic/cmpxchg-local.h:44: error: implicit declaration of =
function 'local_irq_restore'
> > make[6]: *** [/usr/src/modules/alsa-driver/acore/hwdep.o] Fehler 1
> > make[5]: *** [/usr/src/modules/alsa-driver/acore] Fehler 2
> > make[4]: *** [_module_/usr/src/modules/alsa-driver] Fehler 2
> > make[4]: Leaving directory `/usr/src/linux-2.6.27.2'
> > make[3]: *** [compile] Fehler 2
> > make[3]: Leaving directory `/usr/src/modules/alsa-driver'
> > make[2]: *** [build-stamp] Fehler 2
> > make[2]: Leaving directory `/usr/src/modules/alsa-driver'
> > make[1]: *** [kdist_image] Fehler 2
> > make[1]: Leaving directory `/usr/src/modules/alsa-driver'
> > Module /usr/src/modules/alsa-driver failed.
> >=20
> > Same on 2.6.28-rc3
> >=20
> > BTW, alsa-driver 1.0.18 builds fine on PPC 2.6.26. The PPC divers
> > build fine out of vanilla trees (1.6.26/1.0.17 and 2.6.28/1.0.18-rc3)
>=20
> Could you check the snapshot tarball below?
>     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driv=
er-snapshot.tar.gz

# ./gitcompile

=2E....
make[1]: Entering directory `/usr/src/linux-2.6.28-rc3'
  CC [M]  /source/alsa/svn-pkg-alsa/tmp/alsa-driver/acore/hwdep.o
In file included from /usr/src/linux-2.6.28-rc3/arch/powerpc/include/asm/sy=
stem.h:528,
                 from include/linux/list.h:7,
                 from include/linux/module.h:9,
                 from /source/alsa/svn-pkg-alsa/tmp/alsa-driver/include/adr=
iver.h:57,
                 from /source/alsa/svn-pkg-alsa/tmp/alsa-driver/acore/hwdep=
=2Ec:1:
include/asm-generic/cmpxchg-local.h: In function '__cmpxchg_local_generic':
include/asm-generic/cmpxchg-local.h:23: error: implicit declaration of func=
tion 'local_irq_save'
include/asm-generic/cmpxchg-local.h:44: error: implicit declaration of func=
tion 'local_irq_restore'
make[3]: *** [/source/alsa/svn-pkg-alsa/tmp/alsa-driver/acore/hwdep.o] Fehl=
er 1
make[2]: *** [/source/alsa/svn-pkg-alsa/tmp/alsa-driver/acore] Fehler 2
make[1]: *** [_module_/source/alsa/svn-pkg-alsa/tmp/alsa-driver] Fehler 2
make[1]: Leaving directory `/usr/src/linux-2.6.28-rc3'
make: *** [compile] Fehler 2

Elimar

--=20
  Alles was viel bedacht wird ist bedenklich!;-)
         Friedrich Nietzsche

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkQhe8ACgkQ3Ig8bsVPf7D7sQCdGIr7majJvaSkySKgfLMTcCme
a9cAoKYY0P2vchZpe+cocPevSNug0kxq
=CpgK
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--

--===============0081375210399499109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0081375210399499109==--
