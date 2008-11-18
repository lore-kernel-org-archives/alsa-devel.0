From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ARM DaVinci: Add PCM3008 ALSA SoC driver
	for the Lyrtech SFFSDR board
Date: Tue, 18 Nov 2008 11:31:51 +0000
Message-ID: <20081118113150.GC23217@sirena.org.uk>
References: <1226968079-1624-1-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D59B24516
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 12:31:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226968079-1624-1-git-send-email-hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: alsa-devel@alsa-project.org, Hugo Villeneuve <hugo.villeneuve@lyrtech.com>, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 17, 2008 at 07:27:59PM -0500, Hugo Villeneuve wrote:
> The PCM3008 is used on the Lyrtech SFFSDR board, in conjunction with an
> FPGA that generates the bit clock and the master clock

Looks fairly good overall.

> Signed-off-by: Hugo Villeneuve <hugo.villeneuve@lyrtech.com>

Normally codec drivers and machine drivers should be submitted as
separate patches, though it's not critical.

> index 5df7402..dc58ce2 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -80,6 +80,10 @@ config SND_SOC_TWL4030
>  	tristate
>  	depends on TWL4030_CORE
>  
> +config SND_SOC_PCM3008
> +	tristate
> +	depends on SFFSDR_FPGA

The codec driver shouldn't depend on the FPGA driver.  Once that
dependency has been removed the codec should be added to
SND_SOC_ALL_CODECS.

> +static int pcm3008_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params)
> +{
> +	int fs;
> +
> +	/* Fsref can be 32000, 44100 or 48000. */
> +	fs = params_rate(params);
> +
> +	printk(KERN_INFO "pcm3008_hw_params: rate = %d Hz\n", fs);
> +
> +	return sffsdr_fpga_set_codec_fs(fs);
> +}

This should be being done by the machine driver rather than by the codec
driver - this will allow the codec driver to be used on another machine
that has some other method for generating the clocks.  As far as I can
see that's the only dependency on the sffsdr?

> +	/* DEM1  DEM0  DE-EMPHASIS_MODE
> +	 * Low   Low   De-emphasis 44.1 kHz ON
> +	 * Low   High  De-emphasis OFF
> +	 * High  Low   De-emphasis 48 kHz ON
> +	 * High  High  De-emphasis 32 kHz ON
> +	 */

Looks like this should be exported as a control?  It's not important for
merging but it'd be nice.

> +static int pcm3008_soc_suspend(struct platform_device *pdev, pm_message_t msg)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct pcm3008_setup_data *setup = socdev->codec_data;
> +
> +	printk(KERN_INFO "pcm3008_soc_suspend(): TODO\n");

This should be a comment, though it looks like you may actually have
implemented this already?

> +struct pcm3008_setup_data {
> +	u8 dem0_pin;
> +	u8 dem1_pin;
> +	u8 pdad_pin;
> +	u8 pdda_pin;
> +};

GPIO numbers should be unsigned to match the gpiolib API (some systems
do support an awful lot of GPIOs).

Also, ideally pdad and pdad would be used to implement DAPM controls so
that they can be powered down when not in use but again that's not
essential for merging - so long as they're passed in someone could do
that later.

> +config SND_DAVINCI_SOC_SFFSDR
> +	tristate "SoC Audio support for SFFSDR"
> +	depends on SND_DAVINCI_SOC && MACH_DAVINCI_SFFSDR
> +	select SND_DAVINCI_SOC_I2S
> +	select SND_SOC_PCM3008
> +	help
> +	  Say Y if you want to add support for SoC audio on
> +	  Lyrtech SFFSDR board.

This should also select SSFDR_FPGA - select ignores dependencies so the
select from the codec driver won't be picked up (though the codec driver
ought not to be selecting it in the first place).

> --- /dev/null
> +++ b/sound/soc/davinci/davinci-sffsdr.c
> @@ -0,0 +1,145 @@
> +/*
> + * ASoC driver for Lyrtech SFFSDR board.
> + *
> + * Author:      Vladimir Barinov, <vbarinov@ru.mvista.com>
> + * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>

Are you sure?  Looks like cut'n'paste - MODULE_AUTHOR() claims you wrote
this driver.
