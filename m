From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dt: binding: sound cs42l52 driver
Date: Wed, 13 Nov 2013 14:24:26 -0600
Message-ID: <alpine.DEB.2.10.1311131419450.28828@heelrod.ad.cirrus.com>
References: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com> <2417485.xV8Ic1G59x@flatron> <alpine.DEB.2.10.1311131306150.28828@heelrod.ad.cirrus.com> <4248019.0NvEHjb6IO@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4248019.0NvEHjb6IO@flatron>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On Wed, 13 Nov 2013, Tomasz Figa wrote:

> On Wednesday 13 of November 2013 13:10:51 Brian Austin wrote:
>> On Wed, 13 Nov 2013, Tomasz Figa wrote:
>>
>>>>>> +		 0x00 through 0x0F.
>>>>>> +		 Frequency = (64xFs)/(N+2)
>>>>>
>>>>> I suppose N means the value of chgfreq property here, but this should be
>>>>> clearly stated. Same for Fs - I suppose it is sampling frequency, but
>>>>> is it default, minimum, maximum or maybe something else?
>>>>>
>>>> Frequency = (64xFs)/(N+2)
>>>> N = chgfreq value
>>>> Fs = sample rate
>>>
>>> As I mentioned in second part of my comment, is it default, minimum,
>>> maximum or what kind of sample rate? Or is the sample rate fixed?
>>>
>> ah! Sorry, the rate is fixed for the stream. So it varies for what rate is
>> being used.
>>
>
> OK, so the charge pump frequency varies with sampling rate. Well, I guess
> that's fine to provide a raw register value then. The name is still a bit
> misleading, though.
>
> Maybe calling it cirrus,chgfreq-divisor would be better instead? Also the
> description in binding documentation should explicitly state that it's the
> raw value that needs to be written to the CHGFREQ register.
>

Will do,
Thanks
>>>>>> +  - mica-sel   : MIC A single ended input select.  For Single-Ended
>>>>>> +		 configuration, select which MIC to use.
>>>>>> +		 0x00 = MIC1
>>>>>> +		 0x01 = MIC2
>>>>>> +  - micb-sel   : MIC B single ended input select.  For Single-Ended
>>>>>> +		 configuration, select which MIC to use.
>>>>>> +		 0x00 = MIC1
>>>>>> +		 0x01 = MIC2
>>>>>
>>>>> Could you explain what are MIC A, MIC B, MIC1 and MIC2?
>>>>>
>>>> I can add a little more but it is best explained in the datasheet. I can
>>>> add a little more explaination and reference the datasheet section. I feel
>>>> this file might be the wrong place to go into too much depth of the pieces
>>>> of the device when the datasheet could be referenced. Would a reference be
>>>> OK?
>>>>
>>>
>>> I meant just explaining to me, for the purpose of this review. However it
>>> seems like the datasheet is publicly available, so let me just check this
>>> there.
>>>
>> Sorry about that.
>>
>> The CS42L52 has multiple input selections for microphones. Single-ended
>> and differential inputs are allowed for both Left Channel (MICA) and Right
>> Channel (MICB). The +- pins can be used for stereo or mono mics.
>
> OK. After looking at the datasheet for a bit, I'm pretty much convinced
> that these two properties should be rather represented as mixer controls
> instead, for the purpose of channel mixing.
>
> Whether the "Mic X Sel" control would be present in the mixer or not would
> be implied by mic-X-differential property in DT.

That sounds reasonable and yes, the config would be static but you
could have cases where you switch which mic to use as the input to the
PGA.

Thanks for the review,
Brian

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
