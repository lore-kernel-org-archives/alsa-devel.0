From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/14] ALSA: trident: Proper endian notations
Date: Wed, 25 Jul 2018 23:24:02 +0200
Message-ID: <20180725212414.19795-3-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 673BD267762
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:16 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 21206ADA0
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
In-Reply-To: <20180725212414.19795-1-tiwai@suse.de>
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

The TLB entries in Trident driver are represented in little-endian,
hence they should be declared as __le32.

This patch fixes the sparse warnings like:
  sound/pci/trident/trident_memory.c:226:17: warning: incorrect type in assignment (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/trident/trident.h      | 2 +-
 sound/pci/trident/trident_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/trident/trident.h b/sound/pci/trident/trident.h
index 9624e5937719..2d62c1921255 100644
--- a/sound/pci/trident/trident.h
+++ b/sound/pci/trident/trident.h
@@ -264,7 +264,7 @@ struct snd_trident_memblk_arg {
 };
 
 struct snd_trident_tlb {
-	unsigned int * entries;		/* 16k-aligned TLB table */
+	__le32 *entries;		/* 16k-aligned TLB table */
 	dma_addr_t entries_dmaaddr;	/* 16k-aligned PCI address to TLB table */
 	unsigned long * shadow_entries;	/* shadow entries with virtual addresses */
 	struct snd_dma_buffer buffer;
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 49c64fae3466..5523e193d556 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3359,7 +3359,7 @@ static int snd_trident_tlb_alloc(struct snd_trident *trident)
 		dev_err(trident->card->dev, "unable to allocate TLB buffer\n");
 		return -ENOMEM;
 	}
-	trident->tlb.entries = (unsigned int*)ALIGN((unsigned long)trident->tlb.buffer.area, SNDRV_TRIDENT_MAX_PAGES * 4);
+	trident->tlb.entries = (__le32 *)ALIGN((unsigned long)trident->tlb.buffer.area, SNDRV_TRIDENT_MAX_PAGES * 4);
 	trident->tlb.entries_dmaaddr = ALIGN(trident->tlb.buffer.addr, SNDRV_TRIDENT_MAX_PAGES * 4);
 	/* allocate shadow TLB page table (virtual addresses) */
 	trident->tlb.shadow_entries =
-- 
2.18.0
