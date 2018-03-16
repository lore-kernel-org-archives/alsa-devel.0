From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: alsalib and snd_pcm_hw_params_set_rate_minmax
Date: Fri, 16 Mar 2018 17:10:30 +0200
Message-ID: <50ae5d27-127e-17ad-e15a-2b4116d0d474@gmail.com>
References: <8f76589f-d64f-e6c2-db4a-57319e68ec3d@gmail.com>
 <084894a2-8107-05ab-6f6c-7418c505f3c4@sakamocchi.jp>
 <9cf1073b-97ec-a3f5-a08a-5c54f5d92c4a@gmail.com>
 <s5ho9jp79s7.wl-tiwai@suse.de>
 <d17e2fdd-d316-8bd7-351c-9e0446adafc1@gmail.com>
 <s5hefkl6q1s.wl-tiwai@suse.de>
 <43fb1d82-60e3-37af-961b-5d8819bf3cef@gmail.com>
 <s5hefkk3vt0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A57302670A1
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 16:10:33 +0100 (CET)
Received: by mail-lf0-f51.google.com with SMTP id z143-v6so9619372lff.3
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 08:10:33 -0700 (PDT)
In-Reply-To: <s5hefkk3vt0.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On 03/16/2018 05:05 PM, Takashi Iwai wrote:
> On Fri, 16 Mar 2018 11:17:19 +0100,
> Oleksandr Andrushchenko wrote:
>> +Konrad
>>
>> On 03/15/2018 10:29 PM, Takashi Iwai wrote:
>>> On Thu, 15 Mar 2018 14:39:33 +0100,
>>> Oleksandr Andrushchenko wrote:
>>>> On 03/15/2018 03:23 PM, Takashi Iwai wrote:
>>>>> On Thu, 15 Mar 2018 13:20:14 +0100,
>>>>> Oleksandr Andrushchenko wrote:
>>>>>> On 03/15/2018 01:59 PM, Takashi Sakamoto wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Mar 15 2018 19:45, Oleksandr Andrushchenko wrote:
>>>>>>>> Is it possible for user-space to reduce configuration space
>>>>>>>> with snd_pcm_hw_params_set_rate_minmax and then change it
>>>>>>>> with another snd_pcm_hw_params_set_rate_minmax with values
>>>>>>>> out of the reduced config?
>>>>>>>>
>>>>>>>> For example, the initial min/max is 44100/48000 and I set 44100
>>>>>>>> first, e.g.
>>>>>>>>
>>>>>>>> snd_pcm_hw_params_set_rate_minmax(handle, hw_params, 44100, 0, 44100, 0)
>>>>>>>>
>>>>>>>> and then want
>>>>>>>>
>>>>>>>> snd_pcm_hw_params_set_rate_minmax(handle, hw_params, 48000, 0, 48000, 0)
>>>>>>>>
>>>>>>>> Obviously, the last call fails as we have already a reduced
>>>>>>>> space of [44100; 44100].
>>>>>>>>
>>>>>>>> Is there a way I can still set the range to [48000; 48000]?
>>>>>>>>
>>>>>>>> Thank you,
>>>>>>>> Oleksandr
>>>>>>>>
>>>>>>>> P.S. This is in context of work done for [1]
>>>>>>>>
>>>>>>>> [1] https://www.spinics.net/lists/alsa-devel/msg75382.html
>>>>>>> We can't. Once shrinking available interval of a parameter, we cannot
>>>>>>> expand it again without initializing the parameter on memory object for
>>>>>>> 'struct snd_pcm_hw_params_t', in which actual layout is never disclosed
>>>>>>> to user applications.
>>>>>> So, this effectively means that this is a one way road, if you need to
>>>>>> change
>>>>>> some parameter you'll need to start all over, so the whole configuration
>>>>>> space remains consistent :(
>>>>> Yes, that's the design.  The only way to expand is to reset the whole,
>>>>> space and reduce again to the given size.
>>>>>
>>>> Clear, thank you
>>>>>>> If you can initialize whole the parameters, snd_pcm_hw_params_any() is
>>>>>>> available for your purpose, then set min/max rate again.
>>>>>> This is what I do now but...
>>>>>>> But just for
>>>>>>> one of the parameters, in my opinion, we need to open an internal
>>>>>>> API; snd_pcm_hw_param_any()[1].
>>>>>> IMO, this will lead to the false assumption that configuration is possible.
>>>>>> For example, I set 4 channels and 44100, but then, after
>>>>>> snd_pcm_hw_params_any,
>>>>>> set 48000 and might assume that the configuration is still
>>>>>> possible. But this may not
>>>>>> be true: it is true for the configuration returned by snd_pcm_hw_param_any
>>>>>> as we don't know about 4 channels yet. But might not be allowed if we
>>>>>> want 4 channels
>>>>>> and 48000 at the same time.
>>>>> Right.  At the point where snd_pcm_hw_params_any() is called, the
>>>>> whole configuration gets reset.  That's the reason I thought we may
>>>>> need to pass all 5 parameters in the query protocol.
>>>> Yes, I now start thinking of the same, e.g. if we pass
>>>> all 5 parameters (mask for formats and intervals for rate, channels,
>>>> buffer and period), then on backend side I can do something like:
>>>>
>>>> 1. snd_pcm_hw_params_any
>>>> 2. snd_pcm_hw_params_set_format_mask
>>>> 3. snd_pcm_hw_params_set_rate_minmax
>>>> 4. snd_pcm_hw_params_set_channels_minmax
>>>> 5. snd_pcm_hw_params_set_buffer_size_minmax
>>>> 6. snd_pcm_hw_params_set_period_size_minmax
>>>>
>>>> So, when finished the above confirms that configuration is possible.
>>>> The only concern here is that so many calls on backend side
>>>> might introduce start-up latency on frontend side though
>>>>
>>>>> IOW, the query stuff won't be modal, it just tries to reduce the given
>>>>> configuration space to the acceptable ranges.
>>>> Do you think the above solution with 5 parameters and the
>>>> corresponding snd_pcm_hw_params_set_xxx calls will do?
>>> I guess so, but let's model & test :)
>> I did some testing:
>> - frontend driver [1]
>> - sndif protocol [2]
>> - backend changes [3]
>>
>> All seem to work now when I pass all 5 parameters while querying.
>> The only scary thing is that I had to change the size of
>> requests/responses in the sndif protocol from 32 to 64 bytes :(
> You may split the protocol from a single shot to a sequence, too, if
> the size really matters :)
But this will complicate things, e.g. I'll have to collect
the whole thing from pieces before I can try applying the
configuration. What is more it will increase number of IO
operations between front and back by 5, thus increasing start up
latency
>> Takashi, could you please have a quick look and tell me if
>> this is what you expect?
> Through a quick glance, it looks good to me.
> If it works, even better.
Ok, thank you
>
> thanks,
>
> Takashi

Thank you,
Oleksandr
