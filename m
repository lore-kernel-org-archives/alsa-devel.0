From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: memalloc: Add fall-through annotation
Date: Thu,  4 Oct 2018 20:12:30 +0200
Message-ID: <20181004181234.21152-2-tiwai@suse.de>
References: <20181004181234.21152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 875F2267845
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:12:36 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E6E0AB03D
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 18:12:35 +0000 (UTC)
In-Reply-To: <20181004181234.21152-1-tiwai@suse.de>
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

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, add the "fall through" annotation in
snd_dma_alloc_pages().  Note that this seems necessary to be put
exactly before the next label, so it's outside the ifdef block.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index aa266907ec9b..59a4adc286ed 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -203,6 +203,7 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 		 */
 		dmab->dev.type = SNDRV_DMA_TYPE_DEV;
 #endif /* CONFIG_GENERIC_ALLOCATOR */
+		/* fall through */
 	case SNDRV_DMA_TYPE_DEV:
 	case SNDRV_DMA_TYPE_DEV_UC:
 		snd_malloc_dev_pages(dmab, size);
-- 
2.18.0
