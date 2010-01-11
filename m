From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: capturing data from the microphone
Date: Mon, 11 Jan 2010 15:03:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001111500470.4210@eeebox2.perex-int.cz>
References: <4B4227BC.70705@gmail.com>
	<6160a5131001050848r48f9c6ecw4db2e56bb6fd7533@mail.gmail.com>
	<4B43B949.5010702@gmail.com>
	<4f3252891001061559p71933643wcbb59ede24ac29aa@mail.gmail.com>
	<4B46293A.3040600@gmail.com> <4B4B2EA7.2080504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 735A21037FF
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 15:03:04 +0100 (CET)
In-Reply-To: <4B4B2EA7.2080504@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Riccardo Magliocchetti <riccardo.magliocchetti@gmail.com>
Cc: pl bossart <bossart.nospam@gmail.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Jan 2010, Riccardo Magliocchetti wrote:

> Riccardo Magliocchetti ha scritto:
>> Raymond Yau ha scritto:
>>> 2010/1/6 Riccardo Magliocchetti <riccardo.magliocchetti@gmail.com>
>>>
>>>> Hi Pierre,
>>>>
>>>> pl bossart ha scritto:
>>>>> You haven't specified the buffer/period size in the hw params. See
>>>>> alsa-lib/test/pcm.c
>>>>> - Pierre
>>>> They fail when opening default device so I had to remove them, work fine
>>>> when opening
>>>> plughw:0,0 though.
>>>>
>>>>> On Mon, Jan 4, 2010 at 11:39 AM, Riccardo Magliocchetti
>>>>> <riccardo.magliocchetti@gmail.com> wrote:
>>>>>> [the same message is waiting in moderator queue, sorry if you
>>>>>> receive it
>>>> two times]
>>>>>> Hello,
>>>>>>
>>>>>> i'm trying to capture audio data from the microphone, but i'm not able
>>>> to
>>>>>> read any frames.
>>>>>> The frames are always 0 and delay is fixed to 2730. I've tried calling
>>>>>> snd_pcm_avail_delay,  snd_pcm_avail_update but does not make a
>>>> difference.
>>>>>> The soundcard is driven by  snd_hda_intel. The code is more or less
>>>>>> the
>>>>>> same as Paul Davis' tutorial on using the alsa api.
>>
>>>
>>> Even 4096 bytes is x86 DMA page size , seem to be a good choice for those
>>> PCI sound cards, however you cannot assume all sound cards/plugins
>>> support
>>> this buffer size
>>>
>>> If you did not set period_size, buffer_size or periods (period_time,
>>> buffer_time or periods)  , you should call
>>> snd_pcm_hw_params_get_buffer_size() and
>>> snd_pcm_hw_params_get_period_size()
>>> after snd_pcm_hw_params()
>>
>> Thank you both Pierre and Raymond, using the get functions after
>> snd_pcm_hw_params() is working, now i have some concurrency issues to
>> resolve before i can say everything is working properly.
>
> The init works fine but snd_pcm_avail() always returns 0, full code is here
> http://pastebin.com/f687bf37a

The PCM stream must be triggered via snd_pcm_start() or using 
snd_pcm_read*() when sw_param->start_threshold is set appropriately.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
