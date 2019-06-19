From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: soc.h: dobj is used only when
 SND_SOC_TOPOLOGY" to the asoc tree
Date: Wed, 19 Jun 2019 20:00:16 +0100
Message-ID: <20190619190016.GZ5316@sirena.org.uk>
References: <20190619121158.E355D440046@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3036874137180364389=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4D01F80C87
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 21:00:18 +0200 (CEST)
In-Reply-To: <20190619121158.E355D440046@finisterre.sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3036874137180364389==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WSf/+y6apGpKq+5a"
Content-Disposition: inline


--WSf/+y6apGpKq+5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 01:11:58PM +0100, Mark Brown wrote:
> The patch
>=20
>    ASoC: soc.h: dobj is used only when SND_SOC_TOPOLOGY
>=20
> has been applied to the asoc tree at
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=20

Dropped this, it breaks the build in a lot of configurations since dobj
does have some other users.

--WSf/+y6apGpKq+5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0KhkAACgkQJNaLcl1U
h9BYLgf/fORxqFPisc/41mAvSIrarhLNbulNMBHfx/k+em30kKwFiqESMiqQQRpU
QVGsqTaYALb05JvPbEtNjLbsWT5P4Su5isY82NyOAlY8hsrfVqIvOXboL6cm03Nx
OR0HxhDnZDntPuKbfI+MktrnuXWToCJgCI25fUzPW4fHb3ziQzqrACAEnKE0fonx
8RS2cHRkc+zhoPsKEObKywl5fQxsGdZxcpNhgKZ6VB7Wyti23rBaXAbM3bChPHdQ
P/Ct2UugeFEla3mdBXCs8jNQr4Nnb4qkHdoJwwk2N/9Hj0vPRmpNDrsAUJ4yQEiY
BV/wHg37ihUyFQVMbss1WclO8m+K5Q==
=/Ik5
-----END PGP SIGNATURE-----

--WSf/+y6apGpKq+5a--

--===============3036874137180364389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3036874137180364389==--
