From: Bo Shen <voice.shen@atmel.com>
Subject: Re: Question about WM8904 regcache
Date: Fri, 12 Jul 2013 18:03:16 +0800
Message-ID: <51DFD464.1090503@atmel.com>
References: <51DFA98A.50900@atmel.com> <20130712084200.GV24508@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DVREDG02.corp.atmel.com (nasmtp01.atmel.com [192.199.1.246])
 by alsa0.perex.cz (Postfix) with ESMTP id DD0A8265125
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 12:10:50 +0200 (CEST)
In-Reply-To: <20130712084200.GV24508@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 07/12/2013 04:42 PM, Mark Brown wrote:
> On Fri, Jul 12, 2013 at 03:00:26PM +0800, Bo Shen wrote:
>
>>    I try to add the following two line in wm8904_set_bias_level into
>> "case SND_SOC_BIAS_ON", it doesn't work.
>> ---8>---
>> @@ -1832,9 +1834,12 @@ static int wm8904_set_bias_level(struct
>> snd_soc_codec *codec,
>>
>>          switch (level) {
>>          case SND_SOC_BIAS_ON:
>> +               regcache_cache_only(wm8904->regmap, false);
>> +               regcache_sync(wm8904->regmap);
>>                  break;
>> ---<8---
>
> That's far too late to be doing that, the device is already supposed to
> be powered and running - you can see the device is doing this already in
> the transition from _OFF to _STANDBY which is where it should happen.
>
>>    However, If I comment the regcache_cache_only(wm8904->regmap,
>> true) as following, then it play OK.
>> ---8>---
>> @@ -2232,7 +2239,7 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
>>                              WM8904_POBCTRL, 0);
>>
>>          /* Can leave the device powered off until we need it */
>> -       regcache_cache_only(wm8904->regmap, true);
>> +       // regcache_cache_only(wm8904->regmap, true);
>> ---<8---
>
>>    So, any clue for this issue?
>
> The device is supposed to be idle_bias_off so sitting in _BIAS_OFF when
> not in use, this should mean a transition to _STANDBY as part of the
> power up sequence which should reenable interaction with the device.
> Check to see why that is not happening - _OFF should be the default bias
> level as well.
>

Do you mean the system boot up the device should be in _BIAS_OFF state?

I add debug info to set_bias_level function, and don't see this is 
called when system boot up. When I run aplay command, it call from 
_STANDBY to _ON, not _OFF, after show the error message, it call from 
_PREPARE to _OFF.

---8>---
# aplay 44.1k_16bit_stereo.wav
Playing WAVE '44.1k_16bit_stereo.wav' : Signed 16 bit Little Endian, 
Rate 44100 Hz, Stereo
 >>>>>> leve is: 1
 >>>>>> leve is: 2
 >>>>>> leve is: 3
aplay: pcm_write:1737: write error: Input/output error
# >>>>>> leve is: 2
 >>>>>> leve is: 1
 >>>>>> leve is: 0
---<8---

Best Regards,
Bo Shen
