From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/8] ALSA: memalloc: Simplify
	snd_malloc_dev_pages() calls
Date: Mon, 27 Aug 2018 10:59:47 +0200
Message-ID: <20180827085953.10614-3-tiwai@suse.de>
References: <20180827085953.10614-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D17D6267857
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 11:00:00 +0200 (CEST)
In-Reply-To: <20180827085953.10614-1-tiwai@suse.de>
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
Cc: Hans Hu <HansHu@zhaoxin.com>
List-Id: alsa-devel@alsa-project.org

snd_malloc_dev_pages() and snd_free_dev_pages() are local functions
and the parameters passed there are all contained in snd_dma_buffer
object.  As a code-simplification, pass snd_dma_buffer object and
assign the address there like other allocators do (except for
snd_malloc_pages() which is called from outside, hence we can't change
easily).

Only code refactoring, no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index d85df01bf055..cc051bfe2f6f 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -82,26 +82,22 @@ EXPORT_SYMBOL(snd_free_pages);
 
 #ifdef CONFIG_HAS_DMA
 /* allocate the coherent DMA pages */
-static void *snd_malloc_dev_pages(struct device *dev, size_t size, dma_addr_t *dma)
+static void snd_malloc_dev_pages(struct snd_dma_buffer *dmab, size_t size)
 {
 	gfp_t gfp_flags;
 
-	if (WARN_ON(!dma))
-		return NULL;
 	gfp_flags = GFP_KERNEL
 		| __GFP_COMP	/* compound page lets parts be mapped */
 		| __GFP_NORETRY /* don't trigger OOM-killer */
 		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
-	return dma_alloc_coherent(dev, size, dma, gfp_flags);
+	dmab->area = dma_alloc_coherent(dmab->dev.dev, size, &dmab->addr,
+					gfp_flags);
 }
 
 /* free the coherent DMA pages */
-static void snd_free_dev_pages(struct device *dev, size_t size, void *ptr,
-			       dma_addr_t dma)
+static void snd_free_dev_pages(struct snd_dma_buffer *dmab)
 {
-	if (ptr == NULL)
-		return;
-	dma_free_coherent(dev, size, ptr, dma);
+	dma_free_coherent(dmab->dev.dev, dmab->bytes, dmab->area, dmab->addr);
 }
 
 #ifdef CONFIG_GENERIC_ALLOCATOR
@@ -195,7 +191,7 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 		dmab->dev.type = SNDRV_DMA_TYPE_DEV;
 #endif /* CONFIG_GENERIC_ALLOCATOR */
 	case SNDRV_DMA_TYPE_DEV:
-		dmab->area = snd_malloc_dev_pages(device, size, &dmab->addr);
+		snd_malloc_dev_pages(dmab, size);
 		break;
 #endif
 #ifdef CONFIG_SND_DMA_SGBUF
@@ -270,7 +266,7 @@ void snd_dma_free_pages(struct snd_dma_buffer *dmab)
 		break;
 #endif /* CONFIG_GENERIC_ALLOCATOR */
 	case SNDRV_DMA_TYPE_DEV:
-		snd_free_dev_pages(dmab->dev.dev, dmab->bytes, dmab->area, dmab->addr);
+		snd_free_dev_pages(dmab);
 		break;
 #endif
 #ifdef CONFIG_SND_DMA_SGBUF
-- 
2.18.0
