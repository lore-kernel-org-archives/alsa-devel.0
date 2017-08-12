From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: trident: Delete an error message for a
 failed memory allocation in snd_trident_tlb_alloc()
Date: Sat, 12 Aug 2017 13:31:55 +0200
Message-ID: <20c860e6-2aeb-eb8b-2ba7-fba216a70cfa@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CE13266847
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 13:32:41 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Fabian Frederick <fabf@skynet.be>, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Aug 2017 13:20:16 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/trident/trident_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 64d3b8eba4bb..0eca3c370990 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3363,11 +3363,9 @@ static int snd_trident_tlb_alloc(struct snd_trident *trident)
 	trident->tlb.entries_dmaaddr = ALIGN(trident->tlb.buffer.addr, SNDRV_TRIDENT_MAX_PAGES * 4);
 	/* allocate shadow TLB page table (virtual addresses) */
 	trident->tlb.shadow_entries = vmalloc(SNDRV_TRIDENT_MAX_PAGES*sizeof(unsigned long));
-	if (trident->tlb.shadow_entries == NULL) {
-		dev_err(trident->card->dev,
-			"unable to allocate shadow TLB entries\n");
+	if (!trident->tlb.shadow_entries)
 		return -ENOMEM;
-	}
+
 	/* allocate and setup silent page and initialise TLB entries */
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(trident->pci),
 				SNDRV_TRIDENT_PAGE_SIZE, &trident->tlb.silent_page) < 0) {
-- 
2.14.0
