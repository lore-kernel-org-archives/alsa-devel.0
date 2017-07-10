From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Simplify check for
	dma_mmap_coherent() availability
Date: Mon, 10 Jul 2017 16:13:36 +0200
Message-ID: <20170710141336.18649-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BD54266D49
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 16:13:37 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5A61BAABA
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 14:13:37 +0000 (UTC)
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

We check the availability of dma_mmap_coherent() in hw_support_mmap()
but with an ugly ifdef of lots of arch-checks.  Now we have a nice
CONFIG_ARCH_NO_COHERENT_DMA_MMAP kconfig, and this can be used
together with CONFIG_HAS_DMA check for a cleaner and more
comprehensive check.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b26c7e61d600..2a730f38e375 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -238,10 +238,8 @@ static bool hw_support_mmap(struct snd_pcm_substream *substream)
 {
 	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_MMAP))
 		return false;
-	/* check architectures that return -EINVAL from dma_mmap_coherent() */
-	/* FIXME: this should be some global flag */
-#if defined(CONFIG_C6X) || defined(CONFIG_FRV) || defined(CONFIG_MN10300) ||\
-	defined(CONFIG_PARISC) || defined(CONFIG_XTENSA)
+	/* architecture supports dma_mmap_coherent()? */
+#if defined(CONFIG_ARCH_NO_COHERENT_DMA_MMAP) || !defined(CONFIG_HAS_DMA)
 	if (!substream->ops->mmap &&
 	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
 		return false;
-- 
2.13.2
