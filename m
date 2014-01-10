From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] ASoC: imx: Allow using sound with DT
	descriptions only
Date: Fri, 10 Jan 2014 11:45:04 +0800
Message-ID: <20140110034501.GH21717@S2101-09.ap.freescale.net>
References: <1389170635-22301-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id B152A26533F
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 04:44:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1389170635-22301-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 08, 2014 at 12:43:55PM +0400, Alexander Shiyan wrote:
> This patch allow using generic sound cards/codecs based on DT description.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  sound/soc/fsl/Kconfig   | 25 +++----------------------
>  sound/soc/fsl/Makefile  |  5 ++---
>  sound/soc/fsl/imx-pcm.h |  7 -------
>  3 files changed, 5 insertions(+), 32 deletions(-)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 1c7b3b7..cf0d5af 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -7,6 +7,7 @@ config SND_SOC_FSL_SSI
>  
>  config SND_SOC_FSL_SPDIF
>  	tristate
> +	select REGMAP_MMIO
>  
>  config SND_SOC_FSL_UTILS
>  	tristate
> @@ -106,6 +107,8 @@ endif # SND_POWERPC_SOC
>  menuconfig SND_IMX_SOC
>  	tristate "SoC Audio for Freescale i.MX CPUs"
>  	depends on ARCH_MXC || COMPILE_TEST
> +	select SND_SOC_FSL_SSI if OF
> +	select SND_SOC_GENERIC_DMAENGINE_PCM

I'm seeing the following link error when I build a kernel with
SND_IMX_SOC=y and SND_SOC_PHYCORE_AC97=m.

sound/built-in.o: In function `fsl_ssi_probe':
last.c:(.text+0x292c0): undefined reference to `imx_pcm_fiq_init'

Shawn

