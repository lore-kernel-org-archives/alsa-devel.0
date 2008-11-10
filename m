From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Mon, 10 Nov 2008 13:34:52 +0000
Message-ID: <20081110133451.GD12804@sirena.org.uk>
References: <12261302352402-git-send-email-chripell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 74C7424151
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 14:34:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <12261302352402-git-send-email-chripell@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Pellegrin <chripell@gmail.com>
Cc: zdevai@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, Christian Pellegrin <chripell@fsfe.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 08, 2008 at 08:43:55AM +0100, Christian Pellegrin wrote:

> This patch adds support for the UDA1341 codec and a sound card
> definition for one of these UDAs connected to the s3c24xx. It is

First up, thanks for doing this work - it'd be good to see this merged
into ASoC.

> *heavily* based on the one made by Zoltan Devai but:

Ideally this should be submitted as multiple patches - at least one for
the codec and one for the board, probably also one for the l3 interface.

> Generated on  20081108  against v2.6.27

Please generate patches against current git - the topic/asoc branch of:

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

In general, once the merge window is past it's best to submit patches
against at least -rc1, submitting against the previous release makes it
much more likely that your patch will be out of date as has happened
here.

> +++ b/sound/soc/codecs/Kconfig
> @@ -50,3 +50,6 @@ config SND_SOC_CS4270_VD33_ERRATA
>  config SND_SOC_TLV320AIC3X
>  	tristate
>  	depends on I2C
> +
> +config SND_SOC_UDA1341
> +	tristate

You should also add this to SND_SOC_ALL_CODECS.  There's a bunch of
other things like this that have changed between 2.6.27 and the current
code - for example, the bias level configuration.

> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index d7b97ab..cbace60 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
>  obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
>  obj-$(CONFIG_SND_SOC_CS4270)	+= snd-soc-cs4270.o
>  obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
> +obj-$(CONFIG_SND_SOC_UDA1341)	+= uda1341/

There doesn't seem to be much benefit to adding a subdirectory for two
source files here.

> --- /dev/null
> +++ b/sound/soc/codecs/uda1341/l3.c

