From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: An driver error when I using aplay!
Date: Tue, 8 Jun 2004 17:40:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040608174057.A24431@flint.arm.linux.org.uk>
References: <20040607145113.B28526@flint.arm.linux.org.uk> <s5h4qpn4fjk.wl@alsa2.suse.de> <20040607160442.D28526@flint.arm.linux.org.uk> <s5h1xkr4d04.wl@alsa2.suse.de> <20040607161812.F28526@flint.arm.linux.org.uk> <s5hzn7f2xkc.wl@alsa2.suse.de> <20040607164401.G28526@flint.arm.linux.org.uk> <s5hvfi32v4k.wl@alsa2.suse.de> <20040607190416.K28526@flint.arm.linux.org.uk> <s5hekoq2gpu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hekoq2gpu.wl@alsa2.suse.de>; from tiwai@suse.de on Tue, Jun 08, 2004 at 05:48:45PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Roc Wu <cooloney@yahoo.com.cn>, Clemens Ladisch <clemens@ladisch.de>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 08, 2004 at 05:48:45PM +0200, Takashi Iwai wrote:
> At Mon, 7 Jun 2004 19:04:16 +0100,
> Russell King wrote:
> > > > They also _may_ only affect the userspace mapping of
> > > > that memory and not kernel space, so this doesn't help the control
> > > > or status mmaped pages.
> > > 
> > > Oh yes, then how about to use a DMA page for the control/status mmap,
> > > too?
> > 
> > Oddly that's what I did on VIVT caches to get Alsa working a few months
> > ago, but its very unclean and the way I did it, it exposes the "dma"
> > address in the actual page - which would be a major security problem
> > if I let the code out.  As I said back then, I didn't have a clean
> > solution for this.
> 
> Well, i386 and x86-64 provide a function change_page_attr() for this
> purpose.  But it's also a horrible arch-spec hack.
> 
> How about to introduce a function like alloc_pages_noncached()?

Just a quick response on this point while I wait for a rebuild (because
I don't have time to think about the rest of your reply at the moment -
and then I'll probably forget about it by the end of tonight, sorry...)

I think you'll find that alloc_pages_noncached() is unimplementable on
x86 and other architectures.  Some architectures are unable to turn the
cache on and off on a per-page basis, while others can.  Some need to
ensure that the relative mappings of two pages fall on the same cache
colour.  Some need reprogramming of some hardware depending on where
stuff is mapped.  The list goes on and on...

Basically, I think you'll find that this part of the ALSA API isn't
universally implementable across all kernel architectures.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
