From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] ASoC: AD183x: add support for more
	multiple parts
Date: Wed, 15 Jun 2011 15:53:21 +0100
Message-ID: <20110615145321.GB2806@opensource.wolfsonmicro.com>
References: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
	<1308087268-11464-8-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2E55103800
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 16:53:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308087268-11464-8-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Scott Jiang <scott.jiang@analog.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Barry Song <barry.song@analog.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 14, 2011 at 05:34:28PM -0400, Mike Frysinger wrote:

This is OK but some nits/future improvements:

> +static const struct snd_kcontrol_new ad1835a_ad1837a_snd_controls[] = {
> +	/* DAC volume control */
> +	SOC_DOUBLE_R("DAC1 Volume", AD183X_DAC_L1_VOL,
> +			AD183X_DAC_R1_VOL, 0, 0x3FF, 0),

It would be much better to provide dB information but OK.

> +	/* DAC de-emphasis */
> +	SOC_ENUM("Playback Deemphasis", ad183x_deemp_enum),

OK for now but what modern drivers are doing here is making the
deemphasis switch a switch at the application layer then automatically
selecting the sample rate to use for the filter based on the active
sample rate.

> @@ -45,17 +125,17 @@ static const struct snd_kcontrol_new ad183x_snd_controls[] = {
>  
>  	/* ADC switch control */
>  	SOC_DOUBLE("ADC1 Switch", AD183X_ADC_CTRL2, AD183X_ADCL1_MUTE,
> -		AD183X_ADCR1_MUTE, 1, 1),
> +			AD183X_ADCR1_MUTE, 1, 1),

Indentation changes should really be in a separate patch if you end up
needing to respin the series.

> +	if (!strcmp(chip_name, "ad1835a") || !strcmp(chip_name, "ad1837a"))
> +		ad183x->chl_ctrl = &ad1835a_ad1837a_chl_ctrls;
> +	else if (!strcmp(chip_name, "ad1838a") || !strcmp(chip_name, "ad1839a"))
> +		ad183x->chl_ctrl = &ad1838a_ad1839a_chl_ctrls;
> +	else if (!strcmp(chip_name, "ad1836"))
> +		ad183x->chl_ctrl = &ad1836_chl_ctrls;
> +	else {
> +		dev_err(&spi->dev, "unsupported chip type: %s\n", chip_name);
> +		return -EINVAL;

Someone really ought to get around to fixing this in the SPI subsystem
:/
