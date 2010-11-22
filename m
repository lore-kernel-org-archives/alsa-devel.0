From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCHv4 03/18] ARM: Samsung: Define common
	audio-dma device
Date: Mon, 22 Nov 2010 16:07:51 +0900
Message-ID: <001701cb8a13$fbf8cf30$f3ea6d90$%kim@samsung.com>
References: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
	<1290407753-29092-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 475751039B0
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 08:07:29 +0100 (CET)
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LC9006VPYGENA30@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 22 Nov 2010 16:07:26 +0900 (KST)
Received: from DOKGENEKIM02 ([12.23.103.104])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LC9008HRYGEHE@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 22 Nov 2010 16:07:26 +0900 (KST)
In-reply-to: <1290407753-29092-1-git-send-email-jassisinghbrar@gmail.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Jassi Brar' <jassisinghbrar@gmail.com>, alsa-devel@alsa-project.org
Cc: 'Jassi Brar' <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

Jassi Brar wrote:
> 
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> The ASoC uses common DMA driver for Audio devices. So it makes
> sense to a common audio-dma device shared across all platforms.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Added Ben Dooks in Cc.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  arch/arm/mach-s3c2410/mach-h1940.c        |    2 +-
>  arch/arm/mach-s3c2440/mach-rx1950.c       |    2 +-
>  arch/arm/mach-s3c64xx/dev-audio.c         |   13 -------------
>  arch/arm/mach-s3c64xx/mach-smdk6410.c     |    2 +-
>  arch/arm/plat-s3c24xx/devs.c              |   17 ++---------------
>  arch/arm/plat-samsung/Makefile            |    1 +
>  arch/arm/plat-samsung/dev-asocdma.c       |   24 ++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/devs.h |    2 +-
>  8 files changed, 31 insertions(+), 32 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/dev-asocdma.c
> 
> diff --git a/arch/arm/mach-s3c2410/mach-h1940.c
b/arch/arm/mach-s3c2410/mach-
> h1940.c
> index d7ada8c..1a81fe1 100644
> --- a/arch/arm/mach-s3c2410/mach-h1940.c
> +++ b/arch/arm/mach-s3c2410/mach-h1940.c
> @@ -387,7 +387,7 @@ static struct platform_device *h1940_devices[]
__initdata
> = {
>  	&s3c_device_wdt,
>  	&s3c_device_i2c0,
>  	&s3c_device_iis,
> -	&s3c_device_pcm,
> +	&samsung_asoc_dma,
>  	&s3c_device_usbgadget,
>  	&h1940_device_leds,
>  	&h1940_device_bluetooth,
> diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-
> s3c2440/mach-rx1950.c
> index e0622bb..eab6ae5 100644
> --- a/arch/arm/mach-s3c2440/mach-rx1950.c
> +++ b/arch/arm/mach-s3c2440/mach-rx1950.c
> @@ -692,7 +692,7 @@ static struct platform_device *rx1950_devices[]
> __initdata = {
>  	&s3c_device_wdt,
>  	&s3c_device_i2c0,
>  	&s3c_device_iis,
> -	&s3c_device_pcm,
> +	&samsung_asoc_dma,
>  	&s3c_device_usbgadget,
>  	&s3c_device_rtc,
>  	&s3c_device_nand,
> diff --git a/arch/arm/mach-s3c64xx/dev-audio.c
b/arch/arm/mach-s3c64xx/dev-
> audio.c
> index bbaf7b3..4a4b8a5 100644
> --- a/arch/arm/mach-s3c64xx/dev-audio.c
> +++ b/arch/arm/mach-s3c64xx/dev-audio.c
> @@ -315,16 +315,3 @@ void __init s3c64xx_ac97_setup_gpio(int num)
>  	else
>  		s3c_ac97_pdata.cfg_gpio = s3c64xx_ac97_cfg_gpe;
>  }
> -
> -static u64 s3c_device_audio_dmamask = 0xffffffffUL;
> -
> -struct platform_device s3c_device_pcm = {
> -	.name		  = "samsung-audio",
> -	.id		  = -1,
> -	.dev              = {
> -		.dma_mask = &s3c_device_audio_dmamask,
> -		.coherent_dma_mask = 0xffffffffUL
> -	}
> -};
> -EXPORT_SYMBOL(s3c_device_pcm);
> -
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-
> s3c64xx/mach-smdk6410.c
> index 77488fa..e85192a 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -283,7 +283,7 @@ static struct platform_device *smdk6410_devices[]
> __initdata = {
>  	&s3c_device_fb,
>  	&s3c_device_ohci,
>  	&s3c_device_usb_hsotg,
> -	&s3c_device_pcm,
> +	&samsung_asoc_dma,
>  	&s3c64xx_device_iisv4,
>  	&samsung_device_keypad,
> 
> diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
> index 4bf0b39..5987f94 100644
> --- a/arch/arm/plat-s3c24xx/devs.c
> +++ b/arch/arm/plat-s3c24xx/devs.c
> @@ -259,21 +259,6 @@ struct platform_device s3c_device_iis = {
> 
>  EXPORT_SYMBOL(s3c_device_iis);
> 
> -/* ASoC PCM DMA */
> -
> -static u64 s3c_device_audio_dmamask = 0xffffffffUL;
> -
> -struct platform_device s3c_device_pcm = {
> -	.name		  = "samsung-audio",
> -	.id		  = -1,
> -	.dev              = {
> -		.dma_mask = &s3c_device_audio_dmamask,
> -		.coherent_dma_mask = 0xffffffffUL
> -	}
> -};
> -
> -EXPORT_SYMBOL(s3c_device_pcm);
> -
>  /* RTC */
> 
>  static struct resource s3c_rtc_resource[] = {
> @@ -496,6 +481,8 @@ static struct resource s3c_ac97_resource[] = {
>  	},
>  };
> 
> +static u64 s3c_device_audio_dmamask = 0xffffffffUL;
> +
>  struct platform_device s3c_device_ac97 = {
>  	.name		  = "s3c-ac97",
>  	.id		  = -1,
> diff --git a/arch/arm/plat-samsung/Makefile
b/arch/arm/plat-samsung/Makefile
> index afcce47..19d8a16 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -17,6 +17,7 @@ obj-y				+= clock.o
>  obj-y				+= pwm-clock.o
>  obj-y				+= gpio.o
>  obj-y				+= gpio-config.o
> +obj-y				+= dev-asocdma.o
> 
>  obj-$(CONFIG_SAMSUNG_GPIOLIB_4BIT)	+= gpiolib.o
>  obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
> diff --git a/arch/arm/plat-samsung/dev-asocdma.c
b/arch/arm/plat-samsung/dev-
> asocdma.c
> new file mode 100644
> index 0000000..b7b1fca
> --- /dev/null
> +++ b/arch/arm/plat-samsung/dev-asocdma.c
> @@ -0,0 +1,24 @@
> +/* linux/arch/arm/plat-samsung/dev-asocdma.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co. Ltd
> + *	Jaswinder Singh <jassi.brar@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +
> +static u64 audio_dmamask = DMA_BIT_MASK(32);
> +
> +struct platform_device samsung_asoc_dma = {
> +	.name		  = "samsung-audio",
> +	.id		  = -1,
> +	.dev              = {
> +		.dma_mask = &audio_dmamask,
> +		.coherent_dma_mask = DMA_BIT_MASK(32),
> +	}
> +};
> +EXPORT_SYMBOL(samsung_asoc_dma);
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-
> samsung/include/plat/devs.h
> index dec0ded..e9e3b6e 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -32,7 +32,7 @@ extern struct platform_device s3c64xx_device_iisv4;
>  extern struct platform_device s3c64xx_device_spi0;
>  extern struct platform_device s3c64xx_device_spi1;
> 
> -extern struct platform_device s3c_device_pcm;
> +extern struct platform_device samsung_asoc_dma;
> 
>  extern struct platform_device s3c64xx_device_pcm0;
>  extern struct platform_device s3c64xx_device_pcm1;
> --
> 1.6.2.5
