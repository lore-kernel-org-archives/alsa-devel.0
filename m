From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] ASoC: atmel: Use IS_ENABLED()
Date: Mon, 15 May 2017 12:14:20 +0200
Message-ID: <20170515101420.uqqkvric32eacef4@piout.net>
References: <20170515093201.20813-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 38E19266851
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 12:14:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170515093201.20813-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: alsa-devel@alsa-project.org

On 15/05/2017 at 11:32:01 +0200, Takashi Iwai wrote:
> Simplify the ifdef conditions with IS_ENABLED() macro.
> No functional changes.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  sound/soc/atmel/atmel-pcm.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
> index 6eaf081cad50..4b27aed40a51 100644
> --- a/sound/soc/atmel/atmel-pcm.h
> +++ b/sound/soc/atmel/atmel-pcm.h
> @@ -83,8 +83,7 @@ struct atmel_pcm_dma_params {
>  #define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
>  #define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
>  
> -#if defined(CONFIG_SND_ATMEL_SOC_PDC) || \
> -	defined(CONFIG_SND_ATMEL_SOC_PDC_MODULE)
> +#if IS_ENABLED(CONFIG_SND_ATMEL_SOC_PDC)
>  int atmel_pcm_pdc_platform_register(struct device *dev);
>  void atmel_pcm_pdc_platform_unregister(struct device *dev);
>  #else
> @@ -97,8 +96,7 @@ static inline void atmel_pcm_pdc_platform_unregister(struct device *dev)
>  }
>  #endif
>  
> -#if defined(CONFIG_SND_ATMEL_SOC_DMA) || \
> -	defined(CONFIG_SND_ATMEL_SOC_DMA_MODULE)
> +#if IS_ENABLED(CONFIG_SND_ATMEL_SOC_DMA)
>  int atmel_pcm_dma_platform_register(struct device *dev);
>  void atmel_pcm_dma_platform_unregister(struct device *dev);
>  #else
> -- 
> 2.12.2
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
