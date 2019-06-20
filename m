From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rk3399_gru_sound: Support 32, 44.1 and 88.2 kHz
 sample rates
Date: Thu, 20 Jun 2019 16:41:50 +0100
Message-ID: <20190620154150.GE5316@sirena.org.uk>
References: <20190620134708.28311-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rOnZ5ITIX7GHaQD9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190620134708.28311-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Collabora Kernel ML <kernel@collabora.com>, Xing Zheng <zhengxing@rock-chips.com>, Benson Leung <bleung@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--rOnZ5ITIX7GHaQD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2019 at 03:47:08PM +0200, Enric Balletbo i Serra wrote:
> According to the datasheet the max98357a also supports 32, 44.1 and
> 88.2 kHz sample rate. This support was also introduced recently by
> commit fdf34366d324 ("ASoC: max98357a: add missing supported rates").
> This patch adds support for these rates also for the machine driver so
> we get rid of the errors like the below and we are able to play files
> using these sample rates.

Does the machine actually need to validate this at all?  The component
drivers can all apply whatever constraints are needed and do their own
validation, the machine driver is just getting in the way here.

--rOnZ5ITIX7GHaQD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0LqT0ACgkQJNaLcl1U
h9Aomwf+IWYRVucBBZvhsm/gdBVe/B8CpBjmp/2qlcOTbdBRiwV3TGlwjFiWqyNF
a/7criDs2zMUCDb4Ad2Xh7FoRj24dC+1QikkP64iwyN/Y5wJLwQhRRDuM60vjRGp
waQP/rQ86h14cWtTi/+IE8Rm3nFcs/0J0S+87SVuW8kIifVcEAzUGYH8fhTwgkki
SerVWbkR+weSZLJVq/cvR2CKQvt4qPaQ2AT2V7W9pCRzBJRza8CLIg+t7jaFUuLP
EefouE+9/aOgtVf4NT+BPfcy7pptkMZwAsbX0Obcm6+1dmIpjffWRdRzki4AVnJD
wUUi0N6O0HWIkSLhMnqzgBaOrZBMjg==
=cr78
-----END PGP SIGNATURE-----

--rOnZ5ITIX7GHaQD9--
