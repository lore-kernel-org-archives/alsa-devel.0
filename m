From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: Remove memory accounting in memalloc
	helper
Date: Wed,  8 Jan 2014 16:16:07 +0100
Message-ID: <1389194168-12559-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CEE6E261A5E
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 16:16:08 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9D255AC48
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 15:16:08 +0000 (UTC)
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

It's almost superfluous, and doesn't help much for real uses.
Let's reduce the layer size.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 5e1c7bc73b29..bfaf4f04d91d 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -63,18 +63,6 @@ struct snd_mem_list {
  *
  */
 
-static long snd_allocated_pages; /* holding the number of allocated pages */
-
-static inline void inc_snd_pages(int order)
-{
-	snd_allocated_pages += 1 << order;
-}
-
-static inline void dec_snd_pages(int order)
-{
-	snd_allocated_pages -= 1 << order;
-}
-
 /**
  * snd_malloc_pages - allocate pages with the given size
  * @size: the size to allocate in bytes
@@ -87,7 +75,6 @@ static inline void dec_snd_pages(int order)
 void *snd_malloc_pages(size_t size, gfp_t gfp_flags)
 {
 	int pg;
-	void *res;
 
 	if (WARN_ON(!size))
 		return NULL;
@@ -95,9 +82,7 @@ void *snd_malloc_pages(size_t size, gfp_t gfp_flags)
 		return NULL;
 	gfp_flags |= __GFP_COMP;	/* compound page lets parts be mapped */
 	pg = get_order(size);
-	if ((res = (void *) __get_free_pages(gfp_flags, pg)) != NULL)
-		inc_snd_pages(pg);
-	return res;
+	return (void *) __get_free_pages(gfp_flags, pg);
 }
 
 /**
@@ -114,7 +99,6 @@ void snd_free_pages(void *ptr, size_t size)
 	if (ptr == NULL)
 		return;
 	pg = get_order(size);
-	dec_snd_pages(pg);
 	free_pages((unsigned long) ptr, pg);
 }
 
@@ -129,7 +113,6 @@ void snd_free_pages(void *ptr, size_t size)
 static void *snd_malloc_dev_pages(struct device *dev, size_t size, dma_addr_t *dma)
 {
 	int pg;
-	void *res;
 	gfp_t gfp_flags;
 
 	if (WARN_ON(!dma))
@@ -139,11 +122,7 @@ static void *snd_malloc_dev_pages(struct device *dev, size_t size, dma_addr_t *d
 		| __GFP_COMP	/* compound page lets parts be mapped */
 		| __GFP_NORETRY /* don't trigger OOM-killer */
 		| __GFP_NOWARN; /* no stack trace print - this call is non-critical */
-	res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
-	if (res != NULL)
-		inc_snd_pages(pg);
-
-	return res;
+	return dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, gfp_flags);
 }
 
 /* free the coherent DMA pages */
@@ -155,7 +134,6 @@ static void snd_free_dev_pages(struct device *dev, size_t size, void *ptr,
 	if (ptr == NULL)
 		return;
 	pg = get_order(size);
-	dec_snd_pages(pg);
 	dma_free_coherent(dev, PAGE_SIZE << pg, ptr, dma);
 }
 
@@ -432,14 +410,11 @@ static struct proc_dir_entry *snd_mem_proc;
 
 static int snd_mem_proc_read(struct seq_file *seq, void *offset)
 {
-	long pages = snd_allocated_pages >> (PAGE_SHIFT-12);
 	struct snd_mem_list *mem;
 	int devno;
 	static char *types[] = { "UNKNOWN", "CONT", "DEV", "DEV-SG" };
 
 	mutex_lock(&list_mutex);
-	seq_printf(seq, "pages  : %li bytes (%li pages per %likB)\n",
-		   pages * PAGE_SIZE, pages, PAGE_SIZE / 1024);
 	devno = 0;
 	list_for_each_entry(mem, &mem_list_head, list) {
 		devno++;
@@ -581,8 +556,6 @@ static void __exit snd_mem_exit(void)
 {
 	remove_proc_entry(SND_MEM_PROC_FILE, NULL);
 	free_all_reserved_pages();
-	if (snd_allocated_pages > 0)
-		printk(KERN_ERR "snd-malloc: Memory leak?  pages not freed = %li\n", snd_allocated_pages);
 }
 
 
-- 
1.8.5.2
