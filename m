From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Analog Devices AD193X I2S codec
	family driver.
Date: Thu, 18 Sep 2008 15:54:46 +0100
Message-ID: <20080918145445.GE4203@sirena.org.uk>
References: <20080918130309.GA14895@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C422243F0
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Sep 2008 16:54:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080918130309.GA14895@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2008 at 03:03:09PM +0200, Manuel Lauss wrote:
> Driver for the Analog Devices AD1935/AD1937 I2C and
> AD1938/AD1939 SPI codecs.

Thanks.  Overall this looks good, I've got some comments below but
there's only some fairly minor stuff that *needs* to be addressed before
merging.

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -2,6 +2,9 @@ config SND_SOC_AC97_CODEC
>  	tristate
>  	select SND_AC97_CODEC
>  
> +config SND_SOC_AD1939
> +	tristate
> +

Please also add this to the SND_SOC_ALL_CODECS Kconfig option.

> @@ -1,4 +1,5 @@
>  snd-soc-ac97-objs := ac97.o
> +snd-soc-ad1939-objs := ad1939.o
>  snd-soc-ak4535-objs := ak4535.o

Not sure if git will apply this cleanly - best to generate against the
topic/asoc branch of Takashi's tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

> +/* Does the codec have power?  In case of STANDBY/OFF BIAS levels, the
> + * hardware access functions below assume the codec is without power
> + * to avoid futile bus transactions.
> + */
> +static int codec_is_powered(struct snd_soc_codec *c)
> +{
> +	return (c->bias_level == SND_SOC_BIAS_PREPARE) ||
> +		(c->bias_level == SND_SOC_BIAS_ON);
> +}

It'd be worth updating this comment to mention what you're doing with
the chip power in the standby state - it's unusual for the codec to be
held with so little power in standby mode that register writes don't
work, which is why this is a driver-specific thing.  I guess if DAPM
support were implemented then this wouldn't be required any more?

