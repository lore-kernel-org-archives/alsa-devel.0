From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH -next] ASoC: sun4i-i2s: Use PTR_ERR_OR_ZERO in
 sun4i_i2s_init_regmap_fields()
Date: Thu, 22 Aug 2019 16:18:26 +0200
Message-ID: <20190822141826.is6nizjpdgvhd7ra@flea>
References: <20190822065252.74028-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="63ssjdwokv3xdxzu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190822065252.74028-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--63ssjdwokv3xdxzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Aug 22, 2019 at 06:52:52AM +0000, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 9e691baee1e8..2071c54265f3 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -1095,10 +1095,7 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
>  	i2s->field_fmt_sr =
>  			devm_regmap_field_alloc(dev, i2s->regmap,
>  						i2s->variant->field_fmt_sr);
> -	if (IS_ERR(i2s->field_fmt_sr))
> -		return PTR_ERR(i2s->field_fmt_sr);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);

I'm not really convinced that this more readable or more maintainable
though. Is there a reason for this other than we can do it?

Maxie

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--63ssjdwokv3xdxzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV6kMgAKCRDj7w1vZxhR
xYfCAQCzZc0NwL/KfHnmN5cCqmspt4rw9g7yY9ueTUdm/d4SMAD/U5pvKe6kNk6f
0GRxtaBnisn3CWTssq3fqkAzCBywhgk=
=VH9U
-----END PGP SIGNATURE-----

--63ssjdwokv3xdxzu--
