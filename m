From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: DMA and delay feedback
Date: Tue, 15 Dec 2009 08:09:43 +0200
Message-ID: <1260857383.6157.36.camel@eenurkka-desktop>
References: <ad2655cb0912140602s138b7246u6db75e40a699c729@mail.gmail.com>
	<6160a5130912140646g3738731fqbc5caacc153b9da8@mail.gmail.com>
	<ad2655cb0912140735r7ac66c7t45119f957d12dfc5@mail.gmail.com>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id B0E2C103800
	for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2009 07:11:37 +0100 (CET)
In-Reply-To: <ad2655cb0912140735r7ac66c7t45119f957d12dfc5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext James Courtier-Dutton <james.dutton@gmail.com>
Cc: pl bossart <bossart.nospam@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-12-14 at 16:35 +0100, ext James Courtier-Dutton wrote:
> 2009/12/14 pl bossart <bossart.nospam@gmail.com>:
> >> For transfer purposes, one only needs to know that DMA transfer is
> >> complete on period X so that period X can now be over-written.
> >
> > That's the 'traditional' view. ALSA is now used in different ways.
> > PulseAudio sets a timer and relies on snd_pcm_avail() to query how
> > many samples it can write to the ring buffer, the notion of period
> > isn't used at all. I think we could use additional information in the
> > way the hw_ptr position is reported, namely hints on how precise this
> > information is and the granularity of the updates.
> > - Pierre
> >
> 
> There is a problem with getting snd_pcm_avail() accurate from a
> hardware perspective.
> I was trying to come up with a method for letting the application
> (pulseaudio) know how much data it can write in a more accurate
> fashion.
> An extra bit of information is also useful, and that is some
> prediction of when one should next write samples after this write.
> One then has a sensible value to use for the timer.
> People use snd_pcm_avail for different tasks, and I was trying to
> break the use cases out and analyse each one it turn and see if a
> better API interface could result.
> The use cases are:
> 1) Deciding when and how many sample to write and when one is likely
> to need to write again.
> 2) Syncing the samples to a video stream or other time source.
> There are other requiremets:
> 1) Having the application buffer size different from the hardware buffer size.
> 2) Having the application sample rate different from the hardware
> sample rate, and thus doing resampling.
> 
> James

At every DMA IRQ, I guess you may be calling snd_pcm_period_elapsed().
If so, a timestamp is taken that may be polled out with the
SNDRV_PCM_IOCTL_TTSTAMP. So comparing the timestamp to the current time
gives you the exact 'delta'? (Of course there may be issues such as the
call propagation delay (if an IRQ occurs during the ioctl call that
takes time) or the DMA IRQ may arrive at the same time with a more high
priority IRQ etc, but that's all basics...)

- Eero
