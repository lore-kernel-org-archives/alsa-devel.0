From: Jeremy Hall <jhall@maoz.com>
Subject: Re: rme9652: possible deadlock
Date: Tue, 22 Apr 2003 18:04:01 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304222204.h3MM41Mb026010@sith.maoz.com>
References: <Pine.LNX.4.44.0304222136461.1351-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0304222136461.1351-100000@pnote.perex-int.cz> from
 Jaroslav Kysela at "Apr 22, 2003 09:42:52 pm"
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

If both cards try to run snd_pcm_stop() at the same time, one on one CPU 
one on the other, how can disabling local interrupts help? The code takes 
great care to not try to acquire its own substream->runtime->lock because 
the calling process has already acquired this lock.  But if both are 
trying to run snd_pcm_stop at the same time, CPU0 will try to acquire 
CPU1's lock, and CPU1 will try to acquire CPU0's.  Since neither will give 
up his lock, deadlock will occur.

Since the only solution I can see at the moment is to only allow one card 
to process at a time, I find that repulsive and therefore would like to 
see a different solution.

Therefore I would like to see a mechanism brought down through the calling 
hierarchy so that alsa knows that all four substreams are linked and 
therefore should only be governed by a single lock and further more that 
if one card XRUNs and the other doesn't, the offensive card should put 
silence in his buffer to maintain sample-sync.

Both cards are indeed running from the same clock, but sometimes we can't 
get around to servicing an interrupt so we XRUN--things are going too fast 
for even the slightest gitter.

Consider the case where left channel data is on one card, right is on the 
other.  If sample-synch is broekn, the channels will drift out of phase, 
permanently, and the application has no idea it has happened.  I think a 
better solution than pot luck needs to happen, although it may indeed be 
happening--I just don't understand the alsa code very well.  In a 
professional environment, a XRUN isn't a good thing, but a partial XRUN is 
a desaster.

Please understand I am not upset at you, I am not upset at all, I simply 
want to make my views known and to let you know this is something I feel 
quite strongly about.

_J

In the new year, Jaroslav Kysela wrote:
> On Tue, 22 Apr 2003, Jeremy Hall wrote:
> 
> > I wrote up a fix in the rme9652 code that fixes this and allows both cards 
> > to run, preferrably one on one cpu and one on the other.  The only 
> > remaining corner case is if both cards try to run snd_pcm_stop() at the 
> > exact same time.  This still doesn't work if you disable interrupts on the 
> > local CPU and it is not acceptable for me to have to lock a spin_lock and 
> > serialize the cards, allowing only one to run at a time.  In theory if you 
> 
> Sorry, but spinlocking of the arbiter code in interrupt has nothing to do 
> with the sample DMA transfers thus stream throughput. The streaming is not 
> stopped with disabling interrupts for local CPU.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
