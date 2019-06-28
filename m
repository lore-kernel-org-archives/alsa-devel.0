From: <Codrin.Ciubotariu@microchip.com>
Subject: Re: [PATCH v2 01/23] ASoC: atmel: atmel-pcm-dma.c: use
 devm_snd_dmaengine_pcm_register()
Date: Fri, 28 Jun 2019 09:45:10 +0000
Message-ID: <919a7eda-8b5b-1749-2733-93b3489f4269@microchip.com>
References: <87blyitky2.wl-kuninori.morimoto.gx@renesas.com>
 <87a7e2tkx5.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa2.microchip.iphmx.com (esa2.microchip.iphmx.com
 [68.232.149.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C747F80058
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 11:45:21 +0200 (CEST)
In-Reply-To: <87a7e2tkx5.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <7E71BC3BECDD3B4E87436EB179C191D8@namprd11.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: kuninori.morimoto.gx@renesas.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 28.06.2019 07:07, Kuninori Morimoto wrote:
> External E-Mail
> 
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> We have devm_xxx version of snd_dmaengine_pcm_register,
> let's use it.
> 
> This patch also removes related empty functions
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Reviewed-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Thanks again!

Best regards,
Codrin

> v1 -> v2
> 
> 	- remove empty functions
> 
>   sound/soc/atmel/atmel-pcm-dma.c |  9 ++-------
>   sound/soc/atmel/atmel-pcm-pdc.c |  5 -----
>   sound/soc/atmel/atmel-pcm.h     |  8 --------
>   sound/soc/atmel/atmel_ssc_dai.c | 11 -----------
>   4 files changed, 2 insertions(+), 31 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
> index 042e593..db67f5b 100644
> --- a/sound/soc/atmel/atmel-pcm-dma.c
> +++ b/sound/soc/atmel/atmel-pcm-dma.c
> @@ -111,16 +111,11 @@ static const struct snd_dmaengine_pcm_config atmel_dmaengine_pcm_config = {
>   
>   int atmel_pcm_dma_platform_register(struct device *dev)
>   {
> -	return snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config, 0);
> +	return devm_snd_dmaengine_pcm_register(dev,
> +					&atmel_dmaengine_pcm_config, 0);
>   }
>   EXPORT_SYMBOL(atmel_pcm_dma_platform_register);
>   
> -void atmel_pcm_dma_platform_unregister(struct device *dev)
> -{
> -	snd_dmaengine_pcm_unregister(dev);
> -}
> -EXPORT_SYMBOL(atmel_pcm_dma_platform_unregister);
> -
>   MODULE_AUTHOR("Bo Shen <voice.shen@atmel.com>");
>   MODULE_DESCRIPTION("Atmel DMA based PCM module");
>   MODULE_LICENSE("GPL");
> diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
> index 7e9aa70..ed095af 100644
> --- a/sound/soc/atmel/atmel-pcm-pdc.c
> +++ b/sound/soc/atmel/atmel-pcm-pdc.c
> @@ -393,11 +393,6 @@ int atmel_pcm_pdc_platform_register(struct device *dev)
>   }
>   EXPORT_SYMBOL(atmel_pcm_pdc_platform_register);
>   
> -void atmel_pcm_pdc_platform_unregister(struct device *dev)
> -{
> -}
> -EXPORT_SYMBOL(atmel_pcm_pdc_platform_unregister);
> -
>   MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
>   MODULE_DESCRIPTION("Atmel PCM module");
>   MODULE_LICENSE("GPL");
> diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
> index 5173c9b..2e64874 100644
> --- a/sound/soc/atmel/atmel-pcm.h
> +++ b/sound/soc/atmel/atmel-pcm.h
> @@ -72,28 +72,20 @@ struct atmel_pcm_dma_params {
>   
>   #if IS_ENABLED(CONFIG_SND_ATMEL_SOC_PDC)
>   int atmel_pcm_pdc_platform_register(struct device *dev);
> -void atmel_pcm_pdc_platform_unregister(struct device *dev);
>   #else
>   static inline int atmel_pcm_pdc_platform_register(struct device *dev)
>   {
>   	return 0;
>   }
> -static inline void atmel_pcm_pdc_platform_unregister(struct device *dev)
> -{
> -}
>   #endif
>   
>   #if IS_ENABLED(CONFIG_SND_ATMEL_SOC_DMA)
>   int atmel_pcm_dma_platform_register(struct device *dev);
> -void atmel_pcm_dma_platform_unregister(struct device *dev);
>   #else
>   static inline int atmel_pcm_dma_platform_register(struct device *dev)
>   {
>   	return 0;
>   }
> -static inline void atmel_pcm_dma_platform_unregister(struct device *dev)
> -{
> -}
>   #endif
>   
>   #endif /* _ATMEL_PCM_H */
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index b66c778..6f89483 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -1012,16 +1012,6 @@ static int asoc_ssc_init(struct device *dev)
>   	return 0;
>   }
>   
> -static void asoc_ssc_exit(struct device *dev)
> -{
> -	struct ssc_device *ssc = dev_get_drvdata(dev);
> -
> -	if (ssc->pdata->use_dma)
> -		atmel_pcm_dma_platform_unregister(dev);
> -	else
> -		atmel_pcm_pdc_platform_unregister(dev);
> -}
> -
>   /**
>    * atmel_ssc_set_audio - Allocate the specified SSC for audio use.
>    */
> @@ -1050,7 +1040,6 @@ void atmel_ssc_put_audio(int ssc_id)
>   {
>   	struct ssc_device *ssc = ssc_info[ssc_id].ssc;
>   
> -	asoc_ssc_exit(&ssc->pdev->dev);
>   	ssc_free(ssc);
>   }
>   EXPORT_SYMBOL_GPL(atmel_ssc_put_audio);
> 
