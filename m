From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: rme9652: possible deadlock
Date: Mon, 28 Apr 2003 10:58:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EACED44.2020102@libero.it>
References: <200304280823.h3S8NCUh029997@sith.maoz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304280823.h3S8NCUh029997@sith.maoz.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jeremy Hall <jhall@maoz.com>
Cc: Jaroslav Kysela <perex@suse.cz>, "paul@linuxaudiosystems.com" <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jeremy Hall ha scritto:
> Will this fix allow both CPUs to run snd_pcm_period_elapsed() and friends 
> concurrently and then if XRUN is encountered grab the group lock, or will 
> one stream run at a time, in effect only allowing one card to process at a 
> time?

As I've pointed to Jaroslav, current CVS code does not permit to both 
CPUs to run the interrupt handler of two linked streams concurrently.

This is due to unconditional substitution of stream specific lock with a 
linked group lock.

This is of course deadlock safe, but I think it's not the right solution.

I draw my current proposal (my previous proposal to Jaroslav concerning 
that was flawed):

let's call stream specific locks S and the linked group lock G.

Whomever need to take stream specific lock take S.

When this need to be promoted to G, my proposal is to use code like this:

	if (!spin_trylock(G)) {
		spin_unlock(S);
		spin_lock(G);
		spin_lock(S);
	}

This should solve all deadlock issues while retaining minimal lock 
granularity.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
