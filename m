From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v7] ALSA: Add SoC on-chip internal ram support
	for DMA buffer allocation
Date: Wed, 23 Oct 2013 11:47:43 +0800
Message-ID: <1382500063-15422-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 by alsa0.perex.cz (Postfix) with ESMTP id 029C626082D
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2013 05:48:35 +0200 (CEST)
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

Now it's quite common that an SoC contains its on-chip internal RAM.
By using this RAM space for DMA buffer during audio playback/record,
we can shutdown the voltage for external RAM to save power.

So add new DEV type with iram malloc()/free() and accordingly modify
current default mmap() for the iram circumstance.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
Changelog
v6->v7:
 * Assigned pool to private_data field and accordingly refined helper functions.
v5->v6:
 * Dropped remaining OF dependency bacause no need to add them:
   of_node doesn't care about OF; of_get_named_gen_pool() returns NULL if !OF.
v4->v5:
 * Minimized the OF dependency.
v3->v4:
 * Appropriately placed '#ifdef CONFIG_OF'
 * Tested by adding '#undef CONFIG_OF' to modified files, and passed compiling.
v2->v3:
 * Moved iram specific mmap procedure out of ifdef ARCH_HAS_DMA_MMAP_COHERENT
v1->v2:
 * Added of_node check
 * Dropped noops and unused physical addr in snd_free_dev_iram()

---
 include/sound/memalloc.h |  1 +
 sound/core/memalloc.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/core/pcm_native.c  |  6 ++++++
 3 files changed, 59 insertions(+)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index cf15b82..510aec4 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -52,6 +52,7 @@ struct snd_dma_device {
 #else
 #define SNDRV_DMA_TYPE_DEV_SG	SNDRV_DMA_TYPE_DEV /* no SG-buf support */
 #endif
+#define SNDRV_DMA_TYPE_DEV_IRAM		4	/* generic device iram-buffer */
 
 /*
  * info for buffer allocation
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index bdf826f..18c1d47 100644
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
@@ -157,6 +158,46 @@ static void snd_free_dev_pages(struct device *dev, size_t size, void *ptr,
 	dec_snd_pages(pg);
 	dma_free_coherent(dev, PAGE_SIZE << pg, ptr, dma);
 }
+
+/**
+ * snd_malloc_dev_iram - allocate memory from on-chip internal ram
+ * @dmab: buffer allocation record to store the allocated data
+ * @size: number of bytes to allocate from the iram
+ *
+ * This function requires iram phandle provided via of_node
+ */
+void snd_malloc_dev_iram(struct snd_dma_buffer *dmab, size_t size)
+{
+	struct device *dev = dmab->dev.dev;
+	struct gen_pool *pool = NULL;
+
+	if (dev->of_node)
+		pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
+
+	if (!pool)
+		return;
+
+	/* Assign the pool into private_data field */
+	dmab->private_data = pool;
+
+	dmab->area = (void *)gen_pool_alloc(pool, size);
+	if (!dmab->area)
+		return;
+
+	dmab->addr = gen_pool_virt_to_phys(pool, (unsigned long)dmab->area);
+}
+
+/**
+ * snd_free_dev_iram - free allocated specific memory from on-chip internal ram
+ * @dmab: buffer allocation record to store the allocated data
+ */
+void snd_free_dev_iram(struct snd_dma_buffer *dmab)
+{
+	struct gen_pool *pool = dmab->private_data;
+
+	if (pool && dmab->area)
+		gen_pool_free(pool, (unsigned long)dmab->area, dmab->bytes);
+}
 #endif /* CONFIG_HAS_DMA */
 
 /*
@@ -197,6 +238,14 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 		dmab->addr = 0;
 		break;
 #ifdef CONFIG_HAS_DMA
+	case SNDRV_DMA_TYPE_DEV_IRAM:
+		snd_malloc_dev_iram(dmab, size);
+		if (dmab->area)
+			break;
+		/* Internal memory might have limited size and no enough space,
+		 * so if we fail to malloc, try to fetch memory traditionally.
+		 */
+		dmab->dev.type = SNDRV_DMA_TYPE_DEV;
 	case SNDRV_DMA_TYPE_DEV:
 		dmab->area = snd_malloc_dev_pages(device, size, &dmab->addr);
 		break;
@@ -269,6 +318,9 @@ void snd_dma_free_pages(struct snd_dma_buffer *dmab)
 		snd_free_pages(dmab->area, dmab->bytes);
 		break;
 #ifdef CONFIG_HAS_DMA
+	case SNDRV_DMA_TYPE_DEV_IRAM:
+		snd_free_dev_iram(dmab);
+		break;
 	case SNDRV_DMA_TYPE_DEV:
 		snd_free_dev_pages(dmab->dev.dev, dmab->bytes, dmab->area, dmab->addr);
 		break;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a68d4c6..513f095 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3199,6 +3199,12 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 			     struct vm_area_struct *area)
 {
 	area->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
+	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV_IRAM) {
+		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
+		return remap_pfn_range(area, area->vm_start,
+				substream->dma_buffer.addr >> PAGE_SHIFT,
+				area->vm_end - area->vm_start, area->vm_page_prot);
+	}
 #ifdef ARCH_HAS_DMA_MMAP_COHERENT
 	if (!substream->ops->page &&
 	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
-- 
1.8.4
