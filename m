From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4 v2] ASoC: arizona: Add DVFS handling
 for sample rate control
Date: Sat, 21 Jun 2014 21:51:57 +0100
Message-ID: <20140621205157.GC24291@sirena.org.uk>
References: <1403275273-22713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1403275273-22713-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2498986056278549783=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A4C02619E5
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 23:10:33 +0200 (CEST)
In-Reply-To: <1403275273-22713-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============2498986056278549783==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2014 at 03:41:12PM +0100, Charles Keepax wrote:
> From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
>=20
> Some codecs need to boost DVFS for higher sample rates.

One tiny nit:

> +		if (ret !=3D 0) {
> +			arizona_aif_err(dai, "Failed to change DVFS %d\n", ret);
> +			return ret;

Normal style would be "Failed to change DVFS: %d\n".

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpfBqAAoJELSic+t+oim9LtIQAJCNlHY2ebfpAg+/lZAIbrQ+
BZiNvP3Tv6gzxUWnC9fkgmcWsyypvZPZEIiaaU0J0YAyBvmbddY1Ippvpwj/Xvmn
2by2Gd8dwmsxi7bXglLr5qhGHIpPcffhh4RyrzHE9Jt9T33PH0ru/IswE/YeZJQ6
h0UESinIyEJHEbvzyt1FqTRoJ5aVUscf0r5zZmT3WAYDYvHhY0bNz9fp32hmzHoL
1pCyipfsbhKNGi+ZRC8MJRaVpfhY2xcVaz8r8XKJ2wOWRDHqGGy+XOSRg7IjOLr2
00y0rk2CzC7ZbqpK4fY+5UL6nMKrCuEdkaekTFsKhGiXAyCLgxLYL2REzVcDh21o
W9TwaSKvbpeS1kwH9FqNB5nF/FLMlvx642MbWRAIFOCLyJTh28fO2Rmh0RnMYaPL
k1A2rAWUA5YXUtK8c7zShsBngpKtv/SD2BVRndTJ4UdXuEBW028/14vWP2tNkdud
AavKDyWyJtap9cRxg4y6rdadODw8nQmbwMbxiuanvWkZcrdzkjMGHFQspcMU0hRC
cOGzpdzk9GCgjylGl7PKjzuszBiQdYLsetxyYYTCpDGLqXb+Ny6YLAsBlmPuJkaZ
Az47Nx3yHz0wWl32IOFsytdGzU7Aewa26TvZnKd7pBX3bDZHV9b1nSNKZVqT1D/x
3Z0fOTDtBapYcBVYHmY3
=m22v
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

--===============2498986056278549783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2498986056278549783==--
