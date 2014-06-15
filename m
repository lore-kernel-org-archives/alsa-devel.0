From: Joe Perches <joe@perches.com>
Subject: [PATCH -next 26/26] sound: Use dma_zalloc_coherent
Date: Sun, 15 Jun 2014 13:37:55 -0700
Message-ID: <1ee1f44142267688ea2db19c11a83596b98c4f17.1402863905.git.joe@perches.com>
References: <cover.1402863904.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0089.hostedemail.com
 [216.40.44.89]) by alsa0.perex.cz (Postfix) with ESMTP id 396D12652BF
 for <alsa-devel@alsa-project.org>; Sun, 15 Jun 2014 22:39:24 +0200 (CEST)
In-Reply-To: <cover.1402863904.git.joe@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the zeroing function instead of dma_alloc_coherent & memset(,0,)

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/aoa/soundbus/i2sbus/core.c | 12 ++++--------
 sound/sparc/dbri.c               |  6 ++----
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 4678360..a80d5ea 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -47,15 +47,11 @@ static int alloc_dbdma_descriptor_ring(struct i2sbus_dev *i2sdev,
 	/* We use the PCI APIs for now until the generic one gets fixed
 	 * enough or until we get some macio-specific versions
 	 */
-	r->space = dma_alloc_coherent(
-			&macio_get_pci_dev(i2sdev->macio)->dev,
-			r->size,
-			&r->bus_addr,
-			GFP_KERNEL);
+	r->space = dma_zalloc_coherent(&macio_get_pci_dev(i2sdev->macio)->dev,
+				       r->size, &r->bus_addr, GFP_KERNEL);
+	if (!r->space)
+		return -ENOMEM;
 
-	if (!r->space) return -ENOMEM;
-
-	memset(r->space, 0, r->size);
 	r->cmds = (void*)DBDMA_ALIGN(r->space);
 	r->bus_cmd_start = r->bus_addr +
 			   (dma_addr_t)((char*)r->cmds - (char*)r->space);
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index be1b1aa..b2c3d0d 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2534,12 +2534,10 @@ static int snd_dbri_create(struct snd_card *card,
 	dbri->op = op;
 	dbri->irq = irq;
 
-	dbri->dma = dma_alloc_coherent(&op->dev,
-				       sizeof(struct dbri_dma),
-				       &dbri->dma_dvma, GFP_ATOMIC);
+	dbri->dma = dma_zalloc_coherent(&op->dev, sizeof(struct dbri_dma),
+					&dbri->dma_dvma, GFP_ATOMIC);
 	if (!dbri->dma)
 		return -ENOMEM;
-	memset((void *)dbri->dma, 0, sizeof(struct dbri_dma));
 
 	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08x)\n",
 		dbri->dma, dbri->dma_dvma);
-- 
1.8.1.2.459.gbcd45b4.dirty
