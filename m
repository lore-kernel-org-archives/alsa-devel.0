From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: [linux-audio-dev] midi events in jack callback / ALSA Sequencer
Date: Wed, 21 Aug 2002 02:10:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <005701c248af$94d09710$0400a8c0@martijn>
References: <Pine.LNX.4.21.0208191748480.673-100000@summer.quitte> <002001c247ac$2259e960$0400a8c0@martijn> <20020820205028.GA2657@idefix.fvdpol.home.nl>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA20051
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2002 02:13:26 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Frank van de Pol <fvdpol@home.nl>, linux-audio-dev@music.columbia.edu
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[...]
> Within ALSA we have two priority queues, one for tick (bar,beat) scheduled
> events, and one for clock (ns) scheduled events.

As MIDI uses MIDI tick messages for time based sync and MIDI clock messages
for tempo based sync I kind of feel the ALSA sequencer naming is a little
confusing :)

> In case of immediate
> scheduling the priority queue is bypassed and the event submitted in the
> receiver's fifo (which would be your immediate queue).
>
> Due to potential blocking at the receivers you'll need a fifo for every
> destination.

Correct, that's what I've been calling queues.

> Reason for having 2 priority queues with different reference is to cope
with
> tempo/signature changes while remaining in sync. The clock and tick
priority
> queues are in fact parallel in ALSA.

I don't want to support tempo (MIDI clock) scheduling in my MIDI API. This
could be better handled in the application itself. Also, when slaved to MIDI
clock
it is no longer possible to send messages ahead of time, and not supporting
this
in the API makes that clear to the application programmer.

> Since especially for soft synths (but also for some -undocumented!- USB
midi
> interfaces, like Emagic AMT)

Yes, I've repeatedly asked Emagic for documentation on their AMT protocol
without success. :(

> the events need to be scheduled ahead (sort of
> a pre-delay, say 10ms or more) to let the device/softsynth handle the
micro
> scheduling, it would seem a good idea to handle this at the clock based
> queue. Since variable predelay in ms would be not quite friendly to the
tick
> based queue (different units), it might make sense to have the tick based
> queue send events into the clock based queue instead of immediate
delivery).

I'd rather see MIDI clock sync handled in the application. This also keeps
the
API cleaner.

[...]
> A good reason for applications to use (UST/ALSA) scheduling instead of
> taking care of micro scheduling itself and using rawmidi interfaces is
> better support for softsynths to trigger at the right spot in the buffer,
> and for the upcoming smart (eg. USB) midi devices.

Or even MWPP.

[...]
> You can't overcome the limits of the MIDI physical line if that's your
> target transport. However when sending events to soft- or onboard synths
> these limits are different (typically less of an issue).
>
> When using events instead of midi bytes the merging is a no brainer

I was planning on doing that, but even then there are issues with for
example
(N)RPNs.

> leaves room for events not defined in midi spec).

...I'm not sure that is a good idea. What kind of events?

--martijn





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
