From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Forcing an absolute timestamp for every midi event.
Date: Mon, 19 Aug 2002 13:39:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003a01c2477d$6a346d20$0400a8c0@martijn>
References: <20020818055740.2af8e3e7.coding@reduz.com.ar><000c01c246f3$bfed4370$0400a8c0@martijn><20020818195848.6ec26f96.coding@reduz.com.ar><002a01c2474b$842b6170$0400a8c0@martijn> <20020819050734.0e3e0a7c.coding@reduz.com.ar>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA20042
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 13:41:59 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Juan Linietsky <coding@reduz.com.ar>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[...]
> Well, i guess i didnt make myself clear enough.
> Technically, when you use some count/clock/tick based method
> for doing things, there is a certain hardware that generates such
> things.
> How are you sure that you will be able to generate those reliably
> within
> the OS? The only way is generating them in realtime, and prequeuing
> would be impossible.

The MIDI API just allows scheduling MIDI for transmission at a certain
future UST.
Either scheduling is done (partly) in hardware or in a process that
schedules
the messages (using POSIX clock_nanosleep() or a similar function).

I'm thinking instead of the current sequencer API there is a user space
'sequencer' that handles merging and accepts clients to send it either
scheduled or immediate messages (queued) and have a 'driver' be a
combination of a kernel driver (ALSA rawmidi or device specific) and
a 'driver' process that registers queues with the user-space sequencer.

I'm working on this, but it is not that easy since merging MIDI streams
is non-trivial and I want to be able to have hardware do the scheduling if
it supports it and this means events can only be queued in timed order.

> It happens the same when the OS generates
> midi clocks, if the load affects wathever is timing internally,
> all your queue gets screwed. This has its uses i guess anyway.


[...]
> What i mean is the audio callback prooviding the UST time. I mean it's
> not necesary
> since you can compute the delay in time from ust and the audio buffer
> size, but

OK, I'm not sure what you mean here, but as I said earlier, I think the
audio
API should provide a MSC for every buffer in a callback and a UST for every
input buffer corresponding to the end of that buffer. Perhaps better: a
callback could
provide a single UST/MSC pair on every callback where the MSC is higher than
the highest MSC in any input buffer.

> I am _definitively_ in favor of this. Alsa should proovide this, and
> JACK _must_ do it,
> so clients can syncronize properly.

I wonder if Paul can be convinced to add UST timestamping to JACK.
He seems to be agreeing with me lately so things are looking good :)

> > I disagree. I'd rather have a small extra latency than jitter.
>
> We're taling about something WAY beyond human-hearable latency.
> Say you send the event, it will probably reach in nanoseconds if
> things
> go right, or useconds if things go not so right. The event would
> need to delay like, 5 milliseconds for you to notice any jitter.
> And this will _never_ happen. Absolutely *never*.

Since the MIDI API I was talking about timestamps the messages at the
start of the message on the wire it will always arrive at the application
between
1-2 msec late. To avoid possible jitter at audio buffer bounderies messages
should arrive early instead of late and thus some extra latency should be
added
to the MIDI messages' UST. A 2 msec jitter is irritating, an extra 1-2 msec
delay isn't.

Note that at the moment there aren't any softsynths on any platform that I
know
of that can do this, and many have audio buffer size MIDI message jitter on
output. ( http://www.rme-audio.de/english/techinfo/lola/latec.htm ).

> Well, all in all we're both talking about the same. ALSA and JACK
> should proovide
> access to some timer similar to UST. Now the real problem is the
> implementation.
> How to do this? Not all architectures proovide a secondary clock for
> such things,
> and on X86 I cant think of something other than the pentium cycle
> counter.

As long as POSIX clocks are available from both user- and kernel-space and
we
all agree that CLOCK_MONOTONIC is UST for Linux, that'll do. ALSA drivers
could then use CLOCK_MONOTONIC to timestamp buffers. How
CLOCK_MONOTONIC is implemented is not that important, It'll probably have
to be the firm- or hard- timers patch for Linux.

--martijn







-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
