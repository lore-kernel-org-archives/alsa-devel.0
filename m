From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v6 3/3] ASoC: sun4i-i2s: Adjust LRCLK width
Date: Tue, 27 Aug 2019 09:01:01 +0200
Message-ID: <20190827070101.tastgcqvzrgv3kc5@flea>
References: <20190826180734.15801-1-codekipper@gmail.com>
 <20190826180734.15801-4-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aewobl2wvpczcoyt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190826180734.15801-4-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: codekipper@gmail.com
Cc: wens@csie.org, linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, be17068@iperbole.bo.it
List-Id: alsa-devel@alsa-project.org


--aewobl2wvpczcoyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2019 at 08:07:34PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Some codecs such as i2s based HDMI audio and the Pine64 DAC require
> a different amount of bit clocks per frame than what is calculated
> by the sample width. Use the values obtained by the tdm slot bindings
> to adjust the LRCLK width accordingly.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 056a299c03fb..0965a97c96e5 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -455,7 +455,10 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>  		break;
>
>  	case SND_SOC_DAIFMT_I2S:
> -		lrck_period = params_physical_width(params);
> +		if (i2s->slot_width)
> +			lrck_period = i2s->slot_width;
> +		else
> +			lrck_period = params_physical_width(params);
>  		break;

That would be the case with the DSP formats too, right?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--aewobl2wvpczcoyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWTVLQAKCRDj7w1vZxhR
xSAlAQCvR8zoBbzxDhfl4BOVHlf7M+d/VwTWUWIndBN6/bMNDAD+KSWSTL9rCbyM
5aTcKxbY8Hi2H/ljbFggOIAykqgEnQI=
=88rE
-----END PGP SIGNATURE-----

--aewobl2wvpczcoyt--
