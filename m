From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: add a WM8978 codec driver
Date: Tue, 19 Jan 2010 10:57:29 +0000
Message-ID: <42962.538105394$1263901961@news.gmane.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	<Pine.LNX.4.64.1001190851380.4607@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10843103860
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 12:52:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1001190851380.4607@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 19, 2010 at 09:08:57AM +0100, Guennadi Liakhovetski wrote:

This all looks pretty good - there's a few issues below but they're
largely stylistic rather than anything fundamental.

> +	0x0000, 0x0000, 0x0000, 0x01ff,	/* 0x08...0x0b */ /* 0x0b contains the VU bit */
> +	0x01ff, 0x0000, 0x0100, 0x01ff,	/* 0x0c...0x0f */ /* 0x0c and 0x0f contain the VU bit */
> +	0x01ff, 0x0000, 0x012c, 0x002c,	/* 0x10...0x13 */ /* 0x10 contains the VU bit */

What do these comments refer to - do you mean to say that these are not
the actual chip register defaults?  The normal way to deal with those is
to have a write (or other update of the cache defaults).  This avoids
potential confusion later on if the chip updates the register defaults
or when reviewing against the datasheet.

> +#define ARRAY_SINGLE(xreg, xshift, xtexts) SOC_ENUM_SINGLE(xreg, xshift, \
> +						ARRAY_SIZE(xtexts), xtexts)

This looks generic - please namespace it and add it to the header file,
other drivers can benefit from it.

> +static const struct soc_enum wm8978_enum[] = {
> +	/* adc */
> +	ARRAY_SINGLE(WM8978_COMPANDING_CONTROL, 1, wm8978_companding),

Please define individual variables for this - indexing into the array
gets hard to follow, it's far too easy to have an off by one errors
trying to match things up.

> +#define MIXER_ARRAY(n, r, s, i, m) SND_SOC_DAPM_MIXER(n, r, s, i, \
> +                                                       m, ARRAY_SIZE(m))


> +/* Mixer #3: Boost (Input) mixer */
> +static const struct snd_kcontrol_new wm8978_left_boost_mixer[] = {
> +SOC_DAPM_SINGLE("Left PGA Mute", WM8978_LEFT_INP_PGA_CONTROL, 6, 1, 0),
> +};
> +static const struct snd_kcontrol_new wm8978_right_boost_mixer[] = {
> +SOC_DAPM_SINGLE("Right PGA Mute", WM8978_RIGHT_INP_PGA_CONTROL, 6, 1, 0),
> +};

These should have "Switch" at the end of the name.  Also, the names are
going be concatenated with the mixer names so you'll end up with things
"Left Boost Mixer Left PGA Switch" - the individual controls should
probably be just "Switch" so you end up with "Left Boost Mixer Switch".

> +/* Mic Input boost vol */
> +static const struct snd_kcontrol_new wm8978_mic_boost_controls[] = {
> +SOC_DAPM_SINGLE("Left Mic Volume", WM8978_LEFT_ADC_BOOST_CONTROL, 4, 7, 0),
> +SOC_DAPM_SINGLE("Right Mic Volume", WM8978_RIGHT_ADC_BOOST_CONTROL, 4, 7, 0),
> +};

This doesn't seem to be referenced anywhere?

> +#define MIXER_ARRAY(n, r, s, i, m) SND_SOC_DAPM_MIXER(n, r, s, i, \
> +							m, ARRAY_SIZE(m))

Again, this should be done somewhere generic.  Probably by going through
and changing the SND_SOC_DAPM_MIXER definition.

> +	/* Output PLL to GPIO1 */
> +	snd_soc_write(codec, WM8978_GPIO_CONTROL,
> +		      snd_soc_read(codec, WM8978_GPIO_CONTROL) | 0x4);

This should be being done unconditionally.  Put a switch in via the
set_dai_clkdiv() call.

> +	/* Mic bias */
> +	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1,
> +		      (snd_soc_read(codec, 1) & ~4) | 0x10);
> +
> +	/* Out-1 enabled, left/right input channel enabled */
> +	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_2, 0x1bf);
> +
> +	/* Out-2 disabled, right/left output channel enabled, dac enabled */
> +	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_3, 0x10f);

These should all be being managed via DAPM.

> +static int wm8978_set_bias_level(struct snd_soc_codec *codec,
> +				 enum snd_soc_bias_level level)
> +{
> +	u16 power1 = snd_soc_read(codec, WM8978_POWER_MANAGEMENT_1) & ~3;

This bitmask maintains everything except the two LSB...

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +	case SND_SOC_BIAS_PREPARE:
> +		power1 |= 1;  /* VMID 75k */
> +		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, power1);
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		power1 |= 0xC;

...but this is also managing other bits.

> +		if (codec->bias_level == SND_SOC_BIAS_OFF) {
> +			/* Initial cap charge at VMID 5k */
> +			snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1,
> +				      power1 | 0x3);
> +			mdelay(100);
> +		}

> +/* Also supports 12kHz */
> +#define WM8978_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
> +	SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | \
> +	SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)

SNDRV_PCM_RATE_8000_48000

> +static int wm8978_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +
> +	/* we only need to suspend if we are a valid card */
> +	if (!codec->card)
> +		return 0;

Don't need to check for the card any more, the core will stop you
getting called without a card.

> +	/* Sync reg_cache with the hardware */
> +	for (i = 0; i < ARRAY_SIZE(wm8978_reg); i++) {
> +		if (i == WM8978_RESET)
> +			continue;

You can also skip the write if the register has the default value (this
will speed up resume slightly).

> +		data = cpu_to_be16((i << 9) | (cache[i] & 0x1ff));
> +		codec->hw_write(codec->control_data, (char *)&data, 2);
> +	}

Just use snd_soc_write()?
