From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: Replace snd_malloc_pages() and
	snd_free_pages() with standard helpers, take#2
Date: Wed, 27 Mar 2019 10:29:58 +0100
Message-ID: <20190327092959.30382-2-tiwai@suse.de>
References: <20190327092959.30382-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC826F8961A
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 10:30:01 +0100 (CET)
In-Reply-To: <20190327092959.30382-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>
List-Id: alsa-devel@alsa-project.org

snd_malloc_pages() and snd_free_pages() are merely thin wrappers of
the standard page allocator / free functions.  Even the arguments are
compatible with some standard helpers, so there is little merit of
keeping these wrappers.

This patch replaces the all existing callers of snd_malloc_pages() and
snd_free_pages() with the direct calls of the standard helper
functions.  In this version, we use a recently introduced one,
alloc_pages_exact(), which suits better than the old
snd_malloc_pages() implementation for our purposes.  Then we can avoid
the waste of pages by alignment to power-of-two.

Since alloc_pages_exact() does split pages, we need no longer
__GFP_COMP flag; or better to say, we must not pass __GFP_COMP to
alloc_pages_exact().  So the former unconditional addition of
__GFP_COMP flag in snd_malloc_pages() is dropped, as well as in most
other places.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/memalloc.h        |  4 ----
 sound/core/memalloc.c           | 53 +++--------------------------------------
 sound/core/pcm.c                | 14 +++++------
 sound/usb/usx2y/usX2Yhwdep.c    |  3 ++-
 sound/usb/usx2y/usbusx2y.c      |  3 ++-
 sound/usb/usx2y/usx2yhwdeppcm.c |  6 +++--
 6 files changed, 18 insertions(+), 65 deletions(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 1ac0dd82a916..4c6f3b5a7cff 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -151,9 +151,5 @@ int snd_dma_alloc_pages_fallback(int type, struct device *dev, size_t size,
                                  struct snd_dma_buffer *dmab);
 void snd_dma_free_pages(struct snd_dma_buffer *dmab);
 
-/* basic memory allocation functions */
-void *snd_malloc_pages(size_t size, gfp_t gfp_flags);
-void snd_free_pages(void *ptr, size_t size);
-
 #endif /* __SOUND_MEMALLOC_H */
 
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index eb974235c92b..9f48e1d3a257 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -30,53 +30,6 @@
 #endif
 #include <sound/memalloc.h>
 
-/*
- *
- *  Generic memory allocators
- *
- */
-
-/**
- * snd_malloc_pages - allocate pages with the given size
- * @size: the size to allocate in bytes
- * @gfp_flags: the allocation conditions, GFP_XXX
- *
- * Allocates the physically contiguous pages with the given size.
- *
- * Return: The pointer of the buffer, or %NULL if no enough memory.
- */
-void *snd_malloc_pages(size_t size, gfp_t gfp_flags)
-{
-	int pg;
-
-	if (WARN_ON(!size))
-		return NULL;
-	if (WARN_ON(!gfp_flags))
-		return NULL;
-	gfp_flags |= __GFP_COMP;	/* compound page lets parts be mapped */
-	pg = get_order(size);
-	return (void *) __get_free_pages(gfp_flags, pg);
-}
-EXPORT_SYMBOL(snd_malloc_pages);
-
-/**
- * snd_free_pages - release the pages
- * @ptr: the buffer pointer to release
- * @size: the allocated buffer size
- *
- * Releases the buffer allocated via snd_malloc_pages().
- */
-void snd_free_pages(void *ptr, size_t size)
-{
-	int pg;
-
-	if (ptr == NULL)
-		return;
-	pg = get_order(size);
-	free_pages((unsigned long) ptr, pg);
-}
-EXPORT_SYMBOL(snd_free_pages);
-
 /*
  *
  *  Bus-specific memory allocators
@@ -190,8 +143,8 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 	dmab->bytes = 0;
 	switch (type) {
 	case SNDRV_DMA_TYPE_CONTINUOUS:
-		dmab->area = snd_malloc_pages(size,
-					(__force gfp_t)(unsigned long)device);
+		dmab->area = alloc_pages_exact(size,
+					       (__force gfp_t)(unsigned long)device);
 		dmab->addr = 0;
 		break;
 #ifdef CONFIG_HAS_DMA
@@ -275,7 +228,7 @@ void snd_dma_free_pages(struct snd_dma_buffer *dmab)
 {
 	switch (dmab->dev.type) {
 	case SNDRV_DMA_TYPE_CONTINUOUS:
-		snd_free_pages(dmab->area, dmab->bytes);
+		free_pages_exact(dmab->area, dmab->bytes);
 		break;
 #ifdef CONFIG_HAS_DMA
 #ifdef CONFIG_GENERIC_ALLOCATOR
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 7b63aee124af..998e477522fd 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -959,22 +959,22 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 		return -ENOMEM;
 
 	size = PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status));
-	runtime->status = snd_malloc_pages(size, GFP_KERNEL);
+	runtime->status = alloc_pages_exact(size, GFP_KERNEL);
 	if (runtime->status == NULL) {
 		kfree(runtime);
 		return -ENOMEM;
 	}
-	memset((void*)runtime->status, 0, size);
+	memset(runtime->status, 0, size);
 
 	size = PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control));
-	runtime->control = snd_malloc_pages(size, GFP_KERNEL);
+	runtime->control = alloc_pages_exact(size, GFP_KERNEL);
 	if (runtime->control == NULL) {
-		snd_free_pages((void*)runtime->status,
+		free_pages_exact(runtime->status,
 			       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)));
 		kfree(runtime);
 		return -ENOMEM;
 	}
-	memset((void*)runtime->control, 0, size);
+	memset(runtime->control, 0, size);
 
 	init_waitqueue_head(&runtime->sleep);
 	init_waitqueue_head(&runtime->tsleep);
@@ -1000,9 +1000,9 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 	runtime = substream->runtime;
 	if (runtime->private_free != NULL)
 		runtime->private_free(runtime);
-	snd_free_pages((void*)runtime->status,
+	free_pages_exact(runtime->status,
 		       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)));
-	snd_free_pages((void*)runtime->control,
+	free_pages_exact(runtime->control,
 		       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control)));
 	kfree(runtime->hw_constraints.rules);
 	/* Avoid concurrent access to runtime via PCM timer interface */
diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index c1dd9a7b48df..bfe1108416cf 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -75,7 +75,8 @@ static int snd_us428ctls_mmap(struct snd_hwdep * hw, struct file *filp, struct v
 
 	if (!us428->us428ctls_sharedmem) {
 		init_waitqueue_head(&us428->us428ctls_wait_queue_head);
-		if(!(us428->us428ctls_sharedmem = snd_malloc_pages(sizeof(struct us428ctls_sharedmem), GFP_KERNEL)))
+		us428->us428ctls_sharedmem = alloc_pages_exact(sizeof(struct us428ctls_sharedmem), GFP_KERNEL);
+		if (!us428->us428ctls_sharedmem)
 			return -ENOMEM;
 		memset(us428->us428ctls_sharedmem, -1, sizeof(struct us428ctls_sharedmem));
 		us428->us428ctls_sharedmem->CtlSnapShotLast = -2;
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index da4a5a541512..9f7bbed2c0f0 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -437,7 +437,8 @@ static void snd_usX2Y_card_private_free(struct snd_card *card)
 	kfree(usX2Y(card)->In04Buf);
 	usb_free_urb(usX2Y(card)->In04urb);
 	if (usX2Y(card)->us428ctls_sharedmem)
-		snd_free_pages(usX2Y(card)->us428ctls_sharedmem, sizeof(*usX2Y(card)->us428ctls_sharedmem));
+		free_pages_exact(usX2Y(card)->us428ctls_sharedmem,
+				 sizeof(*usX2Y(card)->us428ctls_sharedmem));
 	if (usX2Y(card)->card_index >= 0  &&  usX2Y(card)->card_index < SNDRV_CARDS)
 		snd_usX2Y_card_used[usX2Y(card)->card_index] = 0;
 }
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 714cf50d4a4c..ace8185c3f6d 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -488,7 +488,9 @@ static int snd_usX2Y_usbpcm_prepare(struct snd_pcm_substream *substream)
 	snd_printdd("snd_usX2Y_pcm_prepare(%p)\n", substream);
 
 	if (NULL == usX2Y->hwdep_pcm_shm) {
-		if (NULL == (usX2Y->hwdep_pcm_shm = snd_malloc_pages(sizeof(struct snd_usX2Y_hwdep_pcm_shm), GFP_KERNEL)))
+		usX2Y->hwdep_pcm_shm = alloc_pages_exact(sizeof(struct snd_usX2Y_hwdep_pcm_shm),
+							 GFP_KERNEL);
+		if (!usX2Y->hwdep_pcm_shm)
 			return -ENOMEM;
 		memset(usX2Y->hwdep_pcm_shm, 0, sizeof(struct snd_usX2Y_hwdep_pcm_shm));
 	}
@@ -700,7 +702,7 @@ static void snd_usX2Y_hwdep_pcm_private_free(struct snd_hwdep *hwdep)
 {
 	struct usX2Ydev *usX2Y = hwdep->private_data;
 	if (NULL != usX2Y->hwdep_pcm_shm)
-		snd_free_pages(usX2Y->hwdep_pcm_shm, sizeof(struct snd_usX2Y_hwdep_pcm_shm));
+		free_pages_exact(usX2Y->hwdep_pcm_shm, sizeof(struct snd_usX2Y_hwdep_pcm_shm));
 }
 
 
-- 
2.16.4
