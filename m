From: Tim Goetze <tim@quitte.de>
Subject: Re: user mode sequencer timer?
Date: Wed, 21 Aug 2002 13:15:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0208210129240.682-100000@summer.quitte>
References: <20020820215848.GB3301@idefix.fvdpol.home.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA28272
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2002 13:17:05 +0200
In-Reply-To: <20020820215848.GB3301@idefix.fvdpol.home.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Frank van de Pol <fvdpol@home.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Welkom terug, Frank!

>I see 2 options for it (please correct me if I'm wrong since i've been away
>for too long):
>
>- sync the timer using SND_SEQ_EVENT_SETPOS_TIME events (and optionally
>  SND_SEQ_EVENT_QUEUE_SKEW). ALSA remains running it's own clock (system
>  clock, rtc, external clock), following your internal clock.
>
>- Use a PCM device as timing source (you'll need a reasonable small fragment
>  size though).
>
>- Add support for a userspace clock source eg. add some
>  "SND_SEQ_EVENT_CLOCK_ADVANCE" which would trigger a timer callback (hence
>  snd_seq_timer_interrupt()).

? :) That's three options, unless a PCM device already is a possible
trigger for the main sequencer timer as per first option.

Anyway, my favourite would be the last option. It would also allow
us to implement the kind of predelay soft synths need without a big
fuzz: a clock-master client would only need to advance the clock 
ahead of time.

Groetjes, Tim




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
