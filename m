From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v5 01/15] ASoC: sun4i-i2s: Add regmap field to sign
 extend sample
Date: Wed, 14 Aug 2019 08:43:39 +0200
Message-ID: <20190814064339.lgfngdkiaalygolk@flea>
References: <20190814060854.26345-1-codekipper@gmail.com>
 <20190814060854.26345-2-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ugsoeifrlfa7kjoi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190814060854.26345-2-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: codekipper@gmail.com
Cc: wens@csie.org, linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, be17068@iperbole.bo.it
List-Id: alsa-devel@alsa-project.org


--ugsoeifrlfa7kjoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Aug 14, 2019 at 08:08:40AM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs such as the H3 and A64 this is set by default
> to transfer a 0 after each sample in each slot. However the A10
> and A20 SoCs that this driver was developed on had a default
> setting where it padded the audio gain with zeros.
>
> This isn't a problem whilst we have only support for 16bit audio
> but with larger sample resolution rates in the pipeline then SEXT
> bits should be cleared so that they also pad at the LSB. Without
> this the audio gets distorted.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 793457394efe..8201334a059b 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -135,6 +135,7 @@ struct sun4i_i2s;
>   * @field_fmt_bclk: regmap field to set clk polarity.
>   * @field_fmt_lrclk: regmap field to set frame polarity.
>   * @field_fmt_mode: regmap field to set the operational mode.
> + * @field_fmt_sext: regmap field to set the sign extension.
>   * @field_txchanmap: location of the tx channel mapping register.
>   * @field_rxchanmap: location of the rx channel mapping register.
>   * @field_txchansel: location of the tx channel select bit fields.
> @@ -159,6 +160,7 @@ struct sun4i_i2s_quirks {
>  	struct reg_field		field_fmt_bclk;
>  	struct reg_field		field_fmt_lrclk;
>  	struct reg_field		field_fmt_mode;
> +	struct reg_field		field_fmt_sext;
>  	struct reg_field		field_txchanmap;
>  	struct reg_field		field_rxchanmap;
>  	struct reg_field		field_txchansel;
> @@ -186,6 +188,7 @@ struct sun4i_i2s {
>  	struct regmap_field	*field_fmt_bclk;
>  	struct regmap_field	*field_fmt_lrclk;
>  	struct regmap_field	*field_fmt_mode;
> +	struct regmap_field	*field_fmt_sext;
>  	struct regmap_field	*field_txchanmap;
>  	struct regmap_field	*field_rxchanmap;
>  	struct regmap_field	*field_txchansel;
> @@ -345,6 +348,9 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>  				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
>  				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
>
> +	/* Set sign extension to pad out LSB with 0 */
> +	regmap_field_write(i2s->field_fmt_sext, 0);
> +
>  	return 0;
>  }
>
> @@ -917,6 +923,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
>  	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>  	.has_slave_select_bit	= true,
>  	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> +	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
>  	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
>  	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
>  	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> @@ -936,6 +943,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
>  	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>  	.has_slave_select_bit	= true,
>  	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> +	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
>  	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
>  	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
>  	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> @@ -979,6 +987,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
>  	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>  	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
>  	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),
> +	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 4, 5),
>  	.field_txchanmap	= REG_FIELD(SUN8I_I2S_TX_CHAN_MAP_REG, 0, 31),
>  	.field_rxchanmap	= REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
>  	.field_txchansel	= REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
> @@ -998,6 +1007,7 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
>  	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
>  	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
>  	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> +	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
>  	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
>  	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
>  	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),

You're missing the A83t here

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ugsoeifrlfa7kjoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVOtmwAKCRDj7w1vZxhR
xcCaAQCLwFdvV53x9Yf+SMO3VeB7L/1aAbTd+ecpVTv4DxfHDgD9FhXhMdejlsae
OHzDPbZlEVI+vhB6L3a/niBTANthQwM=
=cwV3
-----END PGP SIGNATURE-----

--ugsoeifrlfa7kjoi--
