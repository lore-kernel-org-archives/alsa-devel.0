From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 1.0.4rc1 release
Date: Tue, 30 Mar 2004 16:23:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403301603190.1835@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0403301505490.25443-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403301505490.25443-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Mar 2004, Clemens Ladisch wrote:

> Jaroslav Kysela wrote:
> > 1.0.4rc1 packages are out. Please, report compilation problems.
> 
> On a 2.2.19 kernel:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.2.19/misc/snd-*
> depmod:         synchronize_irq
> depmod:         tqueue_lock
> depmod:         waitqueue_lock

Missing inclusion of some header files?

> depmod: *** Unresolved symbols in /lib/modules/2.2.19/misc/snd-au88?0.o
> depmod:         snd_pci_compat_disable_device

Fixed.

> depmod: *** Unresolved symbols in /lib/modules/2.2.19/misc/snd.o
> depmod:         kernel_flag

What's this?

> How long do we want to support 2.2.x?

At least for 1.0.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
