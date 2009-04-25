From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC] SoC WM8940 Driver
Date: Sat, 25 Apr 2009 11:21:04 +0100
Message-ID: <20090425102100.GA4394@sirena.org.uk>
References: <49F21310.4060009@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BA492458C
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Apr 2009 12:21:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49F21310.4060009@cam.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 24, 2009 at 07:29:20PM +0000, Jonathan Cameron wrote:

> Initial support for the WM8940 Mono Codec with speaker driver

Overall this looks very good but there are a few things it'd be good to
correct here.  A lot of this is due to copying from older drivers or the
fact that you're working against an older kernel.

> + * VROI (resistance control for unused outputs.

This will be system dependant, the machine driver should configure this
in the DAI init() function or you could let it be set by platform data.

> +static u16 wm8940_reg_defaults[] = {
> +	[WM8940_SOFTRESET] =		0x8940,
> +	[WM8940_POWER1] =		0x0000,

I'd really rather use the more standard ASoC style here with a simple
table of values.  The driver relies on the fact that the register
cache is fully specified for suspend and resume and having a straight
table makes sure that there aren't any missing values in the cache.

> +#define WM8940_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |	\
> +		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |	\
> +		      SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)

SNDRV_PCM_RATE_8000_48000

> +static inline unsigned int wm8940_read_reg_cache(struct snd_soc_codec *codec,
> +						 unsigned int reg)
> +{
> +	u16 *cache = codec->reg_cache;
> +
> +	if (reg > ARRAY_SIZE(wm8940_reg_defaults))
> +		return -1;

Should be >=

> +static inline int wm8940_write_reg_cache(struct snd_soc_codec *codec,
> +					  u16 reg, unsigned int value)
> +{
> +	u16 *cache = codec->reg_cache;
> +
> +	if (reg > ARRAY_SIZE(wm8940_reg_defaults))
> +		return -1;

Should be >=

> +	wm8940_write_reg_cache(codec, reg, value);
> +
> +	return (codec->hw_write(codec->control_data, data, 3) == 3) ? 0 : -EIO;

Don't use the ternery operation here: apart from the legibility issues
if an error code is returned by hw_write() (as opposed to a short value)
you should pass it on.

> +static const struct soc_enum wm8940_enum[] = {
> +	SOC_ENUM_SINGLE(WM8940_COMPANDINGCTL, 1, 4, wm8940_companding),
> +	SOC_ENUM_SINGLE(WM8940_COMPANDINGCTL, 3, 4, wm8940_companding),
> +	SOC_ENUM_SINGLE(WM8940_ALC3, 8, 2, wm8940_alc_mode_text),
> +	SOC_ENUM_SINGLE(WM8940_INPUTCTL, 8, 2, wm8940_mic_bias_levels_text),
> +	SOC_ENUM_SINGLE(WM8940_ADC, 7, 2, wm8940_filter_mode_text),
> +};

Please declare individual variables for these - it saves trying to look
up indexes in the array.  This is done by some older drivers mostly as a
result of conversion from pre-ASoC drivers where the array was useful.

> +static const struct snd_kcontrol_new wm8940_snd_controls[] = {
> +	SOC_SINGLE("Digital Loopback Switch dac to adc", WM8940_COMPANDINGCTL,
> +		   6, 1, 0),

Switch should always be the last component of the name (ALSA userspace
cares, see Documentation/sound/alsa/ControlNames.txt) and DAC and ADC
should be capitalised.  I'd just call it Digital Loopback Switch.

> +       SOC_SINGLE("Companding 8 bit", WM8940_COMPANDINGCTL, 5, 1, 0),

This should be controlled as part of the DAI format control rather than
exposed to the user.

> +	SOC_SINGLE("Digital Loopback Switch adc to dac", WM8940_COMPANDINGCTL,
> +		   0, 1, 0),

This should be called Digital Sidetone Switch and probably ought to be a
DAPM control - there's an ADC to DAC route.

> +	SOC_SINGLE("ALC Enable Switch", WM8940_ALC1, 8, 1, 0),

ALC Switch.

> +	SOC_SINGLE("Capture Boost(+20dB)", WM8940_ADCBOOST, 8, 1, 0),

You could also do this as Capture Boost Volume and provide TLV
information but it's not terribly important either way.

> +	SOC_SINGLE_TLV("Speaker Playback Volume", WM8940_SPKVOL,
> +		       0, 63, 0, wm8940_spk_vol_tlv),
> +	SOC_SINGLE("Speaker Playback Mute", WM8940_SPKVOL,  6, 1, 0),

Speaker Playback Switch; this also means that the sense of the control
needs to be inverted.  Look at the control in alsamixer and you'll see
that it figures out that these both control the same thing and displays
them as a single Speaker Playback control in the UI.

> +	SOC_SINGLE_TLV("Speaker Playback Attenuation", WM8940_SPKVOL,
> +		       8, 1, 1, wm8940_att_tlv),

This should be Speaker Mixer Line Bypass Volume; it only applies to the
bypass path and volume controls always need a Volume at the end of the
name.

> +	SOC_SINGLE("Speaker Playback ZC", WM8940_SPKVOL, 7, 1, 0),

ZC Switch.

> +	SOC_SINGLE("Mono Out Mute", WM8940_MONOMIX, 6, 1, 0),

Mono Out Switch.

> +	SOC_SINGLE_TLV("Mono Out Attenuation", WM8940_MONOMIX,
> +		       7, 1, 1, wm8940_att_tlv),

Again, needs Volume at the end and should be adjusted to match the name
of the mixer control that's generated.

> +	SOC_SINGLE("ZC Timeout Clock Enable Switch", WM8940_ADDCNTRL, 0, 1, 0),

Doesn't need the Enable in there.

> +	SOC_SINGLE("Notch Filter 1 Update Switch", WM8940_NOTCH1, 15, 1, 0),
> +	SOC_SINGLE("Notch Filter 2 Update Switch", WM8940_NOTCH3, 15, 1, 0),
> +	SOC_SINGLE("Notch Filter 3 Update Switch", WM8940_NOTCH5, 15, 1, 0),
> +	SOC_SINGLE("Notch Filter 4 Update Switch", WM8940_NOTCH7, 15, 1, 0),

The notch filter configuration is dependant on the sample rate so the
driver probably ought to be exposing a control based on the cutoff
frequency desired and then configuring the filter appropriately as the
sample rate changes.

I'd remove the notch filter stuff for now if you're not actively using
it.

> +	/* Boost Mixer */
> +	{"Boost Mixer", "Mic PGA Switch", "Mic PGA"},
> +	{"Boost Mixer", "Mic Volume",  "MICP"},
> +	{"Boost Mixer", "Aux Volume", "Aux Input"},
> +
> +	 {"ADC", NULL, "Boost Mixer"},

Something odd with the indentation here?

> +static int wm8940_add_widgets(struct snd_soc_codec *codec)
> +{
> +	snd_soc_dapm_new_controls(codec, wm8940_dapm_widgets,
> +				  ARRAY_SIZE(wm8940_dapm_widgets));
> +	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
> +	snd_soc_dapm_new_widgets(codec);
> +}
> +static int wm8940_add_controls(struct snd_soc_codec *codec)

Blank line between the two functions please.

> +{
> +	int err, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(wm8940_snd_controls); i++) {
> +		err = snd_ctl_add(codec->card,
> +				snd_soc_cnew(&wm8940_snd_controls[i], codec,
> +					NULL));
> +		if (err < 0)
> +			return err;
> +	}

snd_soc_add_controls().

> +static int wm8940_i2s_hw_params(struct snd_pcm_substream *substream,
> +                               struct snd_pcm_hw_params *params,
> +                               struct snd_soc_dai *dai)

...

> +	switch (wm8940->mode) {

> +	switch (wm8940->clk_inversion) {

Just set these in the register when the DAI format is configured - no
need to wait until hw_params().

Also, for the capture stream you should set LOUTR here if there are two
channels being recorded so that the data is output on both channels.

> +static int wm8940_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	u16 mute_reg = wm8940_read_reg_cache(codec, WM8940_DAC) & 0xffbf;
> +
> +	return wm8940_write(codec,
> +			    WM8940_DAC,
> +			    mute ? mute_reg | 0x40 : mute_reg);
> +

I'm really not a fan of the ternary operator :/

> +	if (Ndiv > 12) {
> +		/* FIXME: This will loose accuracy, how to deal? */
> +		printk(KERN_WARNING "Incorrectly handled case\n");

Printing an error is fine; this all comes from the machine driver so
it's not something we expect to ever happen at runtime except in
development.

> +static int wm8940_set_dai_pll(struct snd_soc_dai *codec_dai,
> +		int pll_id, unsigned int freq_in, unsigned int freq_out)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	u16 reg;
> +	if (freq_in == 0 || freq_out == 0) {
> +		/* Clock CODEC directly from MCLK */
> +		reg = wm8940_read_reg_cache(codec, WM8940_CLOCK);
> +		wm8940_write(codec, WM8940_CLOCK, reg & 0x0ff);
> +
> +		/* Turn off PLL */
> +		reg = wm8940_read_reg_cache(codec, WM8940_POWER1);
> +		wm8940_write(codec, WM8940_POWER1, reg & 0x1df);

This will need to be done when reconfiguring the PLL as well so it ought
to be in the main path too.

> +		/* set vmid to 75k and unmute dac */
> +		wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x1);

The comment is out of sync with reality.  Also...

> +	case SND_SOC_BIAS_PREPARE:
> +		/* ensure bufioen and biasen */
> +		pwr_reg |= (1 << 2) | (1 << 3);
> +		/* set vmid to 2.5k for fast start */
> +		wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x3);
> +		break;

This isn't what the low resistance VMID setting is for;

> +struct snd_soc_dai wm8940_dai = {
> +	.name = "WM8940",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 1,
> +		.channels_max = 2, /* lie - pxa-i2s has min of 2*/

What's going on here is that I2S is inhernantly stereo even if only one
of the channels is actually being output - the CODEC is actually taking
a stereo stream, it's just ignoring one of the channels.

> +		.rates = WM8940_RATES,
> +		.formats = WM8940_FORMATS,
> +	},
> +	.capture = {
> +		.stream_name = "Capture",
> +		.channels_min = 1,
> +		.channels_max = 2, /* lie */

See above for setting LOUTR hw_params() - the CODEC is actually able to
output data on both channels.

> +	.ops = {
> +		.hw_params = wm8940_i2s_hw_params,
> +		.set_sysclk = wm8940_set_dai_sysclk,
> +		.digital_mute = wm8940_mute,
> +		.set_fmt = wm8940_set_dai_fmt,
> +		.set_clkdiv = wm8940_set_dai_clkdiv,
> +		.set_pll = wm8940_set_dai_pll,
> +	},

This needs updating for current ASoC - see the topic/asoc branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6

where this has been pulled out into a separate ops structure.

> +};
> +EXPORT_SYMBOL_GPL(wm8940_dai);

You should also set the symmetric_rates flag here since the CODEC has a
single LRCLK and therefore can't run the DAC and ADC at different rates.

> +	/* Enables the level shifters and non-vmid derived bias
> +	 * current generator
> +	 */
> +	ret = wm8940_write(codec, WM8940_POWER1, 0x180);
> +	if (ret < 0)
> +		goto card_err;

set_bias_level() ought to be doing this.

> +static int __init wm8940_modinit(void)
> +{
> +	return snd_soc_register_dai(&wm8940_dai);
> +}
> +module_init(wm8940_modinit);
> +
> +static void __exit wm8940_exit(void)
> +{
> +	snd_soc_unregister_dai(&wm8940_dai);
> +}
> +module_exit(wm8940_exit);

Please take a look at the way in which drivers such as wm8988 and wm8960
register themselves - they have been converted to use the standard
device probing, registering the DAI once the I2C (or SPI) device has
been probed based on normal I2C setup in the arch code.

Broadly speaking you should move everything in the startup path except
the registration of the ALSA controls into the I2C device registration
with the ASoC functions doing the ALSA bits once the rest of the sound
card has registered with it.  You can see some conversions if you look
in git history; cut'n'pasting the probe code for a converted driver will
often get you a long way.
