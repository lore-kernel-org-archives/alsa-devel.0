From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: rme9652: possible deadlock
Date: Tue, 22 Apr 2003 21:42:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304222136461.1351-100000@pnote.perex-int.cz>
References: <200304221922.h3MJM7Y2025304@sith.maoz.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304221922.h3MJM7Y2025304@sith.maoz.com>
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

> I wrote up a fix in the rme9652 code that fixes this and allows both cards 
> to run, preferrably one on one cpu and one on the other.  The only 
> remaining corner case is if both cards try to run snd_pcm_stop() at the 
> exact same time.  This still doesn't work if you disable interrupts on the 
> local CPU and it is not acceptable for me to have to lock a spin_lock and 
> serialize the cards, allowing only one to run at a time.  In theory if you 

Sorry, but spinlocking of the arbiter code in interrupt has nothing to do 
with the sample DMA transfers thus stream throughput. The streaming is not 
stopped with disabling interrupts for local CPU.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
