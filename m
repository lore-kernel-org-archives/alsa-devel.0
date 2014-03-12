From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Wed, 12 Mar 2014 22:15:56 +0100
Message-ID: <5320CE8C.8090608@metafoo.de>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id CC2EA26501B
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 22:13:04 +0100 (CET)
In-Reply-To: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 03/11/2014 08:11 AM, bardliao@realtek.com wrote:
[...]
> +static unsigned int rt286_reg_cache[] = {
> +	[RT286_AUDIO_FUNCTION_GROUP] = 0x0000,
> +	[RT286_DAC_OUT1] = 0x7f7f,
> +	[RT286_DAC_OUT2] = 0x7f7f,
> +	[RT286_SPDIF] = 0x0000,
> +	[RT286_ADC_IN1] = 0x4343,
> +	[RT286_ADC_IN2] = 0x4343,
> +	[RT286_MIC1] = 0x0000,
> +	[RT286_MIXER_IN] = 0x000b,
> +	[RT286_MIXER_OUT1] = 0x0002,
> +	[RT286_MIXER_OUT2] = 0x0000,
> +	[RT286_DMIC1] = 0x0000,
> +	[RT286_DMIC2] = 0x0000,
> +	[RT286_LINE1] = 0x0000,
> +	[RT286_BEEP] = 0x0000,
> +	[RT286_VENDOR_REGISTERS] = 0x0000,
> +	[RT286_SPK_OUT] = 0x8080,
> +	[RT286_HP_OUT] = 0x8080,
> +	[RT286_MIXER_IN1] = 0x0000,
> +	[RT286_MIXER_IN2] = 0x0000,
> +};
> +
> +static int rt286_hw_read(void *context, unsigned int reg, unsigned int *value)
> +{
> +	struct i2c_client *client = context;
> +	struct i2c_msg xfer[2];
> +	int ret;
> +	unsigned int buf = 0x0;
> +
> +	if (reg <= 0xff) { /*read cache*/
> +		*value = rt286_reg_cache[reg];

Any reason particular reason to not use regmap caching? Also your cache is 
driver global which means different device instances will use the same cache, 
which will probably have very weired effects. Also you cache has less than 0xff 
entries, so the check is completely bogus.

> +		return 0;
> +	}
> +	reg = cpu_to_be32(reg);

Don't store values of different endianness in the same variable, all the static 
code checkers will complain about this. Use a __be32 type variable to hold the 
result of cpu_to_be32.

> +	/* Write register */
> +	xfer[0].addr = client->addr;
> +	xfer[0].flags = 0;
> +	xfer[0].len = 4;
> +	xfer[0].buf = (u8 *)&reg;
> +
> +	/* Read data */
> +	xfer[1].addr = client->addr;
> +	xfer[1].flags = I2C_M_RD;
> +	xfer[1].len = 4;
> +	xfer[1].buf = (u8 *)&buf;
> +
> +	ret = i2c_transfer(client->adapter, xfer, 2);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret != 2)
> +		return -EIO;
> +
> +	*value = be32_to_cpu(buf);
> +
> +	return 0;
> +}
> +
[...]
> +static int rt286_update_bits(struct snd_soc_codec *codec, unsigned int vid,
> +				unsigned int nid, unsigned int data,
> +				unsigned int mask, unsigned int value)
> +{
> +	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
> +	unsigned int old, new, verb;
> +	int change, ret;
> +
> +	verb = VERB_CMD((vid | 0x800), nid, data);
> +	regmap_read(rt286->regmap, verb, &old);
> +	new = (old & ~mask) | (value & mask);
> +	change = old != new;
> +
> +	if (change) {
> +		verb = VERB_CMD(vid, nid, new);
> +		ret = regmap_write(rt286->regmap, verb, 0);
> +		if (ret < 0) {
> +			dev_err(codec->dev,
> +				"Failed to write private reg: %d\n", ret);
> +			goto err;
> +		}
> +	}

Can't this use regmap_update_bits()?

> +	return change;
> +
> +err:
> +	return ret;
> +}
[...]
> +static int rt286_index_update_bits(struct snd_soc_codec *codec,
> +	unsigned int wid, unsigned int index,
> +	unsigned int mask, unsigned int data)
> +{
> +	unsigned int old, new;
> +	int change, ret;
> +
> +	old =  rt286_index_read(codec, wid, index);
> +	new = (old & ~mask) | (data & mask);
> +	change = old != new;
> +
> +	if (change) {
> +		ret = rt286_index_write(codec, wid, index, new);
> +		if (ret < 0) {
> +			dev_err(codec->dev,
> +				"Failed to write private reg: %d\n", ret);
> +			goto err;
> +		}
> +	}

Same here.

> +	return change;
> +
> +err:
> +	return ret;
> +}
[...]
> +static int rt286_adc_values[] = {

const

> +	0, 5,
> +};
[...]
> +static int rt286_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	dev_dbg(codec->dev, "%s ratio=%d\n", __func__, ratio);
> +	if (50 == ratio)

