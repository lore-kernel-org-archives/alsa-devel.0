From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: [linux-audio-dev] midi events in jack callback / ALSA Sequencer
Date: Tue, 20 Aug 2002 22:50:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020820205028.GA2657@idefix.fvdpol.home.nl>
References: <Pine.LNX.4.21.0208191748480.673-100000@summer.quitte> <002001c247ac$2259e960$0400a8c0@martijn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail8-sh.home.nl (mail8.home.nl [213.51.128.28])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA15769
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2002 22:50:14 +0200
Content-Disposition: inline
In-Reply-To: <002001c247ac$2259e960$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-dev@music.columbia.edu, Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Martijn, 

the ALSA sequencer is exactly designed to serve a mechanism to route (midi)
_events_ from a source to a sink (either driver, application or whatever). 

On Mon, Aug 19, 2002 at 07:12:47PM +0100, Martijn Sipkema wrote:
> > >MIDI through and any other 'immediate' type MIDI messages do
> > >not need to be scheduled, they can be written to the interface
> immediately.
> >
> > Yes, they could. It would however necessitate different input routes
> > for 'immediate' and 'queued' events to the MIDI output handler.
> 
> The MIDI I/O API I am working on has 'scheduled' and 'immediate' queues. I
> don't think there is a way around this unless 'immediate' messages are not
> used
> at all and that is clearly not an option.

Within ALSA we have two priority queues, one for tick (bar,beat) scheduled
events, and one for clock (ns) scheduled events. In case of immediate
scheduling the priority queue is bypassed and the event submitted in the
receiver's fifo (which would be your immediate queue).

Due to potential blocking at the receivers you'll need a fifo for every
destination. 

Reason for having 2 priority queues with different reference is to cope with
tempo/signature changes while remaining in sync. The clock and tick priority
queues are in fact parallel in ALSA. 

Since especially for soft synths (but also for some -undocumented!- USB midi
interfaces, like Emagic AMT) the events need to be scheduled ahead (sort of
a pre-delay, say 10ms or more) to let the device/softsynth handle the micro
scheduling, it would seem a good idea to handle this at the clock based
queue. Since variable predelay in ms would be not quite friendly to the tick
based queue (different units), it might make sense to have the tick based
queue send events into the clock based queue instead of immediate delivery).

Your links about UST sound very good in this perspective, since the
_monotonic_ clock ensures compatibility between the event (sequencer)
subsystem, and other audio/video subsystems. 

The current clock based ALSA prioq could then simply be a reference against
the UST instead of keeping track of time itself. High level applications can
have the freedom to take whatever route they want, use the ALSA sequencer
API or go directly to the UST based scheduler. All these applications can
still cooperate in this framework :-) (try that in MS Windows.....)

A good reason for applications to use (UST/ALSA) scheduling instead of
taking care of micro scheduling itself and using rawmidi interfaces is
better support for softsynths to trigger at the right spot in the buffer,
and for the upcoming smart (eg. USB) midi devices.

> 
> > This
> > would not help make things simpler. It would also mean that a Sysex
> > or pitch/CC burst routed through can delay MIDI clocks because of the
> > limited bandwidth on the MIDI wire.
> 
> Sysex can hurt timing for other events, but that's MIDI. MIDI clock (any
> MIDI realtime message) can interleave other messages. And yes, merging
> MIDI streams is not easy.

You can't overcome the limits of the MIDI physical line if that's your
target transport. However when sending events to soft- or onboard synths
these limits are different (typically less of an issue). 

When using events instead of midi bytes the merging is a no brainer (and
leaves room for events not defined in midi spec).

> 
> > Thinking about it -- it's hypothetical because we don't have them in
> > Linux yet -- I believe a decent MIDI out handler using a firm timer
> > would be an order of magnitude more complicated than one based on the
> > RTC. Have you coded one yet?
> 
> Yes, and it is not that complex I think. Note that this would only have to
> be done
> in a driver process or a user-space sequencer application and not for every
> client
> application.
> 
> I'll try to get a version of my MIDI I/O API/framework ready, but it will
> probably still
> take me some time to get finished.

Perhaps you might want to look at the ALSA sequencer, and take it to a
higher level? I'd love to see UST time references...

> 
> --martijn
> 

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
