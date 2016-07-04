From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Mon, 4 Jul 2016 11:34:19 +0800
Message-ID: <5779D93B.80106@nuvoton.com>
References: <1466152834-29615-1-git-send-email-KCHSU0@nuvoton.com>
 <20160627171546.GE17217@sirena.org.uk> <5775E4C7.5010303@nuvoton.com>
 <20160701100423.GM6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8482E265876
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2016 05:34:23 +0200 (CEST)
In-Reply-To: <20160701100423.GM6247@sirena.org.uk>
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

On 7/1/2016 6:04 PM, Mark Brown wrote:
> On Fri, Jul 01, 2016 at 11:34:31AM +0800, John Hsu wrote:
>   
>> On 6/28/2016 1:15 AM, Mark Brown wrote:
>>     
>
>   
>>> This looks like a regmap with 7 bit registers and 9 bit value.  Why
>>> aren't we just using the standard regmap support for this?
>>>       
>
>   
>> Yes, that is the i2c format of this codec. The format is not common,
>> and the register map only supports write but not supports read.
>> The driver only can read information from cache, but it can't read
>> the read-only register. Thus, we need to have our own read and write
>> function for codec.
>>     
>
> No, you don't - this is entirely normal for 7x9 regmaps, I've never seen
> such a device that supported readback.  Look at devices like wm8731 for
> examples.
>
>   

Sometimes, we need to know the codec information and need read it
from hardware, not cache. I'm afraid that it can't be done in this
case.

>>>> +	SOC_SINGLE("Digital Loopback Switch", NAU8810_REG_COMP,
>>>> +		NAU8810_ADDAP_SFT, 1, 0),
>>>>         
>
>   
>>> This looks like it should be a DAPM control.
>>>       
>
>   
>> The function is only for debug normally. The playback and capture
>> shouldn't enable the function. Thus, we only put it in the user
>> control.
>>     
>
> If it's for routing it should go into DAPM, someone might find a use for
> it and it'll stop confusion.
>
>   

I know the reason and move it to DAPM.

>>>> +	nau8810->div_id = div_id;
>>>> +	if (div_id != NAU8810_MCLK_DIV_MCLK)
>>>> +		/* Defer the master clock prescaler configuration to DAI
>>>> +		 * hardware parameter if master clock from MCLK because
>>>> +		 * it needs runtime fs information to get the proper div.
>>>> +		 */
>>>> +		ret = nau8810_config_clkdiv(nau8810, div, 0);
>>>> +
>>>> +	return ret;
>>>> +}
>>>>         
>
>   
>>> You shouldn't be implementing new set_clkdiv() operations, there's no
>>> point in having each machine driver figure out the internal clocking of
>>> the device.  Just specify the clocks coming into the device and have
>>> the driver figure out what to do with them.
>>>       
>
>   
>> We want to calculate the proper divide for MCLK as clock source.
>> The design needs sampling rate information for the calculation.
>> In the application sequence, there is no rate information in this
>> stage and it should defer until codec hardware parameter.
>>     
>
> That should be fine, you can do this in your hw_params() can't you?
>   

Yes, it can be done in hw_params().
