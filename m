From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: rme9652: possible deadlock
Date: Tue, 22 Apr 2003 16:16:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304221613310.1351-100000@pnote.perex-int.cz>
References: <200304141847.h3EIl2T0014979@sith.maoz.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200304141847.h3EIl2T0014979@sith.maoz.com>
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

On Mon, 14 Apr 2003, Jeremy Hall wrote:

> Hi,
> 
> Consider the following:
> 
> Two RME9652's are running together and on different interrupts.
> 
> The master, in interrupt context, acquires its runtime->lock and begins 
> snd_pcm_update_hw_ptr_interrupt()
> 
> At the same time, the second card, the slave, is behind, still in play 
> mode, and wants to XRUN.  To do that, it must stop and restart all the 
> substreams connected to it.  To do that, it must acquire the runtime lock 
> of each, but the capture substream is locked in another interrupt.

Yes, there is possible deadlock. Fortunately, we can simply disable 
interrupts for local CPU for critical area (spin_lock -> 
spin_lock_irqsave). Fixed in CVS and thank you for the notice.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
