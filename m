From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [PATCH] 2/3 Implement generic device DMA mapping support
Date: Sun, 29 Feb 2004 22:42:14 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040229224214.D17862@flint.arm.linux.org.uk>
References: <20040229223820.C17862@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040229223820.C17862@flint.arm.linux.org.uk>; from rmk+alsa@arm.linux.org.uk on Sun, Feb 29, 2004 at 10:38:20PM +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is the first shot at this - I've tested it on ARM, covering both
ISA ALSA devices on a PCI machine, and driver model devices on a non-
PCI, non-ISA machine.  However, it needs more testing.  Can people
on alsa-devel please test these patches.

Convert PCI-based memory allocators to use the new driver model-based
allocators.

diff -urpN orig/sound/core/memalloc.c linux/sound/core/memalloc.c
--- orig/sound/core/memalloc.c	Sun Feb 29 18:32:23 2004
+++ linux/sound/core/memalloc.c	Sun Feb 29 18:32:07 2004
@@ -78,9 +78,9 @@ struct snd_mem_list {
 #define HACK_PCI_ALLOC_CONSISTENT
 
 /*
- * A hack to allocate large buffers via pci_alloc_consistent()
+ * A hack to allocate large buffers via dma_alloc_coherent()
  *
- * since pci_alloc_consistent always tries GFP_DMA when the requested
+ * since dma_alloc_coherent always tries GFP_DMA when the requested
  * pci memory region is below 32bit, it happens quite often that even
  * 2 order of pages cannot be allocated.
  *
@@ -88,43 +88,41 @@ struct snd_mem_list {
  * allocation will be done without GFP_DMA.  if the area doesn't match
  * with the requested region, then realloate with the original dma_mask
  * again.
+ *
+ * Really, we want to move this type of thing into dma_alloc_coherent()
+ * so dma_mask doesn't have to be messed with.
  */
 
-static void *snd_pci_hack_alloc_consistent(struct pci_dev *hwdev, size_t size,
-				    dma_addr_t *dma_handle)
+static void *snd_dma_hack_alloc_coherent(struct device *dev, size_t size,
+					 dma_addr_t *dma_handle)
 {
 	void *ret;
-	u64 dma_mask, cdma_mask;
-	unsigned long mask;
+	u64 dma_mask;
 
-	if (hwdev == NULL)
-		return pci_alloc_consistent(hwdev, size, dma_handle);
-	dma_mask = hwdev->dma_mask;
-	cdma_mask = hwdev->consistent_dma_mask;
-	mask = (unsigned long)dma_mask && (unsigned long)cdma_mask;
-	hwdev->dma_mask = 0xffffffff; /* do without masking */
-	hwdev->consistent_dma_mask = 0xffffffff; /* do without masking */
-	ret = pci_alloc_consistent(hwdev, size, dma_handle);
-	hwdev->dma_mask = dma_mask; /* restore */
-	hwdev->consistent_dma_mask = cdma_mask; /* restore */
+	if (dev == NULL)
+		return dev_alloc_coherent(dev, size, dma_handle);
+	dma_mask = dev->dma_mask;
+	dev->dma_mask = 0xffffffff; /* do without masking */
+	ret = dev_alloc_coherent(dev, size, dma_handle, GFP_KERNEL);
+	dev->dma_mask = dma_mask; /* restore */
 	if (ret) {
 		/* obtained address is out of range? */
-		if (((unsigned long)*dma_handle + size - 1) & ~mask) {
+		if (((unsigned long)*dma_handle + size - 1) & ~dma_mask) {
 			/* reallocate with the proper mask */
-			pci_free_consistent(hwdev, size, ret, *dma_handle);
-			ret = pci_alloc_consistent(hwdev, size, dma_handle);
+			dma_free_coherent(dev, size, ret, *dma_handle);
+			ret = dma_alloc_coherent(dev, size, dma_handle, GFP_KERNEL);
 		}
 	} else {
 		/* wish to success now with the proper mask... */
-		if (mask != 0xffffffffUL)
-			ret = pci_alloc_consistent(hwdev, size, dma_handle);
+		if (dma_mask != 0xffffffffUL)
+			ret = dma_alloc_coherent(dev, size, dma_handle, GFP_KERNEL);
 	}
 	return ret;
 }
 
-/* redefine pci_alloc_consistent for some architectures */
-#undef pci_alloc_consistent
-#define pci_alloc_consistent snd_pci_hack_alloc_consistent
+/* redefine dma_alloc_coherent for some architectures */
+#undef dma_alloc_coherent
+#define dma_alloc_coherent snd_dma_hack_alloc_coherent
 
 #endif /* arch */
 #endif /* CONFIG_PCI */
@@ -667,17 +665,7 @@ void *snd_malloc_pci_pages(struct pci_de
 			   size_t size,
 			   dma_addr_t *dma_addr)
 {
-	int pg;
-	void *res;
-
-	snd_assert(size > 0, return NULL);
-	snd_assert(dma_addr != NULL, return NULL);
-	for (pg = 0; PAGE_SIZE * (1 << pg) < size; pg++);
-	res = pci_alloc_consistent(pci, PAGE_SIZE * (1 << pg), dma_addr);
-	if (res != NULL) {
-		mark_pages(res, pg);
-	}
-	return res;
+	return snd_malloc_dev_pages(pci ? &pci->dev : NULL, size, dma_addr);
 }
 
 /**
@@ -699,17 +687,8 @@ void *snd_malloc_pci_pages_fallback(stru
 				    dma_addr_t *dma_addr,
 				    size_t *res_size)
 {
-	void *res;
-
-	snd_assert(res_size != NULL, return NULL);
-	do {
-		if ((res = snd_malloc_pci_pages(pci, size, dma_addr)) != NULL) {
-			*res_size = size;
-			return res;
-		}
-		size >>= 1;
-	} while (size >= PAGE_SIZE);
-	return NULL;
+	return snd_malloc_dev_pages_fallback(pci ? &pci->dev : NULL, size,
+					     dma_addr, res_size);
 }
 
 /**
@@ -726,24 +705,10 @@ void snd_free_pci_pages(struct pci_dev *
 			void *ptr,
 			dma_addr_t dma_addr)
 {
-	int pg;
-
-	if (ptr == NULL)
-		return;
-	for (pg = 0; PAGE_SIZE * (1 << pg) < size; pg++);
-	unmark_pages(ptr, pg);
-	pci_free_consistent(pci, PAGE_SIZE * (1 << pg), ptr, dma_addr);
+	snd_free_dev_pages(pci ? &pci->dev : NULL, size, ptr, dma_addr);
 }
 
 
-#if defined(__i386__)
-/*
- * on ix86, we allocate a page with GFP_KERNEL to assure the
- * allocation.  the code is almost same with kernel/i386/pci-dma.c but
- * it allocates only a single page and checks the validity of the
- * page address with the given pci dma mask.
- */
-
 /**
  * snd_malloc_pci_page - allocate a page in the valid pci dma mask
  * @pci: pci device pointer
@@ -757,45 +722,9 @@ void snd_free_pci_pages(struct pci_dev *
  */
 void *snd_malloc_pci_page(struct pci_dev *pci, dma_addr_t *addrp)
 {
-	void *ptr;
-	dma_addr_t addr;
-	unsigned long mask;
-
-	mask = pci ? (unsigned long)pci->consistent_dma_mask : 0x00ffffffUL;
-	ptr = (void *)__get_free_page(GFP_KERNEL);
-	if (ptr) {
-		addr = virt_to_phys(ptr);
-		if (((unsigned long)addr + PAGE_SIZE - 1) & ~mask) {
-			/* try to reallocate with the GFP_DMA */
-			free_page((unsigned long)ptr);
-			/* use GFP_ATOMIC for the DMA zone to avoid stall */
-			ptr = (void *)__get_free_page(GFP_ATOMIC | GFP_DMA);
-			if (ptr) /* ok, the address must be within lower 16MB... */
-				addr = virt_to_phys(ptr);
-			else
-				addr = 0;
-		}
-	} else
-		addr = 0;
-	if (ptr) {
-		memset(ptr, 0, PAGE_SIZE);
-		mark_pages(ptr, 0);
-	}
-	*addrp = addr;
-	return ptr;
-}
-#else
-
-/* on other architectures, call snd_malloc_pci_pages() helper function
- * which uses pci_alloc_consistent().
- */
-void *snd_malloc_pci_page(struct pci_dev *pci, dma_addr_t *addrp)
-{
 	return snd_malloc_pci_pages(pci, PAGE_SIZE, addrp);
 }
 
-#endif
-
 #if 0 /* for kernel-doc */
 /**
  * snd_free_pci_page - release a page


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
