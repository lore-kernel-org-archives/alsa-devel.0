From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: rme9652: possible deadlock
Date: Wed, 23 Apr 2003 11:51:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304231123500.1280-100000@pnote.perex-int.cz>
References: <200304222204.h3MM41Mb026010@sith.maoz.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304222204.h3MM41Mb026010@sith.maoz.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jeremy Hall <jhall@maoz.com>
Cc: "paul@linuxaudiosystems.com" <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 22 Apr 2003, Jeremy Hall wrote:

> If both cards try to run snd_pcm_stop() at the same time, one on one CPU 
> one on the other, how can disabling local interrupts help? The code takes 
> great care to not try to acquire its own substream->runtime->lock because 
> the calling process has already acquired this lock.  But if both are 
> trying to run snd_pcm_stop at the same time, CPU0 will try to acquire 
> CPU1's lock, and CPU1 will try to acquire CPU0's.  Since neither will give 
> up his lock, deadlock will occur.

It's not true. Spinlocks work in this way:

1) try acquire atomically lock
   - success -> continue
   - fail -> goto 1)

So, CPU0 will get lock and CPU1 will be in a loop until lock is released
in SMP. The deadlock is if one CPU wants to enter to a spinlocked code
area more than once. Because linked cards might be on different IRQ lines,
there is a possibility for a deadlock for one CPU. But if you disable the
interrupts for this CPU before you lock the spinlocked area, the deadlock
cannot occur, because this CPU doesn't accept interrupts at all, thus it
cannot try to acquire same lock again.

> Since the only solution I can see at the moment is to only allow one card 
> to process at a time, I find that repulsive and therefore would like to 
> see a different solution.
> 
> Therefore I would like to see a mechanism brought down through the calling 
> hierarchy so that alsa knows that all four substreams are linked and 
> therefore should only be governed by a single lock and further more that 
> if one card XRUNs and the other doesn't, the offensive card should put 
> silence in his buffer to maintain sample-sync.

All cards (better linked streams) XRUNs at same moment in current
implementation. The only drawback is that interrupts are processed for all
streams separately. It might be optimized for streams with hardware sync,
but it cannot be for streams without hardware sync. Also, the optimization
is negligible in my eyes, because we can reduce only calls to determine
the current position in the ring buffer, all other arbiter code must be
preserved.

> Both cards are indeed running from the same clock, but sometimes we can't 
> get around to servicing an interrupt so we XRUN--things are going too fast 
> for even the slightest gitter.
> 
> Consider the case where left channel data is on one card, right is on the 
> other.  If sample-synch is broekn, the channels will drift out of phase, 
> permanently, and the application has no idea it has happened.  I think a 
> better solution than pot luck needs to happen, although it may indeed be 
> happening--I just don't understand the alsa code very well.  In a 
> professional environment, a XRUN isn't a good thing, but a partial XRUN is 
> a desaster.

If we stop all linked streams at one time XRUN, application must restart 
all things and the driver will GUERANTEE that the restarted streams are 
in sample sync if hardware supports this feature. I don't see any problem 
in this area.

And yes, applications might use no-xrun mode. The sample sync is always 
guaranteed, but the transferred stream might be invalid.

Anyway, XRUNs are bad for "profi" audio. If you cannot avoid them with 
your hardware and software configuration, it's bad. I see large areas in 
hardware and software tuning for audio gurus.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
