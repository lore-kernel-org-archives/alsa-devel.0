From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [BUG] sound: pci: trident: a possible data race
Date: Thu, 4 Oct 2018 11:08:45 +0800
Message-ID: <e334c065-5768-7710-bd70-059f7316157b@gmail.com>
References: <864e211c-8be5-6a34-902a-a71f176111db@gmail.com>
 <s5hk1mzowkd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk1mzowkd.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: keescook@chromium.org, perex@perex.cz, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks for the reply :)


On 2018/10/3 23:54, Takashi Iwai wrote:
> On Wed, 03 Oct 2018 14:50:25 +0200,
> Jia-Ju Bai wrote:
>> CPU0:
>> snd_trident_hw_free
>>      snd_trident_free_voice
>>              line 3870: spin_lock_irqsave()
>>              line 3881: voice->substream = NULL; [WRITE]
>> CPU1:
>> snd_trident_interrupt
>>      line 3798: snd_pcm_period_elapsed(voice->substream);  [READ]
>>
>> As for voice->substream, the WRITE operation in CPU0 is performed
>> with holding a spinlock, but the READ operation in CPU1 is performed
>> without holding this spinlock, so there may exist a data race.
> Thanks for the report.
>
> The actual crash must be very unlikely, almost 0%, though.
> snd_trident_hw_free() is called always after the PCM stream gets
> stopped via trigger callback, i.e. at the moment, there is no
> corresponding interrupt is generated for that voice entry.

How about the case that playback and capture are performed concurrently?
Namely, snd_trident_hw_free() is called for playback, and the interrupt 
is generated for capture.

> And the hardware is very old, I bet only a handful people still using
> in the whole world :)

I have this hardware, so I am the one of these handful people ;)


Best wishes,
Jia-Ju Bai
