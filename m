From: Chris Purnell <cjp@lost.org.uk>
Subject: Re: EMU10K1 and the extra voice
Date: Wed, 9 Jun 2004 19:16:15 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040609191615.GA4529@lost.org.uk>
References: <20040605125936.GA3478@lost.org.uk> <Pine.LNX.4.58.0406061234350.1780@pnote.perex-int.cz> <20040609003555.GA4284@lost.org.uk> <Pine.LNX.4.58.0406090909160.1767@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406090909160.1767@pnote.perex-int.cz>
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

On Wed, Jun 09, 2004 at 09:21:42AM +0200, Jaroslav Kysela wrote:
> On Wed, 9 Jun 2004, Chris Purnell wrote:

> > I've been having a look at how the other driver work (that is the
> > oss like driver in the linux kernel).  It uses the sound cards timer
> > interrupt.  Which the alsa driver appears not to be using at all.
> > What it does is set the timer interval to that of the shotest period
> > time in use.  If a period time is twice that of the timer interval is
> > it serviced every other timer interrupt.  If it is three times ... etc.
> > That way you tipically get an interrupt slightly more often than end of
> > the period.
> 
> 1. how you ensure that PCM stream starts EXACTLY at timer interrupt?

The OSS style driver doesn't.  It just ensures that the interrupts happen
often enough to keep filling the buffer.

> 2. I prefer to reserve timer for sequencer purposes

If you think it will ever been used for that pourose.


I did think of a simple change that might have allowed me to do what I
want.  And that was to not allocate the extra voice when the number of
periods was one.  However when I set the number of periods to 1 I got
stuttering.  What I'm going is periodically calling
snd_pcm_avail_update(), snd_pcm_mmap_begin() and snd_pcm_mmap_commit()
without using ALSA for timing.  So if anyone was going to get away
with setting the number periods to 1 I thought I would.  Do you know
why that didn't work?


> > What I was wanting all those PCM voices for was OpenAL sources.
> > I'm writing a OpenAL that uses the hardware mixing capabilities
> > of the emu10k1 series sound cards.  It's almost there but I've
> > come across a bigger problem.  It is much faster to use the
> > existing, software mixing, OpenAL.  I've gone over my code and
> > it is definitly doing less work.  Some there must be something
> > simultaneously using all those PCM devices that is slowing my
> > computer down.  There could be some large overhead starting or
> > stopping the PCM devices.  It could be all those extra interrupts
> > or all the extra data going over the PCI bus.  I don't know.
> > I'm going to have to do some more testing.
> 
> Yes, I'm interested, too.

I've found out what the problem was.  I had left the bit where
I specify the period size and number commented out.  So it was
setting the period size as small as the driver would let it.
And so my computer was being overwhelmed with all those
interrupts.

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
