From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/6] ASoC: new ADAU1381 codec driver
Date: Sat, 7 Aug 2010 22:43:47 +0100
Message-ID: <2E20D884-E177-4960-937D-5327DFDB185D@opensource.wolfsonmicro.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	<1281212905-12957-3-git-send-email-vapier@gentoo.org>
	(sfid-20100807_212829_472925_41562063)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A97810380E
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 23:43:27 +0200 (CEST)
In-Reply-To: <1281212905-12957-3-git-send-email-vapier@gentoo.org>
	(sfid-20100807_212829_472925_41562063)
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
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On 7 Aug 2010, at 21:28, Mike Frysinger <vapier@gentoo.org> wrote:

> From: Cliff Cai <cliff.cai@analog.com>
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

As with all your other postings today this needs to be redone based on the multi-component branch. It is safe to assume that any new drivers like this ought to be done against the multi-component branch.

> +#define AUDIO_NAME "adau1381"
> +#define ADAU1381_VERSION "0.1"

Remove the version number at least.

> +#define CAP_MIC  1
> +#define CAP_LINE 2
> +#define CAPTURE_SOURCE_NUMBER 2
> +#define ADAU1381_DIG_MIC 0

No ifdefs, this is all stuff that should be configured by the machine driver for the particular board rather than hard coded by the CODEC.

This comes back to the issue I keep raising with the way you guys are doing machine drivers. The machine drivers should describe how a particular board is set up while all the Blackfin machine drivers are producing a "generic" machine driver which attempts to cover all possible machines, which results in things like this and the SPORT stuff in Kconfig as soon as you get even a mildly flexible system setup. It really would be a good idea to fix up your machine drivers to use the framework in the intended fashion, especially as people start deploying more flexible CODECs in conjunction with Blackfin.

> +	if (i2c_master_recv(codec->control_data, buf, len) != len)
> +		return -EIO;

If i2c_master_recv() gave you an error code you should return that. -EIO is reasonable for short reads.

