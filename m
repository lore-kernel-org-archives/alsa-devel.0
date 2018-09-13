From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 1/5] ALSA: core: Add device-managed page
	allocator helper
Date: Thu, 13 Sep 2018 08:05:23 +0200
Message-ID: <20180913060527.24694-2-tiwai@suse.de>
References: <20180913060527.24694-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 001EB26779A
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 08:05:31 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D7B88AFE4
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 06:05:30 +0000 (UTC)
In-Reply-To: <20180913060527.24694-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a preparation for managing the whole resource via devres.
As a first step, add a new allocator function, snd_devm_alloc_pages()
to manage the allocated pages via devres, so that the pages will be
automagically released as device unbinding.

Unlike the old snd_dma_alloc_pages(), the new function returns
directly the snd_dma_buffer pointer.  The caller needs to check the
error via IS_ERR().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/memalloc.h |  4 ++
 sound/core/memalloc.c    | 88 ++++++++++++++++++++++++++++++++--------
 2 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index af3fa577fa06..3a1d9fb44fcf 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -156,5 +156,9 @@ void snd_dma_free_pages(struct snd_dma_buffer *dmab);
 void *snd_malloc_pages(size_t size, gfp_t gfp_flags);
 void snd_free_pages(void *ptr, size_t size);
 
+/* device-managed memory allocator */
+struct snd_dma_buffer *snd_devm_alloc_pages(struct device *dev, int type,
+					    size_t size);
+
 #endif /* __SOUND_MEMALLOC_H */
 
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index aa266907ec9b..a54d7aacec43 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -161,22 +161,8 @@ static void snd_free_dev_iram(struct snd_dma_buffer *dmab)
  *
  */
 
-
-/**
- * snd_dma_alloc_pages - allocate the buffer area according to the given type
- * @type: the DMA buffer type
- * @device: the device pointer
- * @size: the buffer size to allocate
- * @dmab: buffer allocation record to store the allocated data
- *
- * Calls the memory-allocator function for the corresponding
- * buffer type.
- *
- * Return: Zero if the buffer with the given size is allocated successfully,
- * otherwise a negative value on error.
- */
-int snd_dma_alloc_pages(int type, struct device *device, size_t size,
-			struct snd_dma_buffer *dmab)
+static int __snd_dma_alloc_pages(struct device *device, int type, size_t size,
+				 gfp_t gfp_flags, struct snd_dma_buffer *dmab)
 {
 	if (WARN_ON(!size))
 		return -ENXIO;
@@ -188,8 +174,7 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 	dmab->bytes = 0;
 	switch (type) {
 	case SNDRV_DMA_TYPE_CONTINUOUS:
-		dmab->area = snd_malloc_pages(size,
-					(__force gfp_t)(unsigned long)device);
+		dmab->area = snd_malloc_pages(size, gfp_flags);
 		dmab->addr = 0;
 		break;
 #ifdef CONFIG_HAS_DMA
@@ -225,6 +210,30 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 	dmab->bytes = size;
 	return 0;
 }
+
+/**
+ * snd_dma_alloc_pages - allocate the buffer area according to the given type
+ * @type: the DMA buffer type
+ * @device: the device pointer
+ * @size: the buffer size to allocate
+ * @dmab: buffer allocation record to store the allocated data
+ *
+ * Calls the memory-allocator function for the corresponding
+ * buffer type.
+ *
+ * Return: Zero if the buffer with the given size is allocated successfully,
+ * otherwise a negative value on error.
+ */
+int snd_dma_alloc_pages(int type, struct device *device, size_t size,
+			struct snd_dma_buffer *dmab)
+{
+	gfp_t gfp_flags = 0;
+
+	if (type == SNDRV_DMA_TYPE_CONTINUOUS)
+		gfp_flags = (__force gfp_t)(unsigned long)device;
+
+	return __snd_dma_alloc_pages(device, type, size, gfp_flags, dmab);
+}
 EXPORT_SYMBOL(snd_dma_alloc_pages);
 
 /**
@@ -296,3 +305,46 @@ void snd_dma_free_pages(struct snd_dma_buffer *dmab)
 	}
 }
 EXPORT_SYMBOL(snd_dma_free_pages);
+
+/* called by devres */
+static void __snd_release_pages(struct device *dev, void *res)
+{
+	snd_dma_free_pages(res);
+}
+
+/**
+ * snd_devm_alloc_pages - allocate the buffer and manage with devres
+ * @dev: the device pointer
+ * @type: the DMA buffer type
+ * @size: the buffer size to allocate
+ *
+ * Allocate buffer pages depending on the given type and manage using devres.
+ * The pages will be released automatically at the device removal.
+ *
+ * The function cannot handle GFP flags for SNDRV_DMA_TYPE_CONTINUOUS type,
+ * only GFP_KERNEL is assumed.
+ *
+ * The function returns the snd_dma_buffer object at success or the encoded
+ * error pointer via ERR_PTR().  The caller needs to check the error via
+ * IS_ERR() and PTR_ERR().
+ */
+struct snd_dma_buffer *
+snd_devm_alloc_pages(struct device *dev, int type, size_t size)
+{
+	struct snd_dma_buffer *dmab;
+	int err;
+
+	dmab = devres_alloc(__snd_release_pages, sizeof(*dmab), GFP_KERNEL);
+	if (!dmab)
+		return ERR_PTR(-ENOMEM);
+
+	err = __snd_dma_alloc_pages(dev, type, size, GFP_KERNEL, dmab);
+	if (err < 0) {
+		devres_free(dmab);
+		return ERR_PTR(err);
+	}
+
+	devres_add(dev, dmab);
+	return dmab;
+}
+EXPORT_SYMBOL_GPL(snd_devm_alloc_pages);
-- 
2.18.0