The ratio is the number of bit-clock cycles per lr-clock cycle.

> +		rt286_index_update_bits(codec, RT286_VENDOR_REGISTERS,
> +			RT286_I2S_CTRL1, 0x1000, 0x1000);
> +	else
> +		rt286_index_update_bits(codec, RT286_VENDOR_REGISTERS,
> +			RT286_I2S_CTRL1, 0x1000, 0x0);
> +
> +
> +	return 0;
> +}
> +

[...]
> +
> +	if (rt286->i2c->irq) {
> +		rt286_index_update_bits(codec,
> +			RT286_VENDOR_REGISTERS, RT286_IRQ_CTRL, 0x2, 0x2);
> +		ret = request_threaded_irq(rt286->i2c->irq, NULL, rt286_irq,
> +			IRQF_TRIGGER_HIGH | IRQF_ONESHOT, "rt286", rt286);

This IRQ is never freed.

> +		if (ret != 0) {
> +			dev_err(codec->dev,
> +				"Failed to reguest IRQ: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +#define RT286_STEREO_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
> +#define RT286_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
> +			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
> +
> +struct snd_soc_dai_ops rt286_aif_dai_ops = {

const

> +	.hw_params = rt286_hw_params,
> +	.set_fmt = rt286_set_dai_fmt,
> +	.set_sysclk = rt286_set_dai_sysclk,
> +	.set_bclk_ratio = rt286_set_bclk_ratio,
> +};
> +
> +struct snd_soc_dai_driver rt286_dai[] = {
> +	{
> +	 .name = "rt286-aif1",
> +	 .id = RT286_AIF1,
> +	 .playback = {
> +		      .stream_name = "AIF1 Playback",
> +		      .channels_min = 1,
> +		      .channels_max = 2,
> +		      .rates = RT286_STEREO_RATES,
> +		      .formats = RT286_FORMATS,
> +		      },
> +	 .capture = {
> +		     .stream_name = "AIF1 Capture",
> +		     .channels_min = 1,
> +		     .channels_max = 2,
> +		     .rates = RT286_STEREO_RATES,
> +		     .formats = RT286_FORMATS,
> +		     },
> +	 .ops = &rt286_aif_dai_ops,
> +	 .symmetric_rates = 1,

Indention is a bit strange here.

> +	 },
> +};
[...]
> +static const struct i2c_device_id rt286_i2c_id[] = {
> +	{"rt286", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, rt286_i2c_id);
> +
> +static struct acpi_device_id rt286_acpi_match[] = {

const

> +	{ "INT343A", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, rt286_acpi_match);
> +
> +static int rt286_i2c_probe(struct i2c_client *i2c,
> +			   const struct i2c_device_id *id)
> +{
> +	struct rt286_platform_data *pdata = dev_get_platdata(&i2c->dev);
> +	struct rt286_priv *rt286;
> +	struct device *dev = &i2c->dev;
> +	int ret;
> +
> +	rt286 = devm_kzalloc(&i2c->dev,
> +				sizeof(struct rt286_priv),


sizeof(*rt286) is prefered kernel style

> +				GFP_KERNEL);
> +	if (NULL == rt286)
> +		return -ENOMEM;
> +
> +	rt286->regmap = devm_regmap_init(dev, NULL, i2c, &rt286_regmap);
> +	if (IS_ERR(rt286->regmap)) {
> +		ret = PTR_ERR(rt286->regmap);
> +		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	rt286->i2c = i2c;
> +	i2c_set_clientdata(i2c, rt286);
> +
> +	if (pdata)
> +		rt286->pdata = *pdata;
> +
> +	ret = devm_snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt286,
> +				     rt286_dai, ARRAY_SIZE(rt286_dai));

There is no such thing as devm_snd_soc_register_codec().

> +
> +	return ret;
> +}
