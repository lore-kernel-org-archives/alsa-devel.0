From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] ALSA: remove magic cast (0/6)
Date: Mon, 14 Jun 2004 20:18:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0406142003570.1795@pnote.perex-int.cz>
References: <200406141555.i5EFtD7g013906@melkki.cs.helsinki.fi>
 <s5hk6yadspp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from outgoing.perex-int.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 02DAB36A
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2004 20:19:02 +0200 (MEST)
In-Reply-To: <s5hk6yadspp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Jun 2004, Takashi Iwai wrote:

> > This patch remove snd_magic_cast from the kernel.  It's on top of the
> > kcalloc() patch and was compile-tested with allyesconfig.
> 
> Thanks for the patch.
> 
> Did you already make a patch to remove hidden_kmalloc and
> hidden_vmalloc wrappers, or do I miss it?  They are also suprefluous.
> 
> Jaroslav, what do you think about removing kmalloc/vmalloc wrappers
> and magic stuffs from the kernel tree?
> 
> For me, it's ok to remove them from the linux kernel tree
> (ie. alsa-kernel tree).  I agree that they are not needed for the
> matured drivers.  For the experimental drivers, We can provide another
> type check mechanism in alsa-driver tree locally.

I think that we need to separate the patch:

1) removal of own memory pool (check for memory leaks)
2) magic stuff

The structure mistakes usually ends with an oops, but the memory leaks 
cannot be detected easy inside the kernel.

I don't like too much the idea to remove the own memory pool in the debug
mode. It helped me in past numerous times and I think that ALSA is one
from the clean subsystems in this area. I don't understand the kernel
developers - there is no replacement. Yes, it's good only for debugging,
but why not make debugging easier for other developers as well with
proposing a general solution?

Regarding the magic stuffs - I do not care so much. It can be removed now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
