From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: rme9652: possible deadlock
Date: Mon, 28 Apr 2003 11:58:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304281110360.1603-100000@pnote.perex-int.cz>
References: <3EACED44.2020102@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EACED44.2020102@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Jeremy Hall <jhall@maoz.com>, "paul@linuxaudiosystems.com" <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Apr 2003, Abramo Bagnara wrote:

> Jeremy Hall ha scritto:
> > Will this fix allow both CPUs to run snd_pcm_period_elapsed() and friends 
> > concurrently and then if XRUN is encountered grab the group lock, or will 
> > one stream run at a time, in effect only allowing one card to process at a 
> > time?
> 
> As I've pointed to Jaroslav, current CVS code does not permit to both 
> CPUs to run the interrupt handler of two linked streams concurrently.
> 
> This is due to unconditional substitution of stream specific lock with a 
> linked group lock.
> 
> This is of course deadlock safe, but I think it's not the right solution.

Sure, it was 1st version ;-)

> I draw my current proposal (my previous proposal to Jaroslav concerning 
> that was flawed):
> 
> let's call stream specific locks S and the linked group lock G.
> 
> Whomever need to take stream specific lock take S.
> 
> When this need to be promoted to G, my proposal is to use code like this:
> 
> 	if (!spin_trylock(G)) {
> 		spin_unlock(S);
> 		spin_lock(G);
> 		spin_lock(S);
> 	}
> 
> This should solve all deadlock issues while retaining minimal lock 
> granularity.

It seems a bit complicated to me. We can do easy this block:

read_lock(link_manager);
spin_lock(stream);
....
if (stream_in_group)
   spin_lock(group);
....
if (stream_in_group)
   spin_unlock(group);
....
spin_unlock(stream);
read_unlock(link_manager);

I cannot imagine any deadlock with this locking scheme, because stream 
locks are independent now.

Code is now in CVS for revision.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
