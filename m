From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/3] ASoC: add es8328 codec driver
Date: Tue, 17 Jun 2014 08:24:44 +0200
Message-ID: <539FDF2C.10606@metafoo.de>
References: <1402982189-28598-1-git-send-email-xobs@kosagi.com>
 <1402982189-28598-3-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-086.synserver.de (smtp-out-088.synserver.de
 [212.40.185.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 90898265530
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 08:24:54 +0200 (CEST)
In-Reply-To: <1402982189-28598-3-git-send-email-xobs@kosagi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sean Cross <xobs@kosagi.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 06/17/2014 07:16 AM, Sean Cross wrote:

A couple of small bits inline.

[...]
> --- /dev/null
> +++ b/sound/soc/codecs/es8328.c
> @@ -0,0 +1,711 @@
[...]
> +#include <linux/platform_device.h>

You don't use platform devices in here

[...]
> +uint8_t sample_ratios[] = {

static const, also a prefix like es8328_ wont hurt

> +	[ES8328_RATE_8019]  = 0x9,
> +	[ES8328_RATE_11025] = 0x7,
> +	[ES8328_RATE_22050] = 0x4,
> +	[ES8328_RATE_44100] = 0x2,
> +};
> +
> +#define ES8328_RATES (SNDRV_PCM_RATE_44100 | \
> +		SNDRV_PCM_RATE_22050 | \
> +		SNDRV_PCM_RATE_11025)
> +#define ES8328_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
> +
> +/* codec private data */
> +struct es8328_priv {
> +	struct regmap *regmap;
> +	int sysclk;
> +};
> +
> +/*
> + * ES8328 Controls
> + */
> +
> +static const char * const deemph_txt[] = {"None", "32Khz", "44.1Khz", "48Khz"};
> +static SOC_ENUM_SINGLE_DECL(deemph,
> +			    ES8328_DACCONTROL6, 6, deemph_txt);

deemph should just be a single boolean switch (On or Off) and automatically 
select the correct setting based on the configured sample rate.

[...]
> +static const char * const es8328_line_texts[] = {
> +	"Line 1", "Line 2", "PGA", "Differential"};
> +
> +static const unsigned int es8328_line_values[] = {
> +	0, 1, 2, 3};

You don't need to use a value enum for this.

[...]
> +static const char * const es8328_pga_sel[] = {
> +	"Line 1", "Line 2", "Line 3", "Differential"};
> +static const unsigned int es8328_pga_val[] = { 0, 1, 2, 3 };

same here

[...]
> +static int es8328_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params,
> +	struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		u8 dac = snd_soc_read(codec, ES8328_DACCONTROL2);
> +
> +		dac &= ~ES8328_DACCONTROL2_RATEMASK;
> +
> +		switch (params_rate(params)) {
> +		case 8000:
> +			dac |= sample_ratios[ES8328_RATE_8019];
> +			break;
> +		case 11025:
> +			dac |= sample_ratios[ES8328_RATE_11025];
> +			break;
> +		case 22050:
> +			dac |= sample_ratios[ES8328_RATE_22050];
> +			break;
> +		case 44100:
> +			dac |= sample_ratios[ES8328_RATE_44100];
> +			break;
> +		default:
> +			dev_err(codec->dev, "%s: unknown rate %d\n",
> +				 __func__, params_rate(params));
> +			return -EINVAL;
> +		}
> +		snd_soc_write(codec, ES8328_DACCONTROL2, dac);
> +	}
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> +		u8 adc = snd_soc_read(codec, ES8328_ADCCONTROL5);
> +
> +		adc &= ~ES8328_ADCCONTROL5_RATEMASK;
> +
> +		switch (params_rate(params)) {
> +		case 8000:
> +			adc |= sample_ratios[ES8328_RATE_8019];
> +			break;
> +		case 11025:
> +			adc |= sample_ratios[ES8328_RATE_11025];
> +			break;
> +		case 22050:
> +			adc |= sample_ratios[ES8328_RATE_22050];
> +			break;
> +		case 44100:
> +			adc |= sample_ratios[ES8328_RATE_44100];
> +			break;
> +		default:
> +			dev_err(codec->dev, "%s: unknown rate %d\n",
> +				 __func__, params_rate(params));
> +			return -EINVAL;
> +		}
> +		snd_soc_write(codec, ES8328_ADCCONTROL5, adc);
> +	}

The capture and the playback case look pretty much the same. This could 
probably be handled without duplicating the code. Also use 
snd_soc_update_bits() for updating the register.

> +
> +	return 0;
> +}
[...][
> +static int es8328_probe(struct snd_soc_codec *codec)
> +{
> +	/* power on device */
> +	return es8328_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +}

You don't need this one, the core will automatically bring the dapm context 
to idle bias after the device has been probed.

> +
> +static int es8328_remove(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

No, need to have empty callbacks, just leave .remove of the codec driver 
struct NULL.

> +
> +static struct snd_soc_codec_driver soc_codec_dev_es8328 = {

const

the soc_codec_dev_foobar naming pattern comes from a time when this actually 
used to be a device rather than a driver. Something like es8328_codec_driver 
is a more appropriate name these days.

> +	.probe =		es8328_probe,
> +	.remove =		es8328_remove,
> +	.suspend =		es8328_suspend,
> +	.resume =		es8328_resume,
> +	.set_bias_level =	es8328_set_bias_level,
> +	.controls =		es8328_snd_controls,
> +	.num_controls =		ARRAY_SIZE(es8328_snd_controls),
> +	.dapm_widgets =		es8328_dapm_widgets,
> +	.num_dapm_widgets =	ARRAY_SIZE(es8328_dapm_widgets),
> +	.dapm_routes =		es8328_dapm_routes,
> +	.num_dapm_routes =	ARRAY_SIZE(es8328_dapm_routes),
> +};
[...]
> +#if defined(CONFIG_SPI_MASTER)

For CODECs with more than one bus interface we started splitting the bus 
interface support code into separate modules (e.g. one module for the core 
logic of the driver, one module for I2C and one module for SPI). This was 
done to avoid issue when one bus is built-in and the the other is built as a 
module. New drivers should follow this scheme. E.g. see 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/sound/soc/codecs/?id=6c3d713e6d32706999689e379a9098afb4cd8a2c

> +static int es8328_spi_probe(struct spi_device *spi)
> +{
> +	struct es8328_priv *es8328;
> +	int ret;
> +
> +	es8328 = devm_kzalloc(&spi->dev, sizeof(struct es8328_priv),

sizeof(*es8328) is the preferred style

> +			      GFP_KERNEL);
> +	if (es8328 == NULL)
> +		return -ENOMEM;
> +
> +	es8328->regmap = devm_regmap_init_spi(spi, &es8328_regmap);
> +	if (IS_ERR(es8328->regmap))
> +		return PTR_ERR(es8328->regmap);
> +
> +	spi_set_drvdata(spi, es8328);
> +
> +	ret = snd_soc_register_codec(&spi->dev,
> +			&soc_codec_dev_es8328, &es8328_dai, 1);
> +	if (ret < 0)
> +		dev_err(&spi->dev, "unable to register codec: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int es8328_spi_remove(struct spi_device *spi)
> +{
> +	snd_soc_unregister_codec(&spi->dev);
> +
> +	return 0;
[...]
> +static const struct i2c_device_id es8328_i2c_id[] = {
> +	{ "es8328", 0x11 },

The second field is the drvdata, this is not the I2C address of the device. 
If you don't use drvdata just leave it 0.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, es8328_i2c_id);
> +
[...]
