From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_set_params faild on set_buffer_time_near
	and set_period_time_near
Date: Sat, 25 Jul 2015 10:01:30 +0800
Message-ID: <CAN8ccibJoih-XhbySf4KPKyvQjQRuZ53g60d_BmODRAvvyZdqg@mail.gmail.com>
References: <55AE0831.2010206@streamunlimited.com>
 <s5htwsvwawr.wl-tiwai@suse.de>
 <55B1EEAE.3080307@streamunlimited.com>
 <s5h8ua6vude.wl-tiwai@suse.de>
 <55B21E9C.9010506@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id E2CEF26064C
 for <alsa-devel@alsa-project.org>; Sat, 25 Jul 2015 04:01:31 +0200 (CEST)
Received: by obre1 with SMTP id e1so26617706obr.1
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 19:01:31 -0700 (PDT)
In-Reply-To: <55B21E9C.9010506@streamunlimited.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Geier <martin.geier@streamunlimited.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2015-07-24 19:16 GMT+08:00 Martin Geier <martin.geier@streamunlimited.com>:

> Patch with fixed name and description.
>
> Martin
>
>
>
> On 24.07.2015 10:21, Takashi Iwai wrote:
>
>> On Fri, 24 Jul 2015 09:52:14 +0200,
>> Martin Geier wrote:
>>
>>> Thanks for help,
>>>
>>> in attachment is patch with suggest change.
>>> Is the patch acceptable?
>>>
>> I prefer a bit clearer name like params_saved or such, but yes, it's
>> what I had in my mind, too.  Could you tidy it up and resubmit with
>> the more description -- why it's needed and what does it?  Last but
>> not least, it'd be helpful if you give also signed-off-by tag.
>>
>>
>> thanks,
>>
>> Takashi
>>
>>  Martin
>>>
>>> On 23.07.2015 10:11, Takashi Iwai wrote:
>>>
>>>> On Tue, 21 Jul 2015 10:52:01 +0200,
>>>> Martin Geier wrote:
>>>>
>>>>> Hallo,
>>>>>
>>>>> I tried to configure alsa device with snd_pcm_set_params function,
>>>>> requested
>>>>> parameters was:
>>>>> channel 2, rate: 22050, soft_resample: 1, latency: 50000
>>>>>
>>>>> Function snd_pcm_hw_params_set_buffer_time_near and
>>>>> snd_pcm_hw_param_set_near
>>>>> is called with:
>>>>> min: 50000, max: 50000, mindir: 0, maxdir: -1
>>>>>
>>>>> and input params was:
>>>>>
>>>>> ACCESS:  RW_INTERLEAVED
>>>>> FORMAT:  S16_LE
>>>>> SUBFORMAT:  STD
>>>>> SAMPLE_BITS: 16
>>>>> FRAME_BITS: 32
>>>>> CHANNELS: 2
>>>>> RATE: 22050
>>>>> PERIOD_TIME: (362 743039)
>>>>> PERIOD_SIZE: [8 16384]
>>>>> PERIOD_BYTES: [32 65536]
>>>>> PERIODS: [2 19]
>>>>> BUFFER_TIME: (725 1486078)
>>>>> BUFFER_SIZE: [16 32768]
>>>>> BUFFER_BYTES: [64 131072]
>>>>> TICK_TIME: ALL
>>>>>
>>>>> unfortunately, this function fails, on function
>>>>> snd_pcm_hw_param_set_first:
>>>>>
>>>>> ALSA ERROR hw_params: set_near (BUFFER_TIME)
>>>>>               value = 50000 : Invalid argument
>>>>> ACCESS:  RW_INTERLEAVED
>>>>> FORMAT:  S16_LE
>>>>> SUBFORMAT:  STD
>>>>> SAMPLE_BITS: 16
>>>>> FRAME_BITS: 32
>>>>> CHANNELS: 2
>>>>> RATE: 22050
>>>>> PERIOD_TIME: (4580 5533)
>>>>> PERIOD_SIZE: NONE
>>>>> PERIOD_BYTES: [404 488]
>>>>> PERIODS: 10
>>>>> BUFFER_TIME: (50022 50023)
>>>>> BUFFER_SIZE: 1103
>>>>> BUFFER_BYTES: 4412
>>>>> TICK_TIME: ALL
>>>>>
>>>>> This shouldn't be problem because in snd_pcm_set_params is
>>>>> snd_pcm_hw_params_set_period_time_near called.
>>>>> This function should be called with same params as
>>>>> snd_pcm_hw_params_set_buffer_time_near
>>>>> but the input params are:
>>>>>
>>>>> snd_pcm_hw_param_set_near: min: 12500, max: 12500, mindir: 0, maxdir:
>>>>> -1
>>>>> hw_params: snd_pcm_hw_param_set_near (PERIOD_TIME)
>>>>> ACCESS:  RW_INTERLEAVED
>>>>> FORMAT:  S16_LE
>>>>> SUBFORMAT:  STD
>>>>> SAMPLE_BITS: 16
>>>>> FRAME_BITS: 32
>>>>> CHANNELS: 2
>>>>> RATE: 22050
>>>>> PERIOD_TIME: (4580 5533)
>>>>> PERIOD_SIZE: NONE
>>>>> PERIOD_BYTES: [404 488]
>>>>> PERIODS: 10
>>>>> BUFFER_TIME: (50022 50023)
>>>>> BUFFER_SIZE: 1103
>>>>> BUFFER_BYTES: 4412
>>>>> TICK_TIME: ALL
>>>>>
>>>>

What is the period time and buffer time after applied your patch ?

Are latency always <= 50ms ?
