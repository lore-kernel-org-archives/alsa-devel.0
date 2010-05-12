From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Wed, 12 May 2010 07:42:39 -0500
Message-ID: <AANLkTimBQOoQGFoPZ8T7nRrDKhsylLNiqkeQ-HinIeyV@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<20100507232516.GB16910@tango.0pointer.de>
	<AANLkTil2wLMXsRwNGpeCfduwK-hmtbYyN4tki51m-S0X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 753C6243F4
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 14:42:40 +0200 (CEST)
Received: by vws16 with SMTP id 16so1049105vws.38
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 05:42:39 -0700 (PDT)
In-Reply-To: <AANLkTil2wLMXsRwNGpeCfduwK-hmtbYyN4tki51m-S0X@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Some care would need to be taken with regards to detecting xruns.
> I think the alsa code currently uses the interrupt callback to detect this.
> I have seen a Windows 7 machine happily loop the audio buffer
> uncontrollably, so I assume it has problems detecting xruns as well.

When the PulseAudio timer fires, the use of snd_pcm_avail() will force
a call to .pointer and will detect underflows. PulseAudio modilfies
its watermark when underflows occur so that more time is allocated to
refilling the ring buffer.
There are probably some cases I didn't plan for, but on paper I don't
really see a show-stopper here.

> Some sound card hardware only updates the hw pointer at around dma
> interrupt event time, so again using the interrupt is used to improve
> the accuracy of the hw pointer with interpolation used between
> interrupts.

If the hardware doesn't provide an accurate hw pointer, then the
timer-based scheduling should not be used I agree.

> Some sound card hardware has very small hardware buffers, so PA will
> have to be waking up as often as the dma interrupts in order to keep
> the audio hardware buffers full enough.
> In how many cased would PA have to wake up less often than the DMA interrupt?

This patch is mainly for music playback where you have more than 2s
buffered in the ring buffer. PulseAudio will wake-up after 1.9s or so,
as the ring buffer becomes empty, and when it does the wake-up may be
grouped with other system events with the timer slack. Having one or
more interrupts in the middle or the ring buffer will reduce the
efficiency of sleep modes that are being introduced with Moorestown
and future Atom-based SOCs.
So again this patch isn't for everyone. All standard disclaimers
apply, if you have a pre-existing conditon tell your doctor etc. If
there's a 4K ring buffer, this is not useful. If your hardware is
broken, stay the course with the current solution. If PulseAudio is
disabled in your distro, this is of no interest to you. In all these
cases, this patch doesn't change anything, the behavior is the same.
But if you want to optimize for power and latency isn't a concern,
then these interrupts can be disabled and need to.
