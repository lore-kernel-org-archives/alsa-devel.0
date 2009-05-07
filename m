From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] AFEB9260 ASoC driver
Date: Thu, 7 May 2009 16:46:11 +0100
Message-ID: <20090507154611.GK27897@sirena.org.uk>
References: <1241702685-18877-1-git-send-email-slapin@ossfans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9872B247E9
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 17:46:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1241702685-18877-1-git-send-email-slapin@ossfans.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergey Lapin <slapin@ossfans.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 07, 2009 at 05:24:45PM +0400, Sergey Lapin wrote:
> ASoC driver for AT91SAM9260-based AFEB9260 board

This looks good - there's some issues below but they're all pretty
nitpicky.

>  static struct i2c_board_info __initdata afeb9260_i2c_devices[] = {
>  	{
> +		I2C_BOARD_INFO("tlv320aic23", 0x1a),
> +	}, {

Push this separately via arch/arm - there's no build time dependency
here and it'll avoid any merge issues.

>  obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
>  obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) += snd-soc-playpaq.o
> +obj-$(CONFIG_SND_AT91_SOC_AFEB9260) += afeb9260.o

Normally ASoC drivers have a snd-soc- prefix.

> +/*
> + * afeb9260.c  --  SoC audio for AFEB9260
> + *
> + * Copyright (C) 2008 Sergey Lapin <slapin@ossfans.org>

2009?

> +static int afeb9260_startup(struct snd_pcm_substream *substream)
> +{
> +	return 1;
> +}

This is unneeded and should be removed.

> +static void afeb9260_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
> +
> +	dev_dbg(rtd->socdev->dev, "shutdown");
> +}

This too.

> +static int afeb9260_tlv320aic23_init(struct snd_soc_codec *codec)
> +{
> +
> +	/* Add osk5912 specific widgets */
> +	snd_soc_dapm_new_controls(codec, tlv320aic23_dapm_widgets,
> +				  ARRAY_SIZE(tlv320aic23_dapm_widgets));

Cut'n'paste error in the comments (and in a few other places) :)

> +static void __exit afeb9260_soc_exit(void)
> +{
> +	platform_device_unregister(afeb9260_snd_device);
> +}

Do you want to reverse your requst of the SSC port here?
