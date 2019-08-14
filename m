From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 03/15] ASoC: sun4i-i2s: Correct divider calculations
Date: Wed, 14 Aug 2019 09:13:43 +0200
Message-ID: <20190814071343.vvjbozrmv5ionwnf@flea>
References: <20190814060854.26345-1-codekipper@gmail.com>
 <20190814060854.26345-4-codekipper@gmail.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bamdgrdnwpokqt4x"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBOGXZ7VAKGQEVERZREI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190814060854.26345-4-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: wens-jdAy2FN1RRM@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--bamdgrdnwpokqt4x
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

Hi,

(I just noticed this, but can you update my mail address, it's not
@free-electrons for quite a while, you probably want to change your
scripts to use mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org)

On Wed, Aug 14, 2019 at 08:08:42AM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> The clock division circuitry is different on the H3 and later SoCs.
> The division of bclk is now based on pll2.
>
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 73 +++++++++++++++++++++++++------------
>  1 file changed, 49 insertions(+), 24 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 7c37b6291df0..34f31439ae7b 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -127,8 +127,6 @@ struct sun4i_i2s;
>   * @has_chsel_offset: SoC uses offset for selecting dai operational mode.
>   * @reg_offset_txdata: offset of the tx fifo.
>   * @sun4i_i2s_regmap: regmap config to use.
> - * @mclk_offset: Value by which mclkdiv needs to be adjusted.
> - * @bclk_offset: Value by which bclkdiv needs to be adjusted.
>   * @field_clkdiv_mclk_en: regmap field to enable mclk output.
>   * @field_fmt_wss: regmap field to set word select size.
>   * @field_fmt_sr: regmap field to set sample resolution.
> @@ -150,8 +148,6 @@ struct sun4i_i2s_quirks {
>  	bool				has_chsel_offset;
>  	unsigned int			reg_offset_txdata;	/* TX FIFO */
>  	const struct regmap_config	*sun4i_i2s_regmap;
> -	unsigned int			mclk_offset;
> -	unsigned int			bclk_offset;
>
>  	/* Register fields for i2s */
>  	struct reg_field		field_clkdiv_mclk_en;
> @@ -212,7 +208,25 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
>  	{ .div = 8, .val = 3 },
>  	{ .div = 12, .val = 4 },
>  	{ .div = 16, .val = 5 },
> -	/* TODO - extend divide ratio supported by newer SoCs */
> +};
> +
> +static const struct sun4i_i2s_clk_div sun8i_i2s_clk_div[] = {
> +	{ .div = 0, .val = 0 },

Having a divider of 0 seems like a bad idea.

> +	{ .div = 1, .val = 1 },
> +	{ .div = 2, .val = 2 },
> +	{ .div = 4, .val = 3 },
> +	{ .div = 6, .val = 4 },
> +	{ .div = 8, .val = 5 },
> +	{ .div = 12, .val = 6 },
> +	{ .div = 16, .val = 7 },
> +	{ .div = 24, .val = 8 },
> +	{ .div = 32, .val = 9 },
> +	{ .div = 48, .val = 10 },
> +	{ .div = 64, .val = 11 },
> +	{ .div = 96, .val = 12 },
> +	{ .div = 128, .val = 13 },
> +	{ .div = 176, .val = 14 },
> +	{ .div = 192, .val = 15 },
>  };
>
>  static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
> @@ -224,21 +238,21 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
>  	{ .div = 12, .val = 5 },
>  	{ .div = 16, .val = 6 },
>  	{ .div = 24, .val = 7 },
> -	/* TODO - extend divide ratio supported by newer SoCs */
>  };
>
>  static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
>  				  unsigned int oversample_rate,
> -				  unsigned int word_size)
> +				  unsigned int word_size,
> +				  const struct sun4i_i2s_clk_div *bdiv,
> +				  unsigned int size)

Wouldn't it be simpler to just have the divider list in the variant
structure? It would avoid having to refactor all the functions, and
it's not like it's really going to change from one call to another
anyway.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
--bamdgrdnwpokqt4x--
