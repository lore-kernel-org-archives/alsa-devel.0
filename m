From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: user mode sequencer timer?
Date: Tue, 20 Aug 2002 23:58:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020820215848.GB3301@idefix.fvdpol.home.nl>
References: <s5hu1lqssuk.wl@alsa2.suse.de> <Pine.LNX.4.21.0208192009370.673-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail8-sh.home.nl (mail8.home.nl [213.51.128.30])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA16703
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2002 23:58:26 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0208192009370.673-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Mon, Aug 19, 2002 at 08:40:34PM +0200, Tim Goetze wrote:
> >
> >the former is difficult, because the queue is driven by interrupts
> >from a timer source.  that is, a sequencer client must give signals at
> >the constant and fine period.  this is not a job what a user process
> >does.

Just nitpicking: The monotonicy is not required. The only thing needed is
that the interval is known - so we can use dynamically variable clock
frequency :-)

> >
> >the latter, controlling a queue, would be feasible.
> >in this case, you can change the tempo or time skew dynamically by
> >sending events via system-timer port (0:0) to a specified queue.
> >but anyway, a queue must run individually from the client.
> >
> >maybe i can give more specific answer if i understand your question
> >more clearly...
> 
> OK, here goes. I have a core here that processes MIDI and PCM. There's
> a RTC thread that controls event timing, synced to the sample clock. 
> So, internally, the application has a precise idea of the current 
> tempo, tick, time and frame.
> 
> Currently, events sent to ALSA sequencer ports are sent via
> snd_seq_event_output_direct(), with a 0 timestamp. 
> 
> Now what I'm looking for is a way to export this timer functionality
> to the sequencer system, ie make it possible for other clients to
> sync to this clock.
> 
> tim
> 

If I understand you correctly you actually want to slave ALSA to your
application's timing source.

I see 2 options for it (please correct me if I'm wrong since i've been away
for too long):

- sync the timer using SND_SEQ_EVENT_SETPOS_TIME events (and optionally
  SND_SEQ_EVENT_QUEUE_SKEW). ALSA remains running it's own clock (system
  clock, rtc, external clock), following your internal clock.

- Use a PCM device as timing source (you'll need a reasonable small fragment
  size though).

- Add support for a userspace clock source eg. add some
  "SND_SEQ_EVENT_CLOCK_ADVANCE" which would trigger a timer callback (hence
  snd_seq_timer_interrupt()).


Cheers,
Frank.

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
