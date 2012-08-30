From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 1/3] ALSA: Make snd_sgbuf_get_{ptr|addr}()
	available for non-SG cases.
Date: Thu, 30 Aug 2012 13:21:04 -0700
Message-ID: <1346358066-7851-2-git-send-email-ian_minett@creativelabs.com>
References: <1346358066-7851-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1346358066-7851-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index c425062..9201520 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -98,8 +98,10 @@ static inline unsigned int snd_sgbuf_aligned_pages(size_t size)
 /*
  * return the physical address at the corresponding offset
  */
-static inline dma_addr_t snd_sgbuf_get_addr(struct snd_sg_buf *sgbuf, size_t offset)
+static inline dma_addr_t snd_sgbuf_get_addr(struct snd_dma_buffer *dmab,
+					    size_t offset)
 {
+	struct snd_sg_buf *sgbuf = dmab->private_data;
 	dma_addr_t addr = sgbuf->table[offset >> PAGE_SHIFT].addr;
 	addr &= PAGE_MASK;
 	return addr + offset % PAGE_SIZE;
@@ -108,10 +110,31 @@ static inline dma_addr_t snd_sgbuf_get_addr(struct snd_sg_buf *sgbuf, size_t off
 /*
  * return the virtual address at the corresponding offset
  */
-static inline void *snd_sgbuf_get_ptr(struct snd_sg_buf *sgbuf, size_t offset)
+static inline void *snd_sgbuf_get_ptr(struct snd_dma_buffer *dmab,
+				      size_t offset)
 {
+	struct snd_sg_buf *sgbuf = dmab->private_data;
 	return sgbuf->table[offset >> PAGE_SHIFT].buf + offset % PAGE_SIZE;
 }
+
+unsigned int snd_sgbuf_get_chunk_size(struct snd_dma_buffer *dmab,
+				      unsigned int ofs, unsigned int size);
+#else
+/* non-SG versions */
+static inline dma_addr_t snd_sgbuf_get_addr(struct snd_dma_buffer *dmab,
+					    size_t offset)
+{
+	return dmab->addr + offset;
+}
+
+static inline void *snd_sgbuf_get_ptr(struct snd_dma_buffer *dmab,
+				      size_t offset)
+{
+	return dmab->area + offset;
+}
+
+#define snd_sgbuf_get_chunk_size(dmab, ofs, size)	(size)
+
 #endif /* CONFIG_SND_DMA_SGBUF */
 
 /* allocate/release a buffer */
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index cdca2ab..0c054b9 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -982,53 +982,42 @@ static int snd_pcm_lib_alloc_vmalloc_32_buffer
 	_snd_pcm_lib_alloc_vmalloc_buffer \
 			(subs, size, GFP_KERNEL | GFP_DMA32 | __GFP_ZERO)
 
+#define snd_pcm_get_dma_buf(substream) ((substream)->runtime->dma_buffer_p)
+
 #ifdef CONFIG_SND_DMA_SGBUF
 /*
  * SG-buffer handling
  */
 #define snd_pcm_substream_sgbuf(substream) \
-	((substream)->runtime->dma_buffer_p->private_data)
-
-static inline dma_addr_t
-snd_pcm_sgbuf_get_addr(struct snd_pcm_substream *substream, unsigned int ofs)
-{
-	struct snd_sg_buf *sg = snd_pcm_substream_sgbuf(substream);
-	return snd_sgbuf_get_addr(sg, ofs);
-}
-
-static inline void *
-snd_pcm_sgbuf_get_ptr(struct snd_pcm_substream *substream, unsigned int ofs)
-{
-	struct snd_sg_buf *sg = snd_pcm_substream_sgbuf(substream);
-	return snd_sgbuf_get_ptr(sg, ofs);
-}
+	snd_pcm_get_dma_buf(substream)->private_data
 
 struct page *snd_pcm_sgbuf_ops_page(struct snd_pcm_substream *substream,
 				    unsigned long offset);
-unsigned int snd_pcm_sgbuf_get_chunk_size(struct snd_pcm_substream *substream,
-					  unsigned int ofs, unsigned int size);
-
 #else /* !SND_DMA_SGBUF */
 /*
  * fake using a continuous buffer
  */
+#define snd_pcm_sgbuf_ops_page	NULL
+#endif /* SND_DMA_SGBUF */
+
 static inline dma_addr_t
 snd_pcm_sgbuf_get_addr(struct snd_pcm_substream *substream, unsigned int ofs)
 {
-	return substream->runtime->dma_addr + ofs;
+	return snd_sgbuf_get_addr(snd_pcm_get_dma_buf(substream), ofs);
 }
 
 static inline void *
 snd_pcm_sgbuf_get_ptr(struct snd_pcm_substream *substream, unsigned int ofs)
 {
-	return substream->runtime->dma_area + ofs;
+	return snd_sgbuf_get_ptr(snd_pcm_get_dma_buf(substream), ofs);
 }
 
-#define snd_pcm_sgbuf_ops_page	NULL
-
-#define snd_pcm_sgbuf_get_chunk_size(subs, ofs, size)	(size)
-
-#endif /* SND_DMA_SGBUF */
+static inline unsigned int
+snd_pcm_sgbuf_get_chunk_size(struct snd_pcm_substream *substream,
+			     unsigned int ofs, unsigned int size)
+{
+	return snd_sgbuf_get_chunk_size(snd_pcm_get_dma_buf(substream), ofs, size);
+}
 
 /* handle mmap counter - PCM mmap callback should handle this counter properly */
 static inline void snd_pcm_mmap_data_open(struct vm_area_struct *area)
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 9571313..69e01c4 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -327,32 +327,6 @@ struct page *snd_pcm_sgbuf_ops_page(struct snd_pcm_substream *substream, unsigne
 }
 
 EXPORT_SYMBOL(snd_pcm_sgbuf_ops_page);
-
-/*
- * compute the max chunk size with continuous pages on sg-buffer
- */
-unsigned int snd_pcm_sgbuf_get_chunk_size(struct snd_pcm_substream *substream,
-					  unsigned int ofs, unsigned int size)
-{
-	struct snd_sg_buf *sg = snd_pcm_substream_sgbuf(substream);
-	unsigned int start, end, pg;
-
-	start = ofs >> PAGE_SHIFT;
-	end = (ofs + size - 1) >> PAGE_SHIFT;
-	/* check page continuity */
-	pg = sg->table[start].addr >> PAGE_SHIFT;
-	for (;;) {
-		start++;
-		if (start > end)
-			break;
-		pg++;
-		if ((sg->table[start].addr >> PAGE_SHIFT) != pg)
-			return (start << PAGE_SHIFT) - ofs;
-	}
-	/* ok, all on continuous pages */
-	return size;
-}
-EXPORT_SYMBOL(snd_pcm_sgbuf_get_chunk_size);
 #endif /* CONFIG_SND_DMA_SGBUF */
 
 /**
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index d0f0035..da3c619 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
+#include <linux/export.h>
 #include <sound/memalloc.h>
 
 
@@ -136,3 +137,30 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 	snd_free_sgbuf_pages(dmab); /* free the table */
 	return NULL;
 }
+
+
+/*
+ * compute the max chunk size with continuous pages on sg-buffer
+ */
+unsigned int snd_sgbuf_get_chunk_size(struct snd_dma_buffer *dmab,
+				      unsigned int ofs, unsigned int size)
+{
+	struct snd_sg_buf *sg = dmab->private_data;
+	unsigned int start, end, pg;
+
+	start = ofs >> PAGE_SHIFT;
+	end = (ofs + size - 1) >> PAGE_SHIFT;
+	/* check page continuity */
+	pg = sg->table[start].addr >> PAGE_SHIFT;
+	for (;;) {
+		start++;
+		if (start > end)
+			break;
+		pg++;
+		if ((sg->table[start].addr >> PAGE_SHIFT) != pg)
+			return (start << PAGE_SHIFT) - ofs;
+	}
+	/* ok, all on continuous pages */
+	return size;
+}
+EXPORT_SYMBOL(snd_sgbuf_get_chunk_size);
-- 
1.7.4.1
