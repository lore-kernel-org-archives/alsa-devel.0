From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] Allow passing platform_data for
	pxa2xx-ac97
Date: Thu, 23 Jul 2009 16:14:59 +0100
Message-ID: <20090723151458.GA17853@rakim.wolfsonmicro.main>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907221302.40893.marek.vasut@gmail.com>
	<20090723102741.GB6673@rakim.wolfsonmicro.main>
	<200907231616.13101.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32BA42452E
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 17:15:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907231616.13101.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Robert Jarzmik <robert.jarzmik@free.fr>, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, avorontsov@ru.mvista.com, dwmw2@infradead.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 23, 2009 at 04:16:12PM +0200, Marek Vasut wrote:

> This patch adds support for passing platform data to ac97 bus devices
> from PXA2xx-AC97 driver..

I'm OK with this.  Eric any issues?

> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/include/mach/audio.h |    3 +++
>  include/sound/ac97_codec.h             |    3 +++
>  sound/arm/pxa2xx-ac97.c                |    9 +++++++++
>  sound/soc/pxa/pxa2xx-ac97.c            |   11 ++++++++++-
>  4 files changed, 25 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/include/mach/audio.h b/arch/arm/mach-pxa/include/mach/audio.h
> index 16eb025..a3449e3 100644
> --- a/arch/arm/mach-pxa/include/mach/audio.h
> +++ b/arch/arm/mach-pxa/include/mach/audio.h
> @@ -3,10 +3,12 @@
>  
>  #include <sound/core.h>
>  #include <sound/pcm.h>
> +#include <sound/ac97_codec.h>
>  
>  /*
>   * @reset_gpio: AC97 reset gpio (normally gpio113 or gpio95)
>   *              a -1 value means no gpio will be used for reset
> + * @codec_pdata: AC97 codec platform_data
>  
>   * reset_gpio should only be specified for pxa27x CPUs where a silicon
>   * bug prevents correct operation of the reset line. If not specified,
> @@ -20,6 +22,7 @@ typedef struct {
>  	void (*resume)(void *);
>  	void *priv;
>  	int reset_gpio;
> +	void *codec_pdata[AC97_BUS_MAX_DEVICES];
>  } pxa2xx_audio_ops_t;
>  
>  extern void pxa_set_ac97_info(pxa2xx_audio_ops_t *ops);
> diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
> index 9b1c098..3dae3f7 100644
> --- a/include/sound/ac97_codec.h
> +++ b/include/sound/ac97_codec.h
> @@ -32,6 +32,9 @@
>  #include "control.h"
>  #include "info.h"
>  
> +/* maximum number of devices on the AC97 bus */
> +#define	AC97_BUS_MAX_DEVICES	4
> +
>  /*
>   *  AC'97 codec registers
>   */
> diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
> index c570ebd..22d4f83 100644
> --- a/sound/arm/pxa2xx-ac97.c
> +++ b/sound/arm/pxa2xx-ac97.c
> @@ -170,6 +170,13 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
>  	struct snd_ac97_bus *ac97_bus;
>  	struct snd_ac97_template ac97_template;
>  	int ret;
> +	pxa2xx_audio_ops_t *pdata = dev->dev.platform_data;
> +
> +	if (dev->id >= 0) {
> +		dev_err(&dev->dev, "PXA2xx has only one AC97 port.\n");
> +		ret = -ENXIO;
> +		goto err_dev;
> +	}
>  
>  	ret = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
>  			      THIS_MODULE, 0, &card);
> @@ -200,6 +207,7 @@ static int __devinit pxa2xx_ac97_probe(struct platform_device *dev)
>  	snprintf(card->longname, sizeof(card->longname),
>  		 "%s (%s)", dev->dev.driver->name, card->mixername);
>  
> +	snd_ac97_dev_add_pdata(ac97_bus->codec[0], pdata->codec_pdata[0]);
>  	snd_card_set_dev(card, &dev->dev);
>  	ret = snd_card_register(card);
>  	if (ret == 0) {
> @@ -212,6 +220,7 @@ err_remove:
>  err:
>  	if (card)
>  		snd_card_free(card);
> +err_dev:
>  	return ret;
>  }
>  
> diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
> index d9c94d7..b19451d 100644
> --- a/sound/soc/pxa/pxa2xx-ac97.c
> +++ b/sound/soc/pxa/pxa2xx-ac97.c
> @@ -22,6 +22,7 @@
>  #include <mach/hardware.h>
>  #include <mach/regs-ac97.h>
>  #include <mach/dma.h>
> +#include <mach/audio.h>
>  
>  #include "pxa2xx-pcm.h"
>  #include "pxa2xx-ac97.h"
> @@ -241,9 +242,17 @@ EXPORT_SYMBOL_GPL(soc_ac97_ops);
>  static int __devinit pxa2xx_ac97_dev_probe(struct platform_device *pdev)
>  {
>  	int i;
> +	pxa2xx_audio_ops_t *pdata = pdev->dev.platform_data;
>  
> -	for (i = 0; i < ARRAY_SIZE(pxa_ac97_dai); i++)
> +	if (pdev->id >= 0) {
> +		dev_err(&dev->dev, "PXA2xx has only one AC97 port.\n");
> +		return -ENXIO;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(pxa_ac97_dai); i++) {
>  		pxa_ac97_dai[i].dev = &pdev->dev;
> +		pxa_ac97_dai[i].ac97_pdata = pdata->codec_pdata[0];
> +	}
>  
>  	/* Punt most of the init to the SoC probe; we may need the machine
>  	 * driver to do interesting things with the clocking to get us up
> -- 
> 1.6.3.3
> 
