From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: Forcing an absolute timestamp for every midi event.
Date: Tue, 20 Aug 2002 23:11:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020820211118.GA3301@idefix.fvdpol.home.nl>
References: <20020819050734.0e3e0a7c.coding@reduz.com.ar> <003a01c2477d$6a346d20$0400a8c0@martijn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail5-sh.home.nl (mail5.home.nl [213.51.128.16])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA16699
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2002 23:58:12 +0200
Content-Disposition: inline
In-Reply-To: <003a01c2477d$6a346d20$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: Juan Linietsky <coding@reduz.com.ar>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 19, 2002 at 01:39:02PM +0100, Martijn Sipkema wrote:
> 
> The MIDI API just allows scheduling MIDI for transmission at a certain
> future UST.
> Either scheduling is done (partly) in hardware or in a process that
> schedules
> the messages (using POSIX clock_nanosleep() or a similar function).

agreed; I'd like to see the 'firm timer stuff' here :-)

> 
> I'm thinking instead of the current sequencer API there is a user space
> 'sequencer' that handles merging and accepts clients to send it either
> scheduled or immediate messages (queued) and have a 'driver' be a
> combination of a kernel driver (ALSA rawmidi or device specific) and
> a 'driver' process that registers queues with the user-space sequencer.

In the future I'd like to move as much of ALSA sequencer from kernel space
to user space. If a (new) underlaying UST queue is present I see no
objection to move things into userland/alsalib. 

> 
> I'm working on this, but it is not that easy since merging MIDI streams
> is non-trivial and I want to be able to have hardware do the scheduling if
> it supports it and this means events can only be queued in timed order.

Not necessarely; If you have the ability to adjust when your timer is to be
fired/generate irq, you can readjust the schedule time when an event is
received (after all, that's the whole fun with an event based interface).
Merging streams is not a problem; You'll need a priority queue anyway for
merging multiple streams.

> the highest MSC in any input buffer.
> 
> > I am _definitively_ in favor of this. Alsa should proovide this, and
> > JACK _must_ do it,
> > so clients can syncronize properly.
> 
> I wonder if Paul can be convinced to add UST timestamping to JACK.
> He seems to be agreeing with me lately so things are looking good :)

:-)

> 
> > > I disagree. I'd rather have a small extra latency than jitter.

Yes, jitter is far worse than latency. 

> >
> > We're taling about something WAY beyond human-hearable latency.
> > Say you send the event, it will probably reach in nanoseconds if
> > things
> > go right, or useconds if things go not so right. The event would
> > need to delay like, 5 milliseconds for you to notice any jitter.
> > And this will _never_ happen. Absolutely *never*.

> 
> Since the MIDI API I was talking about timestamps the messages at the
> start of the message on the wire it will always arrive at the application
> between
> 1-2 msec late. To avoid possible jitter at audio buffer bounderies messages
> should arrive early instead of late and thus some extra latency should be
> added
> to the MIDI messages' UST. A 2 msec jitter is irritating, an extra 1-2 msec
> delay isn't.
> 
> Note that at the moment there aren't any softsynths on any platform that I
> know
> of that can do this, and many have audio buffer size MIDI message jitter on
> output. ( http://www.rme-audio.de/english/techinfo/lola/latec.htm ).

hmmm, quite a surprise nobody seems to do this, because it seems a logical
step to me to do microscheduling inside the buffer. Please nobody is playing
tricks with these !@#$%^&* software patents here???

> 
> > Well, all in all we're both talking about the same. ALSA and JACK
> > should proovide
> > access to some timer similar to UST. Now the real problem is the
> > implementation.
> > How to do this? Not all architectures proovide a secondary clock for
> > such things,
> > and on X86 I cant think of something other than the pentium cycle
> > counter.
> 
> As long as POSIX clocks are available from both user- and kernel-space and
> we
> all agree that CLOCK_MONOTONIC is UST for Linux, that'll do. ALSA drivers
> could then use CLOCK_MONOTONIC to timestamp buffers. How
> CLOCK_MONOTONIC is implemented is not that important, It'll probably have
> to be the firm- or hard- timers patch for Linux.
> 

looking good!

Frank.

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
