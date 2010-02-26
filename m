From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for Cirrus Logic CS42L52
	Lowpower	Stereo Codec
Date: Fri, 26 Feb 2010 00:53:49 +0000
Message-ID: <20100226005349.GA3800@opensource.wolfsonmicro.com>
References: <1267142855-12854-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 840C81039EF
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 01:53:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267142855-12854-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, heelrod@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 25, 2010 at 06:07:35PM -0600, Brian wrote:

This is a quick first pass review only.  It'd be best if you could
include a Signed-off-by line in submissions so that they can be merged
if they're OK, even if you expect problems you may be surprised!

Overall this looks fairly good - there's a lot of comments below but the
vast majority of them are stylistic issues or needing to update to
current APIs rather than major structural problems with the code.  The
main thing I don't really follow is the register access code, there's
quite a bit of stuff going on in there.

> + * published by the Free Software Foundation.
> + * Revision history
> + * Nov 2007  Initial version.
> + * Oct 2008  Updated to 2.6.26
> + * Feb 2010  Updated to latest asoc git tree

Please remove the changelog, once things are merged git takes care of
that.

> + */
> +#define DEBUG

Not by default in mainline :)

> +#ifdef DEBUG
> +#define SOCDBG(fmt, arg...)	printk(KERN_ERR "%s: %s() " fmt, SOC_CS42L52_NAME, __FUNCTION__, ##arg)
> +#else
> +#define SOCDBG(fmt, arg...)
> +#endif
> +#define SOCINF(fmt, args...)	printk(KERN_INFO "%s: " fmt, SOC_CS42L52_NAME,  ##args)
> +#define SOCERR(fmt, args...)	printk(KERN_ERR "%s: " fmt, SOC_CS42L52_NAME,  ##args)

Please convert the driver to use the standard dev_ and pr_ macros for
this (where possible the dev_ ones are better).

> +static int soc_cs42l52_set_bias_level(struct snd_soc_codec *codec,
> +				enum snd_soc_bias_level level);
> +static int soc_cs42l52_pcm_hw_params(struct snd_pcm_substream *substream,
> +                        	struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai);
> +static int soc_cs42l52_set_sysclk(struct snd_soc_dai *codec_dai,
> +                        int clk_id, u_int freq, int dir);
> +static int soc_cs42l52_digital_mute(struct snd_soc_dai *dai, int mute);
> +static int soc_cs42l52_set_fmt(struct snd_soc_dai *codec_dai,
> +                        u_int fmt);
> +
> +static unsigned int soc_cs42l52_read(struct snd_soc_codec *codec,
> +		                u_int reg);

Please use 'unsigned int' rather than 'u_int' for consistency with the
rest of ASoC.  It's a bit surprising that you need the forward
declarations at all but they do no harm.

