From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [PATCH] 1/3 Implement generic device DMA mapping support
Date: Mon, 1 Mar 2004 18:22:24 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040301182224.M24955@flint.arm.linux.org.uk>
References: <20040229223820.C17862@flint.arm.linux.org.uk> <s5heksch8xf.wl@alsa2.suse.de> <20040301174517.J24955@flint.arm.linux.org.uk> <s5hznb0foar.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hznb0foar.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, Mar 01, 2004 at 06:51:56PM +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 01, 2004 at 06:51:56PM +0100, Takashi Iwai wrote:
> a small concern about GFP_KERNEL is that i experienced the stall when
> the kernel tried to allocate large continuous pages with GFP_KERNEL,
> e.g. modprobe stops infinitely in the module init phase (and you
> cannot even interrupt that process).
> 
> does dma_alloc_coherent(GFP_KERNEL) with big pages work without stall?

It depends where the stall was coming from.  Do you have any further
details?

Also, on a similar note, I hope someone noticed one of the comments I
added in the second patch:

+ *
+ * Really, we want to move this type of thing into dma_alloc_coherent()
+ * so dma_mask doesn't have to be messed with.

(referring to the hack towards the top of memalloc.c.)

This is something which really needs solving more cleanly.  What I
think you're trying to do is to allocate pages for devices whose
DMA mask indicates (eg) 28 bit addressing is possible, but without
the "ISA DMA" (<16MB) restriction?  Could you confirm this?

If this is correct, I suspect it may be something which is not
limited to sound devices, and as such should probably be covered
by the generic code (iow, dma_alloc_coherent.)  However, that's
going to require discussion with other several people.

Currently, x86 dma_alloc_coherent() is:

        if (dev == NULL || (*dev->dma_mask < 0xffffffff))
                gfp |= GFP_DMA;
        ret = (void *)__get_free_pages(gfp, get_order(size));
 
        if (ret != NULL) {
                memset(ret, 0, size);
                *dma_handle = virt_to_phys(ret);
        }
        return ret;

I'm thinking of something more like:

	order = get_order(size);

	mask = 16*1024*1024-1;
	if (dev)
		mask = dev->dma_mask;

	while (1) {
		ret = (void *)__get_free_pages(gfp, order);

		if (ret == NULL || gfp & GFP_DMA)
			break;

		handle = virt_to_phys(ret);
		if ((handle & ~mask) == 0) {
			memset(ret, 0, size);
			*dma_handle = handle;
			break;
		}

		free_pages((unsigned long)ret, order);
		gfp |= GFP_DMA;
	}

	return ret;

Does that look reasonable?  If so, I'll float the idea around x86
people.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
