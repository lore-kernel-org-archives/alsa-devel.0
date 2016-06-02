From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: sunxi: Add Allwinner A10 Digital Audio driver
Date: Thu, 2 Jun 2016 11:26:51 +0100
Message-ID: <20160602102651.GF2282@sirena.org.uk>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-3-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160601175430.11625-3-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andrea Venturi <ennesimamail.av@gmail.com>, Code Kipper <codekipper@gmail.com>, gianfranco@moddevices.com
List-Id: alsa-devel@alsa-project.org


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 01, 2016 at 07:54:28PM +0200, Maxime Ripard wrote:

> @@ -16,4 +25,5 @@ config SND_SUN4I_SPDIF
>  	help
>  	  Say Y or M to add support for the S/PDIF audio block in the Allwinner
>  	  A10 and affiliated SoCs.
> +
>  endmenu

Unrelated whitespace change.

> +static int sun4i_i2s_params_to_sr(struct snd_pcm_hw_params *params)
> +{
> +	switch (params_width(params)) {
> +	case 16:
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}

The switch statement here and in the _wss() function look weird because
they don't have default cases.  Since there's only one user of both
functions it seems better to have the switch statements inline anyway.

> +	for (i = 0; sun4i_i2s_mclk_div[i].div; i++) {
> +		const struct sun4i_i2s_clk_div *mdiv = sun4i_i2s_mclk_div + i;

Why not just write these as normal array lookups?

> +	switch (rate) {
> +        case 176400:
> +        case 88200:

Weird indentation here...  it also seems spaces not tabs are being
used for the case labels.

> +	clk_set_rate(i2s->mod_clk, clk_rate);

Should really check the return value.

> +	/* Enable the first output line */
> +	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +			   SUN4I_I2S_CTRL_SDO_EN_MASK,
> +			   SUN4I_I2S_CTRL_SDO_EN(0));
> +
> +	/* Enable the first two channels */
> +	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_SEL_REG,
> +		     SUN4I_I2S_TX_CHAN_SEL(2));
> +
> +	/* Map them to the two first samples coming in */
> +	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG,
> +		     SUN4I_I2S_TX_CHAN_MAP(0, 0) | SUN4I_I2S_TX_CHAN_MAP(1, 1));

We don't undo these if setup fails...  do them once on probe?

> +static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +        struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +	u32 val;

More tab/space damage, there seems to be quite a bit in the rest of the
driver.

> +static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +
> +	/* Enable the whole hardware block */
> +	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +		     SUN4I_I2S_CTRL_GL_EN);

Runtime PM?  It also seems like this is something that ought to be
covered in the suspend and resume callbacks.

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXUAnqAAoJECTWi3JdVIfQphMH+gPFB0QmNtTw+Fy7H7YHKQ7O
sMv9NLTWtzUFO4kaz93s9vjWq9Y4Mw+FxhUxdMLpYA7xbRNzIsXEg/SkwUA7jRE3
6l9+qI4j7HDVdt+cVthuxTD8rbwr3Zxe53vUgyFzz7zr/5vrROi9OhcVCbFZ8JNi
ilX+DWXZyxaYJvZ62dv65mt1PPAtjQ9rkwsogQ56raYrpTZnmFjmhd/p24ctdoYX
BL5aYLhEAj8P/HdILlTvBrilzk2F2nQy5E6QVk1hhLv/56gDOhMF+4yJXrbAU3Ft
k3kFmI9ToFOWa0A6+F8JVqJuy0+vXJS3tNZhFw+7fAIlskD9L0WI8+U/hOIRrv0=
=uEv0
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--
