From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 1.0.4rc1 release
Date: Tue, 30 Mar 2004 15:09:48 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403301505490.25443-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0403291141430.1856@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0403291141430.1856@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 1.0.4rc1 packages are out. Please, report compilation problems.

On a 2.2.19 kernel:

depmod: *** Unresolved symbols in /lib/modules/2.2.19/misc/snd-*
depmod:         synchronize_irq
depmod:         tqueue_lock
depmod:         waitqueue_lock
depmod: *** Unresolved symbols in /lib/modules/2.2.19/misc/snd-au88?0.o
depmod:         snd_pci_compat_disable_device
depmod: *** Unresolved symbols in /lib/modules/2.2.19/misc/snd.o
depmod:         kernel_flag


How long do we want to support 2.2.x?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
