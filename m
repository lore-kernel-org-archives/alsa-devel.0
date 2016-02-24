From: Florian Vaussard <florian.vaussard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ASoC: ads117x: Add device tree compatible string
Date: Wed, 24 Feb 2016 08:36:37 +0100
Message-ID: <56CD5D85.8070501@gmail.com>
References: <1454686334-9668-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1454686334-9668-3-git-send-email-florian.vaussard@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454686334-9668-3-git-send-email-florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 02/05/2016 04:32 PM, Florian Vaussard wrote:
> This patch adds the necessary device tree compatible string to allow DT
> probing.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
> ---
>  sound/soc/codecs/ads117x.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
> index 1222282..c5be1bd 100644
> --- a/sound/soc/codecs/ads117x.c
> +++ b/sound/soc/codecs/ads117x.c
> @@ -20,6 +20,8 @@
>  #include <sound/initval.h>
>  #include <sound/soc.h>
>  
> +#include <linux/of.h>
> +
>  #define ADS117X_RATES (SNDRV_PCM_RATE_8000_48000)
>  #define ADS117X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
>  
> @@ -75,9 +77,19 @@ static int ads117x_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id ads117x_dt_ids[] = {
> +	{ .compatible = "ti,ads1174" },
> +	{ .compatible = "ti,ads1178" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ads117x_dt_ids);
> +#endif
> +
>  static struct platform_driver ads117x_codec_driver = {
>  	.driver = {
>  			.name = "ads117x-codec",
> +			.of_match_table = of_match_ptr(ads117x_dt_ids),
>  	},
>  
>  	.probe = ads117x_probe,
> 

Do you have any more comments on this patch?

Best regards,
Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
