From: "Christian Morales Vega" <cmorve69@yahoo.es>
Subject: Re: snd_pcm_avail_update() needed before
	snd_pcm_delay() with hda-intel
Date: Tue, 17 Jun 2008 21:27:56 +0200
Message-ID: <8235e6f40806171227y4141c6ceqa0e8269810c88b9e@mail.gmail.com>
References: <8235e6f40806061254v41604524l4e43647482602098@mail.gmail.com>
	<75b66ecd0806061746r1f542ed2i6c966465c1475152@mail.gmail.com>
	<s5hprqn0xv6.wl%tiwai@suse.de>
	<8235e6f40806121132h4dd900f1u250ddeac318f659e@mail.gmail.com>
	<s5hd4mg9shc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DDC624695
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 21:27:57 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so4130188wag.8
	for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2008 12:27:56 -0700 (PDT)
In-Reply-To: <s5hd4mg9shc.wl%tiwai@suse.de>
Content-Disposition: inline
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

2008/6/17 Takashi Iwai <tiwai@suse.de>:
> At Thu, 12 Jun 2008 20:32:51 +0200,
> Christian Morales Vega wrote:
>>
>> 2008/6/12 Takashi Iwai <tiwai@suse.de>:
>> > It's unlikely a driver issue but an incompatibility of dmix, I guess.
>> > But still I don't figure out why this happens.  The hwsync is done at
>> > each snd_pcm_dmix_delay() call (as long as slowptr is set, and it's so
>> > as default).  So, there shouldn't be any difference...
>> >
>> > What happens if you use "hw" or "plughw"?
>> With both plughw and hw works fine.
>>
>> If helps, I have simplified the problematic bsnes code into this:
>
> The program looks running fine on my machine with another HD-audio
> codec.  What is expected in the output and how wrong on yours?

I knew I should not put it under the code :-p
"The listened effect is that when fails you listen the noise for just
buffer_time, and when works the noise never ends."

So the output with the SB Live! is:
State: 2
Delay: 0
Passed
State: 2
Delay: 882
Passed
State: 2
Delay: 1764
Passed
State: 2
Delay: 2646
Passed
State: 2
Delay: 3528
Passed
State: 3
Delay: 4410
Delay/Goal: 4410/3528
State: 3
Delay: 4410
Delay/Goal: 4410/3528
State: 3
Delay: 4410
Delay/Goal: 4410/3528
State: 3
Delay: 4410
Delay/Goal: 4410/3528
State: 3
Delay: 4409
Delay/Goal: 4409/3528

and so until delay reaches 3528, when a new snd_pcm_writei() is done.

With the AD1988 the buffer is fulled one time. After that never again
reaches snd_pcm_writei(). The output is:
State: 2
Delay: 0
Passed
State: 2
Delay: 940
Passed
State: 2
Delay: 1880
Passed
State: 2
Delay: 2820
Passed
State: 2
Delay: 3760
Passed
State: 3
Delay: 4700
Delay/Goal: 4700/3764
State: 3
Delay: 4700
Delay/Goal: 4700/3764
State: 3
Delay: 4700
Delay/Goal: 4700/3764

and so. Delay never decreases. But after some time you see.
State: 4
Delay: 4700
Delay/Goal: 4700/3764

There has been an underrun even if appl_ptr is 4700 frames ahead of hw_ptr???
If you uncomment snd_pcm_avail_update() delay decreases and everything is ok.
