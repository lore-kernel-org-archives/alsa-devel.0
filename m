From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc,
	codec: Add SGTL5000 codec support to asoc
Date: Wed, 8 Dec 2010 12:11:55 +0000
Message-ID: <20101208121155.GC16418@rakim.wolfsonmicro.main>
References: <1291773989-22747-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 373A4103C22
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 13:11:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291773989-22747-1-git-send-email-zhaoming.zeng@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhaoming.zeng@freescale.com
Cc: s.hauer@pengutronix.de, festevam@gmail.com, alsa-devel@alsa-project.org, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 08, 2010 at 10:06:29AM +0800, zhaoming.zeng@freescale.com wrote:
> From: Zeng Zhaoming <zhaoming.zeng@freescale.com>

Broadly speaking this is OK - there's quite a few comments below but
they're mostly fairly small and local things rather than major
structural issues.  The one thing that needs real work is the power
management which is fairly non standard and seems to follow a mix of
hard coding and DAPM.  A lot of the issues here seem to be due to some
rather nasty hardware issues so there's likely to be limits on how nice
the software can be.

For the subject line, please use a prefix such as "ASoC: " like other
patches do - in general check the changelogs for the area you're
submitting against for things like this.

>  config SND_SOC_WM9090
>  	tristate
> +
> +config SND_SOC_SGTL5000
> +	tristate

Keep both Kconfig and Makefile sorted, and remember to add your CODEC to
SND_SOC_ALL_CODECS.

> +	struct regulator *supplies[SGTL5000_SUPPLY_NUM];
> +	int regulator_volt[SGTL5000_SUPPLY_NUM];
> +	struct regulator *reg_vddio;
> +	struct regulator *reg_vdda;
> +	struct regulator *reg_vddd;
> +	int vddio;		/* voltage of VDDIO (mv) */
> +	int vdda;		/* voltage of vdda (mv) */
> +	int vddd;		/* voltage of vddd (mv), 0 if not connected */

You appear to be keeping two copies of the regulators and their
voltages.  TBH I'm not clear why you're caching the voltages - you may
as well just read them when you need them, you only refer to them at
probe time anyway.

