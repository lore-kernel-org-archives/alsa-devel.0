From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Thu, 13 Mar 2014 09:35:40 +0100
Message-ID: <53216DDC.9090502@metafoo.de>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
 <5320CE8C.8090608@metafoo.de>
 <ABFD875FF5FB574BA706497D987D48D7398652@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-042.synserver.de (smtp-out-047.synserver.de
 [212.40.185.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E09326513F
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 09:35:05 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7398652@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 03/13/2014 06:29 AM, Bard Liao wrote:
>>> +
>> [...]
>>> +static int rt286_update_bits(struct snd_soc_codec *codec, unsigned int vid,
>>> +				unsigned int nid, unsigned int data,
>>> +				unsigned int mask, unsigned int value) {
>>> +	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
>>> +	unsigned int old, new, verb;
>>> +	int change, ret;
>>> +
>>> +	verb = VERB_CMD((vid | 0x800), nid, data);
>>> +	regmap_read(rt286->regmap, verb, &old);
>>> +	new = (old & ~mask) | (value & mask);
>>> +	change = old != new;
>>> +
>>> +	if (change) {
>>> +		verb = VERB_CMD(vid, nid, new);
>>> +		ret = regmap_write(rt286->regmap, verb, 0);
>>> +		if (ret < 0) {
>>> +			dev_err(codec->dev,
>>> +				"Failed to write private reg: %d\n", ret);
>>> +			goto err;
>>> +		}
>>> +	}
>>
>> Can't this use regmap_update_bits()?
>
> rt286 use different data length for read/write protocol.
> Also it uses different registers for read/write the same bit.
>
> verb = VERB_CMD((vid | 0x800), nid, data);
> regmap_read(rt286->regmap, verb, &old);
> ...
> verb = VERB_CMD(vid, nid, new);
> ret = regmap_write(rt286->regmap, verb, 0);

You need to differentiate between logical and physical addresses. If your 
device uses different physical addresses for read and write then your read 
and write functions should do the proper translation from the logical 
address to the physical address. Looking at include/sound/hda_verbs.h it 
seems that the GET verbs are always the same as the SET verbs but 
additionally set bit 11. So bit 11 is your read bit that always needs to be 
set when reading a register. This is nothing special to the rt286, in fact 
it is so common that regmap as support for this in the core. See the 
read_flag_mask for the regmap_config struct.

>
> I use different reg(verb) for regmap_read and regmap_write.
> And set regmap_write's val variable to 0.

So you changed the regmap semantics and do pass the value of the register 
write via address and set value always to zero. In that it would probably 
been better to not use regmap at all. But as I said, there doesn't seem to 
be anything special about the device, you just need to implement the read 
and write callbacks correctly, then it is no problem to use 
regmap_update_bits and also regmap level caching.

> I think regmap_update_bits() will do things like
> regmap_read(rt286->regmap, verb, &old);
> regmap_write(rt286->regmap, verb, new);
> with the same verb value.
>
>>
>>> +	return change;
>>> +
>>> +err:
>>> +	return ret;
>>> +}
>> [...]
>>> +static int rt286_index_update_bits(struct snd_soc_codec *codec,
>>> +	unsigned int wid, unsigned int index,
>>> +	unsigned int mask, unsigned int data) {
>>> +	unsigned int old, new;
>>> +	int change, ret;
>>> +
>>> +	old =  rt286_index_read(codec, wid, index);
>>> +	new = (old & ~mask) | (data & mask);
>>> +	change = old != new;
>>> +
>>> +	if (change) {
>>> +		ret = rt286_index_write(codec, wid, index, new);
>>> +		if (ret < 0) {
>>> +			dev_err(codec->dev,
>>> +				"Failed to write private reg: %d\n", ret);
>>> +			goto err;
>>> +		}
>>> +	}
>>
>> Same here.
>
> Same reason as above.

rt286_index_read and rt286_index_write seem to implement a paging mechanism. 
regmap has native support for paging, see regmap_range_cfg. If you can't use 
regmap for paging implement the paging mechanism in your read/write callbacks.

>
>>
>>> +	0, 5,
>>> +};
>> [...]
>>> +static int rt286_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int
>>> +ratio) {
>>> +	struct snd_soc_codec *codec = dai->codec;
>>> +
>>> +	dev_dbg(codec->dev, "%s ratio=%d\n", __func__, ratio);
>>> +	if (50 == ratio)
>>
>> The ratio is the number of bit-clock cycles per lr-clock cycle.
>
> That is exactly the information we need to know.
>
>
>>
>>> +				GFP_KERNEL);
>>> +	if (NULL == rt286)
>>> +		return -ENOMEM;
>>> +
>>> +	rt286->regmap = devm_regmap_init(dev, NULL, i2c, &rt286_regmap);
>>> +	if (IS_ERR(rt286->regmap)) {
>>> +		ret = PTR_ERR(rt286->regmap);
>>> +		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
>>> +			ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	rt286->i2c = i2c;
>>> +	i2c_set_clientdata(i2c, rt286);
>>> +
>>> +	if (pdata)
>>> +		rt286->pdata = *pdata;
>>> +
>>> +	ret = devm_snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt286,
>>> +				     rt286_dai, ARRAY_SIZE(rt286_dai));
>>
>> There is no such thing as devm_snd_soc_register_codec().
>
> That is Mark's suggestion.
> I suppose devm_snd_soc_register_codec() will be upstreaming soon.
> Should I use snd_soc_register_codec() in this patch?

Yes, otherwise the driver won't compile.