> +/*#define L3_DEBUG 1*/
> +#ifdef L3_DEBUG
> +#define DBG(format, arg...) \
> +	printk(KERN_DEBUG "L3: %s:" format "\n" , __func__, ## arg)
> +#else
> +#define DBG(format, arg...) do {} while (0)
> +#endif

Please use the standard pr_debug() macro rather than defining custom
ones.

> +#define setdat(adap, val)	(adap->setdat(adap, val))
> +#define setclk(adap, val)	(adap->setclk(adap, val))
> +#define setmode(adap, val)	(adap->setmode(adap, val))

These should be inline functions for type safety.

> +/*#define UDA1341_DEBUG 1*/
> +#ifdef UDA1341_DEBUG
> +#define DBG(format, arg...) \
> +	printk(KERN_DEBUG "UDA1341: %s:" format "\n" , __func__, ## arg)
> +#else
> +#define DBG(format, arg...) do {} while (0)
> +#endif

Please use the standard pr_debug() macro.

> +static int uda1341_write(struct snd_soc_codec *codec, unsigned int reg,
> +	unsigned int value)
> +{
> +	int ret;
> +	u8 addr;
> +	u8 data = value;
> +
> +	DBG("reg: %02X, value:%02X", reg, value);
> +
> +	if (reg >= UDA1341_REGS_NUM) {
> +		DBG("Unkown register: reg: %d", reg);
> +		return -EINVAL;
> +	}

That should probably print the error unconditionally.

> +static int uda1341_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{

> +	/* set SYSCLK / fs ratio */
> +	switch (uda1341->sysclk / params_rate(params)) {

> +	default:
> +		return -EINVAL;
> +		break;
> +	}

No need for the break here.  It's probably best to log an explicit error
saying why the failure occurred - otherwise it'll be a bit obscure to
users what's going on.  A similar comment applies to the other error
cases.

> +static int uda1341_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +				  int clk_id, unsigned int freq, int dir)
> +{

> +	/* Anything between 256fs*8Khz and 512fs*48Khz should be acceptable
> +	we'll error out on set_hw_params if it's not OK */

This implies rather more flexibility than actually exists - hw_params()
requires an exact multiplier here.  You should probably add a note
explaining that it's up to the machine driver to make sure that the rate
is OK.

> +SOC_SINGLE("Channel 1 mixer gain", UDA1341_EA000, 0, 0x1F, 1),
> +SOC_SINGLE("Channgel 2 mixer gain", UDA1341_EA001, 0, 0x1F, 1),

There's a typo here.  Also, this and many of the other control names
don't fit in with the ALSA control name spec so won't be displayed
correctly by applications.  For example, these should be "Volume" rather
than "gain", and "switch" should be "Switch".  There's documentation of
the standard
names in:

	Documentation/sound/alsa/ControlNames.txt

> +SOC_SINGLE("DAC Gain switch", UDA1341_STATUS1, 6, 1, 0),
> +SOC_SINGLE("ADC Gain switch", UDA1341_STATUS1, 5, 1, 0),

What exactly do these controls do?  "Gain switch" sounds wrong - I'd not
expect the gain to be a boolean.

> +static int uda1341_soc_suspend(struct platform_device *pdev,
> +						pm_message_t state)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct snd_soc_codec *codec = socdev->codec;
> +	struct uda1341_platform_data *pd;
> +
> +	uda1341_dapm_event(codec, SNDRV_CTL_POWER_D3cold);
> +
> +	pd = (struct uda1341_platform_data *) codec->control_data;
> +	if (pd->power)
> +		pd->power(0);

I'd expect that dapm_event() (which is now called set_bias_level())
would be handling the power callback too.

> +struct snd_soc_codec_device soc_codec_dev_uda1341 = {
> +	.probe =        uda1341_soc_probe,
> +	.remove =       uda1341_soc_remove,
> +#if defined(CONFIG_PM)
> +	.suspend =      uda1341_soc_suspend,
> +	.resume =       uda1341_soc_resume,
> +#endif /* CONFIG_PM */

The standard idiom for this is to have an else defining the functions to
NULL pointers above and then no ifdef here.

> +	void (*power) (int);

I'd really expect to see this being passed an argument specifying what
it's interacting with.

> @@ -16,7 +16,7 @@ config SND_S3C2443_SOC_AC97
>  	tristate
>  	select AC97_BUS
>  	select SND_SOC_AC97_BUS
> -	
> +
>  config SND_S3C24XX_SOC_NEO1973_WM8753
>  	tristate "SoC I2S Audio support for NEO1973 - WM8753"
>  	depends on SND_S3C24XX_SOC && MACH_NEO1973_GTA01

Random whitespace change here...

> --- /dev/null
> +++ b/sound/soc/s3c24xx/s3c24xx_uda1341.c

> +/*#define S3C24XX_UDA1341_DEBUG 1*/
> +#ifdef S3C24XX_UDA1341_DEBUG
> +#define DBG(x...) printk(KERN_DEBUG "s3c24xx-i2s: " x)
> +#else
> +#define DBG(x...)
> +#endif

pr_debug().

> +static int s3c24xx_uda1341_hw_params(struct snd_pcm_substream *substream,
> +                                       struct snd_pcm_hw_params *params)
> +{

I can follow this function but it'd be nice to see more comments in
here.  It looks like you could clarify it by iterating over a table of
possible clock sources rather than writing each out in code.

It also looks like this should be imposing constraints which prevent the
configuration of different rates for the DAC and ADC - several existing
codec drivers like the wm8903 provide examples of doing this.

> +	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, clk_source , clk,
> +						SND_SOC_CLOCK_IN);
> +	if (ret < 0)
> +		return ret;

You want to run this through scripts/checkpatch.pl.

> +static void setdat(struct uda1341_platform_data *p, int v)
> +{
> +	s3c2410_gpio_setpin(s3c24xx_uda1341_l3_pins->l3_data, v > 0);
> +	s3c2410_gpio_cfgpin(s3c24xx_uda1341_l3_pins->l3_data,
> +			    S3C2410_GPIO_OUTPUT);
> +}

Is there any reason for setting the pins to output mode each time?  It
looks like you could just configure the mode once at startup and then
only set the pin status here.

> +static void s3c24xx_uda1341_power(int en)
> +{
> +	if (s3c24xx_uda1341_l3_pins->power)
> +		s3c24xx_uda1341_l3_pins->power(en);
> +}

This feels like it ought to be initialised conditionally rather than
having the check for the pin it.

> +	ret = platform_device_add(s3c24xx_uda1341_snd_device);

> +	xtal = clk_get(NULL, "xtal");
> +	pclk = clk_get(NULL, "pclk");

This should be done in the init function for the device and should
really check the return value in case it can't get the clock for some
reason.  Ideally there'd be a dev there, but I'd need to check if the
s3c24xx stuff does that.