> +#if !defined(ADAU1381_DIG_MIC)
> +SND_SOC_DAPM_MICBIAS("Mic Bias", ADAU_RECMBIA-ADAU_FIRSTREG, 0, 0),
> +SND_SOC_DAPM_MIXER("Left Mic Mixer", ADAU_RECVLCL-ADAU_FIRSTREG, 0, 0, NULL, 0),
> +SND_SOC_DAPM_MIXER("Right Mic Mixer", ADAU_RECVLCR-ADAU_FIRSTREG, 0, 0, NULL, 0),
> +#else
> +SND_SOC_DAPM_MICBIAS("Mic Bias Left", SND_SOC_NOPM, 1, 0),
> +SND_SOC_DAPM_MICBIAS("Mic Bias Right", SND_SOC_NOPM, 1, 0),
> +SND_SOC_DAPM_MIXER("Left Mic Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
> +SND_SOC_DAPM_MIXER("Right Mic Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),

It's difficult to see the point of the two biases here - they're not representing anything in the chip (they're _NOPM).

> +	snd_soc_write(codec, ADAU_DIGPWR0, 0xF3);
> +	snd_soc_write(codec, ADAU_DIGPWR0, 0x0D);
> +	reg = (snd_soc_read(codec, ADAU_CONVCT0) & 0xF8) | reg;
> +	snd_soc_write(codec, ADAU_CONVCT0, reg);
> +	reg = (snd_soc_read(codec, ADAU_SAMRATE)) | reg;
> +	snd_soc_write(codec, ADAU_SAMRATE, reg);
> +
> +	reg = (snd_soc_read(codec, ADAU_FRMRATE)) | reg;
> +	snd_soc_write(codec, ADAU_FRMRATE, reg);
> +	snd_soc_write(codec, ADAU_ENGIRUN, 0x01);

It's hard to tell what all this is doing due to the use of magic numbers but it feels like something that'd be better done through the power management infrastructure (either DAPM or the bias level configuration) rather than this.

> +	/* set master/slave audio interface */
> +	reg = (snd_soc_read(codec, ADAU_SPRTCT0) & 0xFE);
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:  /*master*/
> +		reg |= 0x1;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS: /*slave*/
> +		reg &= ~0x1;
> +		break;
> +	default:
> +		return 0;
> +	}

Here and elsewhere in the driver I'd expect the default case to return an error rather than zero when it's bombing out.

> +	switch (freq) {
> +	case 12000000:
> +		adau1381->sysclk = freq;
> +		return 0;
> +	case 12288000:
> +		adau1381->sysclk = freq;
> +		return 0;
> +	}
> +
> +	/* supported 12MHz MCLK only for now */
> +	return -EINVAL;

This comment is bit rotted - it'd probably be clearer to just use a default: case in the switch statement.

> +	/* Only update pll when freq changes */
> +	if (adau1381->pll_enable && adau1381->pll_out == freq_out)
> +		return 0;

Given that you only store the value and don't actually reconfigure the PLL here this is redundant. Doesn't do any harm, though.

> +	case SND_SOC_BIAS_STANDBY:
> +		snd_soc_write(codec, ADAU_CLKCTRL,
> +			(CLKCTRL_SRC_PLL | CLKCTRL_FRQ_1024 | CLKCTRL_DISABLE));
> +		break;

What exactly is this doing? Looking at the bitfields being set it looks like it's doing something that ought to be done elsewhere.

> +static int adau1381_resume(struct platform_device *pdev)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +	struct adau1381_priv *adau1381 = codec->private_data;
> +
> +	adau1381->pdev = pdev;

Why is this being done here rather than on init? Though all this will change when you redo this against multi-component?

> +	schedule_work(&adau1381->resume_work);

Why are you deferring this to scheduled work? ASoC already defers all resume work for non-AC97 devices to a workqueue in order to minimise the impact of things like lengthy rise times for VMIDs and register restores over slow buses so adding an additional deferral seems odd. This code seems likely to cause problems since it's not synchronised with userspace at all (the ASoC core stuff is) which means that applications may start trying to use the device before the work has completed.


> +	adau1381->in_source = CAP_MIC; /*default is mic input*/
> +	adau1381->sysclk = ADAU1381_MCLK_RATE;
> +	adau1381->pll_out = ADAU1381_PLL_FREQ_48;
> +	adau1381->dapm_lineL = DAPM_LINE_DEF;
> +	adau1381->dapm_lineR = DAPM_LINE_DEF;
> +	adau1381->dapm_hpL = DAPM_HP_DEF;
> +	adau1381->dapm_hpR = DAPM_HP_DEF;

As with your other drivers you should use chip defaults.

> +struct adau1381_setup_data {
> +	unsigned short i2c_bus;
> +	unsigned short i2c_address;
> +};

This shouldn't be here.

> +#define MASTER_MODE 1
> +#ifdef MASTER_MODE
> +/* IIS mater mode*/
> +#define ADAU_SRPT_CTRL0		0x01
> +#else
> +/* IIS slave mode*/
> +#define ADAU_SRPT_CTRL0		0x00
> +#endif

This should be controlled at runtime via set_dai_fmt(). There's also a namespace pollution issue with the define, but given that it shouldn't be there in the first place...


> +/*
> + * Reset Mode - ADC capture/DAC playback
> + * (AInput mixers 0db, AOuput mixers 0db, HP out ON)
> +*/
> +static struct adau1381_mode_register adau1381_reset[RESET_REGISTER_COUNT] = {
> +	/* mute outputs */
> +	{ADAU_RGUCTRL, 0x00},

This and all the other tables need to be in the body of the driver rather than the header file. I'm somewhat surprised the compiler isn't complaining about this stuff.

> +	{ADAU_SPRTCT1, 0x21}, /*0x21 = 32bclocks frame, 0x41 = 48*/

Is this not the chip default?
