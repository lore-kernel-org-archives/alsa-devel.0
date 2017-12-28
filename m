From: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: mediatek: fix error handling in
 mt2701_afe_pcm_dev_probe()
Date: Thu, 28 Dec 2017 20:27:08 +0800
Message-ID: <1514464028.21578.2.camel@mtkswgap22>
References: <18b7f0ec484300af795b1873efab96e51393459c.1514190169.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <18b7f0ec484300af795b1873efab96e51393459c.1514190169.git.ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Sorry, please ignore this series. I will send new ones later.

On Mon, 2017-12-25 at 16:28 +0800, Ryder Lee wrote:
> Fix unbalanced error handling path which will get incorrect counts
> if probe failed. The .remove() should be adjusted accordingly.
> 
> Signed-off-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> index 8fda182..b3f6f73 100644
> --- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> +++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
> @@ -1591,8 +1591,12 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, afe);
>  	pm_runtime_enable(&pdev->dev);
> -	if (!pm_runtime_enabled(&pdev->dev))
> -		goto err_pm_disable;
> +	if (!pm_runtime_enabled(&pdev->dev)) {
> +		ret = mt2701_afe_runtime_resume(&pdev->dev);
> +		if (ret)
> +			goto err_pm_disable;
> +	}
> +
>  	pm_runtime_get_sync(&pdev->dev);
>  
>  	ret = snd_soc_register_platform(&pdev->dev, &mtk_afe_pcm_platform);
> @@ -1610,16 +1614,12 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
>  		goto err_dai_component;
>  	}
>  
> -	mt2701_afe_runtime_resume(&pdev->dev);
> -
>  	return 0;
>  
>  err_dai_component:
> -	snd_soc_unregister_component(&pdev->dev);
> -
> -err_platform:
>  	snd_soc_unregister_platform(&pdev->dev);
> -
> +err_platform:
> +	pm_runtime_put_sync(&pdev->dev);
>  err_pm_disable:
>  	pm_runtime_disable(&pdev->dev);
>  
> @@ -1628,17 +1628,14 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
>  
>  static int mt2701_afe_pcm_dev_remove(struct platform_device *pdev)
>  {
> -	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
> -
> +	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	if (!pm_runtime_status_suspended(&pdev->dev))
>  		mt2701_afe_runtime_suspend(&pdev->dev);
> -	pm_runtime_put_sync(&pdev->dev);
>  
>  	snd_soc_unregister_component(&pdev->dev);
>  	snd_soc_unregister_platform(&pdev->dev);
> -	/* disable afe clock */
> -	mt2701_afe_disable_clock(afe);
> +
>  	return 0;
>  }
>  


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
