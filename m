From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Mon, 17 May 2010 11:12:15 +0200
Message-ID: <4BF1086F.9070900@ladisch.de>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>	
	<4BDABDDD.4050502@ladisch.de>	
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>	
	<s5hsk5uq4u4.wl%tiwai@suse.de>	
	<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6E9A3245C7
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 11:12:52 +0200 (CEST)
In-Reply-To: <AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pl bossart wrote:
> Takashi Iwai wrote:
> > The biggest problem I can foresee is the handling of PCM position.
> > In the current implementation, the PCM position continues to go over
> > the buffer size until the certain boundary that is close to long int
> > max.  Without interrupts (i.e. snd_pcm_period_elapsed()), this
> > position update won't work reliably.

Pointer updates (snd_pcm_avail or implicitly when writing samples) are
still necessary, and the interval between them can never be more than
the buffer time if you want to avoid xruns.

It seems to work fine with a simple test program.

> Good catch. I thought the processing was the same whether you called
> snd_pcm_period_elapsed or snd_pcm_avail when the timer fires, since in
> both cases you call the .pointer routine, but there's some code in
> snd_pcm_update_hw_ptr0 that is only executed in an interrupt context.

When an interrupt happens, we know that the current position must be at
least at the end of the period that was started at the last interrupt.
This code does the following: If it looks as if the current position is
less than that, we know that the period interrupt was delayed and that
an entire buffer was played before the position wrapped around to the
current position, so we have to add one buffer size to get the correct
position.

In practice, this implies an underrun.  Without interrupts, this
underrun could not be detected (except by the fact your own timer
has arrived too late).

> Likewise there are a bunch of fixes for hw_ptr position that make use
> of this boundary field (which I have to admit I don't understand too
> much).

The boundary is a multiple of the buffer size, so you can use
ptr%buffer_size to get the position in the actual hardware buffer.
The boundary is larger than the buffer size to allow computations on
pointer values even when long xruns happen.

> Here is my latest set of patches before I forget about them.

Instead of a new field in snd_pcm_hardware, you should better use a new
flag so that userspace also knows about this capability.

Following are my own patches that I wrote before I saw yours; they look
essentially the same.

> Still some work to be done on the alsa-lib one, for some reason the
> hw_param->flags field I used gets overwritten if I don't use the
> hw_device. I suspect this is due to some black magic with the
> pcm->hw_flags when slave devices are used.

Until now this field has been used only for flags used internally in
alsa-lib, so this might be a bug in alsa-lib.


Regards,
Clemens
