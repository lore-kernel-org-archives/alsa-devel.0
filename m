From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: add crosstalk suppression
	feature
Date: Mon, 29 Feb 2016 07:21:16 +0800
Message-ID: <56D380EC.6070302@nuvoton.com>
References: <1454651566-28451-1-git-send-email-KCHSU0@nuvoton.com>
 <20160209183944.GL13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 10990260564
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 00:21:21 +0100 (CET)
In-Reply-To: <20160209183944.GL13270@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

On 2/10/2016 2:39 AM, Mark Brown wrote:
> On Fri, Feb 05, 2016 at 01:52:46PM +0800, John Hsu wrote:
>
>   
>> +/**
>> + * computes log10 of a value; the result is round off to 3 decimal.
>> + * this function takes reference to dvb-math.
>> + *
>> + * @return log10(value) * 1000
>> + */
>> +static u32 nau8825_intlog10_dec3(u32 value)
>> +{
>> +	u32 msb, logentry, significand, interpolation, log10val;
>> +	u64 log2val;
>> +
>> +	msb = fls(value) - 1;
>> +	significand = value << (31 - msb);
>> +	logentry = (significand >> 23) & 0xff;
>> +	interpolation = ((significand & 0x7fffff) *
>> +		((logtable[(logentry + 1) & 0xff] -
>> +		logtable[logentry]) & 0xffff)) >> 15;
>> +
>> +	log2val = ((msb << 24) + (logtable[logentry] << 8) + interpolation);
>> +	log10val = (log2val * LOG10_MAGIC) >> 31;
>> +	return log10val / ((1 << 24) / 1000);
>> +}
>>     
>
> This doesn't look driver specific, it should go somewhere generic
> (though I can't immediately see any relevant place for it...).
>
>   

Do you have any advise what we can do? It's possible to move these 
functions to other files, isn't it?

>> +	/* Config headphone volume */
>> +	regmap_update_bits(nau8825->regmap, NAU8825_REG_HSVOL_CTRL,
>> +		NAU8825_HPL_VOL_MASK | NAU8825_HPR_VOL_MASK, 0x0492);
>>     
>
> These are some very large register write sequences and there seems to be
> a bunch of stuff in them like the above which looks a lot like it's
> configuring things that we'd normally allow users to configure for their
> use case.  This at least needs a lot more documentation about what this
> is doing any why, and it's not clear to me that the code is safe with
> respect to what happens if an application decides to do something at the
> same time as the callibration is running.
>
>   

It has to enable DAC and ADC path for detection and measurement. A 
little like simple playback and record.
Indeed, it spent some time to finish the whole sequence and the 
situation you mention will happen possibly.
Do we can add some mutex in driver to avoid something like race 
condition happened? Could you give us suggenstion? Very thanks.

The document to what is done is fine and we'll add that in next patches.

>> @@ -211,6 +585,7 @@ static bool nau8825_volatile_reg(struct device *dev, unsigned int reg)
>>  	case NAU8825_REG_RESET:
>>  	case NAU8825_REG_IRQ_STATUS:
>>  	case NAU8825_REG_INT_CLR_KEY_STATUS:
>> +	case NAU8825_REG_BIQ_CTRL ... NAU8825_REG_BIQ_COF10:
>>  	case NAU8825_REG_IMM_RMS_L:
>>  	case NAU8825_REG_IMM_RMS_R:
>>  	case NAU8825_REG_I2C_DEVICE_ID:
>>     
>
> It also looks like this could be split up a bit, things like this that
> are just adding new registers could be separate.  The actual
> callibration is tricky but there's a bunch of other changes to support
> that.
>   

No problem, these registers can be split from others.
