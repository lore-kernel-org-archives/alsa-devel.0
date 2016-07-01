From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Fri, 1 Jul 2016 11:34:31 +0800
Message-ID: <5775E4C7.5010303@nuvoton.com>
References: <1466152834-29615-1-git-send-email-KCHSU0@nuvoton.com>
 <20160627171546.GE17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BEB702651DB
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 05:34:33 +0200 (CEST)
In-Reply-To: <20160627171546.GE17217@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 6/28/2016 1:15 AM, Mark Brown wrote:
> On Fri, Jun 17, 2016 at 04:40:34PM +0800, John Hsu wrote:
>
>   
>> +static int nau8810_reg_write(void *context, unsigned int reg,
>> +			      unsigned int value)
>> +{
>> +	struct i2c_client *client = context;
>> +	uint8_t buf[2];
>> +	__be16 *out = (void *)buf;
>> +	int ret;
>> +
>> +	*out = cpu_to_be16((reg << 9) | value);
>> +	ret = i2c_master_send(client, buf, sizeof(buf));
>>     
>
> ...
>
>   
>> +	reg_buf = (uint8_t)(reg << 1);
>> +	xfer[0].addr = client->addr;
>> +	xfer[0].len = sizeof(reg_buf);
>> +	xfer[0].buf = &reg_buf;
>> +	xfer[0].flags = 0;
>> +
>> +	xfer[1].addr = client->addr;
>> +	xfer[1].len = sizeof(val_buf);
>> +	xfer[1].buf = (uint8_t *)&val_buf;
>> +	xfer[1].flags = I2C_M_RD;
>>     
>
> This looks like a regmap with 7 bit registers and 9 bit value.  Why
> aren't we just using the standard regmap support for this?
>
>   

Yes, that is the i2c format of this codec. The format is not common,
and the register map only supports write but not supports read.
The driver only can read information from cache, but it can't read
the read-only register. Thus, we need to have our own read and write
function for codec.

>> +static const struct soc_enum nau8810_enum[] = {
>> +	SOC_ENUM_SINGLE(NAU8810_REG_COMP, NAU8810_ADCCM_SFT,
>> +		ARRAY_SIZE(nau8810_companding), nau8810_companding),
>>     
>
> Don't define a big array of enums, this makes the code both hard to read
> and error prone when we index into the array by hard coded raw numbers.
> Just define each enum as a variable and then reference it by address
> like we do for enums in other drivers.
>
>   

OK, the array can split for every case.

>> +	SOC_SINGLE("Digital Loopback Switch", NAU8810_REG_COMP,
>> +		NAU8810_ADDAP_SFT, 1, 0),
>>     
>
> This looks like it should be a DAPM control.
>
>   

The function is only for debug normally. The playback and capture
shouldn't enable the function. Thus, we only put it in the user
control.

>> +	SOC_SINGLE_TLV("Playback Gain", NAU8810_REG_DACGAIN,
>> +		NAU8810_DACGAIN_SFT, 0xff, 0, digital_tlv),
>>     
>
> All volume controls should have names ending in Volume so that userspace
> tools can know how to presen them.
>
>   

We'll modify it.

>> +static int nau8810_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
>> +	int ret = 0;
>> +
>> +	nau8810->div_id = div_id;
>> +	if (div_id != NAU8810_MCLK_DIV_MCLK)
>> +		/* Defer the master clock prescaler configuration to DAI
>> +		 * hardware parameter if master clock from MCLK because
>> +		 * it needs runtime fs information to get the proper div.
>> +		 */
>> +		ret = nau8810_config_clkdiv(nau8810, div, 0);
>> +
>> +	return ret;
>> +}
>>     
>
> You shouldn't be implementing new set_clkdiv() operations, there's no
> point in having each machine driver figure out the internal clocking of
> the device.  Just specify the clocks coming into the device and have
> the driver figure out what to do with them.
>
>   

We want to calculate the proper divide for MCLK as clock source.
The design needs sampling rate information for the calculation.
In the application sequence, there is no rate information in this
stage and it should defer until codec hardware parameter.

>> +static int nau8810_probe(struct snd_soc_codec *codec)
>> +{
>> +	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
>> +
>> +	regmap_write(nau8810->regmap, NAU8810_REG_RESET, 0x00);
>>     
>
> This will break the regmap cache if the driver is ever rebound to a
> card, do this once on I2C probe.
>   

We will move to i2c probe. Thank you for your suggestion.
