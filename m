From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: 2.6.4-rc1: ALSA makes invalid assumptions about memory types
Date: Sun, 29 Feb 2004 12:22:34 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040229122234.B28963@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

1) Memory types.

   In snd_dma_alloc_pages(), ALSA does this:

        case SNDRV_DMA_TYPE_PCI:
                dmab->area = snd_malloc_pci_pages(dev->dev.pci, size, &dmab->addr);

   which eventually comes down to this:

        res = pci_alloc_consistent(pci, PAGE_SIZE * (1 << pg), dma_addr);

   IOW:

	dmab->area = pci_alloc_consistent(dev->dev.pci, size, &dmab->addr);

   and in snd_pcm_lib_malloc_pages() we copy these into the runtime, thusly:

        runtime->dma_area = dmab.area;
        runtime->dma_addr = dmab.addr;
        runtime->dma_private = dmab.private_data;
        runtime->dma_bytes = size;

   However, in snd_pcm_mmap_data_nopage(), ALSA does this:

                vaddr = runtime->dma_area + offset;
                page = virt_to_page(vaddr);

   virt_to_page may _only_ be used on memory returned by get_free_page()
   and kmalloc(), and certainly not on memory returned by
   pci_alloc_consistent(). The only reason it works on x86 is because
   x86 is a fully cache coherent architecture, so pci_alloc_consistent()
   _just happens_ to be equivalent to get_free_pages() on that platform.
   Note that the same applies to dma_alloc_coherent().

   In other words, the above code will not work on non-cache coherent
   architectures without modification.

   I believe this needs discussing with the DMA API authors on LKML since
   AFAIK the kernel currently doesn't have a clear API to translate memory
   returned by either pci_alloc_consistent() or dma_alloc_coherent() back
   to it's consituent struct page pointers.

   Secondly the user space mapping will be marked as cacheable on some
   architectures, which would be Real Bad(tm) on architectures which
   are not DMA coherent.

   The way architectures mark their mappings uncacheable and/or only
   writecombining is architecture specific... see drivers/video/fbmem.c
   as an example.

2) PCM mmap control/status mappings

   These suffer from a similar cache coherency problem - you can not
   assume that two different mappings of the same page will not alias
   in the CPUs caches.

   In my case on ARM, not only must the user space mappings of these
   structures be marked uncacheable, but also the kernel space mappings
   of the same to ensure that accesses via both mappings always return
   up to date information.

   I have hacks in my tree which work around this using ARM specific
   functionality, but this is very much architecture specific at the
   moment, and I suspect requires a new kernel API for creating memory
   (it's similar to the DMA case above.)

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
