From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 1/2] ALSA: Add SoC on-chip internal memory
	support for DMA buffer allocation
Date: Wed, 16 Oct 2013 16:18:03 +0800
Message-ID: <03ed477b729fd972b896d52312666e5773d8dfec.1381911378.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B8CC265071
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 10:18:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Now it's quite common that an SoC contains its on-chip internal memory.
By using this memory space for DMA buffer during audio playback/record,
we can shutdown the voltage for external memory to save power.

Thus add new DEV type with iram malloc()/free() and accordingly modify
current default mmap() for the iram circumstance.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 include/sound/memalloc.h |  5 ++++
 sound/core/memalloc.c    | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/core/pcm_native.c  |  8 +++++-
 3 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index cf15b82..b53443e 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -52,6 +52,11 @@ struct snd_dma_device {
 #else
 #define SNDRV_DMA_TYPE_DEV_SG	SNDRV_DMA_TYPE_DEV /* no SG-buf support */
 #endif
+#ifdef CONFIG_OF
+#define SNDRV_DMA_TYPE_DEV_IRAM		4	/* generic device iram-buffer */
+#else
+#define SNDRV_DMA_TYPE_DEV_IRAM		SNDRV_DMA_TYPE_DEV
+#endif
 
 /*
  * info for buffer allocation
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index bdf826f..9136d5d 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -30,6 +30,7 @@
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include <linux/dma-mapping.h>
+#include <linux/genalloc.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <sound/memalloc.h>
@@ -157,6 +158,59 @@ static void snd_free_dev_pages(struct device *dev, size_t size, void *ptr,
 	dec_snd_pages(pg);
 	dma_free_coherent(dev, PAGE_SIZE << pg, ptr, dma);
 }
+
+#ifdef CONFIG_OF
+/**
+ * snd_malloc_dev_iram - allocate memory from on-chip internal memory
+ * @dev: DMA device pointer
+ * @size: number of bytes to allocate from the iram
+ * @dma: dma-view physical address
+ *
+ * Return cpu-view address or NULL indicating allocating failure
+ *
+ * This function requires iram phandle provided via of_node
+ */
+void *snd_malloc_dev_iram(struct device *dev, size_t size, dma_addr_t *dma)
+{
+	struct gen_pool *pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
+	unsigned long vaddr;
+
+	if (!pool)
+		return NULL;
+
+	vaddr = gen_pool_alloc(pool, size);
+	if (!vaddr)
+		return NULL;
+
+	if (dma)
+		*dma = gen_pool_virt_to_phys(pool, vaddr);
+
+	return (void *)vaddr;
+}
+
+/**
+ * snd_free_dev_iram - free allocated specific memory from on-chip internal memory
+ * @dev: DMA device pointer
+ * @size: size in bytes of memory to free
+ * @ptr: cpu-view address returned from snd_malloc_dev_iram
+ * @dma: dma-view address returned from snd_malloc_dev_iram
+ *
+ * This function requires iram phandle provided via of_node
+ */
+void snd_free_dev_iram(struct device *dev, size_t size, void *ptr, dma_addr_t dma)
+{
+	struct gen_pool *pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
+	if (!pool)
+		return;
+
+	gen_pool_free(pool, (unsigned long)ptr, size);
+
+	ptr = NULL;
+
+	if (dma)
+		dma = 0;
+}
+#endif /* CONFIG_OF */
 #endif /* CONFIG_HAS_DMA */
 
 /*
@@ -197,6 +251,17 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 		dmab->addr = 0;
 		break;
 #ifdef CONFIG_HAS_DMA
+	case SNDRV_DMA_TYPE_DEV_IRAM:
+#ifdef CONFIG_OF
+		dmab->area = snd_malloc_dev_iram(device, size, &dmab->addr);
+		if (dmab->area)
+			break;
+#endif
+		/*
+		 * Internal memory might have limited size and no enough space,
+		 * so if we fail to malloc, try to fetch memory traditionally.
+		 */
+		dmab->dev.type = SNDRV_DMA_TYPE_DEV;
 	case SNDRV_DMA_TYPE_DEV:
 		dmab->area = snd_malloc_dev_pages(device, size, &dmab->addr);
 		break;
@@ -269,6 +334,12 @@ void snd_dma_free_pages(struct snd_dma_buffer *dmab)
 		snd_free_pages(dmab->area, dmab->bytes);
 		break;
 #ifdef CONFIG_HAS_DMA
+	case SNDRV_DMA_TYPE_DEV_IRAM:
+#ifdef CONFIG_OF
+		snd_free_dev_iram(dmab->dev.dev, dmab->bytes,
+					dmab->area, dmab->addr);
+			break;
+#endif
 	case SNDRV_DMA_TYPE_DEV:
 		snd_free_dev_pages(dmab->dev.dev, dmab->bytes, dmab->area, dmab->addr);
 		break;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a68d4c6..5578bd0 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3201,12 +3201,18 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 	area->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
 #ifdef ARCH_HAS_DMA_MMAP_COHERENT
 	if (!substream->ops->page &&
-	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
+	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV) {
 		return dma_mmap_coherent(substream->dma_buffer.dev.dev,
 					 area,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
 					 area->vm_end - area->vm_start);
+	} else if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV_IRAM) {
+		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
+		return remap_pfn_range(area, area->vm_start,
+				substream->dma_buffer.addr >> PAGE_SHIFT,
+				area->vm_end - area->vm_start, area->vm_page_prot);
+	}
 #elif defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
 	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV &&
 	    !plat_device_is_coherent(substream->dma_buffer.dev.dev))
-- 
1.8.4
