From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: CS4232 SBpro
Date: Mon, 4 Jul 2005 21:33:13 -0500
Message-ID: <20050705023313.GB30398@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I'm looking at adding support for the SBPro that is part of CS4232+ as a
separate pcm device.  This device is mutually exclusive with the
CS4231/6 component; its IRQ, DMA, and mixer settings are shared, and
according to the datasheet, using the SBPro registers after the CS4231
registers should be transparent.  So because of the shared resources, an
open on SBPro while CS4231 is in use should return -EBUSY, and vice
versa.  Also, an interrupt should only be handled by the driver of the
currently open device.

I created a new hwdep device for CS4232 in sb8.  I have thought about a
few approaches to managing user access and interrupts and wonder which
one is better:

- Use a spinlock as a flag in *_open fops to prevent CS4232 or sb8 from
concurrent opens.  Both interrupt handlers are registered, but a check
against the owner of the lock is made.  Disadvantage: wasted invocation
of the unused handler.  Question: where do I store the lock - add on to
the cs4232 card object?

- Every time the pcm is opened, call request_irq() to register the
currently opened device's interrupt handler.  Every time the pcm is
closed, call free_irq().  Disadvantage: slower opens and closes.
Question: can anything strange happen when doing this?  Maybe plugging
a Cardbus card while sound is not in use takes the IRQ away?

- Instead of trying to share two independent drivers, implement a
/proc/asound flag for CS4231 driver that switches between the two
internally.  Depending on the state of the flag, CS4231 fops and
interrupts are redirected to SB8 functions. Disadvantage: Makes
cs4231_lib dependent on sb8... unless it is possible to instead create
proxy fops and interrupt functions in cs4232/6, and call out to
cs4231_lib or sb8 appropriately.

You might ask why bother with this because the WSS component is a
superset of the SBPro: occasionally the WSS component of my CS4232 stops
working (I believe it is a hardware problem), but the SBPro component
continues to work.  I would like to be able to use the SBPro component
(as hw:1,0 or /dev/adsp) instead of being forced to power cycle the
machine or to manually remove snd-cs4232 modules and load snd-sb8
instead.  (It would be possible to load snd-cs4231 and snd-sb8 modules
concurrently if the resources were not shared.)

-- 
Ryan Underwood, <nemesis@icequake.net>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
