From: Riccardo Magliocchetti <riccardo.magliocchetti@gmail.com>
Subject: Re: capturing data from the microphone
Date: Thu, 07 Jan 2010 19:34:34 +0100
Message-ID: <4B46293A.3040600@gmail.com>
References: <4B4227BC.70705@gmail.com>	<6160a5131001050848r48f9c6ecw4db2e56bb6fd7533@mail.gmail.com>	<4B43B949.5010702@gmail.com>
	<4f3252891001061559p71933643wcbb59ede24ac29aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id B7E451037FC
	for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2010 19:34:38 +0100 (CET)
Received: by bwz9 with SMTP id 9so28692295bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 07 Jan 2010 10:34:37 -0800 (PST)
In-Reply-To: <4f3252891001061559p71933643wcbb59ede24ac29aa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau ha scritto:
> 2010/1/6 Riccardo Magliocchetti <riccardo.magliocchetti@gmail.com>
> 
>> Hi Pierre,
>>
>> pl bossart ha scritto:
>>> You haven't specified the buffer/period size in the hw params. See
>>> alsa-lib/test/pcm.c
>>> - Pierre
>> They fail when opening default device so I had to remove them, work fine
>> when opening
>> plughw:0,0 though.
>>
>>> On Mon, Jan 4, 2010 at 11:39 AM, Riccardo Magliocchetti
>>> <riccardo.magliocchetti@gmail.com> wrote:
>>>> [the same message is waiting in moderator queue, sorry if you receive it
>> two times]
>>>> Hello,
>>>>
>>>> i'm trying to capture audio data from the microphone, but i'm not able
>> to
>>>> read any frames.
>>>> The frames are always 0 and delay is fixed to 2730. I've tried calling
>>>> snd_pcm_avail_delay,  snd_pcm_avail_update but does not make a
>> difference.
>>>> The soundcard is driven by  snd_hda_intel. The code is more or less the
>>>> same as Paul Davis' tutorial on using the alsa api.

> 
> Even 4096 bytes is x86 DMA page size , seem to be a good choice for those
> PCI sound cards, however you cannot assume all sound cards/plugins support
> this buffer size
> 
> If you did not set period_size, buffer_size or periods (period_time,
> buffer_time or periods)  , you should call
> snd_pcm_hw_params_get_buffer_size() and snd_pcm_hw_params_get_period_size()
> after snd_pcm_hw_params()

Thank you both Pierre and Raymond, using the get functions after snd_pcm_hw_params() is 
working, now i have some concurrency issues to resolve before i can say everything is 
working properly.

Thanks again,
riccardo
