From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Forcing an absolute timestamp for every midi event.
Date: Sun, 18 Aug 2002 21:12:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000c01c246f3$bfed4370$0400a8c0@martijn>
References: <20020818055740.2af8e3e7.coding@reduz.com.ar>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA06017
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 21:16:23 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Juan Linietsky <coding@reduz.com.ar>, alsa-devel@alsa-project.org, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

> Hi! I wanted to ask, how about forcing
> an absolute timestamp for _every_ midi event?
> I think this would be great for softsynths,
> so they dont need to work with root/schedfifo/lowlatency
> to have a decent timing. Not allways you are willing
> to process midi at the lowest latency possible.
> I say because you dont really need all that if you
> sequence in the computer and control softsynths and maybe
> some external device. 
> This way, the softsynth gets the event with the timestamp,
> gets the current time, substracts the audio delay (latency) to that
> and just mixes internally in smaller blocks processing each 
> event in the right time.

I'm not sure what you mean, but below is what I think would be the
best approach for audio/MIDI I/O.

----

UST = unadjusted system time
MSC = media stream count

see also:

http://www.lurkertech.com/lg/time/intro.html

(synchronous) Audio I/O API
- Callback based.
- All buffers in a callback are of the same size.
- All frames with a particular MSC occur at the same time. (I don't think
 OpenML requires this, EASI does have this with its 'position')
- The audio callback provides an MSC value for every buffer corresponding
 to the first frame in the buffer.
- The (constant) latency (in frames) between an input and an output can be
 seen from the difference between their MSC values.
- The audio callback provides an UST value for every input buffer
 corresponding to the end of that buffer/start of the next buffer.
- The UST value for the start/end of an output buffer can be estimated.

MIDI I/O API
- MIDI messages are received with a UST stamp.
- Timestamps are measured at the start of the message on the wire.
- MIDI messages are either sent immediately or scheduled to UST.
- MIDI messages must have monotonically increasing timestamps if
 scheduled.

For a software synthesizer the MIDI messages received at some UST
can be mapped to a corresponding MSC value and then rendered at
a constant offset from this MSC, most likely the audio I/O latency
(the audio I/O latency may not be the same for all inputs/outputs,
also since MIDI messages always arrive late a small extra latency
should be introduced in this case by increasing the MIDI message's
UST by a constant value in order to compensate for the MIDI interface
and scheduling latency so they arrive a little early instead of late
in order to reduce jitter with MIDI messages arriving near buffer
bounderies).
MIDI -> audio output latency would then be slightly higher (say 2ms,
noting that transmitting a note-on message already takes 3*320usec)
then audio I/O latency.



--martijn





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
