From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 1/1] ASoC: dsd1791: Introduce driver
 for TI DSD1791 stereo codec
Date: Thu, 15 Dec 2011 15:16:22 +0800
Message-ID: <20111215071621.GE24248@opensource.wolfsonmicro.com>
References: <1323906043-28408-1-git-send-email-michael.williamson@criticallink.com>
	<1323906043-28408-2-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DB3BB10393E
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 08:16:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323906043-28408-2-git-send-email-michael.williamson@criticallink.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Williamson <michael.williamson@criticallink.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 14, 2011 at 06:40:43PM -0500, Michael Williamson wrote:

> +static int dsd1791_write(struct snd_soc_codec *codec, unsigned int reg,
> +			 unsigned int value)
> +{
> +	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
> +	u8 buffer[2];
> +	int rc;
> +
> +	buffer[0] = (reg & 0x7F);
> +	buffer[1] = value & 0xFF;
> +	rc = spi_write(dsd1791->spi, buffer, 2);
> +	if (rc) {
> +		dev_err(&dsd1791->spi->dev, "DSD1791 reg write error (%d)\n",
> +			rc);
> +		return -EIO;
> +	}
> +	return 0;

You shouldn't be open coding register I/O - this looks like a basic 8x8
register map so should work just fine with regmap (or the ASoC stuff but
new drivers should really use regmap).

> +	case DSD1791_DAIFMT_I2S:
> +		if (dsd1791->pcm_fmt == DSD1971_FORMAT_S16_LE)
> +			fmt = DSD1791_FMT_16I2S;
> +		else if (dsd1791->pcm_fmt == DSD1971_FORMAT_S24_LE)
> +			fmt = DSD1791_FMT_24I2S;
> +		else
> +			return -EINVAL;

This should be a switch statement.  You've got quite a few instances of
this pattern.

> +	default:
> +		dev_dbg(&dsd1791->spi->dev, "bad format\n");

codec->dev is easier.

> +static int dsd1791_set_sysclk(struct snd_soc_dai *codec_dai,
> +				int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
> +	dsd1791->mclk = freq;
> +	return 0;
> +}

Implement this as a CODEC wide operation, it's simpler.

> +static const struct snd_kcontrol_new dsd1791_snd_controls[] = {
> +};

Remove empty variables and functions.

> +	err = snd_soc_add_controls(codec, dsd1791_snd_controls,
> +		ARRAY_SIZE(dsd1791_snd_controls));

If this were non-empty it should be registered via the CODEC structure.

> +	dev_info(&spi->dev, "probing dsd1791 spi device\n");

This is just noise, remove it.

> +	dsd1791 = kzalloc(sizeof *dsd1791, GFP_KERNEL);
> +	if (!dsd1791)
> +		return -ENOMEM;

devm_kzalloc().

> +	} else
> +		dev_info(&spi->dev, "SPI device initialized\n");

Again, too chatty.

> +static struct spi_driver dsd1791_spi = {
> +	.driver = {
> +		.name = "dsd1791-codec",

No -codec.

> +static int __init dsd1791_init(void)
> +{
> +	spi_register_driver(&dsd1791_spi);
> +
> +	return 0;

Return the error code from spi_register_driver().
