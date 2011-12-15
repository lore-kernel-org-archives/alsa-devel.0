From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC PATCH 1/1] ASoC: dsd1791: Introduce driver
 for TI DSD1791 stereo codec
Date: Thu, 15 Dec 2011 09:57:37 +0100
Message-ID: <4EE9B681.3060102@metafoo.de>
References: <1323906043-28408-1-git-send-email-michael.williamson@criticallink.com>
	<1323906043-28408-2-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-093.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93])
	by alsa0.perex.cz (Postfix) with ESMTP id E090D103CBF
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 09:57:14 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 12/15/2011 12:40 AM, Michael Williamson wrote:
> This patch introduces a (spi) codec driver for the Texas Instruments
> DSD1791 24 bit audio stereo DAC.
> 
> Testing for basic operation using 16 and 24 bit I2S mode has been
> performed.
> 
> http://www.ti.com/product/dsd1791
> 
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> ---
> [...]
> +
> +static int dsd1791_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (params_format(params)) {
> +
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		dsd1791->pcm_fmt = DSD1971_FORMAT_S16_LE;
> +		break;
> +
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		dsd1791->pcm_fmt = DSD1971_FORMAT_S24_LE;
> +		break;

There is really no need to add your own constants here. Just reuse the
SNDRV_PCM_FORMAT constants and assign params_format(params) directly to
dsd1791->pcm_fmt.

> +	default:
> +		dev_dbg(&dsd1791->spi->dev, "bad format\n");
> +		return -EINVAL;
> +	}
> +
> +	return dsd1791_set_format_word(dsd1791, codec);
> +}
> +
> [...]
> +static int dsd1791_set_fmt(struct snd_soc_dai *codec_dai,
> +			     unsigned int fmt)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		dsd1791->dai_fmt = DSD1791_DAIFMT_I2S;
> +		break;
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		dsd1791->dai_fmt = DSD1791_DAIFMT_RIGHT_J;
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		dsd1791->dai_fmt = DSD1791_DAIFMT_LEFT_J;
> +		break;

Same here for the SND_SOC_DAIFMT constants.


> +	default:
> +		dev_dbg(&dsd1791->spi->dev, "bad format\n");
> +		return -EINVAL;
> +	}
> +
> +	return dsd1791_set_format_word(dsd1791, codec);
> +}
> +
> +#define DSD1791_RATES	SNDRV_PCM_RATE_8000_192000
> +#define DSD1791_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE |\
> +			 SNDRV_PCM_FMTBIT_S24_LE)
> +
> +static struct snd_soc_dai_ops dsd1791_dai_ops = {

const

> +	.hw_params	= dsd1791_hw_params,
> +	.set_sysclk	= dsd1791_set_sysclk,
> +	.set_fmt	= dsd1791_set_fmt,
> +};
> +
> [...]
> +
> +struct snd_soc_codec_driver dsd1791_soc_codec_dev = {

static, and maybe rename it to dsd1719_codec_driver. The "_soc_codec_dev"
suffix which you can see in other drivers in from old times, where this used
to be a struct snd_soc_codec_device.

> +	.probe = dsd1791_probe,
> +	.read = dsd1791_read,
> +	.write = dsd1791_write,
> +	.reg_word_size = sizeof(u8),
> +};
> +
> +static int dsd1791_spi_probe(struct spi_device *spi)
__devinit

> +{
> [...]
> +
> +static int dsd1791_spi_remove(struct spi_device *spi)
__devexit
> +{
> [...]
> +}
> +
> +static struct spi_driver dsd1791_spi = {
> +	.driver = {
> +		.name = "dsd1791-codec",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = dsd1791_spi_probe,
> +	.remove = dsd1791_spi_remove,
__devexit_p
> +};
> +
