From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: pcm - fix page conversion on
	non-coherent MIPS arch
Date: Thu, 26 Nov 2009 16:13:06 +0100
Message-ID: <1259248388-20095-4-git-send-email-tiwai@suse.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
	<1259248388-20095-2-git-send-email-tiwai@suse.de>
	<1259248388-20095-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F153103886
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2009 16:13:44 +0100 (CET)
In-Reply-To: <1259248388-20095-3-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-mips@linux-mips.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Becky Bruce <beckyb@kernel.crashing.org>, Wu Zhangjin <wuzhangjin@gmail.com>, Takashi Iwai <tiwai@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: alsa-devel@alsa-project.org

The non-coherent MIPS arch doesn't give the correct address by a simple
virt_to_page() for pages allocated via dma_alloc_coherent().

Original patch by Wu Zhangjin <wuzj@lemote.com>.  A proper check of the
buffer allocation type was added to avoid the wrong conversion.

Note that this doesn't fix perfectly: the pages should be marked with
proper pgprot value.  This will be done in a future implementation like
the conversion to dma_mmap_coherent().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c906be2..e48c5f6 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3066,6 +3066,10 @@ static inline struct page *
 snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned long ofs)
 {
 	void *vaddr = substream->runtime->dma_area + ofs;
+#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
+	if (substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
+		return virt_to_page(CAC_ADDR(vaddr));
+#endif
 	return virt_to_page(vaddr);
 }
 
-- 
1.6.5.3
