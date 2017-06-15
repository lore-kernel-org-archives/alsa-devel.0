From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: ak4613: add use CTRL2::CKS = 00
Date: Thu, 15 Jun 2017 11:22:36 +0100
Message-ID: <20170615102236.sxxxjqnjef3xoev3@sirena.org.uk>
References: <87r2ymm6n2.wl%kuninori.morimoto.gx@renesas.com>
 <87poe6m6lz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vkbpp6lhhu7woxv"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87poe6m6lz.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--5vkbpp6lhhu7woxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 12:39:40AM +0000, Kuninori Morimoto wrote:

> ak4613 CTRL2::CKS controls Speed Mode (Normal/Double/Quad) for Master
> Mode. In default, Normal Mode uses 512fs, but in such case, requested
> input clock for all mode will be same. Then, it might not be eble to
> support correct output if input clock was not enough.
> This patch uses 256fs, and reduse requested imput clock for Noral Mode.

>  	snd_soc_update_bits(codec, CTRL1, FMT_MASK, fmt_ctrl);
> -	snd_soc_update_bits(codec, CTRL2, DFS_MASK, ctrl2);
> +
> +	/* CKS =3D 00 */
> +	snd_soc_update_bits(codec, CTRL2, (CKS_MASK | DFS_MASK), ctrl2);

This looks board specific - shouldn't we be setting the speed mode based
on a combination of the sampling rate and the master clock for the
device? =20

--5vkbpp6lhhu7woxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllCX+sACgkQJNaLcl1U
h9B3dQf/VwwFbIpIrSpA1CbVoyX4yymH5u1molyLiml6oPN0QNPlUkeWzds0LfKl
LGlSZFNraHFbyd6yZWsQH/NTS/IDYlmRlNSTk7AJNbhUfOOB+3XEiwi8KuR5aeeJ
T0zgbFqvhJwWKZFZc2jYBqoSKyE2PhY2b5dxWi+CM8NYqL8TllHX/saBVOi2q65O
/bF2zUMFrvldyJZEIGdRLgEfYkvSNLN94TPRFa++aVlPQ1YoM+bXl6UrYqx5m7TZ
Dd+pEuqV5Us0x2emiIxZ3clwunwoQ58D7RDtpulOChGVmWEXDZs5GD/6GlYZuxf5
sLADrzyEZSzzJSeeJajxQHK3Qb/6tQ==
=8TrF
-----END PGP SIGNATURE-----

--5vkbpp6lhhu7woxv--
