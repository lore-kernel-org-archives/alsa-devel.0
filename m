From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: ctxfi: Fix the incorrect check of
	dma_set_mask() call
Date: Mon, 20 Mar 2017 10:24:17 +0100
Message-ID: <20170320092417.6158-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D5FBC266CC6
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 10:24:19 +0100 (CET)
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: alsa-devel@alsa-project.org

In the commit [15c75b09f8d1: ALSA: ctxfi: Fallback DMA mask to 32bit],
I forgot to put "!" at dam_set_mask() call check in cthw20k1.c (while
cthw20k2.c is OK).  This patch fixes that obvious bug.

(As a side note: although the original commit was completely wrong,
 it's still working for most of machines, as it sets to 32bit DMA mask
 in the end.  So the bug severity is low.)

Fixes: 15c75b09f8d1 ("ALSA: ctxfi: Fallback DMA mask to 32bit")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ctxfi/cthw20k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index ab4cdab5cfa5..79edd88d5cd0 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -1905,7 +1905,7 @@ static int hw_card_start(struct hw *hw)
 		return err;
 
 	/* Set DMA transfer mask */
-	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(dma_bits))) {
+	if (!dma_set_mask(&pci->dev, DMA_BIT_MASK(dma_bits))) {
 		dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(dma_bits));
 	} else {
 		dma_set_mask(&pci->dev, DMA_BIT_MASK(32));
-- 
2.11.1