> +static int dac_info_volsw(struct snd_kcontrol *kcontrol,
> +			  struct snd_ctl_elem_info *uinfo)
> +{

I think you're looking for SOC_DOUBLE_R_SX_TLV(), or possibly a variant
of SOC_DOUBLE_S8_TLV()?

> +static const char *mic_gain_text[] = {
> +	"0dB", "20dB", "30dB", "40dB"
> +};
>
> +static const char *adc_m6db_text[] = {
> +	"No Change", "Reduced by 6dB"
> +};

Provide gain information using TLV data.

> +static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
> +	SOC_ENUM("MIC GAIN", mic_gain),

Mic Volume.

> +	SOC_ENUM("Capture Vol Reduction", adc_m6db),

Capture Volume.

> +static int __sgtl5000_digital_mute(struct snd_soc_codec *codec, int mute)
> +{

Using __ like this isn't idomiatic for Linux, and given that...

> +static int sgtl5000_digital_mute(struct snd_soc_dai *codec_dai, int mute)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +
> +	return __sgtl5000_digital_mute(codec, mute);
> +}

...this simply passes through to the above function it'd be better to
just implement directly in here.

> +	/* Clock inversion */
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +	case SND_SOC_DAIFMT_NB_IF:
> +		break;
> +	case SND_SOC_DAIFMT_IB_IF:
> +	case SND_SOC_DAIFMT_IB_NF:
> +		i2sctl |= SGTL5000_I2S_SCLK_INV;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

This looks wrong - you're claiming to support four formats with two
different register settings.  It looks like you can only actually invert
one of the clocks so should remove the options for the other one.

> +static int sgtl5000_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +				   int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (clk_id) {
> +	case SGTL5000_SYSCLK:
> +		sgtl5000->sysclk = freq;
> +		break;
> +	case SGTL5000_LRCLK:
> +		sgtl5000->lrclk = freq;
> +		break;

LRCLK should be configured in hw_params().

> +static int sgtl5000_pcm_prepare(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +	int reg;
> +
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_DIG_POWER);
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		reg |= SGTL5000_I2S_IN_POWERUP;
> +	else
> +		reg |= SGTL5000_I2S_OUT_POWERUP;
> +	snd_soc_write(codec, SGTL5000_CHIP_DIG_POWER, reg);

This looks like you should have AIF widgets in DAPM.

> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> +		reg |= SGTL5000_ADC_POWERUP;
> +		if (sgtl5000->capture_channels == 1)
> +			reg &= ~SGTL5000_ADC_STEREO;
> +		else
> +			reg |= SGTL5000_ADC_STEREO;
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
> +	}

Why is this here - it looks like it should be in hw_params()?

> +	/* The DAI has shared clocks so if we already have a playback or
> +	 * capture going then constrain this substream to match it.
> +	 */
> +	if (sgtl5000->master_substream) {

Just set symmetric_rates in your DAI (in fact you're doing this) and
delete all this code (and associated variables and code elsewhere).  The
core will manage the symmetry constraints for you.

> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		ana_pwr = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> +		ana_pwr &= ~(SGTL5000_ADC_POWERUP | SGTL5000_ADC_STEREO);
> +		snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
> +	}

The ADC power at least looks like it should be handled by DAPM.

> +static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
> +				  struct snd_pcm_hw_params *params,
> +				  struct snd_soc_dai *dai)
> +{

> +	switch (sgtl5000->lrclk) {
> +	case 8000:
> +	case 16000:
> +		sys_fs = 32000;
> +		break;
> +	case 11025:
> +	case 22050:
> +		sys_fs = 44100;
> +		break;
> +	default:
> +		sys_fs = sgtl5000->lrclk;
> +		break;

A comment explaining what's going on here would be helpful - it
looks like the device is running internally at 32kHz or higher and
downsampling somehow to present lower output frequencies?

> +	default:
> +		dev_err(codec->dev, "sample rate %d not supported\n", sgtl5000->lrclk);
> +		return -EFAULT;

-EPARM or something.  -EFAULT means a memory access error.

> +	/* SGTL5000 rev1 has a IC bug to prevent switching to MCLK from PLL. */
> +	if (!sgtl5000->master) {

I'd expect to see this code returning an error if something triggers a
switch from MCLK to PLL when it's not supported.

> +		sys_fs = sgtl5000->lrclk;
> +		clk_ctl = SGTL5000_RATE_MODE_DIV_1 << SGTL5000_RATE_MODE_SHIFT;
> +		if (sys_fs * 256 == sgtl5000->sysclk)
> +			clk_ctl |= SGTL5000_MCLK_FREQ_256FS << \
> +				SGTL5000_MCLK_FREQ_SHIFT;

No need for \ outside of macros. 

> +	if ((clk_ctl & SGTL5000_MCLK_FREQ_MASK) == SGTL5000_MCLK_FREQ_PLL) {
> +		snd_soc_write(codec, SGTL5000_CHIP_PLL_CTRL, pll_ctl);
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_CLK_TOP_CTRL);
> +		if (div2)
> +			reg |= SGTL5000_INPUT_FREQ_DIV2;
> +		else
> +			reg &= ~SGTL5000_INPUT_FREQ_DIV2;
> +		snd_soc_write(codec, SGTL5000_CHIP_CLK_TOP_CTRL, reg);

snd_soc_update_bits().

> +static void sgtl5000_mic_bias(struct snd_soc_codec *codec, int enable)
> +{
> +	int reg, bias_r = 0;
> +	if (enable)
> +		bias_r = SGTL5000_BIAS_R_4k << SGTL5000_BIAS_R_SHIFT;
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_MIC_CTRL);
> +	if ((reg & SGTL5000_BIAS_R_MASK) != bias_r) {
> +		reg &= ~SGTL5000_BIAS_R_MASK;
> +		reg |= bias_r;
> +		snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, reg);
> +	}

This looks a lot like snd_soc_update_bits(), and it looks a lot like the
mic bias should be a DAPM widget since...

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		sgtl5000_mic_bias(codec, 1);
> +
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
> +				SGTL5000_BIAS_R_MASK, SGTL5000_BIAS_R_MASK);

...as things stand the mic bias is being powered up even for playback.

> +	case SND_SOC_BIAS_PREPARE:	/* partial On */
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
> +				SGTL5000_BIAS_R_MASK, 0);
> +
> +		/* must power up hp/line out before vag & dac to
> +		   avoid pops. */
> +		reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);

