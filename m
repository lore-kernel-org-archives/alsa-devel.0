From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: [PATCH] 1/3 Implement generic device DMA mapping support
Date: Sun, 29 Feb 2004 22:38:20 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040229223820.C17862@flint.arm.linux.org.uk>
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
To: Jaroslav Kysela <perex@suse.cz>, Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is the first shot at this - I've tested it on ARM, covering both
ISA ALSA devices on a PCI machine, and driver model devices on a non-
PCI, non-ISA machine.  However, it needs more testing.  Can people
on alsa-devel please test these patches.

This patch adds support for the generic device/driver model to ALSA
for the sole purpose of supporting their DMA mapping functionality.

This patch changes snd_malloc_sgbuf_pages() to use this dma mapping
functionality.

diff -urpN orig/sound/core/Makefile linux/sound/core/Makefile
--- orig/sound/core/Makefile	Wed Feb 18 22:35:45 2004
+++ linux/sound/core/Makefile	Sun Feb 29 16:37:15 2004
@@ -15,10 +15,7 @@ endif
 snd-pcm-objs := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
 		pcm_memory.o
 
-snd-page-alloc-objs := memalloc.o
-ifeq ($(CONFIG_PCI),y)
-snd-page-alloc-objs += sgbuf.o
-endif
+snd-page-alloc-objs := memalloc.o sgbuf.o
 
 snd-rawmidi-objs  := rawmidi.o
 snd-timer-objs    := timer.o
diff -urpN orig/sound/core/memalloc.c linux/sound/core/memalloc.c
--- orig/sound/core/memalloc.c	Wed Feb 18 22:35:45 2004
+++ linux/sound/core/memalloc.c	Sun Feb 29 17:32:54 2004
@@ -157,6 +157,9 @@ static int compare_device(const struct s
 	case SNDRV_DMA_TYPE_SBUS:
 		return a->dev.sbus == b->dev.sbus;
 #endif
+	case SNDRV_DMA_TYPE_DEV:
+	case SNDRV_DMA_TYPE_DEV_SG:
+		return a->dev.dev == b->dev.dev;
 	}
 	return 0;
 }
