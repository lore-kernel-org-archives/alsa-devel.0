From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: Forcing an absolute timestamp for every midi event.
Date: Sun, 18 Aug 2002 14:48:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020818124850.GA2929@idefix.fvdpol.home.nl>
References: <20020818055740.2af8e3e7.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail2.home.nl (mail2.home.nl [213.51.129.226])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA00777
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 14:48:42 +0200
Content-Disposition: inline
In-Reply-To: <20020818055740.2af8e3e7.coding@reduz.com.ar>
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




On Sun, Aug 18, 2002 at 05:57:40AM -0300, Juan Linietsky wrote:
> Hi! I wanted to ask, how about forcing
> an absolute timestamp for _every_ midi event?

It's not 100% clear to me wat you mean. When using the sequencer api you
already have a timestamp (either tick/clock) for every event scheduled. Midi
data captured from eg. the midi input port is timestamped upon receive IRQ.

what is missing?


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

agreed; this is the whole concept of providing scheduling information
(ie timestamp) with the events. One hairy bit is the handling of time based
events versus tick based events in case your sequencer needs to cope with
a variable tempo or sync to midi clock sources.

Frank

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
