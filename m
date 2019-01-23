From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 2/8] ASoC: wcd9335: add support to wcd9335 codec
Date: Wed, 23 Jan 2019 10:11:42 +0000
Message-ID: <4e09bbcb-2258-9a41-eca6-19c6a9dea97b@linaro.org>
References: <20190110150616.2332-1-srinivas.kandagatla@linaro.org>
 <20190110150616.2332-3-srinivas.kandagatla@linaro.org>
 <20190122184146.GF7579@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122184146.GF7579@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: robh+dt@kernel.org, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 22/01/2019 18:41, Mark Brown wrote:
> On Thu, Jan 10, 2019 at 03:06:10PM +0000, Srinivas Kandagatla wrote:
> 
> This all looks good apart from a couple of small things that should be
> easy to fix:
> 
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index 62bdb7e333b8..1c4904940621 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -1100,6 +1100,12 @@ config SND_SOC_UDA1380
>>           tristate
>>   	depends on I2C
>>   
>> +config SND_SOC_WCD9335
>> +	tristate "WCD9335 Codec"
>> +	depends on SLIMBUS
>> +	select REGMAP_SLIMBUS
>> +        tristate
>> +
>>   config SND_SOC_WL1273
>>   	tristate
>>   
> 
> You should add this to SND_SOC_ALL_CODECS.
Sure, I will add this in next version.
> 
>> +static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
>> +{
>> +	struct wcd9335_codec *wcd = data;
>> +	unsigned long status = 0;
>> +	int i, j, port_id;
>> +	unsigned int val, int_val = 0;
>> +	bool tx;
>> +	unsigned short reg = 0;
>> +
>> +	for (i = WCD9335_SLIM_PGD_PORT_INT_STATUS_RX_0, j = 0;
>> +	     i <= WCD9335_SLIM_PGD_PORT_INT_STATUS_TX_1; i++, j++) {
>> +		regmap_read(wcd->if_regmap, i, &val);
>> +		status |= ((u32)val << (8 * j));
>> +	}
>> +
>> +	for_each_set_bit(j, &status, 32) {
>> +		tx = (j >= 16 ? true : false);
>> +		port_id = (tx ? j - 16 : j);
> 
> ...
> 
>> +	return IRQ_HANDLED;
>> +}
> 
> This will report that it handled the interrupt unconditionally, this
> means that if the interrupt fires in error or there's some bug the
> interrupt will never be acknowledged (it looks like the chip requires
> acks?) but the interrupt core won't be able to notice and handle the
> problem as effectively as it could've done.  It's better to report
> IRQ_NONE if nothing as handled so that the core can do error handling.
I agree, Will fix this in next version!

thanks,
srini
> 
