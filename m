From: Jeremy Hall <jhall@maoz.com>
Subject: Re: rme9652: possible deadlock
Date: Wed, 23 Apr 2003 11:06:22 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304231506.h3NF6NvB029642@sith.maoz.com>
References: <Pine.LNX.4.44.0304231123500.1280-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0304231123500.1280-100000@pnote.perex-int.cz> from
 Jaroslav Kysela at "Apr 23, 2003 11:51:32 am"
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

In the new year, Jaroslav Kysela wrote:
> On Tue, 22 Apr 2003, Jeremy Hall wrote:
> 
> > If both cards try to run snd_pcm_stop() at the same time, one on one CPU 
> > one on the other, how can disabling local interrupts help? The code takes 
> > great care to not try to acquire its own substream->runtime->lock because 
> > the calling process has already acquired this lock.  But if both are 
> > trying to run snd_pcm_stop at the same time, CPU0 will try to acquire 
> > CPU1's lock, and CPU1 will try to acquire CPU0's.  Since neither will give 
> > up his lock, deadlock will occur.
> 
> It's not true. Spinlocks work in this way:
> 
> 1) try acquire atomically lock
>    - success -> continue
>    - fail -> goto 1)
> 
> So, CPU0 will get lock and CPU1 will be in a loop until lock is released
> in SMP. The deadlock is if one CPU wants to enter to a spinlocked code
> area more than once. Because linked cards might be on different IRQ lines,
> there is a possibility for a deadlock for one CPU. But if you disable the
> interrupts for this CPU before you lock the spinlocked area, the deadlock
> cannot occur, because this CPU doesn't accept interrupts at all, thus it
> cannot try to acquire same lock again.
> 
ok, it might not be a deadlock, but here is how I see it as I read through 
the code: Let us start with _SND_PCM_ACTION()

in pcm_native.c: 606

res is set to 0

a read lock snd_pcm_link_lock is acquired on CPU0, caller's 
substream->runtime->lock is already acquired.  Because this is a macro, it 
is unclear to me fully how this plays out.

On CPU1, its substream->runtime->lock is acquired from its calling 
process.  If you are permitted to have multiple read locks, CPU1 might 
also acquire the read lock, if not, it will wait indefinitely here.

cheerfully cooking along, CPU0 begins a while loop, while s != substream, 
its given substream (itself), so in essence iterate through all substreams 
that aren't itself

{
if certain the iterator s is not equal to the substream the caller gave 
you, i.e. yourself, acquire the runtime lock.

CPU0 iterates through snd_pcm_pre_stop, correcting for errors etc for the 
substreams until it hits the one that CPU1 is processing.  Whether CPU1 is 
waiting on the read lock to be released or has iterated this far in the 
processing doesn't matter because neither will ever release their locks.  
Both CPUs will wait forever, or until they burn up, because each process 
is depending on a backdoor (if you will allow me to loosely use this term) 
to get the job done.

}

I do not intend to be patronizing, it just helps me to see things written 
out like this and helps expose misconceptions on my part. (I have a long 
way to go on learning kernel)

> > Since the only solution I can see at the moment is to only allow one card 
> > to process at a time, I find that repulsive and therefore would like to 
> > see a different solution.
> > 
> > Therefore I would like to see a mechanism brought down through the calling 
> > hierarchy so that alsa knows that all four substreams are linked and 
> > therefore should only be governed by a single lock and further more that 
> > if one card XRUNs and the other doesn't, the offensive card should put 
> > silence in his buffer to maintain sample-sync.
> 
> All cards (better linked streams) XRUNs at same moment in current
> implementation. The only drawback is that interrupts are processed for all
> streams separately. It might be optimized for streams with hardware sync,
> but it cannot be for streams without hardware sync. Also, the optimization
> is negligible in my eyes, because we can reduce only calls to determine
> the current position in the ring buffer, all other arbiter code must be
> preserved.
> 
They may XRUN at near the same time, but because interrupts are 
asynchronous, it is very possible for one card to process a different 
number of frames than the other (because of the XRUN) and because the 
application assumes that if a XRUN is reported it happened for the whole 
device.  If your buffer is 4096 frames per fragment, and for the 
simplistic case there are two fragments, somewhere in that lot one card 
XRUNs, the other doesn't.  Now one card is at time x, the other at (worst 
case) 4096 - x.  What does the application do? throw out its data for the 
whole fragment? (for both cards)

actually it could be a LONG ways off, it could be several periods off, in 
fact if they get out of synch, the application could read old data from 
the slow card's memory.  When does the application get woken? does alsa 
make sure that both cards are done before waking the application?

> > Both cards are indeed running from the same clock, but sometimes we can't 
> > get around to servicing an interrupt so we XRUN--things are going too fast 
> > for even the slightest gitter.
> > 
> > Consider the case where left channel data is on one card, right is on the 
> > other.  If sample-synch is broekn, the channels will drift out of phase, 
> > permanently, and the application has no idea it has happened.  I think a 
> > better solution than pot luck needs to happen, although it may indeed be 
> > happening--I just don't understand the alsa code very well.  In a 
> > professional environment, a XRUN isn't a good thing, but a partial XRUN is 
> > a desaster.
> 
> If we stop all linked streams at one time XRUN, application must restart 
> all things and the driver will GUERANTEE that the restarted streams are 
> in sample sync if hardware supports this feature. I don't see any problem 
> in this area.
> 
yes, if we stop them at one time, but we might not stop them at the "same" 
time.

> And yes, applications might use no-xrun mode. The sample sync is always 
> guaranteed, but the transferred stream might be invalid.
> 
What does jack use?

> Anyway, XRUNs are bad for "profi" audio. If you cannot avoid them with 
> your hardware and software configuration, it's bad. I see large areas in 
> hardware and software tuning for audio gurus.
> 
I'm working on them, one at a time. :) I'm having moderate success, 
however.

_J

> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