@@ -196,7 +199,7 @@ int snd_dma_alloc_pages(const struct snd
 		dmab->area = snd_malloc_pci_pages(dev->dev.pci, size, &dmab->addr);
 		break;
 	case SNDRV_DMA_TYPE_PCI_SG:
-		snd_malloc_sgbuf_pages(dev->dev.pci, size, dmab);
+		snd_malloc_sgbuf_pages(&dev->dev.pci->dev, size, dmab);
 		break;
 #endif
 #ifdef CONFIG_SBUS
@@ -204,6 +207,12 @@ int snd_dma_alloc_pages(const struct snd
 		dmab->area = snd_malloc_sbus_pages(dev->dev.sbus, size, &dmab->addr);
 		break;
 #endif
+	case SNDRV_DMA_TYPE_DEV:
+		dmab->area = snd_malloc_dev_pages(dev->dev.dev, size, &dmab->addr);
+		break;
+	case SNDRV_DMA_TYPE_DEV_SG:
+		snd_malloc_sgbuf_pages(dev->dev.dev, size, dmab);
+		break;
 	default:
 		printk(KERN_ERR "snd-malloc: invalid device type %d\n", dev->type);
 		dmab->area = NULL;
@@ -248,6 +257,12 @@ void snd_dma_free_pages(const struct snd
 		snd_free_sbus_pages(dev->dev.sbus, dmab->bytes, dmab->area, dmab->addr);
 		break;
 #endif
+	case SNDRV_DMA_TYPE_DEV:
+		snd_free_dev_pages(dev->dev.dev, dmab->bytes, dmab->area, dmab->addr);
+		break;
+	case SNDRV_DMA_TYPE_DEV_SG:
+		snd_free_sgbuf_pages(dmab);
+		break;
 	default:
 		printk(KERN_ERR "snd-malloc: invalid device type %d\n", dev->type);
 	}
@@ -492,6 +507,104 @@ void snd_free_pages(void *ptr, size_t si
 	free_pages((unsigned long) ptr, pg);
 }
 
+/**
+ * snd_malloc_dev_pages - allocate pages for a device with the given size
+ * @dev: the device pointer
+ * @size: the size to allocate in bytes
+ * @dma: the pointer to store the DMA address of the buffer
+ *
+ * Allocates the physically contiguous pages with the given size for
+ * the device.
+ *
+ * Returns the pointer of the buffer, or NULL if not enough memory.
+ */
+void *snd_malloc_dev_pages(struct device *dev, size_t size, dma_addr_t *dma)
+{
+	int pg;
+	void *res;
+
+	snd_assert(size > 0, return NULL);
+	snd_assert(dma != NULL, return NULL);
+	pg = get_order(size);
+	res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, GFP_KERNEL);
+	if (res != NULL)
+		mark_pages(res, pg);
+
+	return res;
+}
+EXPORT_SYMBOL(snd_malloc_dev_pages);
+
+/**
+ * snd_malloc_dev_page - allocate a page in the valid device dma mask
+ * @dev: device pointer
+ * @addrp: the pointer to store the DMA address of the buffer
+ *
+ * Allocates a single page for the given device and returns
+ * the virtual address and stores the physical address on addrp.
+ * 
+ * This function cannot be called from interrupt handlers or
+ * within spinlocks.
+ */
+void *snd_malloc_dev_page(struct device *dev, dma_addr_t *addrp)
+{
+	return snd_malloc_dev_pages(dev, PAGE_SIZE, addrp);
+}
+EXPORT_SYMBOL(snd_malloc_dev_page);
+
+/**
+ * snd_malloc_dev_pages_fallback - allocate pages with the given size with fallback for a device
+ * @dev: device pointer
+ * @size: the requested size to allocate in bytes
+ * @dma: the pointer to store the DMA address of the buffer
+ * @res_size: the pointer to store the size of buffer actually allocated
+ *
+ * Allocates the physically contiguous pages with the given request
+ * size for a device.  When no space is left, this function reduces the size
+ * and tries to allocate again.  The size actually allocated is stored in
+ * res_size argument.
+ *
+ * Returns the pointer of the buffer, or NULL if no enoguh memory.
+ */
+void *snd_malloc_dev_pages_fallback(struct device *dev, size_t size,
+				    dma_addr_t *dma, size_t *res_size)
+{
+	void *res;
+
+	snd_assert(res_size != NULL, return NULL);
+	do {
+		if ((res = snd_malloc_dev_pages(dev, size, dma)) != NULL) {
+			*res_size = size;
+			return res;
+		}
+		size >>= 1;
+	} while (size >= PAGE_SIZE);
+	return NULL;
+}
+EXPORT_SYMBOL(snd_malloc_dev_pages_fallback);
+
+/**
+ * snd_free_dev_pages - release the pages
+ * @dev: device pointer
+ * @size: the allocated buffer size
+ * @ptr: the CPU address of buffer to release
+ * @dma: the DMA address of the buffer
+ *
+ * Releases the buffer allocated via snd_malloc_dev_pages().
+ */
+void snd_free_dev_pages(struct device *dev, size_t size, void *ptr,
+			dma_addr_t dma)
+{
+	int pg;
+
+	if (ptr == NULL)
+		return;
+	pg = get_order(size);
+	unmark_pages(ptr, pg);
+	dma_free_coherent(dev, PAGE_SIZE << pg, ptr, dma);
+}
+EXPORT_SYMBOL(snd_free_dev_pages);
+
+
 #if defined(CONFIG_ISA) && ! defined(CONFIG_PCI)
 
 /**
@@ -925,6 +1038,14 @@ static int snd_mem_proc_read(char *page,
 			len += sprintf(page + len, "SBUS [%x]", mem->dev.dev.sbus->slot);
 			break;
 #endif
+		case SNDRV_DMA_TYPE_DEV:
+		case SNDRV_DMA_TYPE_DEV_SG:
+			if (mem->dev.dev.dev) {
+				len += sprintf(page + len, "%s [%s]",
+					       mem->dev.type == SNDRV_DMA_TYPE_DEV_SG ? "DEV" : "DEV-SG",
+					       mem->dev.dev.dev->bus_id);
+			}
+			break;
 		default:
 			len += sprintf(page + len, "UNKNOWN");
 			break;
diff -urpN orig/sound/core/pcm_lib.c linux/sound/core/pcm_lib.c
--- orig/sound/core/pcm_lib.c	Wed Feb 18 22:35:45 2004
+++ linux/sound/core/pcm_lib.c	Sun Feb 29 15:48:13 2004
@@ -2670,7 +2670,6 @@ EXPORT_SYMBOL(snd_pcm_lib_preallocate_pc
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_pci_pages_for_all);
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_sg_pages);
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_sg_pages_for_all);
-EXPORT_SYMBOL(snd_pcm_sgbuf_ops_page);
 #endif
 #ifdef CONFIG_SBUS
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_sbus_pages);
diff -urpN orig/sound/core/pcm_memory.c linux/sound/core/pcm_memory.c
--- orig/sound/core/pcm_memory.c	Sun Feb 29 19:27:59 2004
+++ linux/sound/core/pcm_memory.c	Sun Feb 29 19:27:13 2004
@@ -275,6 +275,129 @@ int snd_pcm_lib_preallocate_pages_for_al
 	return 0;
 }
 
+/**
+ * snd_pcm_lib_preallocate_dev_pages - pre-allocation for a device
+ *
+ * @dev: device
+ * @substream: substream to assign the buffer
+ * @size: the requested pre-allocation size in bytes
+ * @max: max. buffer size acceptable for the changes via proc file
+ *
+ * Do pre-allocation for the device.
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ */
+int snd_pcm_lib_preallocate_dev_pages(struct device *dev,
+				      snd_pcm_substream_t *substream,
+				      size_t size, size_t max)
+{
+	substream->dma_device.type = SNDRV_DMA_TYPE_DEV;
+	substream->dma_device.dev.dev = dev;
+	setup_pcm_id(substream);
+	return snd_pcm_lib_preallocate_pages1(substream, size, max);
+}
+EXPORT_SYMBOL(snd_pcm_lib_preallocate_dev_pages);
+
+/*
+ * FIXME: the function name is too long for docbook!
+ *
+ * snd_pcm_lib_preallocate_dev_pages_for_all - pre-allocation for a device (all substreams)
+ * @dev: device
+ * @pcm: pcm to assign the buffer
+ * @size: the requested pre-allocation size in bytes
+ * @max: max. buffer size acceptable for the changes via proc file
+ *
+ * Do pre-allocation to all substreams of the given pcm for the
+ * device.
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ */
+int snd_pcm_lib_preallocate_dev_pages_for_all(struct device *dev,
+					      snd_pcm_t *pcm,
+					      size_t size, size_t max)
+{
+	snd_pcm_substream_t *substream;
+	int stream, err;
+
+	for (stream = 0; stream < 2; stream++)
+		for (substream = pcm->streams[stream].substream; substream; substream = substream->next)
+			if ((err = snd_pcm_lib_preallocate_dev_pages(dev, substream, size, max)) < 0)
+				return err;
+	return 0;
+}
+EXPORT_SYMBOL(snd_pcm_lib_preallocate_dev_pages_for_all);
+
+/**
+ * snd_pcm_lib_preallocate_dev_sg_pages - initialize SG-buffer for a device
+ *
+ * @dev: device
+ * @substream: substream to assign the buffer
+ * @size: the requested pre-allocation size in bytes
+ * @max: max. buffer size acceptable for the changes via proc file
+ *
+ * Initializes SG-buffer for a device.
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ */
+int snd_pcm_lib_preallocate_dev_sg_pages(struct device *dev,
+					snd_pcm_substream_t *substream,
+					size_t size, size_t max)
+{
+	substream->dma_device.type = SNDRV_DMA_TYPE_DEV_SG;
+	substream->dma_device.dev.dev = dev;
+	setup_pcm_id(substream);
+	return snd_pcm_lib_preallocate_pages1(substream, size, max);
+}
+EXPORT_SYMBOL(snd_pcm_lib_preallocate_dev_sg_pages);
+
+/*
+ * FIXME: the function name is too long for docbook!
+ *
+ * snd_pcm_lib_preallocate_dev_sg_pages_for_all - initialize SG-buffer for a device (all substreams)
+ * @dev: device
+ * @pcm: pcm to assign the buffer
+ * @size: the requested pre-allocation size in bytes
+ * @max: max. buffer size acceptable for the changes via proc file
+ *
+ * Initialize the SG-buffer to all substreams of the given pcm for the
+ * device.
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ */
+int snd_pcm_lib_preallocate_dev_sg_pages_for_all(struct device *dev,
+						 snd_pcm_t *pcm,
+						 size_t size, size_t max)
+{
+	snd_pcm_substream_t *substream;
+	int stream, err;
+
+	for (stream = 0; stream < 2; stream++)
+		for (substream = pcm->streams[stream].substream; substream; substream = substream->next)
+			if ((err = snd_pcm_lib_preallocate_dev_sg_pages(dev, substream, size, max)) < 0)
+				return err;
+	return 0;
+}
+EXPORT_SYMBOL(snd_pcm_lib_preallocate_dev_sg_pages_for_all);
+
+/**
+ * snd_pcm_sgbuf_ops_page - get the page struct at the given offset
+ * @substream: the pcm substream instance
+ * @offset: the buffer offset
+ *
+ * Returns the page struct at the given buffer offset.
+ * Used as the page callback of PCM ops.
+ */
+struct page *snd_pcm_sgbuf_ops_page(snd_pcm_substream_t *substream, unsigned long offset)
+{
+	struct snd_sg_buf *sgbuf = snd_pcm_substream_sgbuf(substream);
+
+	unsigned int idx = offset >> PAGE_SHIFT;
+	if (idx >= (unsigned int)sgbuf->pages)
+		return NULL;
+	return sgbuf->page_table[idx];
+}
+EXPORT_SYMBOL(snd_pcm_sgbuf_ops_page);
+
 #ifdef CONFIG_ISA
 /**
  * snd_pcm_lib_preallocate_isa_pages - pre-allocation for the ISA bus
@@ -555,24 +678,6 @@ int snd_pcm_lib_preallocate_sg_pages_for
 	return 0;
 }
 
-/**
- * snd_pcm_sgbuf_ops_page - get the page struct at the given offset
- * @substream: the pcm substream instance
- * @offset: the buffer offset
- *
- * Returns the page struct at the given buffer offset.
- * Used as the page callback of PCM ops.
- */
-struct page *snd_pcm_sgbuf_ops_page(snd_pcm_substream_t *substream, unsigned long offset)
-{
-	struct snd_sg_buf *sgbuf = snd_pcm_substream_sgbuf(substream);
-
-	unsigned int idx = offset >> PAGE_SHIFT;
-	if (idx >= (unsigned int)sgbuf->pages)
-		return NULL;
-	return sgbuf->page_table[idx];
-}
-
 #endif /* CONFIG_PCI */
 
 #ifndef MODULE
diff -urpN orig/sound/core/sgbuf.c linux/sound/core/sgbuf.c
--- orig/sound/core/sgbuf.c	Sat Jun 14 22:35:05 2003
+++ linux/sound/core/sgbuf.c	Sun Feb 29 16:38:53 2004
@@ -33,8 +33,8 @@
 
 
 /**
- * snd_malloc_sgbuf_pages - allocate the pages for the PCI SG buffer
- * @pci: the pci device pointer
+ * snd_malloc_sgbuf_pages - allocate the pages for a device SG buffer
+ * @dev: the device pointer
  * @size: the requested buffer size in bytes
  * @dmab: the buffer record to store
  *
@@ -48,7 +48,7 @@
  * Returns the mapped virtual address of the buffer if allocation was
  * successful, or NULL at error.
  */
-void *snd_malloc_sgbuf_pages(struct pci_dev *pci, size_t size, struct snd_dma_buffer *dmab)
+void *snd_malloc_sgbuf_pages(struct device *dev, size_t size, struct snd_dma_buffer *dmab)
 {
 	struct snd_sg_buf *sgbuf;
 	unsigned int i, pages;
@@ -59,7 +59,7 @@ void *snd_malloc_sgbuf_pages(struct pci_
 	if (! sgbuf)
 		return NULL;
 	memset(sgbuf, 0, sizeof(*sgbuf));
-	sgbuf->pci = pci;
+	sgbuf->dev = dev;
 	pages = snd_sgbuf_aligned_pages(size);
 	sgbuf->tblsize = sgbuf_align_table(pages);
 	sgbuf->table = kmalloc(sizeof(*sgbuf->table) * sgbuf->tblsize, GFP_KERNEL);
@@ -75,7 +75,7 @@ void *snd_malloc_sgbuf_pages(struct pci_
 	for (i = 0; i < pages; i++) {
 		void *ptr;
 		dma_addr_t addr;
-		ptr = snd_malloc_pci_page(sgbuf->pci, &addr);
+		ptr = snd_malloc_dev_page(sgbuf->dev, &addr);
 		if (! ptr)
 			goto _failed;
 		sgbuf->table[i].buf = ptr;
@@ -115,7 +115,7 @@ int snd_free_sgbuf_pages(struct snd_dma_
 		return -EINVAL;
 
 	for (i = 0; i < sgbuf->pages; i++)
-		snd_free_pci_page(sgbuf->pci, sgbuf->table[i].buf, sgbuf->table[i].addr);
+		snd_free_dev_page(sgbuf->dev, sgbuf->table[i].buf, sgbuf->table[i].addr);
 	if (dmab->area)
 		vunmap(dmab->area);
 	dmab->area = NULL;
diff -urpN orig/include/sound/memalloc.h linux/include/sound/memalloc.h
--- orig/include/sound/memalloc.h	Sun Feb 29 20:33:35 2004
+++ linux/include/sound/memalloc.h	Sun Feb 29 22:23:20 2004
@@ -29,12 +29,15 @@
 #include <asm/sbus.h>
 #endif
 
+struct device;
+
 /*
  * buffer device info
  */
 struct snd_dma_device {
 	int type;			/* SNDRV_MEM_TYPE_XXX */
 	union {
+		struct device *dev;	/* generic device */
 		struct pci_dev *pci;	/* for PCI and PCI-SG types */
 		unsigned int flags;	/* GFP_XXX for continous and ISA types */
 #ifdef CONFIG_SBUS
@@ -53,6 +56,8 @@ struct snd_dma_device {
 #define SNDRV_DMA_TYPE_PCI		3	/* PCI continuous */
 #define SNDRV_DMA_TYPE_SBUS		4	/* SBUS continuous */
 #define SNDRV_DMA_TYPE_PCI_SG		5	/* PCI SG-buffer */
+#define SNDRV_DMA_TYPE_DEV		6	/* generic device continuous */
+#define SNDRV_DMA_TYPE_DEV_SG		7	/* generic device SG-buffer */
 
 #ifdef CONFIG_PCI
 /*
@@ -99,6 +104,16 @@ void *snd_malloc_pages(size_t size, unsi
 void *snd_malloc_pages_fallback(size_t size, unsigned int gfp_flags, size_t *res_size);
 void snd_free_pages(void *ptr, size_t size);
 
+/*
+ * Generic device continuous pages
+ */
+void *snd_malloc_dev_pages(struct device *dev, size_t size, dma_addr_t *dma_addr);
+void *snd_malloc_dev_pages_fallback(struct device *dev, size_t size, dma_addr_t *dma_addr, size_t *res_size);
+void snd_free_dev_pages(struct device *dev, size_t size, void *ptr, dma_addr_t dma_addr);
+/* one page allocation */
+void *snd_malloc_dev_page(struct device *dev, dma_addr_t *dma_addr);
+#define snd_free_dev_page(dev,ptr,addr) snd_free_dev_pages(dev,PAGE_SIZE,ptr,addr)
+
 #ifdef CONFIG_PCI
 /*
  * PCI continuous pages
@@ -136,9 +151,8 @@ void snd_free_isa_pages(size_t size, voi
 #endif /* CONFIG_PCI */
 #endif /* CONFIG_ISA */
 
-#ifdef CONFIG_PCI
 /*
- * Scatter-Gather PCI pages
+ * Scatter-Gather generic device pages
  */
 struct snd_sg_page {
 	void *buf;
@@ -151,10 +165,10 @@ struct snd_sg_buf {
 	int tblsize;	/* allocated table size */
 	struct snd_sg_page *table;	/* address table */
 	struct page **page_table;	/* page table (for vmap/vunmap) */
-	struct pci_dev *pci;
+	struct device *dev;
 };
 
-void *snd_malloc_sgbuf_pages(struct pci_dev *pci, size_t size, struct snd_dma_buffer *dmab);
+void *snd_malloc_sgbuf_pages(struct device *dev, size_t size, struct snd_dma_buffer *dmab);
 int snd_free_sgbuf_pages(struct snd_dma_buffer *dmab);
 
 /*
@@ -172,6 +186,5 @@ static inline dma_addr_t snd_sgbuf_get_a
 {
 	return sgbuf->table[offset >> PAGE_SHIFT].addr + offset % PAGE_SIZE;
 }
-#endif /* CONFIG_PCI */
 
 #endif /* __SOUND_MEMALLOC_H */
diff -urpN orig/include/sound/pcm.h linux/include/sound/pcm.h
--- orig/include/sound/pcm.h	Wed Feb 18 22:35:25 2004
+++ linux/include/sound/pcm.h	Sun Feb 29 15:33:19 2004
@@ -932,10 +932,6 @@ int snd_pcm_lib_preallocate_sg_pages(str
 int snd_pcm_lib_preallocate_sg_pages_for_all(struct pci_dev *pci,
 					     snd_pcm_t *pcm,
 					     size_t size, size_t max);
-#define snd_pcm_substream_sgbuf(substream) ((substream)->runtime->dma_private)
-#define snd_pcm_sgbuf_pages(size) snd_sgbuf_aligned_pages(size)
-#define snd_pcm_sgbuf_get_addr(sgbuf,ofs) snd_sgbuf_get_addr(sgbuf,ofs)
-struct page *snd_pcm_sgbuf_ops_page(snd_pcm_substream_t *substream, unsigned long offset);
 #endif
 
 #ifdef CONFIG_SBUS
@@ -948,6 +944,24 @@ int snd_pcm_lib_preallocate_sbus_pages_f
 					       size_t max);
 #endif
 
+int snd_pcm_lib_preallocate_dev_pages(struct device *dev,
+				      snd_pcm_substream_t *substream,
+				      size_t size, size_t max);
+int snd_pcm_lib_preallocate_dev_pages_for_all(struct device *dev,
+					      snd_pcm_t *pcm,
+					      size_t size,
+					      size_t max);
+int snd_pcm_lib_preallocate_dev_sg_pages(struct device *dev,
+					 snd_pcm_substream_t *substream,
+					 size_t size, size_t max);
+int snd_pcm_lib_preallocate_dev_sg_pages_for_all(struct device *dev,
+						 snd_pcm_t *pcm,
+						 size_t size, size_t max);
+#define snd_pcm_substream_sgbuf(substream) ((substream)->runtime->dma_private)
+#define snd_pcm_sgbuf_pages(size) snd_sgbuf_aligned_pages(size)
+#define snd_pcm_sgbuf_get_addr(sgbuf,ofs) snd_sgbuf_get_addr(sgbuf,ofs)
+struct page *snd_pcm_sgbuf_ops_page(snd_pcm_substream_t *substream, unsigned long offset);
+
 static inline void snd_pcm_limit_isa_dma_size(int dma, size_t *max)
 {
 	*max = dma < 4 ? 64 * 1024 : 128 * 1024;

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
