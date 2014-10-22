From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH next 1/2] ALSA: pcm: Remove arch-dependent mmap
	kludges
Date: Wed, 22 Oct 2014 12:15:48 +0200
Message-ID: <1413972949-11290-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 13B1D26060F
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 12:15:55 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E0C79ACD9
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 10:15:54 +0000 (UTC)
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

Since we have consistently dma_mmap_coherent() for all architectures,
the current ifdef and arch-specific codes in pcm core can be cleaned
up gracefully.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 815396d8427f..aa6754da7929 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -35,9 +35,6 @@
 #include <sound/timer.h>
 #include <sound/minors.h>
 #include <asm/io.h>
-#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
-#include <dma-coherence.h>
-#endif
 
 /*
  *  Compatibility
@@ -3251,20 +3248,6 @@ static inline struct page *
 snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned long ofs)
 {
 	void *vaddr = substream->runtime->dma_area + ofs;
-#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
-	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
-		return virt_to_page(CAC_ADDR(vaddr));
-#endif
-#if defined(CONFIG_PPC32) && defined(CONFIG_NOT_COHERENT_CACHE)
-	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV) {
-		dma_addr_t addr = substream->runtime->dma_addr + ofs;
-		addr -= get_dma_offset(substream->dma_buffer.dev.dev);
-		/* assume dma_handle set via pfn_to_phys() in
-		 * mm/dma-noncoherent.c
-		 */
-		return pfn_to_page(addr >> PAGE_SHIFT);
-	}
-#endif
 	return virt_to_page(vaddr);
 }
 
@@ -3309,13 +3292,6 @@ static const struct vm_operations_struct snd_pcm_vm_ops_data_fault = {
 	.fault =	snd_pcm_mmap_data_fault,
 };
 
-#ifndef ARCH_HAS_DMA_MMAP_COHERENT
-/* This should be defined / handled globally! */
-#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
-#define ARCH_HAS_DMA_MMAP_COHERENT
-#endif
-#endif
-
 /*
  * mmap the DMA buffer on RAM
  */
@@ -3331,7 +3307,6 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 				area->vm_end - area->vm_start, area->vm_page_prot);
 	}
 #endif /* CONFIG_GENERIC_ALLOCATOR */
-#ifdef ARCH_HAS_DMA_MMAP_COHERENT
 	if (!substream->ops->page &&
 	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
 		return dma_mmap_coherent(substream->dma_buffer.dev.dev,
@@ -3339,11 +3314,6 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
 					 area->vm_end - area->vm_start);
-#elif defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
-	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV &&
-	    !plat_device_is_coherent(substream->dma_buffer.dev.dev))
-		area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
-#endif /* ARCH_HAS_DMA_MMAP_COHERENT */
 	/* mmap with fault handler */
 	area->vm_ops = &snd_pcm_vm_ops_data_fault;
 	return 0;
-- 
2.1.2
