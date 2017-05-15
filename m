From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] ASoC: atmel: Use IS_ENABLED()
Date: Mon, 15 May 2017 14:58:15 +0200
Message-ID: <5742d70d-92a3-3e3c-634d-c30894f52be8@microchip.com>
References: <20170515093201.20813-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa2.microchip.iphmx.com (esa2.microchip.iphmx.com
 [68.232.149.84])
 by alsa0.perex.cz (Postfix) with ESMTP id DDAFB266851
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 14:57:59 +0200 (CEST)
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
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Le 15/05/2017 =E0 11:32, Takashi Iwai a =E9crit :
> Simplify the ifdef conditions with IS_ENABLED() macro.
> No functional changes.
> =

> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks

> ---
>  sound/soc/atmel/atmel-pcm.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> =

> diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
> index 6eaf081cad50..4b27aed40a51 100644
> --- a/sound/soc/atmel/atmel-pcm.h
> +++ b/sound/soc/atmel/atmel-pcm.h
> @@ -83,8 +83,7 @@ struct atmel_pcm_dma_params {
>  #define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
>  #define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (=
reg))
>  =

> -#if defined(CONFIG_SND_ATMEL_SOC_PDC) || \
> -	defined(CONFIG_SND_ATMEL_SOC_PDC_MODULE)
> +#if IS_ENABLED(CONFIG_SND_ATMEL_SOC_PDC)
>  int atmel_pcm_pdc_platform_register(struct device *dev);
>  void atmel_pcm_pdc_platform_unregister(struct device *dev);
>  #else
> @@ -97,8 +96,7 @@ static inline void atmel_pcm_pdc_platform_unregister(st=
ruct device *dev)
>  }
>  #endif
>  =

> -#if defined(CONFIG_SND_ATMEL_SOC_DMA) || \
> -	defined(CONFIG_SND_ATMEL_SOC_DMA_MODULE)
> +#if IS_ENABLED(CONFIG_SND_ATMEL_SOC_DMA)
>  int atmel_pcm_dma_platform_register(struct device *dev);
>  void atmel_pcm_dma_platform_unregister(struct device *dev);
>  #else
> =



-- =

Nicolas Ferre
