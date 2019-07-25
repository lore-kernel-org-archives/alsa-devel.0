From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: codec2codec: run callbacks in order
Date: Thu, 25 Jul 2019 14:00:16 +0100
Message-ID: <20190725130016.GC4213@sirena.org.uk>
References: <20190724162405.6574-1-jbrunet@baylibre.com>
 <20190724162405.6574-2-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190724162405.6574-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 06:24:00PM +0200, Jerome Brunet wrote:
> When handling dai_link events on codec to codec links, run all .startup()
> callbacks on sinks and sources before running any .hw_params(). Same goes
> for hw_free() and shutdown(). This is closer to the behavior of regular
> dai links

This looks good but needs rebasing against -next due to Morimoto-san's
recent DAI changes:

  CC      sound/soc/soc-dapm.o
sound/soc/soc-dapm.c: In function =E2=80=98snd_soc_dai_link_event=E2=80=99:
sound/soc/soc-dapm.c:3857:10: error: implicit declaration of function =E2=
=80=98soc_dai_hw_params=E2=80=99; did you mean =E2=80=98snd_soc_dai_hw_para=
ms=E2=80=99? [-Werror=3Dimplicit-function-declaration]
    ret =3D soc_dai_hw_params(&substream, params, source);
          ^~~~~~~~~~~~~~~~~
          snd_soc_dai_hw_params

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl05p+AACgkQJNaLcl1U
h9AP+gf+KYWXJgB5nW6jPKjIT4VghTppSU3QuuCdZrhY/sNBJSzzMz6wo1IPyz97
fyMJDcDemoa6wbn2EdzxffFQKt7DlKNs8fNe1TSu6SaQaITcI5iGYaeeQ0U+t1ps
bydYObp41RlNN66PWCqoObTjwrtmbT4KjZt6VVD/rpUA+TYVaT4lAlC43lYdGOwS
s1U3cqK0UhnJ2tl7ijvp1GbohlH7hG+STTgSwMVHjnqTvDAnLJrQ7aXO4U39m4mc
GKQ2VtknUOXH4SmQ/HCyLdKOHXSv2fWdEMSeD65MBUxRnfW9ivMoQabStIA39rk9
m1xUbylnxDjw8hciPEbmbsQapqiavg==
=HgG8
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
