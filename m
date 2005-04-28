From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to tell how many frames gone to PCM
Date: Thu, 28 Apr 2005 10:25:45 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504281011230.16383-100000@studcom.urz.uni-halle.de>
References: <426FF6A3.5050304@pianodisc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <426FF6A3.5050304@pianodisc.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve deRosier <derosier@pianodisc.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Steve deRosier wrote:
> Forgeting the +4/PERIOD_SIZE hack I've got in there for a moment
> (I must have a culmative off-by-one error somewhere),

No, the events are usiong the wrong clock.  Real-time scheduling uses
the system clock instead of the timer source you've set for the queue.
That is, at every timer interrupt, ALSA checks whether the system time
has reached the scheduled event time.  OTOH, MIDI ticks are calculated
using the timer interrupt frequency.

> this player always seemed sloppy, where as the other player was
> real crisp.  Would I be guessing right that if several real-time
> scheduled events were supposed to go out, but built up till the
> tick happened, all of those would be sent out and then more events
> would buffer till the next tick?

Yes.  Events are sent out at every timer interrupt.  This is true for
both real-time and tick scheduled events

> Clemens Ladisch wrote:
> > The nice thing about using ticks is that you can set them up to be any
> > quantity you want (in this case probably the same as one PCM frame or
> > period).
>
> Ok, I'm changing to tick-based timing.  How do I setup my tick
> timing?  Is the sample code in the docs what I'm looking for?:

Yes.

> Ideas of the PPQ and BPM I should use to match 1 tick to 1 frame?

I'd use one quarter note per second (tempo = 1000000 microseconds per
quarter note) so that the sampling frequency can be used directly as
PPQ (ticks per quarter note).


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
