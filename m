From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/8] ALSA: memalloc: Don't align the size to
	power-of-two
Date: Mon, 27 Aug 2018 10:59:46 +0200
Message-ID: <20180827085953.10614-2-tiwai@suse.de>
References: <20180827085953.10614-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D047D26784F
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

The size passed to dma_alloc_coherent() doesn't have to be aligned
with power-of-two, rather it should be the raw size.  As a minor
optimization, remove the size adjustment in the current code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 753d5fc4b284..d85df01bf055 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -84,29 +84,24 @@ EXPORT_SYMBOL(snd_free_pages);
 /* allocate the coherent DMA pages */
 static void *snd_malloc_dev_pages(struct device *dev, size_t size, dma_addr_t *dma)
 {
-	int pg;
 	gfp_t gfp_flags;
 
 	if (WARN_ON(!dma))
 		return NULL;
-	pg = get_order(size);
 	gfp_flags = GFP_KERNEL
 		| __GFP_COMP	/* compound page lets parts be mapped */
 		| __GFP_NORETRY /* don't trigger OOM-killer */
 		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
-	return dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
+	return dma_alloc_coherent(dev, size, dma, gfp_flags);
 }
 
 /* free the coherent DMA pages */
 static void snd_free_dev_pages(struct device *dev, size_t size, void *ptr,
 			       dma_addr_t dma)
 {
-	int pg;
-
 	if (ptr == NULL)
 		return;
-	pg = get_order(size);
-	dma_free_coherent(dev, PAGE_SIZE << pg, ptr, dma);
+	dma_free_coherent(dev, size, ptr, dma);
 }
 
 #ifdef CONFIG_GENERIC_ALLOCATOR
-- 
2.18.0
