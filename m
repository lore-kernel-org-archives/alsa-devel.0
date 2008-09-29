From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/5] [RFC] ALSA ASoC driver for TLVaic23b
	audio codec
Date: Mon, 29 Sep 2008 11:56:48 +0100
Message-ID: <20080929105647.GB27647@sirena.org.uk>
References: <dfeb90390809290245v77aea7b8s5a24a7d635a46a6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A532243EC
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 12:56:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <dfeb90390809290245v77aea7b8s5a24a7d635a46a6e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 29, 2008 at 03:15:04PM +0530, Arun KS wrote:
> ASOC Audio driver for TLVaic23b audio codec

This looks good overall, thanks!  There's quite a few comments below but
they're mostly minor things at the coding style issues.

The only issue I've got overall is that the name of the codec seems to
vary through the driver - sometimes it's referred to as the tlv320aic23,
sometimes as aic23 and sometimes as tlvaic23.  It'd be good if the
naming scheme were more consistent.  My inclination would be to go with
tlv320aic23 since it will reduce the risk of collisions and the general
style is to use the full part number (then again, I know the tlv320aic3x
driver didn't do that).

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -55,3 +55,7 @@ config SND_SOC_TWL4030
>  	tristate
>  	depends on SND_SOC && TWL4030_CORE
> 

This patch is against the OMAP tree - please generate all submitted
patches against either the ASoC dev tree or the topic/asoc branch of:

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

Even if other patches in the series depend on the OMAP tree there should
be no reason not to merge an I2C codec driver like this with no external
dependencies immediately.

> +config SND_SOC_TLV320AIC23
> +	tristate
> +	depends on I2C
> +

Please also add this to the SND_SOC_ALL_CODECS Kconfig option.

> +static int aic23_write(struct snd_soc_codec *codec, unsigned int reg,
> +		       unsigned int value)
> +{
> +
> +	u8 data;
> +
> +	/* TLV320AIC23 has 7 bit address and 9 bits of data
> +	 * so we need to switch one data bit into reg and rest
> +	 * of data into val
> +	 */
> +
> +	if ((reg < 0 || reg > 9) && (reg != 15)) {
> +		printk(KERN_WARNING "Invalid register R%d\n", reg);
> +		return -1;
> +	}

It'd be nice if this said which device was being written to - adding in
the driver name to the printk(), for example.  It'd make it easier for
someone seeing the message in their logs to work out where it came from.

> +	data = (reg << 1) | (value >> 8 & 0x01);
> +
> +	aic23_write_reg_cache(codec, reg, value);
> +
> +	if (codec->hw_write(codec->control_data, (u8) data,
> +			    (u8) (value & 0xff)) == 0)
> +		return 0;
> +
> +	printk(KERN_ERR "I2C: cannot write %03x to register R%d\n", value, reg);

Again, saying where the error came from would be nice.

> +       SOC_SINGLE("Mic Mute", ANALOG_AUDIO_CONTROL_ADDR, 1, 0x01, 0),

This should be "Mic Switch" to help UIs display the control correctly.

> +/* aic23 related */
> +static const struct aic23_samplerate_reg_info
> + rate_reg_info[NUMBER_SAMPLE_RATES_SUPPORTED] = {
> +	{4000, 0x06, 1},	/*  4000 */

You could just use [] for the size of the array and let the compiler
figure it out - you actually use ARRAY_SIZE() rather than the #define
for the array size later anyway.

> +static int aic23_set_bias_level(struct snd_soc_codec *codec,
> +				enum snd_soc_bias_level level)
> +{
> +	u16 reg;
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		reg = aic23_read_reg_cache(codec, POWER_DOWN_CONTROL_ADDR);
> +		aic23_write(codec, POWER_DOWN_CONTROL_ADDR,
> +			    reg & (~DEVICE_POWER_OFF));
> +		/* Activate interface */
> +		reg = aic23_read_reg_cache(codec, DIGITAL_INTERFACE_ACT_ADDR);
> +		aic23_write(codec, DIGITAL_INTERFACE_ACT_ADDR, reg | ACT_ON);
> +		break;
> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		reg = aic23_read_reg_cache(codec, POWER_DOWN_CONTROL_ADDR);
> +		aic23_write(codec, POWER_DOWN_CONTROL_ADDR,
> +			    reg | DEVICE_POWER_OFF);
> +		/* Deactivate interface */
> +		reg = aic23_read_reg_cache(codec, DIGITAL_INTERFACE_ACT_ADDR);
> +		aic23_write(codec, DIGITAL_INTERFACE_ACT_ADDR, reg & (~ACT_ON));

Hrm.  This probably deserves a comment about what DEVICE_POWER_OFF does
that the normal DAPM control doesn't.  Given that there are no bypass
paths there should be no risk of interfering with DAPM but it raises a
bit of an eyebrow.

> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +	codec->hw_write = (hw_write_t) i2c_smbus_write_byte_data;
> +	codec->hw_read = NULL;
> +	ret = i2c_add_driver(&aic23b_i2c_driver);
> +	if (ret != 0)
> +		printk(KERN_ERR "can't add i2c driver");
> +#else
> +	/* Add other interfaces here */
> +#endif

If the device doesn't support anything except I2C then please remove all
the conditionals on I2C support from the driver (they don't add
anything).  If the device does support other control methods then please
change this to be something like:

   #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
   ...
   #endif
   /* Add other interfaces here */

That way if someone adds support for the other control interfaces
they'll be encouraged to do it in a way that allows kernels to be built
supporting multiple systems simultaneously.

> +#define AIC23_CACHEREGNUM		16
> +/* Codec TLV320AIC23 */
> +#define LEFT_LINE_VOLUME_ADDR		0x00
> +#define RIGHT_LINE_VOLUME_ADDR		0x01
> +#define LEFT_CHANNEL_VOLUME_ADDR	0x02
> +#define RIGHT_CHANNEL_VOLUME_ADDR	0x03
> +#define ANALOG_AUDIO_CONTROL_ADDR	0x04
> +#define DIGITAL_AUDIO_CONTROL_ADDR	0x05
> +#define POWER_DOWN_CONTROL_ADDR		0x06
> +#define DIGITAL_AUDIO_FORMAT_ADDR	0x07
> +#define SAMPLE_RATE_CONTROL_ADDR	0x08
> +#define DIGITAL_INTERFACE_ACT_ADDR	0x09
> +#define RESET_CONTROL_ADDR		0x0F

These (and most of the rest of the defines in the header) should all be
namespaced - there's a very good chance of them colliding with other
things and this header is going to be included in the machine drivers.

> +/* Define to set the AIC23 as the master w.r.t McBSP */
> +#define AIC23_MASTER

> +#ifndef DEFAULT_BITPERSAMPLE
> +#define DEFAULT_BITPERSAMPLE		16
> +#endif

> +#define DEFAULT_SAMPLE_RATE		44100
> +#define CODEC_CLOCK			12000000
> +#define AUDIO_MCBSP			OMAP_MCBSP1

None of these should be in this driver - they should all be part of the
machine driver.

> +struct aic23_samplerate_reg_info {
> +	u32 sample_rate;
> +	u8 control;		/* SR3, SR2, SR1, SR0 and BOSR */
> +	u8 divider		/* if 0 CLKIN = MCLK, if 1 CLKIN = MCLK/2 */
> +};

This could just be pushed into the driver.