Oh dear, that sounds very buggy.  I'd suggest using events on DAPM nodes
for this stuff (perhaps just a big "output" widget) - it's more
idiomatic if nothing else.

> +	case SND_SOC_BIAS_STANDBY:
> +		/* soc calls digital_mute to unmute before record but doesn't
> +		   call digital_mute to mute after record. */
> +		__sgtl5000_digital_mute(codec, 1);

Hrm?  The mute control is for the DAC and has nothing to do with
recording.  What's the actual issue here - if there is an issue here it
should be fixed in the framework rather than bodged in an individual
driver.

> +		/* save ANA POWER register value for resume */
> +		cache[SGTL5000_CHIP_ANA_POWER >> 1] = ana_pwr;

Why would you do this on _BIAS_OFF?  This isn't a suspend/resume thing,
when the power is brought back up from _OFF the framework will make a
new decision about what to power up.

> +#define SGTL5000_RATES (SNDRV_PCM_RATE_8000 |\
> +		      SNDRV_PCM_RATE_11025 |\
> +		      SNDRV_PCM_RATE_16000 |\
> +		      SNDRV_PCM_RATE_22050 |\
> +		      SNDRV_PCM_RATE_32000 |\
> +		      SNDRV_PCM_RATE_44100 |\
> +		      SNDRV_PCM_RATE_48000 |\
> +		      SNDRV_PCM_RATE_96000)

SNDRV_PCM_RATE_8000_96000.

> +static int sgtl5000_volatile_register(unsigned int reg)
> +{
> +	if (reg == SGTL5000_CHIP_ID ||
> +	    reg == SGTL5000_CHIP_ADCDAC_CTRL ||
> +	    reg == SGTL5000_CHIP_ANA_STATUS)
> +		return 1;
> +	return 0;

Use a switch statement for legibility.

> +	/* Bring the codec back up to standby first to minimise pop/clicks */
> +	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	if (codec->suspend_bias_level == SND_SOC_BIAS_ON)
> +		sgtl5000_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
> +	sgtl5000_set_bias_level(codec, codec->suspend_bias_level);

The CODEC will never be in any state above STANDBY at suspend.

> +static int sgtl5000_remove(struct snd_soc_codec *codec)
> +{
> +	if (codec->control_data)
> +		sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);

You're guranteed to have control data.

> +	for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
> +		struct regulator *reg;
> +		reg = regulator_get(&client->dev, supply_names[i]);
> +		if (IS_ERR(reg))
> +			continue;
> +
> +		sgtl5000->regulator_volt[i] = regulator_get_voltage(reg) / 1000;
> +		regulator_enable(reg);
> +
> +		sgtl5000->supplies[i] = reg;
> +	}

> +	sgtl5000->regulator_volt[VDDA] = 3300;
> +	sgtl5000->regulator_volt[VDDIO] = 3300;

You're not actually doing anything to make that be the case...  You
should either set the voltage here, check the voltage and error out if
it's wrong or just ignore the voltages and assume the hardware is
correct.

> +	msleep(1);

This delay looks like it's in the wrong place?

> +	for (i=0; i < SGTL5000_SUPPLY_NUM; i++) {
> +		if( !sgtl5000->supplies[i] )
> +			continue;

Run your patch through checkpatch - the space placement here isn't the
usual kernel style.

> +static const struct i2c_device_id sgtl5000_id[] = {
> +	{"sgtl5000-i2c", 0},

No -i2c - the bus type is already encoded in the bus type.

> +static struct i2c_driver sgtl5000_i2c_driver = {
> +	.driver = {
> +		   .name = "sgtl5000-i2c",

Likewise.
