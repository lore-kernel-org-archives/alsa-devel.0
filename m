From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Forcing an absolute timestamp for every midi event.
Date: Mon, 19 Aug 2002 07:41:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002a01c2474b$842b6170$0400a8c0@martijn>
References: <20020818055740.2af8e3e7.coding@reduz.com.ar><000c01c246f3$bfed4370$0400a8c0@martijn> <20020818195848.6ec26f96.coding@reduz.com.ar>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA15265
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 07:44:43 +0200
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
> > - Callback based.
> 
> Callbacks on midi are retarded, and VERY annoying. It's simply
> throwing more work to the programmer which the lib can and should do.
> Seriosly, think about it, what is better?

Actually I was talking about the audio API in this case.

> > - All buffers in a callback are of the same size.
> 
> This is also unnecesary, since the api takes care of this.

No, this is absolutely necessary. Note that ASIO/EASI/JACK all
have this.

> I know you
> are probably
> thinking about mlocking the buffers, because they are constant size so
> you dont
> pagefault and stuff. This is outright paranoia :). Hey, I worked with
> midi on linux
> for years, the events allways get there in time! And even with that,
> why should you care?
> they are timestamped anyway.

Again, this was about audio. And the frames per callback do not have to
be constant.
And yes, I think the realtime part of an application should mlock().

> > - All frames with a particular MSC occur at the same time. (I don't
> > think
> >  OpenML requires this, EASI does have this with its 'position')
> > - The audio callback provides an MSC value for every buffer
> > corresponding
> >  to the first frame in the buffer.
> 
> fine, what happens if your app xruns the audio buffer for X time? all
> the count gets screwed?
> you will shutdown the app like jack? will you ask devices for sync?
> will you drop events? 

The application can detect xruns by looking at the MSCs.

> > - The audio callback provides an UST value for every input buffer
> >  corresponding to the end of that buffer/start of the next buffer.
> 
> This is actually a great idea, Very good for audio/video
> syncronization,
> or for JACK. Which may have to process serial chained clients in the
> graph,
> Even if not 100% necesary for midi, it  could also make good use of
> it. Doesnt alsa already support
> something like that? Still tho, it would need to have to handle
> xruns.

This is absolutely necessary for MIDI, or else scheduling MIDI to UST
doesn't make much sense.

> > - MIDI messages are either sent immediately or scheduled to UST.
> > - MIDI messages must have monotonically increasing timestamps if
> >  scheduled.
> > 
> 
> These two can be done too, and it's good, but some people will argue
> you
> that you should be able to queue events with relative timestaps in
> midi clocks,
> so you can pre-send the events and then play with the tempo (BPM) and
> events
> will respond to that. This is quite a problem, since on one side you
> have
> the ones like us, who want absolute timestamps because
> they work much better on a computer than midi clocks (which are easy
> to lose sync to).
> But on the other hand you have people who works all with hardware
> stuff
> and wants midi clocks because their equipment will process stuff in
> realtime.
> All in all, i'm all for timestamps because this is a software api, and
> we work
> with software in a multitasking OS. Thats why my original mail is
> "forcing absolute timestamps". It means, whathever the input is, my
> softsynth
> will only work with timestamps, so timestamps need to be forced.

MIDI clock sync (slave) should be handled by the application and by its
very nature will not allow scheduling events ahead of time.

> > For a software synthesizer the MIDI messages received at some UST
> > can be mapped to a corresponding MSC value and then rendered at
> > a constant offset from this MSC, most likely the audio I/O latency
> > (the audio I/O latency may not be the same for all inputs/outputs,
> > also since MIDI messages always arrive late a small extra latency
> > should be introduced in this case by increasing the MIDI message's
> > UST by a constant value in order to compensate for the MIDI
> > interface and scheduling latency so they arrive a little early
> > instead of late in order to reduce jitter with MIDI messages
> > arriving near buffer bounderies).
> 
> Bad idea, as long as things are not audible, dont adding extra crap
> is the best. Midi hardware works like this and the delay is even
> higher,
> yet you cant hear it. So I think this is beyond pointless. 

I disagree. I'd rather have a small extra latency than jitter.

-martijn





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
