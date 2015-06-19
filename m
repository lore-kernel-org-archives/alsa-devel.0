From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Audio Driver Works In Ubuntu but Crash in Debian
	After 2nd Run
Date: Fri, 19 Jun 2015 14:56:33 +0900
Message-ID: <5583AF11.70503@sakamocchi.jp>
References: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>
 <557FD536.3020906@ladisch.de>
 <CA+k7WwZqBc9CyE0DpYnSW7ZVc6otZ8dJQ+9rtUXAsrKyv2j_nA@mail.gmail.com>
 <55812940.5050906@ladisch.de> <1434531934.2471.9.camel@loki>
 <CA+k7WwbSt-sxQePXx=A=2LJgNS2OPTrZQFhHcD2g02HM0P7NYg@mail.gmail.com>
 <CA+k7Wwb7i5n9dgGGVgkgbOpFC-+tsQnehMgkPLCnOebH5AE4oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1BF2604F3
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 07:56:36 +0200 (CEST)
In-Reply-To: <CA+k7Wwb7i5n9dgGGVgkgbOpFC-+tsQnehMgkPLCnOebH5AE4oA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Azizul Hakim <azizulfahim2002@gmail.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 19 2015 13:32, Azizul Hakim wrote:
> Now during the 2nd playback, the driver initializes the buffer pointer to
> "0" again inside the *.prepare* function. And then I see it calls the
> *.pointer* function only once and afterwards stop with the error message *ALSA
> sound/core/pcm_lib.c:1910 playback write error (DMA or IRQ trouble?)*

When you see this log with playback PCM application, it means that 'the 
application is running in blocking-mode (O_NONBLOCK) with 
no-period-wakeup mode, and the blocking continues during 10 seconds'.
(when period-size is too large, it continues longer than 10 seconds.)

The blocking mode is released by several cues, but in this case I think
we should focus on calling 'snd_pcm_period_elapsed()'. In ALSA PCM 
driver, calling this function changes PCM ringbuffer status, then 
releases the blocking state in some conditions.

Therefore, we can judge that your driver may call no 
'snd_pcm_period_elapsed()' because receiving no 'struct urb.complete()' 
callback.

I think you should check your 'beagleaudio_audio_start()' function and 
confirm whether it can set/release USB subsystem correctly.

Additionally, I reccomend you to use URB monitor in runtime to see your 
driver can transmit URBs in second playbacking. (In my memory, Wireshark 
has the functionality.)

> So I stopped initializing the buffer pointer to "0" during the second
> playback assuming that the buffer pointer should stay at the place it
> stopped from previous playback. But that also didn't work for me. I get the
> same error message. Note that same driver works on Ubuntu without any
> problem and as many times as I want.

The zero-reset is needed, I think.

In your driver, 'struct beagleaudio.snd_buffer_pos' and 'struct 
beagleaudio.snd_period_pos' are used to count the number of PCM frames 
in a period or a buffer.

They're an alternative representation of ALSA PCM rung-buffer status, 
and no need to keep the state in different PCM runtimes. It's good to 
reset them before PCM substream is running. (typically, done in 'struct 
snd_pcm_ops.prepare()' callback).

# I note that I'm not good at USB subsystem and USB Audio Device Class.
# My comments come from general knowledgement about ALSA PCM core.


Regards

Takashi Sakamoto
