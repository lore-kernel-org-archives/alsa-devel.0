From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Wed, 9 Sep 2009 10:18:58 +0800
Message-ID: <4f3252890909081918y672a9a21r966362381d0c1ae3@mail.gmail.com>
References: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>
	<s5hljkrrl3s.wl%tiwai@suse.de> <1252330155.3283.5.camel@localhost>
	<s5hbplmssrg.wl%tiwai@suse.de>
	<20090907224659.GA5917@tango.0pointer.de>
	<s5htyzej6fj.wl%tiwai@suse.de>
	<20090908133825.GA22845@tango.0pointer.de>
	<s5heiqh5wh0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f190.google.com (mail-px0-f190.google.com
	[209.85.216.190])
	by alsa0.perex.cz (Postfix) with ESMTP id F134824476
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 04:18:59 +0200 (CEST)
Received: by pxi28 with SMTP id 28so3756591pxi.2
	for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2009 19:18:58 -0700 (PDT)
In-Reply-To: <s5heiqh5wh0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/9/8 Takashi Iwai <tiwai@suse.de>

> At Tue, 8 Sep 2009 15:38:25 +0200,
> Lennart Poettering wrote:
> >
> > On Tue, 08.09.09 08:29, Takashi Iwai (tiwai@suse.de) wrote:
> >
> > > > This turned out to cause a couple of issues with some drivers (i
> think
> > > > CS46xx is one of them, ice1712 another, I lack the hw in question, so
>

it's rather common
e.g  HDA also have

    snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
    snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
                   128);
    snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
                   128);




> > > > i never tried to track this down further). Basically on those drivers
> > > > both _set_buffer_size_near() and _set_periods_near() would fail with
> > > > EINVAL for some reason and then causing snd_pcm_hw_params() to return
> > > > ENOENT. Removing the two calls and calling snd_pcm_hw_params() would
> > > > however work. Changing the order of the first two calls, i.e. doing
> > > > first _set_periods_near() and then _set_buffer_size_near() would make
> > > > both calls succeed and the snd_pcm_hw_params(), too.
> > >
> > > The general problem in the hw_params setup is that the multiple
> > > parameters depending with each other are allowed almost freely.
> > > And, yet another problematic constraint is like cs46xx's one, the
> > > power-of-two rule.  This limits strongly the value range.
> > >
> > > Also, another issue is the presence of three units to specify the same
> > > thing.  There are units, frame, bytes and time for period and buffer
> > > sizes.  Especially the former two and the time units can be
> > > inconsistent due to the integer rounding.
> >
> > I always use 'frames' as unit for the actual calls, even if I said
> > bytes.
>
> It's not about what unit you use.  It's the fact that three units
> exist in the hw_params space parallel and they have to be aligned with
> each other.  See ens1371 example below.
>
>
> > > > It would be good if the ALSA docs would actually mention in which
> > > > order those functions need to be called, if the order matters, which
> > > > it apparently does.
> > >
> > > There is no golden rule, unfortunately, AFAIK.  There can be pretty
> > > weird hardware, e.g. the buffer size depending on rate.  But, as a
> > > rule of thumb:
> > > 1. set access, format, channels and rate first,
> > > 2. if you need larger buffers than shorter periods, set the buffer
> > >   size first,
> > > 3. set the period size only when you must specify it
> >
> > This breaks on ice1712 at least...
>
> Might be.
>


The front device of ice1712 has a route plugin

you may need to use hw:0,0 if you are using mmap_begin, .... and read/write
10 and 12 channels like jackd

Actually the front device of emu10k1 has two IFACE_PCM controls , most
likely you will need to modify EMU10K1.conf so that capture do not hook
those controls


>
> > > But, this can also fail when a hardware has a strong dependency
> > > between period and buffer sizes together with a strong constraint
> > > in period size.  In that case, you may need to try another way,
> > > set period and hw_params.
> >
> > For me the large buffers matter most. And large periods are the second
> > most important thing. Would something like the following make sense?
> >
> > <snip>
> > snd_pcm_hw_params_any(pcm, hw);
> > snd_pcm_hw_params_set_access(pcm, hw, ...);
> > snd_pcm_hw_params_set_format(pcm, hw, ...);
> > snd_pcm_hw_params_set_rate_near(pcm, hw, ...);
> > snd_pcm_hw_params_set_channels_near(pcm, hw, ...);
> >
> > snd_pcm_hw_params_copy(hw2, hw);
> >
> > /* We care more about buffer size than the period size, so try setting
> > things in this order first */
> > snd_pcm_hw_params_set_buffer_size_near(hw, ...);
> > snd_pcm_hw_params_set_periods_near(hw, ...);
> >
> > if (snd_pcm_hw_params(pcm, hw) < 0) {
> >    /* This order didn't work, so let's try it the other way round */
> >    snd_pcm_hw_params_set_periods_near(hw2, ...);
> >    snd_pcm_hw_params_set_buffer_size_near(hw2, ...);
> >
> >    if (snd_pcm_hw_params(pcm, hw2) < 0) {
> >        /* fail fatally */
> >        ....
> >    }
> > }
> > </snip>
>
> I think yes.  But needs more testing of course :)
>
>
> > > > ens1371 has some issues with the buffer size: if you ask it for 65536
> > > > bytes in the playback buffer it will only agree to 65532. If the next
> > > > time you ask for 65532 right-away it will only agree to 65528, and so
> on...)
> > >
> > > The byte size can depend on the sample format and channels.
> > > This might be the case.  Otherwise I don't see any strong restriction
> > > of buffer/period size in ens1371 code.  It has the restriction of
> > > sample rates, though.
> >
> > I only actually manipulate samples here, not bytes. So the prob is
> > that if you ask for a buffer size of n samples it will only agree to
> > n-1 samples, for every possible n. Other drivers don't do that.
>
> Then the problem is likely the sample rate setup.  ens1371 can't give
> you always the integer sample rate.  Now the problem of multiple units
> appears here like a ghost.  Almost every parameter is associated with
> other parameters in the end due to the constraints below:
>  buffer_time = buffer_size / sample_rate
>  buffer_size = buffer_bytes / (channels * format_width)
>
> When you get a non-integer rate value, even buffer_size can be
> affected, rounded down to the next integer value.
>
> All for one, one for all -- what a perfect world.
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
