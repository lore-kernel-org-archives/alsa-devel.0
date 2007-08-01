From: Songmao Tian <tiansm@lemote.com>
Subject: ALSA on MIPS platform
Date: Wed, 01 Aug 2007 15:56:48 +0800
Message-ID: <46B03CC0.3090000@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lemote.com (unknown [222.92.8.141])
	by alsa0.perex.cz (Postfix) with SMTP id ABE9810389B
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 09:57:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-mips@linux-mips.org
List-Id: alsa-devel@alsa-project.org

Hi,
    In 
http://www.linux-mips.org/archives/linux-mips/2007-04/msg00114.html, 
Atsushi Nemoto pointed out the problem is discussed before, the thread 
can be found at http://lkml.org/lkml/2006/1/25/117. Thanks Atsushi Nemoto:)
    The problem is clear:
1. dma_alloc_noncoherent() return a non-cached address, and 
virt_to_page() need a cached logical addr (Have I named it right?)
2. mmaped dam buffer should be non-cached.

We have a ugly patch, but we want to solve the problem cleanly, so can 
anyone show me the way?

Regards,
Tian

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 59b29cd..fd0aa66 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3138,7 +3138,11 @@ static struct page 
*snd_pcm_mmap_data_nopage(struct vm_area_struct *area,
             return NOPAGE_OOM; /* XXX: is this really due to OOM? */
     } else {
         vaddr = runtime->dma_area + offset;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+        page = virt_to_page(CAC_ADDR(vaddr));
+#else
         page = virt_to_page(vaddr);
+#endif
     }
     get_page(page);
     if (type)
@@ -3254,6 +3258,11 @@ static int snd_pcm_mmap(struct file *file, struct 
vm_area_struct *area)
     substream = pcm_file->substream;
     snd_assert(substream != NULL, return -ENXIO);
 
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+    /* all mmap using uncached mode */
+    area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
+#endif
+
     offset = area->vm_pgoff << PAGE_SHIFT;
     switch (offset) {
     case SNDRV_PCM_MMAP_OFFSET_STATUS:
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index cefd228..2251e70 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -91,12 +91,21 @@ void *snd_malloc_sgbuf_pages(struct device *device,
         }
         sgbuf->table[i].buf = tmpb.area;
         sgbuf->table[i].addr = tmpb.addr;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+        sgbuf->page_table[i] = virt_to_page(CAC_ADDR(tmpb.area));
+#else
         sgbuf->page_table[i] = virt_to_page(tmpb.area);
+#endif
         sgbuf->pages++;
     }
 
     sgbuf->size = size;
+#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
+    /* maybe we should use uncached accelerated mode */
+    dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, 
pgprot_noncached(PAGE_KERNEL));
+#else
     dmab->area = vmap(sgbuf->page_table, sgbuf->pages, VM_MAP, 
PAGE_KERNEL);
+#endif
     if (! dmab->area)
         goto _failed;
     return dmab->area;
