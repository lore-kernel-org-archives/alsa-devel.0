From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: buffer producer/consumer sync
Date: Wed, 31 Mar 2004 09:53:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040331095306.A32258@flint.arm.linux.org.uk>
References: <F509E6111989D311B63700805FA761DA0D82DE6E@DBDE01> <20040331083114.C27804@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403310936170.1950@pnote.perex-int.cz> <20040331085330.A30701@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311004040.1950@pnote.perex-int.cz> <20040331091124.B30701@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311027290.1950@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403311027290.1950@pnote.perex-int.cz>; from perex@suse.cz on Wed, Mar 31, 2004 at 10:29:06AM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "Gupta, Kshitij" <kshitij@ti.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 31, 2004 at 10:29:06AM +0200, Jaroslav Kysela wrote:
> On Wed, 31 Mar 2004, Russell King wrote:
> > Keeping the existing ->nopage will not work - there is no way to get to
> > a struct page on ARM given the information available to the ALSA code.
> 
> Looking to arch/arm/mm/consistent.c - vm_region_find / pfn_to_page?

No - we don't have a pfn to start with, and I'm not implementing an
interface which returns a struct page because, as was agreed on
linux-arch, such an interface is completely wrong.

The correct interface is dma_mmap_coherent().

I'm actually tempted to provide dma_mmap_coherent() and just let
everyone else whinge and moan that the API doesn't meet their
expectations.

BTW, ARM also needs the mark_pages and unmark_pages functions commented
out since they're also trying to use virt_to_page() on virtual addresses
that this function is not supposed to - except for the ISA DMA case
(and yes, we have ISA DMA-based sound cards as well.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
