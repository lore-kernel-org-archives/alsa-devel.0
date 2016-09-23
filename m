From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: rk3399_gru_sound: fix recording pop at first
 attempt
Date: Fri, 23 Sep 2016 16:27:37 -0500
Message-ID: <20160923212737.GA17658@rob-hp-laptop>
References: <1474552206-31742-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1474552206-31742-1-git-send-email-zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, woojoo.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cychiang-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, hychao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 22, 2016 at 09:50:06PM +0800, Xing Zheng wrote:
> From: Wonjoon Lee <woojoo.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> Pop happens when mclk applied but dmic's own boot-time

This statement doesn't make sense.

> Specify dmic delay times in dt to make sure
> clocks are ready earlier than dmic working

I don't think this really belongs in DT. Seems like better control of 
the init order is needed. Or why not just a fixed delay in the driver?

> 
> Signed-off-by: Wonjoon Lee <woojoo.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v2:
> - rename dmic-delay to dmic-wakeup-delay-ms
> 
>  .../bindings/sound/rockchip,rk3399-gru-sound.txt           |  7 +++++++
>  sound/soc/rockchip/rk3399_gru_sound.c                      | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> index f19b6c8..eac91db 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> @@ -6,10 +6,17 @@ Required properties:
>    connected to the codecs
>  - rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
>  
> +Optional properties:
> +- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
> +  If this option is specified, which means it's required dmic need
> +  delay for DMIC to ready so that rt5514 can avoid recording before
> +  DMIC send valid data
> +
>  Example:
>  
>  sound {
>  	compatible = "rockchip,rk3399-gru-sound";
>  	rockchip,cpu = <&i2s0>;
>  	rockchip,codec = <&max98357a &rt5514 &da7219>;
> +	dmic-wakeup-delay-ms = <20>;
>  };
> diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
> index ee06489..9ed735a 100644
> --- a/sound/soc/rockchip/rk3399_gru_sound.c
> +++ b/sound/soc/rockchip/rk3399_gru_sound.c
> @@ -38,6 +38,8 @@
>  
>  #define SOUND_FS	256
>  
> +unsigned int rt5514_dmic_delay;
> +
>  static struct snd_soc_jack rockchip_sound_jack;
>  
>  static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
> @@ -123,6 +125,9 @@ static int rockchip_sound_rt5514_hw_params(struct snd_pcm_substream *substream,
>  		return ret;
>  	}
>  
> +	/* Wait for DMIC stable */
> +	msleep(rt5514_dmic_delay);
> +
>  	return 0;
>  }
>  
> @@ -343,6 +348,15 @@ static int rockchip_sound_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	/* Set DMIC delay */
> +	ret = device_property_read_u32(&pdev->dev, "dmic-delay",

Obviously, this doesn't work now...

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
> 1.9.1
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
