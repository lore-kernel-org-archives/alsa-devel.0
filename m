From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 23/25] ALSA/dummy: Replace tasklet with
	softirq hrtimer
Date: Sat, 2 Sep 2017 10:19:45 +0900
Message-ID: <19775981-a3f2-5f65-e934-bfe25db62a43@sakamocchi.jp>
References: <s5hh8wnvjei.wl-tiwai@suse.de>
 <20170901102537.8066-1-o-takashi@sakamocchi.jp>
 <s5hbmmutytt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 4BDF9266BA4
 for <alsa-devel@alsa-project.org>; Sat,  2 Sep 2017 03:19:53 +0200 (CEST)
In-Reply-To: <s5hbmmutytt.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, keescook@chromium.org, peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, john.stultz@linaro.org, tglx@linutronix.de, hch@lst.org, anna-maria@linutronix.de
List-Id: alsa-devel@alsa-project.org

On p 1 2017 20:58, Takashi Iwai wrote:
>> >From 07d61ba2a1c0e06e914443225e194d99f2d8c58d Mon Sep 17 00:00:00 2001
>> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> Date: Fri, 1 Sep 2017 19:10:18 +0900
>> Subject: [PATCH] ALSA: dummy: avoid stall due to a call of hrtimer_cancel() on
>>   a callback of hrtimer
>>
>> A call of 'htrimer_cancel()' on a callback of hrtimer brings endless loop
>> because 'struct hrtimer_clock_base.running' is not NULL on the callback.
>> In hrtimer subsystem, this member is used to indicate the instance of
>> hrtimer gets callbacks and there's a helper function,
>> 'hrtimer_callback_running()' to check it.
>>
>> ALSA dummy driver uses hrtimer to emulate hardware interrupt per period
>> of PCM buffer. When XRUN occurs on PCM substream, in a call of
>> 'snd_pcm_period_elapsed()', 'struct snd_pcm_ops.stop()' is called to
>> stop the substream. In current implementation, 'hrtimer_cancel()' is
>> used to wait for cancellation of hrtimer. However, as described, this
>> brings endless loop.
> 
> It's not only about XRUN.  When the stream finishes the draining, it
> stops the stream gracefully -- that is the very normal operation.

I overlooked it. Thanks for your indication.

>> For this problem, this commit uses 'hrtimer_callback_running()' to
>> detect whether to be on a callback of hrtimer or not, then skip
>> cancellation of hrtimer in hrtimer callbacks. Furthermore, at a case of
>> XRUN, hrtimer callback returns HRTIMER_NORESTART after a call of
>> 'snd_pcm_period_elapsed()' to discontinue hrtimr because cancellation is
>> skipped.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> It's better to fold the fix into the original patch instead of
> introducing a bug and fixing it.

Yep. I request the authors to include this fix.


Well, in sound subsystem, there're a few drivers which uses hrtimer:
  - snd-pcsp
  - snd-sh-dac-audio
  - snd-soc-imx-pcm-fiq

As a quick glance, 'snd-sh-dac-audio' includes the same bug, too. 
Additionally, 'snd-soc-imx-pcm-fiq' maintains hrtimer with loose manner 
in a point of state of PCM substream and it shall gain the same bug if 
improved. Later, I posted some patches for them.


Thanks

Takashi Sakamoto
