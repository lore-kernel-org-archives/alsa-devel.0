From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: [linux-audio-dev] Re: Forcing an absolute timestamp for every midi event.
Date: Sun, 18 Aug 2002 23:18:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020818211826.GA7440@idefix.fvdpol.home.nl>
References: <20020818055740.2af8e3e7.coding@reduz.com.ar> <000c01c246f3$bfed4370$0400a8c0@martijn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail4.home.nl (mail4.home.nl [213.51.129.228])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA07615
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 23:18:19 +0200
Content-Disposition: inline
In-Reply-To: <000c01c246f3$bfed4370$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-dev@music.columbia.edu
Cc: Juan Linietsky <coding@reduz.com.ar>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Martijn,

I read the pages explaining the position of UST for synchronising audio/midi
etc. It really looks good! 

It this moment the ALSA sequencer API supports already accurate timestamping
of incoming midi data, but since the it is not coupled to the audio streams
synchronisation is still tricky unless you use the audio frame interrupt as
a clock source. 

Over time I'd like to migrate the more complex portions of the ALSA
sequencer from kernel to user space; leaving only the minimal required
functions in kernel (eg. timestamping/micro scheduling). All of this has yet
to be determined of course, it are just thoughts for the future direction. 

Is there already a commonly available UST on linux? To my knowledge the only
thing that comes close is the (cpu specific) cycle counter.

Frank.


On Sun, Aug 18, 2002 at 09:12:52PM +0100, Martijn Sipkema wrote:
> I'm not sure what you mean, but below is what I think would be the
> best approach for audio/MIDI I/O.
> 
> ----
> 
> UST = unadjusted system time
> MSC = media stream count
> 
> see also:
> 
> http://www.lurkertech.com/lg/time/intro.html
> 
> (synchronous) Audio I/O API
> - Callback based.
> - All buffers in a callback are of the same size.
> - All frames with a particular MSC occur at the same time. (I don't think
>  OpenML requires this, EASI does have this with its 'position')
> - The audio callback provides an MSC value for every buffer corresponding
>  to the first frame in the buffer.
> - The (constant) latency (in frames) between an input and an output can be
>  seen from the difference between their MSC values.
> - The audio callback provides an UST value for every input buffer
>  corresponding to the end of that buffer/start of the next buffer.
> - The UST value for the start/end of an output buffer can be estimated.
> 
> MIDI I/O API
> - MIDI messages are received with a UST stamp.
> - Timestamps are measured at the start of the message on the wire.
> - MIDI messages are either sent immediately or scheduled to UST.
> - MIDI messages must have monotonically increasing timestamps if
>  scheduled.
> 
> For a software synthesizer the MIDI messages received at some UST
> can be mapped to a corresponding MSC value and then rendered at
> a constant offset from this MSC, most likely the audio I/O latency
> (the audio I/O latency may not be the same for all inputs/outputs,
> also since MIDI messages always arrive late a small extra latency
> should be introduced in this case by increasing the MIDI message's
> UST by a constant value in order to compensate for the MIDI interface
> and scheduling latency so they arrive a little early instead of late
> in order to reduce jitter with MIDI messages arriving near buffer
> bounderies).
> MIDI -> audio output latency would then be slightly higher (say 2ms,
> noting that transmitting a note-on message already takes 3*320usec)
> then audio I/O latency.
> 
> 
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
