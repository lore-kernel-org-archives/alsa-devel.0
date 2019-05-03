From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: mediatek: mt8516: Add ADDA DAI driver
Date: Fri, 3 May 2019 15:00:34 +0900
Message-ID: <20190503060034.GD14916@sirena.org.uk>
References: <20190502121041.8045-1-fparent@baylibre.com>
 <20190502121041.8045-5-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/EQiL+SffV/fXkvV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190502121041.8045-5-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com, kaichieh.chuang@mediatek.com, shunli.wang@mediatek.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--/EQiL+SffV/fXkvV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 02, 2019 at 02:10:40PM +0200, Fabien Parent wrote:

> +static int mt8516_afe_adda_hw_params(struct snd_pcm_substream *substream,
> +			  struct snd_pcm_hw_params *params,
> +			  struct snd_soc_dai *dai)
> +{
> +	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
> +	unsigned int width_val = params_width(params) > 16 ?
> +		(AFE_CONN_24BIT_O03 | AFE_CONN_24BIT_O04) : 0;

Please write normal conditional statements rather than burying things in
the variable declarations usin the ternery operator, it makes things
much more legible.

--/EQiL+SffV/fXkvV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzL2QEACgkQJNaLcl1U
h9CnBQf+I75JGpPa7HZs9a5wiVauteNssp4QFPfRbk8PmvqiqEycEs+1ykqmWwhK
K7c2GX0MELLAlaU9UmlelicrJB5+xaGGOAUFl5CVnVt9zxLdrXPvfeet/dK9FBtY
Vpjh1BVvkUYgD9gz/u2sRgOtysfwQzfB17Uh3GtNHfoofg4Fhi/MqevPdkDyRf00
ZelGCTTFYLeFLm66hzyjZHfGPlRBTG1G7IcNJ/mRgGg7Asc2LaxhauBM0nLTqANG
H5t9WOoaoIbQy2JDR0PCw22mB0gE+tY7gkMZZy3NWxnzZk4uNTgR5Me2P/vly6Bc
x6jXh8xYjanv7sdTg/r/in0JXtVYTA==
=rEDi
-----END PGP SIGNATURE-----

--/EQiL+SffV/fXkvV--