> +/* add non dapm controls */
> +static int ad1939_add_controls(struct snd_soc_codec *codec)
> +{
> +	struct ad1939_private *ad = codec->private_data;
> +	int err, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad1939_snd_ctls); i++) {
> +		if ((i <= 3) && (i >= ad->mixpairs))
> +			continue;

This could really use a comment, at least referencing the documentation
in the header file.

> +static int ad1939_hw_params(struct snd_pcm_substream *substream,
> +			    struct snd_pcm_hw_params *params)
> +{

> +	/* sample rate */
> +	dac0 &= ~(3<<1);	/* 48kHz */
> +	adc0 &= ~(3<<6);	/* 48kHz */

Might be worth making these comments (and the similar ones you have
elsewhere) say "Default: 48kHz" or similar.  I can see what you're doing
here but on first reading through it was a bit confusing.  Not really 
important, though.

> +	switch (rate) {
> +	case 32000 ... 48000:
> +		break;
> +	case 64000 ... 96000:
> +		dac0 |= (1<<1);
> +		adc0 |= (1<<6);
> +		break;
> +	case 128000 ... 192000:
> +		dac0 |= (2<<1);
> +		adc0 |= (2<<6);
> +		break;

This and some of the other code will force the ADC and DAC to have the
same configuration - is that needed by the codec?  If not then it'd be
better to check which substream it is operating on and only configure
the ADC or DAC as appropriate (you could save lots of conditionals by
only checking when actually writing the configuration out at the end of
the function).

With the code as it currently stands the codec should impose constraints
to let user space know that the playback and capture streams have to be
in the same mode.  There's examples of how to do that in cs4270,
ssm2602, wm8903 and possibly other drivers.

One or the other of these should probably be done prior to merge.

> +	/* codec clocks master/slave setup */
> +	dac1 &= ~((1<<4) | (1<<5)); /* LRCK BCK slave */
> +	adc2 &= ~((1<<3) | (1<<6)); /* LRCK BCK slave */
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:	 /* BCK/LCK master */
> +		dac1 |= (1<<4) | (1<<5); /* LRCK BCK master */
> +		adc2 |= (1<<3) | (1<<6); /* LRCK BCK master */
> +		if (ad->drvflags & AD1939_DRV_ADCDAC_COMMON_BCK) {
> +			if (ad->drvflags & AD1939_DRV_ADC_BCK_MASTER)
> +				dac1 &= ~(1<<5); /* DAC BCLK slave */
> +			else
> +				adc2 &= ~(1<<6); /* ADC BCLK slave */
> +		}

In general if the codec has clocking which can be configured as flexibly
as this one appears to then it's normally better to allow the machine
driver to configure the clocking manually via the clock configuration
APIs.

This avoids having to have code in the codec driver to support unusual
machine configurations such as those where the audio clocks are also
used for other devices and lets machine drivers do things like change
clock sources dynamically at run time.  For example, a system may only
enable the PLL for some clock rates and use a crystal source for others,
saving power.  It also frees you from having to worry about imposing
constraints arising from things like shared LRCLKs in the codec driver,
saving quite a bit of complexity.

This is probably OK for merge as-is but it's very different to how most
codec drivers work and is going to limit what people can do with the
driver.

> +#define AD1939_RATES	\
> +	(SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 | \
> +	 SNDRV_PCM_RATE_192000)

Your code appeared to support rather more rates than this?

> +	/* limit output attenuation controls to requested number */
> +	ad->mixpairs = setup->mixpairs;
> +	if ((ad->mixpairs < 1) || (ad->mixpairs > 4))
> +		ad->mixpairs = 4;

It's probably worth complaining if someone tries to set ad->mixpairs to
something more than 4.  It may be better to just not do this and leave
the controls exposed - why is this being done?

> +	/* Bitclock sources for the ADC and DAC I2S interfaces */
> +	r0 = ad1939_read(codec, AD1939_DACCTL1);
> +	r1 = ad1939_read(codec, AD1939_ADCCTL2);
> +	r0 &= ~AD1939_BCLKSRC_DAC_PLL;
> +	r1 &= ~AD1939_BCLKSRC_ADC_PLL;
> +	r0 |= setup->dac_adc_clksrc & AD1939_BCLKSRC_DAC_PLL;
> +	r1 |= setup->dac_adc_clksrc & AD1939_BCLKSRC_ADC_PLL;
> +	ad1939_write(codec, AD1939_DACCTL1, r0);
> +	ad1939_write(codec, AD1939_ADCCTL2, r1);

This definitely makes it look like the chip is flexible enough to
warrant allowing machine drivers finer grained control.

> +	/* register pcms */
> +	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1,
> +			       SNDRV_DEFAULT_STR1);
> +	if (unlikely(ret < 0)) {

Optimist :)

> +	printk(KERN_ERR CODEC_NAME ": i2c codec init failed\n");

Since you have an I2C device here this could be dev_err().

> +#define ad1939_i2c_suspend NULL
> +#define ad1939_i2c_resume NULL

> +#define ad1939_spi_suspend NULL
> +#define ad1939_spi_resume NULL

It'd be better to just remove these - they can be added when someone
implements them and in the mean time it'll avoid anyone seeing the
references and assuming suspend and resume are supported.

> +/* Master PLL clock source, select one */
> +#define AD1939_PLL_SRC_MCLK		0	/* external clock */
> +#define AD1939_PLL_SRC_DACLRCK		1	/* get from DAC LRCLK */
> +#define AD1939_PLL_SRC_ADCLRCK		2	/* get from ADC LRCLK */

> +/* clock sources for ADC, DAC. Refer to the manual for more information
> + * (for 192000kHz modes, internal PLL _MUST_ be used). Select one for ADC
> + * and DAC.

> +/* MCLK_XO pin configuration */
> +#define AD1939_MCLKXO_MCLKXI		0	/* mirror MCLK_XI pin */
> +#define AD1939_MCLKXO_256FS		1
> +#define AD1939_MCLKXO_512FS		2
> +#define AD1939_MCLKXO_OFF		3	/* disable MCLK_XO output */

These are things that I'd definitely expect to see configured via clock
configuration calls.
