From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] extcon: arizona: Add support for
	select accessory detect mode when headphone detection"
Date: Fri, 17 Apr 2015 10:00:47 +0100
Message-ID: <20150417090047.GC3480@opensource.wolfsonmicro.com>
References: <1429259579-16563-1-git-send-email-ideal.song@samsung.com> <1429259579-16563-2-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429259579-16563-2-git-send-email-ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2015 at 05:32:58PM +0900, Inha Song wrote:
> This patch add support for select accessory detect mode to HPDETL or HPDETR.
> Arizona provides a headphone detection circuit on the HPDETL and HPDETR pins
> to measure the impedance of an external load connected to the headphone.
> 
> Depending on board design, headphone detect pins can change to HPDETR or HPDETL.
> 
> Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/extcon/extcon-arizona.c   | 34 ++++++++++++++++++++++++++++++----
>  include/linux/mfd/arizona/pdata.h |  3 +++
>  2 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 63f01c4..7bc9159 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -95,6 +95,7 @@ struct arizona_extcon_info {
>  	int jack_flips;
>  
>  	int hpdet_ip;
> +	int hpdet_channel;

Don't really think this is necessary we can just use the pdata
value where required doesn't add much copying it to extcon_info.

>  
>  	struct extcon_dev *edev;
>  };
> @@ -653,9 +654,9 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
>  	ret = regmap_update_bits(arizona->regmap,
>  				 ARIZONA_ACCESSORY_DETECT_MODE_1,
>  				 ARIZONA_ACCDET_MODE_MASK,
> -				 ARIZONA_ACCDET_MODE_HPL);
> +				 info->hpdet_channel);
>  	if (ret != 0) {
> -		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
> +		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
>  		goto err;
>  	}
>  
> @@ -705,9 +706,9 @@ static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info)
>  				 ARIZONA_ACCESSORY_DETECT_MODE_1,
>  				 ARIZONA_ACCDET_SRC | ARIZONA_ACCDET_MODE_MASK,
>  				 info->micd_modes[0].src |
> -				 ARIZONA_ACCDET_MODE_HPL);
> +				 info->hpdet_channel);
>  	if (ret != 0) {
> -		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
> +		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
>  		goto err;
>  	}
>  
> @@ -1103,6 +1104,23 @@ static void arizona_micd_set_level(struct arizona *arizona, int index,
>  	regmap_update_bits(arizona->regmap, reg, mask, level);
>  }
>  
> +#ifdef CONFIG_OF
> +static int arizona_of_get_extcon_pdata(struct arizona *arizona)
> +{
> +	struct arizona_pdata *pdata = &arizona->pdata;
> +
> +	of_property_read_u32(arizona->dev->of_node, "wlf,hpdet-channel",
> +			     &pdata->hpdet_channel);
> +
> +	return 0;
> +}
> +#else
> +static inline int arizona_of_get_extcon_pdata(struct arizona *arizona)
> +{
> +	return 0;
> +}
> +#endif
> +

I believe it is preferred to leave this as not ifdef'ed...

>  static int arizona_extcon_probe(struct platform_device *pdev)
>  {
>  	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
> @@ -1120,6 +1138,9 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  	if (!info)
>  		return -ENOMEM;
>  
> +	if (!dev_get_platdata(arizona->dev))
> +		arizona_of_get_extcon_pdata(arizona);

And to wrap this in an if (IS_ENABLED(CONFIG_OF)).

> +
>  	info->micvdd = devm_regulator_get(&pdev->dev, "MICVDD");
>  	if (IS_ERR(info->micvdd)) {
>  		ret = PTR_ERR(info->micvdd);
> @@ -1338,6 +1359,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  
>  	arizona_extcon_set_mode(info, 0);
>  
> +	if (arizona->pdata.hpdet_channel)
> +		info->hpdet_channel = ARIZONA_ACCDET_MODE_HPR;
> +	else
> +		info->hpdet_channel = ARIZONA_ACCDET_MODE_HPL;
> +

Just move the two defines in include/dt-bindings/mfd/arizona.h
and have the pdata get set directly to one of the values.

>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_idle(&pdev->dev);
>  	pm_runtime_get_sync(&pdev->dev);
> diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
> index 4578c72..feb5903 100644
> --- a/include/linux/mfd/arizona/pdata.h
> +++ b/include/linux/mfd/arizona/pdata.h
> @@ -139,6 +139,9 @@ struct arizona_pdata {
>  	/** GPIO used for mic isolation with HPDET */
>  	int hpdet_id_gpio;
>  
> +	/** Channel to use for headphone detection */
> +	int hpdet_channel;

Lets use and unsigned here, we don't need it to be signed and it
saves type issues with read_u32.

> +
>  	/** Extra debounce timeout used during initial mic detection (ms) */
>  	int micd_detect_debounce;
>  
> -- 
> 2.0.0.390.gcb682f8
> 

Thanks,
Charles
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
