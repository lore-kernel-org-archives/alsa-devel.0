From: Mark Brown <broonie@kernel.org>
Subject: Re: [v2] ASoC: AMD: Configure wclk and bclk of master codec
Date: Mon, 25 Mar 2019 12:06:41 +0000
Message-ID: <20190325120641.GE7284@sirena.org.uk>
References: <20190325063759.28300-1-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jTMWTj4UTAEmbWeb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190325063759.28300-1-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Adam.Thomson.Opensource@diasemi.com" <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Wei Yongjun <weiyongjun1@huawei.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--jTMWTj4UTAEmbWeb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 06:38:27AM +0000, Agrawal, Akshu wrote:

> v2: Removed clk set rate and enable/disable from da7219 ops as
> da7219 codec takes care of them internally. Clock configuration
> kept for those codecs where da7219 acts as master of clock.
> As suggested by Adam Thomson.
>=20
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---

Place any inter-version changelogs after the --- as covered in
submitting-patches.rst.=20

--jTMWTj4UTAEmbWeb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyYxFAACgkQJNaLcl1U
h9Bwtgf/S5cgck6hSu5iyhKwTjGNtEgyPIFBMYUguqKWMZ3gn5raaj5Jk10Ivfhx
PMFH1Rm/k8UzxXl9r2qqb/lqQWHRCt9GDf5RwobpaopYlVONlNKiSx4W6kSqOrjb
JOp00I+unTbeO1LOXPgokwm0dRzRz7JUUgM74QSkghOky6G3qVThY+GG2nBYswr6
i6Ixgo1qvFcc1gI0weEN9Dl04OFCB/dKbBXPvZx6pFCFsWwyvZdMNbOAn7w8paGg
fzoZxNULc3UimvOAhRVQD5O6+dX5rKmbFkMC0C7ZX6IGyoCXWovS01peGfnA8bsJ
Q5Z5l2qykwbet9wBI/NIdGWe/RgHJA==
=JFBI
-----END PGP SIGNATURE-----

--jTMWTj4UTAEmbWeb--
