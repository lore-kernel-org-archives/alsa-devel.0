From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Thu, 10 Dec 2009 08:27:33 -0600
Message-ID: <6160a5130912100627t4d62397dp654c9bcb84ade617@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<4f3252890912021826g732292ecv8959a7cfbf574446@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
	<4f3252890912041817u7ab83a3eh7643476d64d709f3@mail.gmail.com>
	<s5h4oo1sisn.wl%tiwai@suse.de>
	<4f3252890912090355n70a2b5cfu4fbb74d473480a94@mail.gmail.com>
	<s5hr5r4ntus.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id 7E3F52434A
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 15:27:34 +0100 (CET)
Received: by pwi18 with SMTP id 18so1255547pwi.32
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 06:27:33 -0800 (PST)
In-Reply-To: <s5hr5r4ntus.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,
I tested with .periods_min=2 and reduced the period_max by half. The
underruns reported by PulseAudio are no longer present with this
modification.
However, there's still something fishy here. In both cases, with 1 or
2 periods, PulseAudio seems to wake-up more often than it should with
snd_pcm_poll_descriptors_revents returning a null event. See the
sequence below. Not sure if the problem is a bad configuration of the
timers of if the driver generates these events?
I also noticed that the underrun reported with a single period are
associated with the POLLOUT revent. I am not sure this is normal?
Thanks for your feedback.
- Pierre

D: alsa-sink.c: Waking up in 157.78ms (system clock).
>> WAKEUP
E: alsa-sink.c: snd_pcm_poll_descriptors_revents() returned zero
D: alsa-sink.c: Loop
D: alsa-sink.c: Buffer time: 371 ms; Sleep time: 321 ms; Process time: 50 ms
D: alsa-sink.c: avail: 1076 (samples 269)
>> This is not consistent, there are too few samples in the buffer
D: alsa-sink.c: 365.42 ms left to play; inc threshold = 0.00 ms; dec
threshold = 100.00 ms
D: alsa-sink.c: Not filling up, because too early.
>> go back to sleep
D: alsa-sink.c: Waking up in 157.71ms (system clock).
>> WAKEUP
E: alsa-sink.c: snd_pcm_poll_descriptors_revents() returned zero
D: alsa-sink.c: Loop
D: alsa-sink.c: Buffer time: 371 ms; Sleep time: 321 ms; Process time: 50 ms
D: alsa-sink.c: avail: 1136 (samples 284)
>> again the buffer is still almost full and we have nothing to do
D: alsa-sink.c: 365.08 ms left to play; inc threshold = 0.00 ms; dec
threshold = 100.00 ms
D: alsa-sink.c: Not filling up, because too early.
