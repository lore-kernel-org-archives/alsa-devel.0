From: Matt Flax <flatmax@flatmax.org>
Subject: Re: ASoC : question about custom rate
Date: Wed, 10 Sep 2014 09:45:55 +1000
Message-ID: <540F9133.7070405@flatmax.org>
References: <540EBDB8.20507@flatmax.org> <540EDA18.5070309@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
 [150.101.137.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 4952B265461
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 01:46:25 +0200 (CEST)
In-Reply-To: <540EDA18.5070309@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/09/14 20:44, Lars-Peter Clausen wrote:
> On 09/09/2014 10:43 AM, Matt Flax wrote:
>> Hi there,
>>
>> I have an ASIC running on an ASoC with a custom rate @ 18750 Hz.
>> I would like ALSA to report the correct rate.
>>
>> If I do nothing, then the following reports 16000 Hz :
>> cat /proc/asound/card0/pcm0c/sub0/hw_params
>>
>> I have verified that the hardware is running at the expected 18750 Hz.
>> I am wondering what/where is the correct place to setup the actual 
>> rate ?
>>
>> I am trying to set the rates at startup like so but ALSA will not 
>> work with
>> the driver when I do this :
>>
>> static int implant_startup(struct snd_pcm_substream *substream, struct
>> snd_soc_dai *dai)
>> {
>>      snd_pcm_hw_constraint_minmax(substream->runtime,
>> SNDRV_PCM_HW_PARAM_RATE, 18750, 18750);
>
>
> This is the correct approach. But it is quite likely that your I2S 
> driver will set additional constraints (e.g. just 16k, 32k, etc.) that 
> results in an empty list for the rate constraints. If the I2S driver 
> works fine maybe change the constraints to only set a minimum and 
> maximum rate instead of specific rates.

Yes, you are right, the i2s driver uses the macro SNDRV_PCM_RATE_8000_96000.

I have used your advice to test by manually setting the i2s rates to 
SNDRV_PCM_RATE_CONTINUOUS in the i2s driver's src code.
Now the rate is reported correctly in software. Thank you.

Is there a way to access the underlying i2s driver from within my 
codec's startup file so that I don't need to alter the core driver 
source code ?

thanks
Matt
