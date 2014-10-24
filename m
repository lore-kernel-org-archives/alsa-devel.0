From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Avoid mmap warnings on x86
Date: Fri, 24 Oct 2014 13:04:37 +0200
Message-ID: <1414148677-25620-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BBF62604C5
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 13:04:42 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 34476AAF3
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 11:04:42 +0000 (UTC)
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

On x86, using dma_mmap_coherent() for the pages allocated via
dma_alloc_coherent() results in a warning like:
  aplay:32536 map pfn RAM range req uncached-minus for [mem 0x21d500000-0x21d51ffff], got write-back

Until the issue is addressed in the core side, take back to the old
good way in PCM code only for x86.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a915ed07aee1..2f7ad10ee7c3 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3324,6 +3324,7 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 				area->vm_end - area->vm_start, area->vm_page_prot);
 	}
 #endif /* CONFIG_GENERIC_ALLOCATOR */
+#ifndef CONFIG_X86 /* for avoiding warnings arch/x86/mm/pat.c */
 	if (!substream->ops->page &&
 	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
 		return dma_mmap_coherent(substream->dma_buffer.dev.dev,
@@ -3331,6 +3332,7 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream *substream,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
 					 area->vm_end - area->vm_start);
+#endif /* CONFIG_X86 */
 	/* mmap with fault handler */
 	area->vm_ops = &snd_pcm_vm_ops_data_fault;
 	return 0;
-- 
2.1.2
