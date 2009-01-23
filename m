From: Cristian Morales Vega <cmorve69@yahoo.es>
Subject: Re: snd_pcm_avail_update() needed before
	snd_pcm_delay() with hda-intel
Date: Fri, 23 Jan 2009 13:14:58 +0100
Message-ID: <8235e6f40901230414s18fc6042se7f79075a1f3a51d@mail.gmail.com>
References: <8235e6f40806061254v41604524l4e43647482602098@mail.gmail.com>
	<75b66ecd0806061746r1f542ed2i6c966465c1475152@mail.gmail.com>
	<s5hprqn0xv6.wl%tiwai@suse.de>
	<8235e6f40806121132h4dd900f1u250ddeac318f659e@mail.gmail.com>
	<s5hd4mg9shc.wl%tiwai@suse.de>
	<8235e6f40806171227y4141c6ceqa0e8269810c88b9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.241])
	by alsa0.perex.cz (Postfix) with ESMTP id DFEAA24402
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 13:14:59 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so4545213rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 04:14:58 -0800 (PST)
In-Reply-To: <8235e6f40806171227y4141c6ceqa0e8269810c88b9e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/6/17 Christian Morales Vega <cmorve69@yahoo.es>:
> 2008/6/17 Takashi Iwai <tiwai@suse.de>:
>> At Thu, 12 Jun 2008 20:32:51 +0200,
>> Christian Morales Vega wrote:
>>>
>>> 2008/6/12 Takashi Iwai <tiwai@suse.de>:
>>> > It's unlikely a driver issue but an incompatibility of dmix, I guess.
>>> > But still I don't figure out why this happens.  The hwsync is done at
>>> > each snd_pcm_dmix_delay() call (as long as slowptr is set, and it's so
>>> > as default).  So, there shouldn't be any difference...
>>> >
>>> > What happens if you use "hw" or "plughw"?
>>> With both plughw and hw works fine.
>>>
>>> If helps, I have simplified the problematic bsnes code into this:
>>
>> The program looks running fine on my machine with another HD-audio
>> codec.  What is expected in the output and how wrong on yours?
>
> I knew I should not put it under the code :-p
> "The listened effect is that when fails you listen the noise for just
> buffer_time, and when works the noise never ends."
>
> So the output with the SB Live! is:
> State: 2
> Delay: 0
> Passed
> State: 2
> Delay: 882
> Passed
> State: 2
> Delay: 1764
> Passed
> State: 2
> Delay: 2646
> Passed
> State: 2
> Delay: 3528
> Passed
> State: 3
> Delay: 4410
> Delay/Goal: 4410/3528
> State: 3
> Delay: 4410
> Delay/Goal: 4410/3528
> State: 3
> Delay: 4410
> Delay/Goal: 4410/3528
> State: 3
> Delay: 4410
> Delay/Goal: 4410/3528
> State: 3
> Delay: 4409
> Delay/Goal: 4409/3528
>
> and so until delay reaches 3528, when a new snd_pcm_writei() is done.
>
> With the AD1988 the buffer is fulled one time. After that never again
> reaches snd_pcm_writei(). The output is:
> State: 2
> Delay: 0
> Passed
> State: 2
> Delay: 940
> Passed
> State: 2
> Delay: 1880
> Passed
> State: 2
> Delay: 2820
> Passed
> State: 2
> Delay: 3760
> Passed
> State: 3
> Delay: 4700
> Delay/Goal: 4700/3764
> State: 3
> Delay: 4700
> Delay/Goal: 4700/3764
> State: 3
> Delay: 4700
> Delay/Goal: 4700/3764
>
> and so. Delay never decreases. But after some time you see.
> State: 4
> Delay: 4700
> Delay/Goal: 4700/3764
>
> There has been an underrun even if appl_ptr is 4700 frames ahead of hw_ptr???
> If you uncomment snd_pcm_avail_update() delay decreases and everything is ok.
>

I still have the same problem with alsa-1.0.19.git20090122-1.1 and
alsa-driver-kmp-default-1.0.19.20090123_2.6.27.7_9.1-3.1 on openSUSE
11.1. Exactly same behavior: works with emu10k1, works with plughw...
only doesn't works when using AD1988 and "default:1" device.

Also reading Lennart Poettering discussion about snd_pcm_avail_update,
snd_pcm_delay, etc I see bsnes is wrongly using snd_pcm_delay(). But I
don't understand the snd_pcm_avail() vs snd_pcm_avail_update(). If
snd_pcm_avail_update() doesn't calls hwsync the info it will return
will be outdated/unuseful, will not? And how it is a call to
snd_pcm_avail_update() fixes the problem I'm having here with
snd_pcm_delay()? My problem isn't precisely the lack of a hwsync in
snd_pcm_delay()?
In snd_pcm_avail_update() doc: "The position is not synced with
hardware (driver) position in the sound ring buffer in this function."
isn't a contradiction with "Also this function might be called after
snd_pcm_delay() or snd_pcm_hwsync() functions to move private ring
buffer pointers in alsa-lib (the internal plugin chain)."? Probably
I'm missunderstanding something. If snd_pcm_avail_update() isn't
updating the same thing that snd_pcm_hwsync(), what it is updating?
