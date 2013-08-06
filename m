From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Questions about virtual ALSA driver (dummy),
 PortAudio and full-duplex drops
Date: Tue, 06 Aug 2013 12:59:30 +0200
Message-ID: <5200D712.2040800@ladisch.de>
References: <51EF41C8.2040701@imi.aau.dk>
 <201307241403.28873.gineera@aspect135.co.uk> <51F07150.1060004@imi.aau.dk>
 <51F0E3C5.4020400@ladisch.de> <51FD9AB6.4050408@imi.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C28032616E1
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 12:59:35 +0200 (CEST)
In-Reply-To: <51FD9AB6.4050408@imi.aau.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Smilen Dimitrov <sd@imi.aau.dk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Smilen Dimitrov wrote:
> On 2013-07-25 10:37, Clemens Ladisch wrote:
>> Your driver's .pointer callback must report the *actual* position at
>> which the hardware has finished reading from the buffer

... for a playback stream, or finished reading, for a capture stream.

> I'm interested in the operation of a virtual (platform) driver,
> which talks to _no_ soundcard hardware

And what does this driver do?  What is your goal?

> I'm assuming that the card has it's own intern capture buffer memory
> on board;

No modern card has this.  All data is immediately read from/written to
main memory.

> and ALSA manages the equivalent of `substream->runtime->dma_area`
> as capture buffer memory in RAM. The main purpose of the ALSA driver,
> then, is to manage the copying the data from the intern card capture
> buffer, to the `dma_area` capture buffer in RAM of the PC;

This is handled by the hardware's DMA.

> once the data is in the `dma_area`, the rest of the ALSA engine will
> make sure that data ends up in `audiobuf` in user-space, upon a call
> to `snd_pcm_readi` as given above.

Yes.  (When using snd_pcm_mmap_*, the dma_area is mapped to userspace,
and ALSA itself will never access the contents of the buffer.)

> [...] where the `azx_interrupt` handler has been called (since it's
> also possible to capture interrupt entries for power, for instance);

The stream's SD_STS register tells whether this is an interrupt because
a period boundary has been crossed.

> On the PC side, the driver's .pointer callback can be triggered both
> by userspace call to `snd_pcm_readi`, and (apparently) independently
> of it - but (surprising for me) it is not necessarily periodic!

The .pointer callback is triggered by snd_pcm_period_elapsed() (because
some more data, or even another period, might have been transferred in
the meantime), whenever userspace writes or reads samples, or whenever
userspace feels like asking for the current position.

> when I see "wall clock" referred to in code, does that refer to
> this, which I've called "Real Time"?

It's called "wall clock" because Intel named the register this way;
actually, it's the device's sample clock.

> And herein lies the crux of my inquiery: given there is no hardware
> targetted with a virtual driver, I can in principle return whatever I
> want as a .pointer position.

If you are actually transferring sample from/to somewhere, you must
return the status of these transfers.

> I should be able to simulate a proper operation to userspace, just by
> increasing this .pointer value properly. However, even if I do that,
> I still manage to somehow trigger a full-duplex drop in the PortAudio
> userspace layer

A buffer length of about 1 ms is very likely to result in over/underruns,
regardless of what your .pointer callback does.

Better try with a 32000-frame buffer first.

> The card then, uses it's own clock, which is not burdened with
> anything else but filling buffers, meaning we can expect tight timing
> here; and when it generates an IRQ, it is handled by kernel with
> highest priority - ergo, not so much jitter. Timer functions, on the
> other hand, run in softIRQ context - meaning they (and their
> scheduling) could be preempted by the hardware IRQ of any other device
> on the system; ergo, more jitter. Is this reasonable to assume?

Yes, but other hardware interrupts interfere only if other devices are
used at the same time.


Regards,
Clemens
