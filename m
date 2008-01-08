From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Disabling buffer fill level preprocessing by ALSA
Date: Tue, 8 Jan 2008 09:00:24 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801080833090.22730@tm8103.perex-int.cz>
References: <20071231171226.GA17953@tango.0pointer.de>
	<s5hfxx9ao8b.wl%tiwai@suse.de>
	<20080107160706.GE14386@tango.0pointer.de>
	<Pine.LNX.4.61.0801071916450.22730@tm8103.perex-int.cz>
	<20080107223850.GA12262@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 93E6124AAE
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 09:00:25 +0100 (CET)
In-Reply-To: <20080107223850.GA12262@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Jan 2008, Lennart Poettering wrote:

> On Mon, 07.01.08 19:33, Jaroslav Kysela (perex@perex.cz) wrote:
> 
> > > > > I assume that I can enable a mode like that with one of the SW
> > > > > params. But quite frankly the docs for it are not enlighening at all.
> > > > 
> > > > Set the stop_threshould sw_params to the boundary size.
> > > > 
> > > > 	snd_pcm_sw_params_get_boundary(sw_params, &boundary);
> > > > 	snd_pcm_sw_params_set_stop_threshold(pcm, sw_params, boundary);
> > > > 
> > > > then the driver behaves in the "freewheel" mode.  The dmix plugin uses
> > > > this technique.
> > > 
> > > That's not what I was looking for. This will only disable automatic
> > > stopping on buffer underrun. I am using that already in PA (however I
> > > pass -1 as stop threshold, which should work, too, shouldn't it?)
> > > 
> > > What I am really looking for is a way to disable that ALSA reports via
> > > poll() the buffer fill level, but instead only reports whether an
> > > interrupt happened.
> > 
> > Note that you can control fill level using snd_pcm_forward/rewind 
> > without any R/W calls (of course if supported in whole chain).
> > ALSA supports only "controlled" I/O not dumb I/O as OSS driver for mmap.
> > 
> > If you look for timing source, use timer API - you may try 
> > alsa-lib/test/timer.c:
> > 
> > ./timer class=3 card=0 device=0 subdevice=0
> 
> How does this timer depend on the PCM clock? Is its wakeup granularity
> dependant on the period parameters of the matching PCM device? Or am I
> supposed to first initialize PCM, and chose some period parameters the
> hw likes and than pass that on to the timer subsystem?
> 
> I assume I don't have any guarantee that all alsa devices have such a
> timer attached? So I'd need some major non-trivial fallback code if I
> make use of these timers? 
> 
> > > The background why I want this is this: As mentioned I am now
> > > scheduling audio in PA mostly based on system timers. To be able to do
> > > that I need to be able to translate timespans from the sound card
> > > clock to the system clock. Which requires me to get the sample time
> > > from the sound card from time to time and filter it through some code
> > > that estimates how the sound card clock and the system clock
> > > deviates. I'd prefer to do that only once or maybe twice everytime the
> > > playback buffer is fully played, and only shortly after an IRQ
> > > happened, under the assumption that this is the best time to get the
> > > most accurate timing information from the sound card.
> > 
> > It's not really necessary. You can use only one timing source (system 
> > timer) and use position timestamps to do corrections.
> 
> Position timestamps? You mean status->tstamp, right? I'd like to use
> that.  But this still has two problems:
> 
> 1) As mentioned, CLOCK_MONOTONIC support is still missing in ALSA(-lib)

Yes, but it will be added. No other has had this requirement until now.

> 2) I'd like to correct my estimations as quickly as possible, i.e. as
>    soon as a new update is available, and not only when I ask for
>    it. So basically, I want to be able to sleep in a poll() for timing
>    updates.

It is not necessary. It's always good to keep defined behaviour (e.g. use 
system timers for "decide" times) and use snd_pcm_delay() to get the 
actual ring buffer position. More task wakeups mean keeping CPU more 
busy.

> > But your example does not explain, why you don't move r/w pointer in the 
> > ring buffer (use mmap_commit), thus why you don't fullfill the avail_min 
> > requirement for poll wakeup. It seems to me that you're trying to do some 
> > crazy things with the ring buffer which are not allowed.
> 
> As mentioned, when PA starts up it configures the audio hw buffer to
> 2s or so with the minimal number of periods (2 on my sound
> cards). Then, clients come and go. Depending on the what the minimal latency
> constraints of the clients are, I however will only fill up part of
> the buffer.
> 
> Scenario #1: 
> 
> Only one simple MP3 playing music application is connected. It doesn't
> have any real latency constraints. We always fill up the whole 2s
> buffer, then sleep for 1990 ms, and then fill it up again, and so
> on. If the MP3 player pauses or seeks, we rewrite the audio buffer
> with _rewind(). Thus alsthough we buffer two full seconds the user
> interfaces still reacts snappy.
> 
> Now, because the user starts and stops applications all the time, we
> dynamically change into scenario #2:
> 
> The MP3 playing application is still running. However, now a VoIP
> application is running too. It wants a worst case latency of let's say
> 20ms. When this applications starts up we don't want to interrupt
> playback of the MP3 application. So from now on we only use 20ms of
> the previously configured 2s hw buffer. And as soon as we wrote 20ms,
> we sleep for 10ms, and then fill it up again, and so on.
> 
> Now, after a while the VoIP call is over, we enter scenario #3:
> 
> This is identical to #1, we again use the full 2s hw buffer, and sleep
> for 1990ms.
> 
> So, depending on what clients are connected, we dynamically change the
> wakeups. Now, on ALSA (and with a lot of sound hw, as I understood
> Takashi) you cannot reconfigure the period sizes dynamically without
> interruptions of audio output. That's why I want to disable the whole
> period/buffer fill level management of ALSA, and do all myself with
> system timers, which I thankfully now can due to the advent of
> hrtimers (at least on Linux/x86). System timers nowadays are a lot
> more flexibe than the PCM timer, because they can be reconfigured all
> the time without any drawbacks. They are not dependant on period sizes
> or other stuff which may only be reconfigured by resetting the audio
> devices. The only drawback is that we need to determinine how the
> sound card clock and the system clock deviate.
> 
> Does that make sense to you?

Yes, but I don't see any problem to change avail_min dynamically 
(sw_params can be changed at any time), so each interrupt can be catched 
via poll(). But I really think that one timing source (system timers) is 
enough.

I think that "not used" soundcard interrupts in this case are not a big 
problem (CPU usage etc.).

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
