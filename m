From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [PATCH] 1/3 Implement generic device DMA mapping support
Date: Tue, 2 Mar 2004 14:26:32 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040302142632.A12353@flint.arm.linux.org.uk>
References: <20040229223820.C17862@flint.arm.linux.org.uk> <s5heksch8xf.wl@alsa2.suse.de> <20040301174517.J24955@flint.arm.linux.org.uk> <s5hznb0foar.wl@alsa2.suse.de> <s5h8yijfiic.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h8yijfiic.wl@alsa2.suse.de>; from tiwai@suse.de on Tue, Mar 02, 2004 at 03:09:15PM +0100
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

On Tue, Mar 02, 2004 at 03:09:15PM +0100, Takashi Iwai wrote:
> At Mon, 01 Mar 2004 18:51:56 +0100,
> I wrote:
> > ah, yes, then it's fine.  thanks.
> 
> i was too fast to confirm that -- it turned out that this doesn't
> help.
> 
> since dma_alloc_coherent() is just a wrapper to pci_alloc_consistent()
> on x86, GFP_KERNEL is ignored.  instead, GFP_ATOMIC is used always.
> sigh...

include/asm-i386/dma-mapping.h:

void *dma_alloc_coherent(struct device *dev, size_t size,
                           dma_addr_t *dma_handle, int flag);

arch/i386/kernel/pci-dma.c:

void *dma_alloc_coherent(struct device *dev, size_t size,
                           dma_addr_t *dma_handle, int gfp)
{
        void *ret;
        /* ignore region specifiers */
        gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
 
        if (dev == NULL || (*dev->dma_mask < 0xffffffff))
                gfp |= GFP_DMA;
        ret = (void *)__get_free_pages(gfp, get_order(size));
 
        if (ret != NULL) {
                memset(ret, 0, size);
                *dma_handle = virt_to_phys(ret);
        }
        return ret;
}

I, therefore, suggest that you're not looking at a 2.6.3 kernel.  This
was changed from pci_alloc_consistent to dma_alloc_coherent on 22 Dec,
and was modified to take the GFP flags on 13 Jan.

dma_alloc_coherent() is therefore not a wrapper for pci_alloc_consistent().

However, include/asm-generic/pci-dma-compat.h which is included by
include/asm-i386/pci.h contains:

static inline void *
pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
                     dma_addr_t *dma_handle)
{
        return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, GFP_ATOMIC);
}

I'm not sure which kernel are you looking at, because it doesn't seem
to match mainline kernels.

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
