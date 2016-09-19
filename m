From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] ASoC: rk3399_gru_sound: fix recording pop at first
 attempt
Date: Mon, 19 Sep 2016 15:44:30 +0100
Message-ID: <20160919144404.GA18734@leverpostej>
References: <1474295379-16936-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1474295379-16936-1-git-send-email-zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, woojoo.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, hychao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, cychiang-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 19, 2016 at 10:29:39PM +0800, Xing Zheng wrote:
> From: Wonjoon Lee <woojoo.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> Pop happens when mclk applied but dmic's own boot-time
> Specify dmic delay times in dt to make sure
> clocks are ready earlier than dmic working
> 
> Signed-off-by: Wonjoon Lee <woojoo.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
>  .../bindings/sound/rockchip,rk3399-gru-sound.txt   |    6 ++++++
>  sound/soc/rockchip/rk3399_gru_sound.c              |   14 ++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> index f19b6c8..b7dd3ab 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> @@ -6,6 +6,12 @@ Required properties:
>    connected to the codecs
>  - rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
>  
> +Optional properties:
> +- dmic-delay : specify delay time for DMIC ready.
> +  If this option is specified, which means it's required dmic need
> +  delay for DMIC to ready so that rt5514 can avoid recording before
> +  DMIC send valid data

What units is this in? Per the code it looks like ms, so if we follow
Documentation/devicetree/bindings/property-units.txt, thous should be
named something like dmic-enable-delay-ms.

That said, do we even need a property for this? Does this vary much in
practice?

If it does, can we not derive this delay from other information (e.g.
the rates of input clocks and so on)? What exactly determines the
necessary delay?

Thanks,
Mark.

>  
>  sound {
> diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
> index 164b6da..6ab838b 100644
> --- a/sound/soc/rockchip/rk3399_gru_sound.c
> +++ b/sound/soc/rockchip/rk3399_gru_sound.c
> @@ -37,6 +37,8 @@
>  
>  #define SOUND_FS	256
>  
> +unsigned int rt5514_dmic_delay;
> +
>  static struct snd_soc_jack rockchip_sound_jack;
>  
>  static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
> @@ -122,6 +124,9 @@ static int rockchip_sound_rt5514_hw_params(struct snd_pcm_substream *substream,
>  		return ret;
>  	}
>  
> +	/* Wait for DMIC stable */
> +	msleep(rt5514_dmic_delay);
> +
>  	return 0;
>  }
>  
> @@ -334,6 +339,15 @@ static int rockchip_sound_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	/* Set DMIC delay */
> +	ret = device_property_read_u32(&pdev->dev, "dmic-delay",
> +					&rt5514_dmic_delay);
> +	if (ret) {
> +		rt5514_dmic_delay = 0;
> +		dev_dbg(&pdev->dev,
> +			"no optional property 'dmic-delay' found, default: no delay\n");
> +	}
> +
>  	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
>  	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
>  	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
> -- 
> 1.7.9.5
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
