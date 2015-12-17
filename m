From: "Wu, Songjun" <songjun.wu@atmel.com>
Subject: Re: [PATCH 1/2] ASoC: atmel-pdmic: add the Pulse
 Density Modulation Interface Controller
Date: Thu, 17 Dec 2015 10:41:17 +0800
Message-ID: <567220CD.2060706@atmel.com>
References: <1450080940-4123-1-git-send-email-songjun.wu@atmel.com>
 <1450080940-4123-2-git-send-email-songjun.wu@atmel.com>
 <20151216122727.GI5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DVREDG02.corp.atmel.com (nasmtp01.atmel.com [192.199.1.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 252B52659A5
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2015 03:41:26 +0100 (CET)
In-Reply-To: <20151216122727.GI5727@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 12/16/2015 20:27, Mark Brown wrote:
> On Mon, Dec 14, 2015 at 04:15:39PM +0800, Songjun Wu wrote:
>
>> Add driver for the Pulse Density Modulation Interface
>> Controller. It comes with digitallly controlled gain,
>> a High-Pass and a SINCC filter.
>
> This looks basically OK but there's a *lot* of weird coding style issues
> in here.  It's really all that, nothing too serious that I noticed -
> I've pointed out some of the patterns below not every individual issue.
>
>> +	for (i = 0; i < ARRAY_SIZE(mic_gain_table); i++) {
>> +		if ((mic_gain_table[i].dgain == dgain_val)
>> +		&& (mic_gain_table[i].scale == scale_val))
>> +			ucontrol->value.integer.value[0] = i;
>> +	}
>
> This indentation is really weird, why is the && aligned with the if?
>
Accept.
>> +	snd_soc_update_bits(codec, PDMIC_DSPR1,
>> +		PDMIC_DSPR1_OFFSET_MASK,
>> +		(u32)(dd->pdata->mic_offset << PDMIC_DSPR1_OFFSET_SHIFT));
>
> These are weird too, I'd expect the second line to be part of the first.
>
>> +static struct regmap *atmel_pdmic_codec_get_remap(struct device *dev)
>> +{
>> +	return dev_get_regmap(dev, NULL);
>> +}
>
> This is (or should be) the default in the core.
>
You are right. The core has initialized the regmap in function 
snd_soc_component_add_unlocked.
This function can be removed.
Thank you.
>> +	if ((fs < rate_min) || (fs > rate_max)) {
>> +		dev_err(codec->dev,
>> +		"sample rate is %dHz, min rate is %dHz, max rate is %dHz\n",
>> +		fs, rate_min, rate_max);
>
> This too, alignment after the (.
>
Accept.
>> +	if (bits == 16)
>> +		dspr0_val = (PDMIC_DSPR0_SIZE_16_BITS
>> +				<< PDMIC_DSPR0_SIZE_SHIFT);
>> +	else if (bits == 32)
>> +		dspr0_val = (PDMIC_DSPR0_SIZE_32_BITS
>> +				<< PDMIC_DSPR0_SIZE_SHIFT);
>> +	else
>> +		return -EINVAL;
>
> This looks like it should be a switch statement.
>
Accept.
