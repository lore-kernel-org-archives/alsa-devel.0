From: Chris Purnell <cjp@lost.org.uk>
Subject: Re: EMU10K1 and the extra voice
Date: Wed, 9 Jun 2004 00:35:55 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040609003555.GA4284@lost.org.uk>
References: <20040605125936.GA3478@lost.org.uk> <Pine.LNX.4.58.0406061234350.1780@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406061234350.1780@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 06, 2004 at 12:38:22PM +0200, Jaroslav Kysela wrote:
> On Sat, 5 Jun 2004, Chris Purnell wrote:
> 
> > For PCM playback the EMU10K1 driver is allocating an extra voice.
> > This is somewhat wastefull and I kind of need all 64 voices.
> > Is appears to be using it to generate the period interrupts.
> > Does anyone know what it would take to rewrite the driver to
> > not need this extra voice?
> 
> I'm not sure, if it's possible in a simple way. The extra voice is
> required to do the proper interrupt acknowledge. If I remember correctly,
> the interrupts are going faster than voice position otherwise.
> 
> Anyway, it wouldn't be a big problem to update driver and create a new 
> (ONE!) PCM device with multiple mixed channels (up to 63).

I've been having a look at how the other driver work (that is the
oss like driver in the linux kernel).  It uses the sound cards timer
interrupt.  Which the alsa driver appears not to be using at all.
What it does is set the timer interval to that of the shotest period
time in use.  If a period time is twice that of the timer interval is
it serviced every other timer interrupt.  If it is three times ... etc.
That way you tipically get an interrupt slightly more often than end of
the period.

If you are going to use a single timing device for all PCM devices
I don't see any advantage of using a PCM voice over the cards timer.
But they may be a better way to use it than the other driver.

Another concern I have about using a PCM voice for timing is
all those wasted DMA cycles.

What I was wanting all those PCM voices for was OpenAL sources.
I'm writing a OpenAL that uses the hardware mixing capabilities
of the emu10k1 series sound cards.  It's almost there but I've
come across a bigger problem.  It is much faster to use the
existing, software mixing, OpenAL.  I've gone over my code and
it is definitly doing less work.  Some there must be something
simultaneously using all those PCM devices that is slowing my
computer down.  There could be some large overhead starting or
stopping the PCM devices.  It could be all those extra interrupts
or all the extra data going over the PCI bus.  I don't know.
I'm going to have to do some more testing.

-- 
Christopher John Purnell  | I thought I'd found a reason to live
http://www.lost.org.uk/   | Just like before when I was a child
--------------------------| Only to find that dreams made of sand
What gods do you pray to? | Would just fall apart and slip through my hands


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
