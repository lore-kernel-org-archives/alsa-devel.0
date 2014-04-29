From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Tue, 29 Apr 2014 23:17:28 +0600
Message-ID: <535FDEA8.7010206@gmail.com>
References: <5356A9B6.9060405@gmail.com>	<5358FCF0.2040701@ladisch.de>	<53597BA2.8080201@gmail.com>	<5359FE72.8050605@canonical.com>	<535A6C96.7040109@gmail.com>	<CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>	<535B83E4.5050303@gmail.com>	<CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>	<535E908C.4030509@gmail.com>
 <CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 8272F260320
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 19:20:40 +0200 (CEST)
Received: by mail-lb0-f173.google.com with SMTP id l4so392709lbv.4
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 10:20:40 -0700 (PDT)
In-Reply-To: <CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

29.04.2014 22:01, Raymond Yau wrote:
>  >
>  >
>  > On most sound cards, PulseAudio uses timer-based scheduling and thus
> is not subject to any period-size limitations. As far as I can see,
> snd_ymfpci does not include SNDRV_PCM_INFO_BATCH, and thus will be used
> in this mode. In addition, it has an implementation of
> snd_ymfpci_playback_pointer that seems to look at the hardware, which is
> good. So effective period times less than 5 ms should work on this card.
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/?qt=grep&q=period+wakeup
>
> Is there any reason to use timer scheduling for the sound card which
> cannot disable period wake up ?

Yes (if "cannot disable period wakeups" is the only bad thing about the 
card, which the further text in your e-mail contradicts to). Key words: 
dynamic latency.

As you surely know, running with low latency has a high chance of 
underruns due to CPU spikes, so this should be avoided if reasonable. 
However, some applications (e.g. VoIP) require low latency. By ignoring 
period wakeups and relying on time-based scheduling, one can effectively 
change the period size on the fly, obtaining low latency only when it is 
needed.

> The sound cards are still wake up by period and the timer
>
> As the DSP of ymfpci can mix up to 32 voices of different sample rate,
> mono/stereo , u8/s16 .

Understood.

> The driver just setup the card's timer to increase the fake hw_ptr  on
> 5ms interval by (48000Hz * 5ms) 240 samples

And that's bad. As the precision of hw_ptr is only 5 ms (and not 1 
sample), the driver must set SNDRV_PCM_INFO_BATCH. This would indeed 
avoid rewinds in the current PulseAudio code.

However, I don't see any code that backs up your claim. Is that fake 
pointer increased in hardware (as opposed to in the kernel) with such 
bad granularity?

See snd_ymfpci_memalloc(): both chip->voices[voice].bank and 
chip->bank_playback[voice][bank] are assigned a pointer that is based on 
chip->work_ptr.area, which is itself obtained through 
snd_dma_alloc_pages. So all bank pointers definitely point into the 
DMA-able area.

Also, snd_ymfpci_playback_pointer is based on 
voice->bank[chip->active_bank].start only, and the same construction is 
used in the interrupt handler to obtain the current playback position. 
So it is definitely based on what the hardware wrote into the DMA-able 
area, and that's why I thought that the .pointer function is good. Does 
it write there only just before the interrupt, or every 256 samples 
independently on the period size, or on some other condition?

> Unlike most sound cards which  periods_min equal to 2,  the periods_min
> of snd_ymfpci is 3

OK, but I don't see why it is relevant. Surely we can set up as many 
periods as we want, if all we are going to do with period interrupts is 
to ignore them in userspace.

> As the fake hw_ptr increase by 240 samples on 5 ms interval,  I  think
> it is a bad idea to allow any application to perform rewind

It is a bad idea to rewind into the uncertain area that we don't know 
whether it is already playing or not. If we have 6 periods 5 ms each, 
and always keep 5 of them full by promptly reacting to the interrupt 
notifications, then surely we can rewind one of them without much risk. 
But indeed, a full rewind is impossible for a fake hw_ptr with such bad 
granularity.

-- 
Alexander E. Patrakov
