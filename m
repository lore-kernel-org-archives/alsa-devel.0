From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 2/5] ASoC: codecs: msm8916-wcd-analog: get micbias
 voltage from dt
Date: Fri, 11 Aug 2017 16:15:47 +0100
Message-ID: <5a6db43c-3ba4-aba7-977e-0ea731d4f2f9@linaro.org>
References: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
 <20170809164927.19663-3-srinivas.kandagatla@linaro.org>
 <20170810152437.ezfhi7cukutyabmt@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170810152437.ezfhi7cukutyabmt@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, damien.riegel@savoirfairelinux.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 10/08/17 16:24, Mark Brown wrote:
> On Wed, Aug 09, 2017 at 06:49:24PM +0200, srinivas.kandagatla@linaro.org wrote:
> 
>> -	snd_soc_write(codec, CDC_A_MICB_1_VAL, MICB_1_VAL_MICB_OUT_VAL_V2P70V);
>> -	/*
>> -	 * Special headset needs MICBIAS as 2.7V so wait for
>> -	 * 50 msec for the MICBIAS to reach 2.7 volts.
>> -	 */
>> -	msleep(50);
>> +	if (wcd->micbias_mv)
> 
> We seem to have just completely lost this ramp time handling?
Yes, will take care of this in next version.

> 
