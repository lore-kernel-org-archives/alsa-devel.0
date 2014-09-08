From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Master Plan on rewinding
Date: Mon, 08 Sep 2014 09:34:07 +0200
Message-ID: <540D5BEF.6080708@metafoo.de>
References: <540C76E0.9050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-029.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id BA0022617BB
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 09:34:04 +0200 (CEST)
In-Reply-To: <540C76E0.9050808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On 09/07/2014 05:16 PM, Alexander E. Patrakov wrote:
[...]
> 2. PulseAudio blindly assumes that it can rewind up to hwbuf_frames -
> (snd_pcm_avail() + rewind_safeguard) frames. The rewind safeguard is needed
> due to reasons that I don't completely understand, but one of them is
> imprecise reporting of the hardware pointer, and another one is that the
> hardware transfers several bytes at a time, and the bytes we need to
> overwrite may be already cached by the hardware.
>

Also at the time you will process the result form snd_pcm_avail() will be 
more than what was reported as the audio DMA keeps going in the background.

[...]
> For the allegedly existing cards where the pointer granularity is always the
> same as the period size, Raymond's method will not work. However, I don't
> know any concrete example of such card (I didn't look at snd-firewire in
> detail, though). And in any case, my opinion is that this "pointer
> granularity = period size" limitation on such cards can be treated as a
> driver bug that needs to be fixed (by someone who knows the driver, not by
> me). On cards where pointer updates happen only on interrupts, the driver
> should not configure the card in such a way that one period visible to the
> userspace corresponds to one interrupt. Instead, it should always configure
> the card for the minimum possible period size, and report only part of the
> period interrupts to period_elapsed(). I.e.: userspace asked for 2 periods
> 64 ms each, but let's configure the card for, say, 64 periods 2 ms each, and
> use the "extra" interrupts only for updating the pointer.
>

There are quite a few ASoC drivers that do have this restriction. For some 
of the drivers the restriction comes from the hardware itself for others it 
is while the hardware in theory supports it nobody bothered so far to 
implement this.

I do not agree that this should be treated as a driver bug and that those 
drivers should increase the interrupt rate. Mainly because this is policy 
and the interrupt rate is configured by the application by setting the 
period size and the driver should not have to guess what kind of latency 
requirements the application has. If the application has lower latency 
requirements it needs to set a smaller period size. Unnecessarily increasing 
the interrupt rate has for example has a impact on power consumption which 
is something you'd like to keep low on battery powered devices.

We should though expose the granularity with which the pointer is updated to 
userspace so it can make educated decisions on how to configure the period size.

- Lars
