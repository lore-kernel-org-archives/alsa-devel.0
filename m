From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: Forcing an absolute timestamp for every midi event.
Date: Sun, 18 Aug 2002 19:58:48 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020818195848.6ec26f96.coding@reduz.com.ar>
References: <20020818055740.2af8e3e7.coding@reduz.com.ar>
	<000c01c246f3$bfed4370$0400a8c0@martijn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from john.anime.com.ar ([64.113.39.216])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA10606
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 00:57:51 +0200
Received: from server (OL110-150.fibertel.com.ar [24.232.150.110])
	by john.anime.com.ar (8.9.3/8.9.3) with SMTP id SAA29533
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 18:57:42 -0400
In-Reply-To: <000c01c246f3$bfed4370$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 18 Aug 2002 21:12:52 +0100
"Martijn Sipkema" <msipkema@sipkema-digital.com> wrote:

> > Hi! I wanted to ask, how about forcing
> > an absolute timestamp for _every_ midi event?
> > I think this would be great for softsynths,
> > so they dont need to work with root/schedfifo/lowlatency
> > to have a decent timing. Not allways you are willing
> > to process midi at the lowest latency possible.
> > I say because you dont really need all that if you
> > sequence in the computer and control softsynths and maybe
> > some external device. 
> > This way, the softsynth gets the event with the timestamp,
> > gets the current time, substracts the audio delay (latency) to
> > that and just mixes internally in smaller blocks processing each 
> > event in the right time.
> 
> I'm not sure what you mean, but below is what I think would be the
> best approach for audio/MIDI I/O.
> 
> ----
> 
> UST = unadjusted system time
> MSC = media stream count
> 

I completely agree on using some sort of unadjusted system time, but.


> - Callback based.

Callbacks on midi are retarded, and VERY annoying. It's simply
throwing more work to the programmer which the lib can and should do.
Seriosly, think about it, what is better?

Callback system:

The programmer has to setup a waiting callback, so when the event
arrives, it will
get the current time, write it to a special event struct he did with
the event data,
and push it to an (argably blocking) fifo. Then the audio thread will
get events from it while 
it mixes.

Event polling:

The user polls for an event, which comes nicely formatted into a
struct, with timestamp and everything.

Conclusion:

The callback system is unnecesary, and even makes things worse because
if you run the program with low priority, the app can even get
callbacks wrong. Sure, you could send the event with timestamp
to a callback already, but then what do you want the callback for?
It's much better if the
api, which runs at kernel level, timestamps the event itself. So
callbacks are straight unnecesary.
We talked about this already on irc, if you still have more reasons
for using a callback, let me know :)


> - All buffers in a callback are of the same size.

This is also unnecesary, since the api takes care of this. I know you
are probably
thinking about mlocking the buffers, because they are constant size so
you dont
pagefault and stuff. This is outright paranoia :). Hey, I worked with
midi on linux
for years, the events allways get there in time! And even with that,
why should you care?
they are timestamped anyway.


YES! i know you also told me you hate that alsa takes care of so much,
and many people
has said that alsa seq api is overcomplicated. But personally, having
programmed midi on almost every OS, and having written a midi
sequencer, i can easily say that
alsa seq is the most comfortable api I have worked with. Linux does
not need really another
midi api, only needs GOOD DOCUMENTATION OF THE API, because i had to
resort to diving into
the alsadriver and lib source code to figure out stuff.


> - All frames with a particular MSC occur at the same time. (I don't
> think
>  OpenML requires this, EASI does have this with its 'position')
> - The audio callback provides an MSC value for every buffer
> corresponding
>  to the first frame in the buffer.

fine, what happens if your app xruns the audio buffer for X time? all
the count gets screwed?
you will shutdown the app like jack? will you ask devices for sync?
will you drop events? 

> - The (constant) latency (in frames) between an input and an output
> can be
>  seen from the difference between their MSC values.

This sounds nice, and comes by default, but what is this good for? I'd
like a good example.

> - The audio callback provides an UST value for every input buffer
>  corresponding to the end of that buffer/start of the next buffer.

This is actually a great idea, Very good for audio/video
syncronization,
or for JACK. Which may have to process serial chained clients in the
graph,
Even if not 100% necesary for midi, it  could also make good use of
it. Doesnt alsa already support
something like that? Still tho, it would need to have to handle
xruns.


> - The UST value for the start/end of an output buffer can be
> estimated.
> 
> MIDI I/O API
> - MIDI messages are received with a UST stamp.

Ths is what i've been complaining in the past two mails ;)

> - Timestamps are measured at the start of the message on the wire.

yes.

> - MIDI messages are either sent immediately or scheduled to UST.
> - MIDI messages must have monotonically increasing timestamps if
>  scheduled.
> 

These two can be done too, and it's good, but some people will argue
you
that you should be able to queue events with relative timestaps in
midi clocks,
so you can pre-send the events and then play with the tempo (BPM) and
events
will respond to that. This is quite a problem, since on one side you
have
the ones like us, who want absolute timestamps because
they work much better on a computer than midi clocks (which are easy
to lose sync to).
But on the other hand you have people who works all with hardware
stuff
and wants midi clocks because their equipment will process stuff in
realtime.
All in all, i'm all for timestamps because this is a software api, and
we work
with software in a multitasking OS. Thats why my original mail is
"forcing absolute timestamps". It means, whathever the input is, my
softsynth
will only work with timestamps, so timestamps need to be forced.




> For a software synthesizer the MIDI messages received at some UST
> can be mapped to a corresponding MSC value and then rendered at
> a constant offset from this MSC, most likely the audio I/O latency
> (the audio I/O latency may not be the same for all inputs/outputs,
> also since MIDI messages always arrive late a small extra latency
> should be introduced in this case by increasing the MIDI message's
> UST by a constant value in order to compensate for the MIDI
> interface and scheduling latency so they arrive a little early
> instead of late in order to reduce jitter with MIDI messages
> arriving near buffer bounderies).

Bad idea, as long as things are not audible, dont adding extra crap
is the best. Midi hardware works like this and the delay is even
higher,
yet you cant hear it. So I think this is beyond pointless. 



Juan Linietsky


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
