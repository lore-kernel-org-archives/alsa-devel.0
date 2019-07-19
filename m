From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v5 2/6] ASoC: sgtl5000: Improve VAG power and mute control
Date: Fri, 19 Jul 2019 09:19:10 +0200
Message-ID: <3c153dcc-e656-2959-6281-15cc895660e0@intel.com>
References: <20190718090240.18432-1-oleksandr.suvorov@toradex.com>
 <20190718090240.18432-3-oleksandr.suvorov@toradex.com>
 <9c9ee47c-48bd-7109-9870-8f73be1f1cfa@intel.com>
 <a86e4d6b-ed2c-d2f2-2974-6f00dc6ef68a@intel.com>
 <CAGgjyvGboMPx5wKJ_1DaeYZazSHmQUGwDZHoCBt5vhpVq3Q_bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAGgjyvGboMPx5wKJ_1DaeYZazSHmQUGwDZHoCBt5vhpVq3Q_bA@mail.gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Igor Opaniuk <igor.opaniuk@toradex.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Sasha Levin <sashal@kernel.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2019-07-19 09:09, Oleksandr Suvorov wrote:
> On Thu, 18 Jul 2019 at 21:49, Cezary Rojewski <cezary.rojewski@intel.com> wrote:
>>
>> On 2019-07-18 20:42, Cezary Rojewski wrote:
>>> On 2019-07-18 11:02, Oleksandr Suvorov wrote:
>>>> +enum {
>>>> +    HP_POWER_EVENT,
>>>> +    DAC_POWER_EVENT,
>>>> +    ADC_POWER_EVENT,
>>>> +    LAST_POWER_EVENT
>>>> +};
>>>> +
>>>> +static u16 mute_mask[] = {
>>>> +    SGTL5000_HP_MUTE,
>>>> +    SGTL5000_OUTPUTS_MUTE,
>>>> +    SGTL5000_OUTPUTS_MUTE
>>>> +};
>>>
>>> If mute_mask[] is only used within common handler, you may consider
>>> declaring const array within said handler instead (did not check that
>>> myself).
>>> Otherwise, simple comment for the second _OUTPUTS_MUTE should suffice -
>>> its not self explanatory why you doubled that mask.
> 
> Ok, I'll add a comment to explain doubled mask.
> 
>>>
>>>> +
>>>>    /* sgtl5000 private structure in codec */
>>>>    struct sgtl5000_priv {
>>>>        int sysclk;    /* sysclk rate */
>>>> @@ -137,8 +157,109 @@ struct sgtl5000_priv {
>>>>        u8 micbias_voltage;
>>>>        u8 lrclk_strength;
>>>>        u8 sclk_strength;
>>>> +    u16 mute_state[LAST_POWER_EVENT];
>>>>    };
>>>
>>> When I spoke of LAST enum constant, I did not really had this specific
>>> usage in mind.
>>>
>>>   From design perspective, _LAST_ does not exist and should never be
>>> referred to as "the next option" i.e.: new enum constant.
> 
> By its nature, LAST_POWER_EVENT is actually a size of the array, but I
> couldn't come up with a better name.
> 
>>> That is way preferred usage is:
>>> u16 mute_state[ADC_POWER_EVENT+1;
>>> -or-
>>> u16 mute_state[LAST_POWER_EVENT+1];
>>>
>>> Maybe I'm just being radical here :)
> 
> Maybe :)  I don't like first variant (ADC_POWER_EVENT+1): somewhen in
> future, someone can add a new event to this enum and we've got a
> possible situation with "out of array indexing".
> 
>>>
>>> Czarek
>>
>> Forgive me for double posting. Comment above is targeted towards:
>>
>>   >> +enum {
>>   >> +    HP_POWER_EVENT,
>>   >> +    DAC_POWER_EVENT,
>>   >> +    ADC_POWER_EVENT,
>>   >> +    LAST_POWER_EVENT
>>   >> +};
>>
>> as LAST_POWER_EVENT is not assigned explicitly to ADC_POWER_EVENT and
>> thus generates implicit "new option" of value 3.
> 
> So will you be happy with the following variant?
> ...
>      ADC_POWER_EVENT,
>      LAST_POWER_EVENT =  ADC_POWER_EVENT,
> ...
>     u16 mute_state[LAST_POWER_EVENT+1];
> ...
> 

It's not about being happy - I'm a happy man in general ;p

As stated already, declaring _LAST_ as the "new option" is misleading 
and not advised.
And yeah, [_LAST_ + 1] is usually the one you should go with.

Czarek
