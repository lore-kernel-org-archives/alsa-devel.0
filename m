From: Jeremy Hall <jhall@maoz.com>
Subject: Re: rme9652: possible deadlock
Date: Tue, 22 Apr 2003 15:22:07 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304221922.h3MJM7Y2025304@sith.maoz.com>
References: <Pine.LNX.4.44.0304221613310.1351-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0304221613310.1351-100000@pnote.perex-int.cz> from
 Jaroslav Kysela at "Apr 22, 2003 04:16:01 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jeremy Hall <jhall@maoz.com>, "paul@linuxaudiosystems.com" <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I wrote up a fix in the rme9652 code that fixes this and allows both cards 
to run, preferrably one on one cpu and one on the other.  The only 
remaining corner case is if both cards try to run snd_pcm_stop() at the 
exact same time.  This still doesn't work if you disable interrupts on the 
local CPU and it is not acceptable for me to have to lock a spin_lock and 
serialize the cards, allowing only one to run at a time.  In theory if you 
have both cards running, you can process twice the data in the same amount 
of time.  This should allow you to run 96000 at 64 frames per cycle with 
the same joy that I currently run 48000 at 64 frames_per_cycles--you're 
still moving the same amount of bits, just in the 48 case you're dropping 
half the channels (you'd have to see my pcm_multi posted to this list 
before)

I can provide my rme9652 patch if you'd like.

_J

In the new year, Jaroslav Kysela wrote:
> On Mon, 14 Apr 2003, Jeremy Hall wrote:
> 
> > Hi,
> > 
> > Consider the following:
> > 
> > Two RME9652's are running together and on different interrupts.
> > 
> > The master, in interrupt context, acquires its runtime->lock and begins 
> > snd_pcm_update_hw_ptr_interrupt()
> > 
> > At the same time, the second card, the slave, is behind, still in play 
> > mode, and wants to XRUN.  To do that, it must stop and restart all the 
> > substreams connected to it.  To do that, it must acquire the runtime lock 
> > of each, but the capture substream is locked in another interrupt.
> 
> Yes, there is possible deadlock. Fortunately, we can simply disable 
> interrupts for local CPU for critical area (spin_lock -> 
> spin_lock_irqsave). Fixed in CVS and thank you for the notice.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
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
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
