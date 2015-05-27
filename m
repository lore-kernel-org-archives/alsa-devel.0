From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 2/2] ASoC: atmel: compile pcm driver in
 snd-soc-atmel_ssc_dai
Date: Wed, 27 May 2015 09:50:24 +0200
Message-ID: <1432713024.27695.235.camel@x220>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
	 <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Now that this patch is already applied my remarks can only be addressed
in a follow up patch. (Perhaps such a patch is already queued.)

On Tue, 2015-05-26 at 00:04 +0200, Alexandre Belloni wrote:
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
 
>  config SND_ATMEL_SOC_PDC
> -	tristate
> +	bool
>  
>  config SND_ATMEL_SOC_DMA
> -	tristate
> +	bool
>  	select SND_SOC_GENERIC_DMAENGINE_PCM

> --- a/sound/soc/atmel/Makefile
> +++ b/sound/soc/atmel/Makefile

> -snd-soc-atmel-pcm-pdc-objs := atmel-pcm-pdc.o
> -snd-soc-atmel-pcm-dma-objs := atmel-pcm-dma.o
> -snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
> +snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_PDC) := atmel-pcm-pdc.o
> +snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_DMA) += atmel-pcm-dma.o
> +snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o $(snd-soc-atmel-pcm-y)
>  
> -obj-$(CONFIG_SND_ATMEL_SOC_PDC) += snd-soc-atmel-pcm-pdc.o
> -obj-$(CONFIG_SND_ATMEL_SOC_DMA) += snd-soc-atmel-pcm-dma.o
>  obj-$(CONFIG_SND_ATMEL_SOC_SSC) += snd-soc-atmel_ssc_dai.o

The code in atmel-pcm-pdc.c and atmel-pcm-dma.c will now either be part
of the snd-soc-atmel_ssc_dai.ko or be built-in. That means, I think,
that:
- the (in total) four uses of EXPORT_SYMBOL() in these two files can be
  dropped;
- MODULE_AUTHOR() and friends, and probably also the include of
  linux/module.h, can be dropped from these two files.

Furthermore, the references to CONFIG_SND_ATMEL_SOC_PDC_MODULE and
CONFIG_SND_ATMEL_SOC_DMA_MODULE in atmel-pcm.h can be removed now.

Thanks,


Paul Bolle