> +/**
> + * snd_soc_get_volsw - single mixer get callback
> + * @kcontrol: mixer control
> + * @uinfo: control element information
> + *
> + * Callback to get the value of a single mixer control.
> + *
> + * Returns 0 for success.
> + */
> +int snd_soc_cs42l5x_get_volsw(struct snd_kcontrol *kcontrol,
> +    struct snd_ctl_elem_value *ucontrol)
> +{
> +    struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +    int reg = kcontrol->private_value & 0xff;

The indentation looks wrong - should be tabs for indenting the code
blocks.  scripts/checkpatch.pl is a pretty good check for this sort of
stuff, I'll not mention other issues.

> +    int shift = (kcontrol->private_value >> 8) & 0x0f;
> +    int rshift = (kcontrol->private_value >> 12) & 0x0f;
> +    int max = (kcontrol->private_value >> 16) & 0xff;
> +    int mask = (1 << fls(max)) - 1;
> +    int min = (kcontrol->private_value >> 24) & 0xff;
> +
> +    ucontrol->value.integer.value[0] =
> +	((snd_soc_read(codec, reg) >> shift) - min) & mask;
> +    if (shift != rshift)
> +	ucontrol->value.integer.value[1] =
> +	    ((snd_soc_read(codec, reg) >> rshift) - min) & mask;

This and most of the other custom control stuff looks an awful lot like
it should be done by adding a SND_SOC_DOUBLE_SIGNED() or something along
the lines of the existing _S8() but I didn't read entirely closely.  I
was speaking to someone on IRC only the other day who needed some of
those types for a different device.

These should also be updated to use struct soc_mixer_control for the
private value rather than shifting everything into the private value, it
allows wider ranges and is less error prone.

> +static const u8 soc_cs42l52_reg_default[] = {
> +	0x00, 0xE0, 0x01, 0x07, 0x05, /*4*/
> +	0xa0, 0x00, 0x00, 0x81, /*8*/

Very nitpicky but you're using a mix of upper and lower case for the
letters in the hex digits.

> +static inline int soc_cs42l52_read_reg_cache(struct snd_soc_codec *codec,
> +		u_int reg)
> +{
> +	u8 *cache = codec->reg_cache;
> +
> +	return reg > SOC_CS42L52_REG_NUM ? -EINVAL : cache[reg];
> +}

You should be able to replace all your register I/O code with use of
soc-cache.c with 8 bit data, 8 bit register.  Except...

> +	if(info->flags & SOC_CS42L52_ALL_IN_ONE)
> +	{
> +		for(i = 0; i < codec->num_dai; i++)
> +		{
> +			if(info->machine_handler) 
> +				info->machine_handler(i);

...I'm not sure what's going on here but it could really use an
explanation?  I'm not sure what ALL_IN_ONE is supposed to do, or what
the machine_handler() function is for.

> +		if(info->flags & SOC_CS42L52_CHIP_SWICTH)
> +		{
> +			num = info->flags & SOC_CS42L52_CHIP_MASK;
> +			if(info->machine_handler)
> +                                info->machine_handler(num);
> +		}

This too.  There's a lot of unusual code using this machine handler
function.  I suspect this can all use ASoC standard stuff.

> +static inline int soc_cs42l52_get_revison(struct snd_soc_codec *codec)
> +{
> +	u8 data;
> +        u8 addr;
> +	int num, ret = 0;

> +	struct soc_codec_cs42l52 *info = (struct soc_codec_cs42l52*)codec->private_data;

No need to cast away from void (quite a few examples of this in the
code).

> +	return ret < 0 ? ret : data;

I'm not a big fan of the ternery operator...

> +static unsigned int soc_cs42l52_read(struct snd_soc_codec *codec,
> +		u_int reg)
> +{
> +	u8 data;
> +	u8 addr;
> +        int i, ret = 0;
> +        struct soc_codec_cs42l52 *info = (struct soc_codec_cs42l52*)codec->private_data;
> +#ifndef CONFIG_CS42L52_DEBUG
> +	if(reg == CODEC_CS42L52_SPK_STATUS)
> +	{
> +#endif

This really shouldn't be ifdefed.  If you need to handle registers that
report status from the device with the soc-cache stuff use the
volatile_register() callback in the CODEC, any registers that need a
CODEC read will call through to the hardware rather than using the
cache.

> +static const char *cs42l52_adc_mux[] = {"AIN1", "AIN2", "AIN3", "AIN4", "PGA"};
> +static const char *cs42l52_mic_mux[] = {"MIC1", "MIC2"};
> +static const char *cs42l52_stereo_mux[] = {"Mono", "Stereo"};
> +static const char *cs42l52_off[] = {"On", "Off"};
> +static const char *cs42l52_hpmux[] = {"Off", "On"};
> +
> +static const struct soc_enum soc_cs42l52_enum[] = {
> +SOC_ENUM_DOUBLE(CODEC_CS42L52_ANALOG_HPF_CTL, 4, 6, 2, cs42l52_hpf_freeze), /*0*/
> +SOC_ENUM_SINGLE(CODEC_CS42L52_ADC_HPF_FREQ, 0, 4, cs42l52_hpf_corner_freq),

Don't use an array of enums, define individual variables for them.  Some
drivers use the arrays for historical reasons - they're quite painful to
work with if you ever want to change anything in the middle and we've
found a few off by one errors in the referencing into the arrays before
:/.

> +static const struct snd_kcontrol_new soc_cs42l52_controls[] = {
> +
> +SOC_ENUM("Mic VA Capture Switch", soc_cs42l52_enum[18]), /*0*/

enums shouldn't be called Switch - Switch has a specific meaning to ALSA
(see Documentation/sound/alsa/ControlNames.txt, there's quite a few
other controls could do with having the components of the name reordered
and various other things following that).  Normally just omit the ' Switch'
from the name.

> +SOC_DOUBLE("Analog SR Capture Switch", CODEC_CS42L52_ANALOG_HPF_CTL, 1, 3, 1, 1),
> +SOC_DOUBLE("Analog ZC Capture Switch", CODEC_CS42L52_ANALOG_HPF_CTL, 0, 2, 1, 1),

This'd normally be 'Capture ZC Switch' if it's for zero cross.

> +SOC_ENUM("HPF corner freq Capture Switch", soc_cs42l52_enum[1]), /*5*/
> +
> +SOC_SINGLE("Ganged Ctl Capture Switch", CODEC_CS42L52_ADC_MISC_CTL, 7, 1, 1), /* should be enabled init */

What does the comment mean here?

> +SOC_SINGLE("HP Analog Gain Playback Volume", CODEC_CS42L52_PB_CTL1, 5, 7, 0),

Just "Headphone Volume"?

> +SOC_SINGLE("Playback B=A Volume Playback Switch", CODEC_CS42L52_PB_CTL1, 4, 1, 0), /*10*/ /*should be enabled init*/ 

If this is the mute for the headphone volume it should have the same
name but with Switch instead of Volume so applications like alsamixer
can display the two together.

> +static int soc_cs42l52_add_controls(struct snd_soc_codec *codec)
> +{
> +	int i,ret = 0;
> +
> +	for(i = 0; i < ARRAY_SIZE(soc_cs42l52_controls); i++)
> +	{
> +		ret = snd_ctl_add(codec->card,
> +			snd_soc_cnew(&soc_cs42l52_controls[i], codec, NULL));
> +		if(ret < 0)
> +		{
> +			SOCDBG("add cs42l52 controls failed\n");
> +			break;

Replace this with snd_soc_add_controls().

> +	/* Sum switches */
> +	SND_SOC_DAPM_PGA("AIN1A Switch", CODEC_CS42L52_ADC_PGA_A, 0, 0, NULL, 0),

Without having checked the datasheet I *suspect* most of these switches
should be modelled as inputs to a mixer (possibly one with no power
control of its own)?  The "Switch" in the name certainly looks very out
of place in the name of a DAPM control.

> +	/* Output path */
> +	SND_SOC_DAPM_MUX("Passthrough Left Playback Switch", SND_SOC_NOPM, 0, 0, &cs42l52_hpa_mux),

Normally "Bypass" instead of "Passthrough".

> +	/* Mic Bias */
> +        {"Mic Bias Capture Switch", "On", "PGA MICA"},
> +        {"Mic Bias Capture Switch", "On", "PGA MICB"},
> +	{"Mic-Bias", NULL, "Mic Bias Capture Switch"},
> +	{"Mic-Bias", NULL, "Mic Bias Capture Switch"},
> +        {"ADC Mux Left Capture Switch",  "PGA", "Mic-Bias"},
> +        {"ADC Mux Right Capture Switch", "PGA", "Mic-Bias"},
> +        {"Passthrough Left Playback Switch",  "On", "Mic-Bias"},
> +        {"Passthrough Right Playback Switch", "On", "Mic-Bias"},

This looks odd - normally the microphone bias would be connected to the
microphone input externally and would not be hooked up as an input
wihtin the CODEC?

> +	/* terminator */
> +        {NULL, NULL, NULL},

Not needed any more (I'm vaugely surprised this doesn't generate an
error).

> +#define SOC_CS42L52_RATES ( SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 | \
> +                            SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
> +                            SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
> +                            SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | \
> +                            SNDRV_PCM_RATE_96000 ) /*refer to cs42l52 datasheet page35*/

This is equivalent to SNDRV_PCM_RATE_8000_96000

> +/* #define CONFIG_MANUAL_CLK */

This might use some comments (or should possibly be deleted)?

> +	soc_cs42l52_set_bias_level(soc_codec, SND_SOC_BIAS_OFF);
> +	soc_codec->bias_level = SND_SOC_BIAS_STANDBY;
> +	schedule_delayed_work(&soc_codec->delayed_work, msecs_to_jiffies(1000));
> +	soc_cs42l52_required_setup(soc_codec);

A comment about what the delayed work is up to wouldn't hurt?

> +		/*set hp default volume*/
> +		soc_cs42l52_write(soc_codec, CODEC_CS42L52_HPA_VOL, DEFAULT_HP_VOL);
> +		soc_cs42l52_write(soc_codec, CODEC_CS42L52_HPB_VOL, DEFAULT_HP_VOL);

For pretty much all the configuration you're doing here just let
userspace set things up, there's no telling what's an appropriate
setting on any given system and presumably the chip designers made a
reasonable effort to ensure that the default state of the chip is at
least not harmful.

> +#ifdef CONFIG_MANUAL_CLK
> +		soc_cs42l52_write(soc_codec, CODEC_CS42L52_CLK_CTL, 
> +				(soc_cs42l52_read(soc_codec, CODEC_CS42L52_CLK_CTL) 
> +				 & ~CLK_CTL_AUTODECT_ENABLE));

Pass this configuration in as platform data, this will allow multiple
boards to build from the same kernel.

> +	ret = snd_soc_init_card(soc_dev);
> +	if(ret)
> +	{
> +		SOCERR("add snd card failed\n");
> +		goto card_err;
> +	}

Please develop against

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

(or whatever the latest kernel version branch is at any given time.)

You should also be calling snd_soc_register_codec() and
snd_soc_register_dai() from this function.

> +#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)

No need for the ifdefs if you only support I2C, the ifdefs are used by
drivers that have multiple control interfaces (typically I2C plus SPI).

> +	}
> +
> +
> +	return ret;
> +}
> +
> +static int cs42l52_i2c_remove(struct i2c_client *client)
> +{
> +	struct snd_soc_codec *soc_codec;
> + 	if(client)
> +	{
> +		soc_codec = i2c_get_clientdata(client);
> +		if(soc_codec)
> + 	        	kfree(soc_codec->reg_cache);
> +	}
> +        return 0;
> +}

This should be unregistering from ASoC as well, or refusing to remove if
not implemented.

> +	case SND_SOC_DAIFMT_DSP_B:
> +		SOCINF("unsupported format\n");
> +		ret = -EINVAL;
> +		goto done;
> +	default:
> +		SOCINF("invaild format\n");
> +		ret = -EINVAL;
> +		goto done;

Could just squash these together.

> +	case SND_SOC_DAIFMT_IB_IF:
> +		SOCDBG("codec dai fmt inversed sclk\n");
> +		iface |= IFACE_CTL1_INV_SCLK;
> +		break;
> +	case SND_SOC_DAIFMT_IB_NF:
> +		iface |= IFACE_CTL1_INV_SCLK;
> +		break;

It looks like the hardware only supports the inversion of one of the
clocks so only two of the clock polarity combinations should be
supported?

> +	info->format = iface;

I'd really expect to see interaction with the hardware here?

> +	/* 96k */
> +	{12288000, 96000, CLK_CTL_S_DS_MODE, CLK_CTL_NOT_32K, CLK_CTL_NOT_27M, CLK_CTL_RATIO_128, 0},
> +	{18432000, 96000, CLK_CTL_S_DS_MODE, CLK_CTL_NOT_32K, CLK_CTL_NOT_27M, CLK_CTL_RATIO_128, 0},/*29*/
> +	{12000000, 96000, CLK_CTL_S_DS_MODE, CLK_CTL_NOT_32K, CLK_CTL_NOT_27M, CLK_CTL_RATIO_125, 0},
> +	{24000000, 96000, CLK_CTL_S_DS_MODE, CLK_CTL_NOT_32K, CLK_CTL_NOT_27M, CLK_CTL_RATIO_125, 1},

If you're feeling adventurous you should be able to use this data to set
up constraints for the DAI in the startup() callback so only sample
rates supported from the system clock can be used by userspace.

> +static int soc_cs42l52_pcm_hw_params(struct snd_pcm_substream *substream,
> +				     struct snd_pcm_hw_params *params,
> +				     struct snd_soc_dai *dai)
> +{
> +	int ret = 0;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_device *soc_dev = rtd->socdev;
> +	struct snd_soc_codec *soc_codec = soc_dev->card->codec;
> +	struct soc_codec_cs42l52 *info = (struct soc_codec_cs42l52*)soc_codec->private_data;
> +
> +	u32 clk = 0;
> +	int index = soc_cs42l52_get_clk(info->sysclk, params_rate(params));

> +static int soc_cs42l52_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct snd_soc_device *soc_dev = (struct snd_soc_device*)platform_get_drvdata(pdev);
> +	struct snd_soc_codec *soc_codec = soc_dev->card->codec;
> +	
> +	soc_cs42l52_write(soc_codec, CODEC_CS42L52_PWCTL1, PWCTL1_PDN_CODEC);
> +	soc_cs42l52_set_bias_level(soc_codec, SND_SOC_BIAS_OFF);

I'd expect that set_bias_level() would do what the explict write does?

> +#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
> +	if(soc_codec_data->i2c_addr)
> +	{
> +		ret = i2c_add_driver(&cs42l52_i2c_drv);
> +		
> +		if(ret)
> +		{
> +			SOCERR("register i2c driver failed\n");
> +			goto out;
> +			
> +		}
> +		SOCINF("Cirrus Logic ALSA SoC codec cs42l52 driver verison 1.2 2/2010\n");
> +		return ret;	
> +	}

This should be changed to use standard device model registration - see

   http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=5998102b9095fdb7c67755812038612afea315c5

for an example of doing the conversion.

> +struct soc_codec_cs42l52_data{
> +	u_short i2c_addr;
> +};

With the device model stuff this won't be needed any more.

> +/*
> + *CS42L52 internal registers
> + */
> +#define CODEC_CS42L52_CHIP	0x01
> +#define CHIP_ID   		0xE0
> +#define CHIP_ID_MASK		0xF8

Many of the register names and other definitions for register fields and
values need to be namespace to avoid collisions.
