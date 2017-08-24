From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: remove duplicate definition of
 controls/num_controls
Date: Thu, 24 Aug 2017 14:50:05 +0100
Message-ID: <20170824135005.6fqhutprcakq6aqj@sirena.org.uk>
References: <874lsxrdgl.wl%kuninori.morimoto.gx@renesas.com>
 <87378hrdfe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5005145641749073813=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B30A1266DE5
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 15:50:15 +0200 (CEST)
In-Reply-To: <87378hrdfe.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============5005145641749073813==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sutb2r3pdsjgmik2"
Content-Disposition: inline


--sutb2r3pdsjgmik2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 01:03:32AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> snd_soc_component and snd_soc_component_driver both have
> controls/num_controls, but these are duplicated.
> Let's remove duplicated definition.

This doesn't apply against current code, please check and resend.

--sutb2r3pdsjgmik2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlme2YwACgkQJNaLcl1U
h9CGqgf/d101QcoieCsNAg0xaqEAgEOD1+/jlZuk3sGCN3VqFd45SVanYZVKICd5
bKrGDSAQBQdLGT5d/lmo1LTSlQtU714VyEbJ00hkCThkVKe1/p1N6cnwwEQ6w05s
ZnA4gS6gMa9KTIDRjbkRl2iXqeNrNJMc5W9/+ljHkKdd/BzWAkuRVL2e/qd1ic9a
QSbD/nqacS1CadvMb3eLEdgbMx7uO/LU/j78Wez9znjLvrhCAdilFJ8MhBzen8Yu
WVX0mJzgV5mjDNQS7RGuiRUtexbIBkHmyAxg4J1r36O7ykeMEm1q4/kCJN2TGRLc
vfAIsG8Km8hEEemLgQ1MGzREihws5g==
=1Nfd
-----END PGP SIGNATURE-----

--sutb2r3pdsjgmik2--

--===============5005145641749073813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5005145641749073813==--
