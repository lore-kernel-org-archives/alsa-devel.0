From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
Date: Wed, 12 Sep 2012 07:50:31 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA7F8CF@DBDE01.ent.ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id B694B2615E9
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 09:50:41 +0200 (CEST)
In-Reply-To: <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Girdwood,
 Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 31, 2012 at 18:20:58, Hebbar, Gururaja wrote:
> OMAP2+ platforms (like TI81xx, AM33xx) uses davinci-pcm driver. SRAM is
> not needed/used in EDMA transfers for audio on such platforms. However
> they do not provide generic SRAM APIs (sram_alloc() and sram_free()). In
> such cases the pcm driver cannot be used directly as it results in
> compilation failure on OMAP2 platforms.
> 
> Fix this by providing a config option to indicate missing SRAM API
> support. This config is enabled by default on Davinci platform so as to
> not break existing platforms. For OMAP2+ platforms, the config is
> disabled.

Gentle ping. Is there any comments/review for this patch? 
If not, can this be pulled in?

> 
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> ---
> :100644 100644 9e11a14... 328b463... M	sound/soc/davinci/Kconfig
> :100644 100644 93ea3bf... 7ac5a19... M	sound/soc/davinci/davinci-pcm.c
>  sound/soc/davinci/Kconfig       |    5 +++++
>  sound/soc/davinci/davinci-pcm.c |    8 ++++++++
>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
> index 9e11a14..328b463 100644
> --- a/sound/soc/davinci/Kconfig
> +++ b/sound/soc/davinci/Kconfig
> @@ -15,6 +15,11 @@ config SND_DAVINCI_SOC_MCASP
>  config SND_DAVINCI_SOC_VCIF
>  	tristate
>  
> +config SND_DAVINCI_HAVE_SRAM
> +	bool
> +	default y if ARCH_DAVINCI=y
> +	default n if ARCH_OMAP=y
> +
>  config SND_DAVINCI_SOC_EVM
>  	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
>  	depends on SND_DAVINCI_SOC
> diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
> index 93ea3bf..7ac5a19 100644
> --- a/sound/soc/davinci/davinci-pcm.c
> +++ b/sound/soc/davinci/davinci-pcm.c
> @@ -23,7 +23,9 @@
>  #include <sound/soc.h>
>  
>  #include <asm/dma.h>
> +#if defined(CONFIG_SND_DAVINCI_HAVE_SRAM)
>  #include <mach/sram.h>
> +#endif
>  
>  #include "davinci-pcm.h"
>  
> @@ -259,6 +261,7 @@ static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
>  	}
>  }
>  
> +#if defined(CONFIG_SND_DAVINCI_HAVE_SRAM)
>  static int allocate_sram(struct snd_pcm_substream *substream, unsigned size,
>  		struct snd_pcm_hardware *ppcm)
>  {
> @@ -289,6 +292,7 @@ exit2:
>  exit1:
>  	return -ENOMEM;
>  }
> +#endif
>  
>  /*
>   * Only used with ping/pong.
> @@ -676,7 +680,9 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
>  
>  	ppcm = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
>  			&pcm_hardware_playback : &pcm_hardware_capture;
> +#if defined(CONFIG_SND_DAVINCI_HAVE_SRAM)
>  	allocate_sram(substream, params->sram_size, ppcm);
> +#endif
>  	snd_soc_set_runtime_hwparams(substream, ppcm);
>  	/* ensure that buffer size is a multiple of period size */
>  	ret = snd_pcm_hw_constraint_integer(runtime,
> @@ -817,11 +823,13 @@ static void davinci_pcm_free(struct snd_pcm *pcm)
>  		dma_free_writecombine(pcm->card->dev, buf->bytes,
>  				      buf->area, buf->addr);
>  		buf->area = NULL;
> +#if defined(CONFIG_SND_DAVINCI_HAVE_SRAM)
>  		iram_dma = buf->private_data;
>  		if (iram_dma) {
>  			sram_free(iram_dma->area, iram_dma->bytes);
>  			kfree(iram_dma);
>  		}
> +#endif
>  	}
>  }
>  
> -- 
> 1.7.1
> 
> 


Regards, 
Gururaja
