From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: ALSAseq and timing (and audio plugins)
Date: Tue, 13 Aug 2002 23:18:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020813211827.GB30290@idefix.fvdpol.home.nl>
References: <20020811201426.5f7306cb.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail2.home.nl (mail2.home.nl [213.51.129.226])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA28705
	for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2002 23:18:17 +0200
Content-Disposition: inline
In-Reply-To: <20020811201426.5f7306cb.coding@reduz.com.ar>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Juan Linietsky <coding@reduz.com.ar>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Juan,

the ALSA sequencer has for every queue internally a queue for events
scheduled in absolute time and in tick/beats. According to the internal time
reference the event is dispatched at the required (real) time. 

For softsynth applications the events should be dispatched ahead of time
(depending on the buffer size/latency in the synthesis application). At this
moment there is no provision to register a listner with a negative
pre-delay. A (feasable and logical) application workaround is to configure
this pre-delay in the application generating the events (if known), or
otherwise when the event is not known ahead it can't do better than 'play as
soon as possible' anyhow.

If your synth works with a large buffer size you'll need to calculate the
start of trigger from the timestamp in the event.

For better support of softsynths I'm thinking about a special hook in
alsa-lib (userland) or jack/laspda where for the audio fragment/buffer an
array with the alsa sequencer events is supplied.

The sample buffer (to be output) has:
- # number of samples
- channels, sample rate & other sample specific parameters
- start time of buffer 
- end time of buffer 
- array of events

The start & end time are needed to determine the current pitch the transport
is doing (ie. to cope with varispeed) Playing the stream backwards would
remain a big challange still.. 

Reality is that I'm very tight on my free time, so don't expect to see code
soon....


Cheers,
Frank.


On Sun, Aug 11, 2002 at 08:14:26PM -0300, Juan Linietsky wrote:
> Hi, i'm trying to implement a proper timing control in a sequencer
> client implementation,
> but i have a question not covered in the documentation. Basically,
> does alsalib or alsa
> do any kind of timing conversion or something at the time of the event
> arrival?
> what i mean is, basically my seq client app (a softsynth) has to to
> take care of _all_ kind of timings?
> (direct/timestamp absolute and relative/tick), or does alsa proovide
> some method (for timing conversion or something) so i can easily parse
> those? This is basically so i can process audio in large blocks and
> sync properly with the audio being played, even if there is a certain
> latency. I checked out
> some existing apps (timidity and iiwusynth) and none seem to bother
> about checking the time of
> the event, so they'll screwup when using bigger audio buffersizes. 
> Has this been ever implemented? 
> 
> Thanks!
> 
> Juan Linietsky
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
