From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: Forcing an absolute timestamp for every midi event.
Date: Mon, 19 Aug 2002 05:07:34 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020819050734.0e3e0a7c.coding@reduz.com.ar>
References: <20020818055740.2af8e3e7.coding@reduz.com.ar>
	<000c01c246f3$bfed4370$0400a8c0@martijn>
	<20020818195848.6ec26f96.coding@reduz.com.ar>
	<002a01c2474b$842b6170$0400a8c0@martijn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from john.anime.com.ar ([64.113.39.216])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA17041
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 10:07:38 +0200
Received: from server (OL110-150.fibertel.com.ar [24.232.150.110])
	by john.anime.com.ar (8.9.3/8.9.3) with SMTP id EAA30330
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 04:07:28 -0400
In-Reply-To: <002a01c2474b$842b6170$0400a8c0@martijn>
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

On Mon, 19 Aug 2002 07:41:30 +0100
"Martijn Sipkema" <msipkema@sipkema-digital.com> wrote:

> [...]
> > > - Callback based.
> > 
> > Callbacks on midi are retarded, and VERY annoying. It's simply
> > throwing more work to the programmer which the lib can and should
> > do. Seriosly, think about it, what is better?
> 
> Actually I was talking about the audio API in this case.

oh, nevermind then! :)
I thought all that fuzz was for midi. sorry!

> 
> > > - All frames with a particular MSC occur at the same time. (I
> > > don't think
> > >  OpenML requires this, EASI does have this with its 'position')
> > > - The audio callback provides an MSC value for every buffer
> > > corresponding
> > >  to the first frame in the buffer.
> > 
> > fine, what happens if your app xruns the audio buffer for X time?
> > all the count gets screwed?
> > you will shutdown the app like jack? will you ask devices for
> > sync? will you drop events? 
> 
> The application can detect xruns by looking at the MSCs.

Well, i guess i didnt make myself clear enough.
Technically, when you use some count/clock/tick based method
for doing things, there is a certain hardware that generates such
things.
How are you sure that you will be able to generate those reliably
within
the OS? The only way is generating them in realtime, and prequeuing
would be impossible. It happens the same when the OS generates
midi clocks, if the load affects wathever is timing internally,
all your queue gets screwed. This has its uses i guess anyway.

> 
> > > - The audio callback provides an UST value for every input
> > > buffer
> > >  corresponding to the end of that buffer/start of the next
> > >  buffer.
> > 
> > This is actually a great idea, Very good for audio/video
> > syncronization,
> > or for JACK. Which may have to process serial chained clients in
> > the graph,
> > Even if not 100% necesary for midi, it  could also make good use
> > of it. Doesnt alsa already support
> > something like that? Still tho, it would need to have to handle
> > xruns.
> 
> This is absolutely necessary for MIDI, or else scheduling MIDI to
> UST doesn't make much sense.

Of course it is, otherwise discussing it would be out of the question
;)
What i mean is the audio callback prooviding the UST time. I mean it's
not necesary
since you can compute the delay in time from ust and the audio buffer
size, but
I am _definitively_ in favor of this. Alsa should proovide this, and
JACK _must_ do it,
so clients can syncronize properly. 

> MIDI clock sync (slave) should be handled by the application and by
> its very nature will not allow scheduling events ahead of time.

not clock sync, i mean the midi api. Thats why i think it's pointless.
ant hear it. So I think this is beyond pointless. 

> 
> I disagree. I'd rather have a small extra latency than jitter.
>

We're taling about something WAY beyond human-hearable latency.
Say you send the event, it will probably reach in nanoseconds if
things
go right, or useconds if things go not so right. The event would
need to delay like, 5 milliseconds for you to notice any jitter.
And this will _never_ happen. Absolutely *never*. 


Well, all in all we're both talking about the same. ALSA and JACK
should proovide
access to some timer similar to UST. Now the real problem is the
implementation.
How to do this? Not all architectures proovide a secondary clock for
such things,
and on X86 I cant think of something other than the pentium cycle
counter.

Juan Linietsky



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
