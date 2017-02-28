From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: ctxfi: Fallback DMA mask to 32bit
Date: Tue, 28 Feb 2017 17:24:07 +0100
Message-ID: <20170228162407.32296-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DFDA2266718
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 17:24:09 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5C689ABC6
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 16:24:09 +0000 (UTC)
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

Currently ctxfi driver tries to set only the 64bit DMA mask on 64bit
architectures, and bails out if it fails.  This causes a problem on
some platforms since the 64bit DMA isn't always guaranteed.  We should
fall back to the default 32bit DMA when 64bit DMA fails.

Fixes: 6d74b86d3c0f ("ALSA: ctxfi - Allow 64bit DMA")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ctxfi/cthw20k1.c | 19 ++++++-------------
 sound/pci/ctxfi/cthw20k2.c | 19 ++++++-------------
 2 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index 9667cbfb0ca2..ab4cdab5cfa5 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -27,12 +27,6 @@
 #include "cthw20k1.h"
 #include "ct20k1reg.h"
 
-#if BITS_PER_LONG == 32
-#define CT_XFI_DMA_MASK		DMA_BIT_MASK(32) /* 32 bit PTE */
-#else
-#define CT_XFI_DMA_MASK		DMA_BIT_MASK(64) /* 64 bit PTE */
-#endif
-
 struct hw20k1 {
 	struct hw hw;
 	spinlock_t reg_20k1_lock;
@@ -1904,19 +1898,18 @@ static int hw_card_start(struct hw *hw)
 {
 	int err;
 	struct pci_dev *pci = hw->pci;
+	const unsigned int dma_bits = BITS_PER_LONG;
 
 	err = pci_enable_device(pci);
 	if (err < 0)
 		return err;
 
 	/* Set DMA transfer mask */
-	if (dma_set_mask(&pci->dev, CT_XFI_DMA_MASK) < 0 ||
-	    dma_set_coherent_mask(&pci->dev, CT_XFI_DMA_MASK) < 0) {
-		dev_err(hw->card->dev,
-			"architecture does not support PCI busmaster DMA with mask 0x%llx\n",
-			CT_XFI_DMA_MASK);
-		err = -ENXIO;
-		goto error1;
+	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(dma_bits))) {
+		dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(dma_bits));
+	} else {
+		dma_set_mask(&pci->dev, DMA_BIT_MASK(32));
+		dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(32));
 	}
 
 	if (!hw->io_base) {
diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index 6414ecf93efa..18ee7768b7c4 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -26,12 +26,6 @@
 #include "cthw20k2.h"
 #include "ct20k2reg.h"
 
-#if BITS_PER_LONG == 32
-#define CT_XFI_DMA_MASK		DMA_BIT_MASK(32) /* 32 bit PTE */
-#else
-#define CT_XFI_DMA_MASK		DMA_BIT_MASK(64) /* 64 bit PTE */
-#endif
-
 struct hw20k2 {
 	struct hw hw;
 	/* for i2c */
@@ -2029,19 +2023,18 @@ static int hw_card_start(struct hw *hw)
 	int err = 0;
 	struct pci_dev *pci = hw->pci;
 	unsigned int gctl;
+	const unsigned int dma_bits = BITS_PER_LONG;
 
 	err = pci_enable_device(pci);
 	if (err < 0)
 		return err;
 
 	/* Set DMA transfer mask */
-	if (dma_set_mask(&pci->dev, CT_XFI_DMA_MASK) < 0 ||
-	    dma_set_coherent_mask(&pci->dev, CT_XFI_DMA_MASK) < 0) {
-		dev_err(hw->card->dev,
-			"architecture does not support PCI busmaster DMA with mask 0x%llx\n",
-			CT_XFI_DMA_MASK);
-		err = -ENXIO;
-		goto error1;
+	if (!dma_set_mask(&pci->dev, DMA_BIT_MASK(dma_bits))) {
+		dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(dma_bits));
+	} else {
+		dma_set_mask(&pci->dev, DMA_BIT_MASK(32));
+		dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(32));
 	}
 
 	if (!hw->io_base) {
-- 
2.11.1
