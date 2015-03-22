From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: RE: [PATCH] ASoC:pcm512x: Make PLL lock output selectable via
 device tree.
Date: Sun, 22 Mar 2015 21:25:35 +0000
Message-ID: <222bcd862d8442158dffedd0657c8ab2@EMAIL.axentia.se>
References: <1426886563-10936-1-git-send-email-hm@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426886563-10936-1-git-send-email-hm-n6SlHCM0l+K9FHfhHBbuYA@public.gmane.org>
Content-Language: sv-SE
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Howard Mitchell <hm-n6SlHCM0l+K9FHfhHBbuYA@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Howard Mitchell wrote:
> Currently the PLL Lock output signal is hardcoded to GPIO4. This
> makes it seletable in the same way as pll-in and pll-out.

Oops, I never intended the plllock code the hit upstream. I thought
I had removed that testing code and was very surprised to see it, that
was an odd experience. From my point of view it is fine to instead
remove the whole pll-lock thing.

But now the cat is out, so maybe we have to keep a way to output
the pll-lock signal for backwards compatibility?

Appart from the space-indent changes, this looks fine (if we do in fact
need to keep it at all). But I would like to see a new version of the
patch without the whitespace changes before I commit to that.

Cheers,
Peter

> Signed-off-by: Howard Mitchell <hm-n6SlHCM0l+K9FHfhHBbuYA@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/pcm512x.txt          |    3 ++
>  sound/soc/codecs/pcm512x.c                         |   47 +++++++++++++-------
>  2 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/pcm512x.txt
> b/Documentation/devicetree/bindings/sound/pcm512x.txt
> index 3aae3b4..432f186 100644
> --- a/Documentation/devicetree/bindings/sound/pcm512x.txt
> +++ b/Documentation/devicetree/bindings/sound/pcm512x.txt
> @@ -26,6 +26,8 @@ Optional properties:
>      given pll-in pin and PLL output on the given pll-out pin.  An
>      external connection from the pll-out pin to the SCLK pin is assumed.
> 
> +  - pll-lock : gpio pin used to output the PLL lock flag.
> +
>  Examples:
> 
>  	pcm5122: pcm5122@4c {
> @@ -49,4 +51,5 @@ Examples:
>  		clocks = <&sck>;
>  		pll-in = <3>;
>  		pll-out = <6>;
> +		pll-lock = <4>;
>  	};
> diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
> index 8472099..a4217d7 100644
> --- a/sound/soc/codecs/pcm512x.c
> +++ b/sound/soc/codecs/pcm512x.c
> @@ -49,6 +49,7 @@ struct pcm512x_priv {
>  	int fmt;
>  	int pll_in;
>  	int pll_out;
> +	int pll_lock;
>  	int pll_r;
>  	int pll_j;
>  	int pll_d;
> @@ -1296,24 +1297,26 @@ static int pcm512x_hw_params(struct
> snd_pcm_substream *substream,
>  				ret, pcm512x->pll_out);
>  			return ret;
>  		}
> +	}
> 
> -		gpio = PCM512x_G1OE << (4 - 1);
> -		ret = regmap_update_bits(pcm512x->regmap, PCM512x_GPIO_EN,
> -					 gpio, gpio);
> -		if (ret != 0) {
> -			dev_err(codec->dev, "Failed to enable gpio %d: %d\n",
> -				4, ret);
> -			return ret;
> -		}
> -
> -		gpio = PCM512x_GPIO_OUTPUT_1 + 4 - 1;
> -		ret = regmap_update_bits(pcm512x->regmap, gpio,
> -					 PCM512x_GxSL, PCM512x_GxSL_PLLLK);
> -		if (ret != 0) {
> -			dev_err(codec->dev,
> -				"Failed to output pll lock on %d: %d\n",
> -				ret, 4);
> -			return ret;
> +	if (pcm512x->pll_lock) {
> +                gpio = PCM512x_G1OE << (pcm512x->pll_lock - 1);
> +                ret = regmap_update_bits(pcm512x->regmap, PCM512x_GPIO_EN,
> +                                         gpio, gpio);
> +                if (ret != 0) {
> +                        dev_err(codec->dev, "Failed to enable gpio %d: %d\n",
> +                                pcm512x->pll_lock, ret);
> +                        return ret;
> +                }
> +
> +                gpio = PCM512x_GPIO_OUTPUT_1 + pcm512x->pll_lock - 1;
> +                ret = regmap_update_bits(pcm512x->regmap, gpio,
> +                                         PCM512x_GxSL, PCM512x_GxSL_PLLLK);
> +                if (ret != 0) {
> +                        dev_err(codec->dev,
> +                                "Failed to output pll lock on %d: %d\n",
> +                                ret, pcm512x->pll_lock);
> +                        return ret;
>  		}
>  	}
> 
> @@ -1518,6 +1521,16 @@ int pcm512x_probe(struct device *dev, struct
> regmap *regmap)
>  			ret = -EINVAL;
>  			goto err_clk;
>  		}
> +
> +                if (of_property_read_u32(np, "pll-lock", &val) >= 0) {
> +                        if (val > 6) {
> +                                dev_err(dev, "Invalid pll-lock\n");
> +                                ret = -EINVAL;
> +                                goto err_clk;
> +                        }
> +                        pcm512x->pll_lock = val;
> +                }
> +
>  	}
>  #endif
> 
> --
> 1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
