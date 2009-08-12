From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] new ad1836 codec driver based on asoc
Date: Wed, 12 Aug 2009 14:46:45 +0100
Message-ID: <20090812134645.GC11898@rakim.wolfsonmicro.main>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 571452446C
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 15:46:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250051574-25119-2-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 12, 2009 at 12:32:52PM +0800, Barry Song wrote:
> There has been  an ad1836 driver in sound/blackfin based on traditional alsa.
> The new driver is based on asoc. The architecture of ad1836 codec driver
> is very much like ad1938.

This is mostly good, a few relatively minor issues though.

> +	SOC_DOUBLE_R("DAC3  Volume", AD1836_DAC_L3_VOL,
> +			AD1836_DAC_R3_VOL, 0, 0x3FF, 0),

You've got an extra space in the volume control names which I'd expect
to confuse user space.

> +       { "DAC1OUT", "DAC1 Switch", "DAC" },
> +       { "DAC2OUT", "DAC2 Switch", "DAC" },

I'm surprised this works since the switches weren't declared as DAPM
controls but if the core supports it that's OK.

> +static int ad1836_set_tdm_slot(struct snd_soc_dai *dai,
> +		unsigned int mask, int slots)
> +{

This needs updating for the new set_tdm_slot() API but given that
there's only one possible configuration I'd suggest just removing it -
the function does nothing other than check its arguments.

> +	reg = codec->read(codec, AD1836_DAC_CTRL1);
> +	reg = (reg & (~AD1836_DAC_WORD_LEN_MASK)) | word_len;
> +	codec->write(codec, AD1836_DAC_CTRL1, reg);

Not essential but snd_soc_update_bits() does the read/modify/write cycle
for you.

> +static struct spi_driver ad1836_spi_driver = {
> +	.driver = {
> +		.name	= "ad1836-spi",

Just "ad1836" - the fact that it's controlled via SPI is clear from the
fact that this is a struct spi_driver.

> +	ret = snd_soc_register_codec(codec);
> +	if (ret != 0) {
> +		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_register_dai(&ad1836_dai);
> +	if (ret != 0) {
> +		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
> +		snd_soc_unregister_codec(codec);
> +		return ret;
> +	}

Should also be freeing the private data structure on error.

> +struct snd_soc_codec_device soc_codec_dev_ad1836 = {
> +	.probe = 	ad1836_probe,
> +	.remove = 	ad1836_remove,
> +	/* The power management of ad1836 is very simple. There are
> +	 * only adc&dac 2 components to control. Dapm handles them.
> +	 */
> +	.suspend =      NULL,
> +	.resume =       NULL,

The power control will be handled by DAPM but your driver still needs to
restore things like the volume settings - when the driver is powered off
the register settings will be forgotten.
