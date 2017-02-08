From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH] ASoC: bcm2835: Add 8 channel (multitrack)
 capability
Date: Thu, 9 Feb 2017 07:41:49 +1100
Message-ID: <21a531f2-4efb-fd92-b709-90f97ec73a92@flatmax.org>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <20170208182835.6hpwcxiae2lh56d5@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas03p.mx.bigpond.com (nschwmtas03p.mx.bigpond.com
 [61.9.189.143]) by alsa0.perex.cz (Postfix) with ESMTP id 1014B266A0A
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 21:41:58 +0100 (CET)
In-Reply-To: <20170208182835.6hpwcxiae2lh56d5@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Eric Anholt <eric@anholt.net>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


On 09/02/17 05:28, Mark Brown wrote:
> On Tue, Feb 07, 2017 at 10:09:36AM +1100, Matt Flax wrote:
>
>>   	case SND_SOC_DAIFMT_CBS_CFM:
>>   		clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
>> +	case SND_SOC_DAIFMT_CBM_CFS:
> Is this fall through deliberate?
>
>> +	/* Default data delay to 1 bit.
>> +	   In I2S mode, we must have 2 channels */
>>   	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>>   	case SND_SOC_DAIFMT_I2S:
>> +		if (params_channels(params) != 2)
>> +			return -EINVAL;
>> +	case SND_SOC_DAIFMT_DSP_A:
>> +	case SND_SOC_DAIFMT_DSP_B:
>>   		data_delay = 1;
>>   		break;
>>   	default:
> Same here.  This is also buggy in that it treats DSP A and DSP B
> identically, they are different so the configuration must be incorrect
> for one of them.  I suspect this is configuring for DSP A.
I can remove DSP_B. In actual fact this isn't the real problem.
> You should also really have a setup() function that imposes a channel
> constraint when in I2S mode, wm8988 is one example here.
>
I had a look at wm8988.c and couldn't see this channel constraint 
linking to I2S. Can you point me to it ?

thanks
Matt