>  	help
>  	  Say Y or M if you want to add support for codecs attached to
>  	  the i.MX CPUs.
> @@ -119,19 +122,11 @@ config SND_SOC_IMX_PCM_FIQ
>  	tristate
>  	select FIQ
>  
> -config SND_SOC_IMX_PCM_DMA
> -	tristate
> -	select SND_SOC_GENERIC_DMAENGINE_PCM
> -
> -config SND_SOC_IMX_AUDMUX
> -	tristate
> -
>  config SND_MXC_SOC_WM1133_EV1
>  	tristate "Audio on the i.MX31ADS with WM1133-EV1 fitted"
>  	depends on MACH_MX31ADS_WM1133_EV1
>  	select SND_SOC_WM8350
>  	select SND_SOC_IMX_PCM_FIQ
> -	select SND_SOC_IMX_AUDMUX
>  	select SND_SOC_IMX_SSI
>  	help
>  	  Enable support for audio on the i.MX31ADS with the WM1133-EV1
> @@ -141,8 +136,6 @@ config SND_SOC_MX27VIS_AIC32X4
>  	tristate "SoC audio support for Visstrim M10 boards"
>  	depends on MACH_IMX27_VISSTRIM_M10 && I2C
>  	select SND_SOC_TLV320AIC32X4
> -	select SND_SOC_IMX_PCM_DMA
> -	select SND_SOC_IMX_AUDMUX
>  	select SND_SOC_IMX_SSI
>  	help
>  	  Say Y if you want to add support for SoC audio on Visstrim SM10
> @@ -154,7 +147,6 @@ config SND_SOC_PHYCORE_AC97
>  	select SND_SOC_AC97_BUS
>  	select SND_SOC_WM9712
>  	select SND_SOC_IMX_PCM_FIQ
> -	select SND_SOC_IMX_AUDMUX
>  	select SND_SOC_IMX_SSI
>  	help
>  	  Say Y if you want to add support for SoC audio on Phytec phyCORE
> @@ -169,7 +161,6 @@ config SND_SOC_EUKREA_TLV320
>  	depends on I2C
>  	select SND_SOC_TLV320AIC23
>  	select SND_SOC_IMX_PCM_FIQ
> -	select SND_SOC_IMX_AUDMUX
>  	select SND_SOC_IMX_SSI
>  	help
>  	  Enable I2S based access to the TLV320AIC23B codec attached
> @@ -179,9 +170,6 @@ config SND_SOC_IMX_WM8962
>  	tristate "SoC Audio support for i.MX boards with wm8962"
>  	depends on OF && I2C
>  	select SND_SOC_WM8962
> -	select SND_SOC_IMX_PCM_DMA
> -	select SND_SOC_IMX_AUDMUX
> -	select SND_SOC_FSL_SSI
>  	help
>  	  Say Y if you want to add support for SoC audio on an i.MX board with
>  	  a wm8962 codec.
> @@ -190,18 +178,13 @@ config SND_SOC_IMX_SGTL5000
>  	tristate "SoC Audio support for i.MX boards with sgtl5000"
>  	depends on OF && I2C
>  	select SND_SOC_SGTL5000
> -	select SND_SOC_IMX_PCM_DMA
> -	select SND_SOC_IMX_AUDMUX
> -	select SND_SOC_FSL_SSI
>  	help
>  	  Say Y if you want to add support for SoC audio on an i.MX board with
>  	  a sgtl5000 codec.
>  
>  config SND_SOC_IMX_SPDIF
>  	tristate "SoC Audio support for i.MX boards with S/PDIF"
> -	select SND_SOC_IMX_PCM_DMA
>  	select SND_SOC_FSL_SPDIF
> -	select REGMAP_MMIO
>  	help
>  	  SoC Audio support for i.MX boards with S/PDIF
>  	  Say Y if you want to add support for SoC audio on an i.MX board with
> @@ -211,8 +194,6 @@ config SND_SOC_IMX_MC13783
>  	tristate "SoC Audio support for I.MX boards with mc13783"
>  	depends on MFD_MC13XXX && ARM
>  	select SND_SOC_IMX_SSI
> -	select SND_SOC_IMX_AUDMUX
>  	select SND_SOC_MC13783
> -	select SND_SOC_IMX_PCM_DMA
>  
>  endif # SND_IMX_SOC
> diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
> index aaccbee..5474a0c 100644
> --- a/sound/soc/fsl/Makefile
> +++ b/sound/soc/fsl/Makefile
> @@ -34,11 +34,10 @@ obj-$(CONFIG_SND_MPC52xx_SOC_EFIKA) += efika-audio-fabric.o
>  # i.MX Platform Support
>  snd-soc-imx-ssi-objs := imx-ssi.o
>  snd-soc-imx-audmux-objs := imx-audmux.o
> +obj-$(CONFIG_SND_SOC_IMX_PCM_FIQ) += imx-pcm-fiq.o
>  obj-$(CONFIG_SND_SOC_IMX_SSI) += snd-soc-imx-ssi.o
> -obj-$(CONFIG_SND_SOC_IMX_AUDMUX) += snd-soc-imx-audmux.o
>  
> -obj-$(CONFIG_SND_SOC_IMX_PCM_FIQ) += imx-pcm-fiq.o
> -obj-$(CONFIG_SND_SOC_IMX_PCM_DMA) += imx-pcm-dma.o
> +obj-$(CONFIG_SND_IMX_SOC) += imx-pcm-dma.o snd-soc-imx-audmux.o
>  
>  # i.MX Machine Support
>  snd-soc-eukrea-tlv320-objs := eukrea-tlv320.o
> diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
> index c79cb27..a1364cb 100644
> --- a/sound/soc/fsl/imx-pcm.h
> +++ b/sound/soc/fsl/imx-pcm.h
> @@ -38,14 +38,7 @@ struct imx_pcm_fiq_params {
>  	struct snd_dmaengine_dai_dma_data *dma_params_tx;
>  };
>  
> -#if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_DMA)
>  int imx_pcm_dma_init(struct platform_device *pdev);
> -#else
> -static inline int imx_pcm_dma_init(struct platform_device *pdev)
> -{
> -	return -ENODEV;
> -}
> -#endif
>  
>  #if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_FIQ)
>  int imx_pcm_fiq_init(struct platform_device *pdev,
> -- 
> 1.8.3.2
> 
