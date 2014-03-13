From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Thu, 13 Mar 2014 05:29:47 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7398652@RTITMBSV03.realtek.com.tw>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
 <5320CE8C.8090608@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4747D265114
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 06:29:55 +0100 (CET)
In-Reply-To: <5320CE8C.8090608@metafoo.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Thursday, March 13, 2014 5:16 AM
> To: Bard Liao
> Cc: broonie@kernel.org; lgirdwood@gmail.com; Oder Chiou;
> alsa-devel@alsa-project.org; Gustaw Lewandowski; Flove
> Subject: Re: [alsa-devel] [PATCH v5] ASoC: add RT286 CODEC driver
> 
> On 03/11/2014 08:11 AM, bardliao@realtek.com wrote:
> [...]
> > +static unsigned int rt286_reg_cache[] = {
> > +	[RT286_AUDIO_FUNCTION_GROUP] = 0x0000,
> > +	[RT286_DAC_OUT1] = 0x7f7f,
> > +	[RT286_DAC_OUT2] = 0x7f7f,
> > +	[RT286_SPDIF] = 0x0000,
> > +	[RT286_ADC_IN1] = 0x4343,
> > +	[RT286_ADC_IN2] = 0x4343,
> > +	[RT286_MIC1] = 0x0000,
> > +	[RT286_MIXER_IN] = 0x000b,
> > +	[RT286_MIXER_OUT1] = 0x0002,
> > +	[RT286_MIXER_OUT2] = 0x0000,
> > +	[RT286_DMIC1] = 0x0000,
> > +	[RT286_DMIC2] = 0x0000,
> > +	[RT286_LINE1] = 0x0000,
> > +	[RT286_BEEP] = 0x0000,
> > +	[RT286_VENDOR_REGISTERS] = 0x0000,
> > +	[RT286_SPK_OUT] = 0x8080,
> > +	[RT286_HP_OUT] = 0x8080,
> > +	[RT286_MIXER_IN1] = 0x0000,
> > +	[RT286_MIXER_IN2] = 0x0000,
> > +};
> > +
> > +static int rt286_hw_read(void *context, unsigned int reg, unsigned
> > +int *value) {
> > +	struct i2c_client *client = context;
> > +	struct i2c_msg xfer[2];
> > +	int ret;
> > +	unsigned int buf = 0x0;
> > +
> > +	if (reg <= 0xff) { /*read cache*/
> > +		*value = rt286_reg_cache[reg];
> 
> Any reason particular reason to not use regmap caching? Also your cache is
> driver global which means different device instances will use the same cache,
> which will probably have very weired effects. Also you cache has less than 0xff
> entries, so the check is completely bogus.

Because rt286 uses different registers for read and write the same bits.
So, I can't read the real value from cache.
The cache I am using is for dummy registers actually.
These dummy registers are mainly used for dapm to get the route information.
We don't touch the codec when read/write these dummy registers.
I will try to put the cache into rt286_priv.
And will change if (reg <= 0xff) to if (reg <= RT286_MIXER_IN2).

> 
> > +	/* Write register */
> > +	xfer[0].addr = client->addr;
> > +	xfer[0].flags = 0;
> > +	xfer[0].len = 4;
> > +	xfer[0].buf = (u8 *)&reg;
> > +
> > +	/* Read data */
> > +	xfer[1].addr = client->addr;
> > +	xfer[1].flags = I2C_M_RD;
> > +	xfer[1].len = 4;
> > +	xfer[1].buf = (u8 *)&buf;
> > +
> > +	ret = i2c_transfer(client->adapter, xfer, 2);
> > +	if (ret < 0)
> > +		return ret;
> > +	else if (ret != 2)
> > +		return -EIO;
> > +
> > +	*value = be32_to_cpu(buf);
> > +
> > +	return 0;
> > +}
> > +
> [...]
> > +static int rt286_update_bits(struct snd_soc_codec *codec, unsigned int vid,
> > +				unsigned int nid, unsigned int data,
> > +				unsigned int mask, unsigned int value) {
> > +	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
> > +	unsigned int old, new, verb;
> > +	int change, ret;
> > +
> > +	verb = VERB_CMD((vid | 0x800), nid, data);
> > +	regmap_read(rt286->regmap, verb, &old);
> > +	new = (old & ~mask) | (value & mask);
> > +	change = old != new;
> > +
> > +	if (change) {
> > +		verb = VERB_CMD(vid, nid, new);
> > +		ret = regmap_write(rt286->regmap, verb, 0);
> > +		if (ret < 0) {
> > +			dev_err(codec->dev,
> > +				"Failed to write private reg: %d\n", ret);
> > +			goto err;
> > +		}
> > +	}
> 
> Can't this use regmap_update_bits()?

rt286 use different data length for read/write protocol.
Also it uses different registers for read/write the same bit.

verb = VERB_CMD((vid | 0x800), nid, data);
regmap_read(rt286->regmap, verb, &old);
...
verb = VERB_CMD(vid, nid, new);
ret = regmap_write(rt286->regmap, verb, 0);

I use different reg(verb) for regmap_read and regmap_write.
And set regmap_write's val variable to 0.
I think regmap_update_bits() will do things like
regmap_read(rt286->regmap, verb, &old);
regmap_write(rt286->regmap, verb, new);
with the same verb value.

> 
> > +	return change;
> > +
> > +err:
> > +	return ret;
> > +}
> [...]
> > +static int rt286_index_update_bits(struct snd_soc_codec *codec,
> > +	unsigned int wid, unsigned int index,
> > +	unsigned int mask, unsigned int data) {
> > +	unsigned int old, new;
> > +	int change, ret;
> > +
> > +	old =  rt286_index_read(codec, wid, index);
> > +	new = (old & ~mask) | (data & mask);
> > +	change = old != new;
> > +
> > +	if (change) {
> > +		ret = rt286_index_write(codec, wid, index, new);
> > +		if (ret < 0) {
> > +			dev_err(codec->dev,
> > +				"Failed to write private reg: %d\n", ret);
> > +			goto err;
> > +		}
> > +	}
> 
> Same here.

Same reason as above.

> 
> > +	0, 5,
> > +};
> [...]
> > +static int rt286_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int
> > +ratio) {
> > +	struct snd_soc_codec *codec = dai->codec;
> > +
> > +	dev_dbg(codec->dev, "%s ratio=%d\n", __func__, ratio);
> > +	if (50 == ratio)
> 
> The ratio is the number of bit-clock cycles per lr-clock cycle.

That is exactly the information we need to know.


> 
> > +				GFP_KERNEL);
> > +	if (NULL == rt286)
> > +		return -ENOMEM;
> > +
> > +	rt286->regmap = devm_regmap_init(dev, NULL, i2c, &rt286_regmap);
> > +	if (IS_ERR(rt286->regmap)) {
> > +		ret = PTR_ERR(rt286->regmap);
> > +		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	rt286->i2c = i2c;
> > +	i2c_set_clientdata(i2c, rt286);
> > +
> > +	if (pdata)
> > +		rt286->pdata = *pdata;
> > +
> > +	ret = devm_snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt286,
> > +				     rt286_dai, ARRAY_SIZE(rt286_dai));
> 
> There is no such thing as devm_snd_soc_register_codec().

That is Mark's suggestion.
I suppose devm_snd_soc_register_codec() will be upstreaming soon.
Should I use snd_soc_register_codec() in this patch?

> 
> > +
> > +	return ret;
> > +}
> 
> 
> ------Please consider the environment before printing this e-mail.
