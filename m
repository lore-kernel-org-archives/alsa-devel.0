From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: EMU10K1 and the extra voice
Date: Wed, 9 Jun 2004 09:21:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0406090909160.1767@pnote.perex-int.cz>
References: <20040605125936.GA3478@lost.org.uk> <Pine.LNX.4.58.0406061234350.1780@pnote.perex-int.cz>
 <20040609003555.GA4284@lost.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040609003555.GA4284@lost.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Purnell <cjp@lost.org.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Jun 2004, Chris Purnell wrote:

> On Sun, Jun 06, 2004 at 12:38:22PM +0200, Jaroslav Kysela wrote:
> > On Sat, 5 Jun 2004, Chris Purnell wrote:
> > 
> > > For PCM playback the EMU10K1 driver is allocating an extra voice.
> > > This is somewhat wastefull and I kind of need all 64 voices.
> > > Is appears to be using it to generate the period interrupts.
> > > Does anyone know what it would take to rewrite the driver to
> > > not need this extra voice?
> > 
> > I'm not sure, if it's possible in a simple way. The extra voice is
> > required to do the proper interrupt acknowledge. If I remember correctly,
> > the interrupts are going faster than voice position otherwise.
> > 
> > Anyway, it wouldn't be a big problem to update driver and create a new 
> > (ONE!) PCM device with multiple mixed channels (up to 63).
> 
> I've been having a look at how the other driver work (that is the
> oss like driver in the linux kernel).  It uses the sound cards timer
> interrupt.  Which the alsa driver appears not to be using at all.
> What it does is set the timer interval to that of the shotest period
> time in use.  If a period time is twice that of the timer interval is
> it serviced every other timer interrupt.  If it is three times ... etc.
> That way you tipically get an interrupt slightly more often than end of
> the period.

1. how you ensure that PCM stream starts EXACTLY at timer interrupt?
2. I prefer to reserve timer for sequencer purposes

> Another concern I have about using a PCM voice for timing is
> all those wasted DMA cycles.

If we create a PCM with multiple channels (3+) then the overhead is 
minimal, because only one voice will do this timing job. Also we reduce 
the interrupt handler / stream position overhead.

> What I was wanting all those PCM voices for was OpenAL sources.
> I'm writing a OpenAL that uses the hardware mixing capabilities
> of the emu10k1 series sound cards.  It's almost there but I've
> come across a bigger problem.  It is much faster to use the
> existing, software mixing, OpenAL.  I've gone over my code and
> it is definitly doing less work.  Some there must be something
> simultaneously using all those PCM devices that is slowing my
> computer down.  There could be some large overhead starting or
> stopping the PCM devices.  It could be all those extra interrupts
> or all the extra data going over the PCI bus.  I don't know.
> I'm going to have to do some more testing.

Yes, I'm interested, too. But simple expression shows that 64 voices 
saturates about 5% of the PCI bus at 48kHz:

48000 * 2 = 96000
96000 * 64 = 6144000
6144000 bytes = 6MB/sec (comparing 133MB/sec - teoretical PCI limit)

Of course, there is always some overhead with non-busmaster-DMA PCI 
transactions, but I think that we don't go above 10% of the bus 
saturation.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
