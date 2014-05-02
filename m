From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Fri, 2 May 2014 13:39:44 +0800
Message-ID: <CAN8cciYoR25LDZnr6R9Bn_ek4rX1q8XoRPT+H4Mpp3ecZJF85w@mail.gmail.com>
References: <5356A9B6.9060405@gmail.com> <5358FCF0.2040701@ladisch.de>
 <53597BA2.8080201@gmail.com> <5359FE72.8050605@canonical.com>
 <535A6C96.7040109@gmail.com>
 <CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>
 <535B83E4.5050303@gmail.com>
 <CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>
 <535E908C.4030509@gmail.com>
 <CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>
 <535FDEA8.7010206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com
 [209.85.192.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B7B33265495
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 07:39:45 +0200 (CEST)
Received: by mail-qg0-f43.google.com with SMTP id a108so4269324qge.16
 for <alsa-devel@alsa-project.org>; Thu, 01 May 2014 22:39:45 -0700 (PDT)
In-Reply-To: <535FDEA8.7010206@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>>  >
>>  >
>>  > On most sound cards, PulseAudio uses timer-based scheduling and thus
>> is not subject to any period-size limitations. As far as I can see,
>> snd_ymfpci does not include SNDRV_PCM_INFO_BATCH, and thus will be used
>> in this mode.

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/073816.html

Do you mean sound card which cannot provide sample
granularity need to use that flag or you want the driver to provide this
granularity to application ?

>In addition, it has an implementation of
>> snd_ymfpci_playback_pointer that seems to look at the hardware, which is
>> good. So effective period times less than 5 ms should work on this card.

>>

>
> Yes (if "cannot disable period wakeups" is the only bad thing about the
card, which the further text in your e-mail contradicts to). Key words:
dynamic latency.
>
> As you surely know, running with low latency has a high chance of
underruns due to CPU spikes, so this should be avoided if reasonable.
However, some applications (e.g. VoIP) require low latency. By ignoring
period wakeups and relying on time-based scheduling, one can effectively
change the period size on the fly, obtaining low latency only when it is
needed.
>

Are there any different reqiurment bewteen VOIP and other application in
addition to low latency ?

Voip does not really need stereo . The web cam Mic usually capture at
16000Hz mono while pulseaudio use same default  rate for playback and
capture

>
>
> However, I don't see any code that backs up your claim. Is that fake
pointer increased in hardware (as opposed to in the kernel) with such bad
granularity?
>
> See snd_ymfpci_memalloc(): both chip->voices[voice].bank and
chip->bank_playback[voice][bank] are assigned a pointer that is based on
chip->work_ptr.area, which is itself obtained through snd_dma_alloc_pages.
So all bank pointers definitely point into the DMA-able area.
>
> Also, snd_ymfpci_playback_pointer is based on
voice->bank[chip->active_bank].start only, and the same construction is
used in the interrupt handler to obtain the current playback position. So
it is definitely based on what the hardware wrote into the DMA-able area,
and that's why I thought that the .pointer function is good. Does it write
there only just before the interrupt, or every 256 samples independently on
the period size, or on some other condition?

http://mailman.alsa-project.org/pipermail/alsa-devel/2011-September/043715.html

The author of the driver told me that

The period interrupts are not accurate at all.  The ymfpci hardware
internally uses fixed periods of 256 frames at 48 kHz. the driver reports a
period interrupt when the next hardware interrupt at or after a period
boundary occurs.  The current position reported by the hardware is the
position at the time of the last hardware interrupt

>
> OK, but I don't see why it is relevant. Surely we can set up as many
periods as we want, if all we are going to do with period interrupts is to
ignore them in userspace.
>

Do you mean pulseaudio will use more periods instead of periods_min for
those sound cards which cannot disable period wake-up ?

Do  dynamic latency mean pulseaudio use 1ms and double the times  until the
sound card ?

It may also be obtained by double the number of periods and restrict
hwbuf_unused in multiple of samples in a period instead of any arbituary
number of sample ?

>
> It is a bad idea to rewind into the uncertain area that we don't know
whether it is already playing or not. If we have 6 periods 5 ms each, and
always keep 5 of them full by promptly reacting to the interrupt
notifications, then surely we can rewind one of them without much risk. But
indeed, a full rewind is impossible for a fake hw_ptr with such bad
granularity.
>

/* FIXME? True value is 256/48 = 5.33333 ms */
err = snd_pcm_hw_constraint_minmax(runtime,
   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
   5334, UINT_MAX);
if (err < 0)
return err;
err = snd_pcm_hw_rule_noresample(runtime, 48000);

Do you mean when noresample is used, the period byte constraint should be
used instead of period time to avoid rounding error ?

To obtain dynamic latency, you can just keep half of them  or at least two
periods full at any time
