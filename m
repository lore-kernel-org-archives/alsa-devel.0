From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 17/22] ALSA: hda - Add position_check op
Date: Fri, 28 Feb 2014 15:41:28 -0800
Message-ID: <1393630893-29010-18-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f201.google.com (mail-ob0-f201.google.com
 [209.85.214.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C1EA2659AA
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-ob0-f201.google.com with SMTP id gq1so921999obb.0
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 15:42:51 -0800 (PST)
In-Reply-To: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

This op will be used by hda_intel to do the position check.  Takashi
wisely suggested adding this before moving the interrupt handler to
common HDA code.  Having this callback prevents the need to move the
hda_intel specific delayed interrupt handling with the irq.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 30 +++++++++++++++++++++---------
 sound/pci/hda/hda_priv.h  |  2 ++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 4f693ef..53e4b40 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -416,6 +416,23 @@ static void azx_init_pci(struct azx *chip)
 
 static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev);
 
+/* called from IRQ */
+static int azx_position_check(struct azx *chip, struct azx_dev *azx_dev)
+{
+	int ok;
+
+	ok = azx_position_ok(chip, azx_dev);
+	if (ok == 1) {
+		azx_dev->irq_pending = 0;
+		return ok;
+	} else if (ok == 0 && chip->bus && chip->bus->workq) {
+		/* bogus IRQ, process it later */
+		azx_dev->irq_pending = 1;
+		queue_work(chip->bus->workq, &chip->irq_pending_work);
+	}
+	return 0;
+}
+
 /*
  * interrupt handler
  */
@@ -425,7 +442,7 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 	struct azx_dev *azx_dev;
 	u32 status;
 	u8 sd_status;
-	int i, ok;
+	int i;
 
 #ifdef CONFIG_PM_RUNTIME
 	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
@@ -455,17 +472,11 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 			    !(sd_status & SD_INT_COMPLETE))
 				continue;
 			/* check whether this IRQ is really acceptable */
-			ok = azx_position_ok(chip, azx_dev);
-			if (ok == 1) {
-				azx_dev->irq_pending = 0;
+			if (!chip->ops->position_check ||
+			    chip->ops->position_check(chip, azx_dev)) {
 				spin_unlock(&chip->reg_lock);
 				snd_pcm_period_elapsed(azx_dev->substream);
 				spin_lock(&chip->reg_lock);
-			} else if (ok == 0 && chip->bus && chip->bus->workq) {
-				/* bogus IRQ, process it later */
-				azx_dev->irq_pending = 1;
-				queue_work(chip->bus->workq,
-					   &chip->irq_pending_work);
 			}
 		}
 	}
@@ -1821,6 +1832,7 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.substream_alloc_pages = substream_alloc_pages,
 	.substream_free_pages = substream_free_pages,
 	.pcm_mmap_prepare = pcm_mmap_prepare,
+	.position_check = azx_position_check,
 };
 
 static int azx_probe(struct pci_dev *pci,
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index edbe2eb..bf3cb33 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -311,6 +311,8 @@ struct hda_controller_ops {
 				    struct snd_pcm_substream *substream);
 	void (*pcm_mmap_prepare)(struct snd_pcm_substream *substream,
 				 struct vm_area_struct *area);
+	/* Check if current position is acceptable */
+	int (*position_check)(struct azx *chip, struct azx_dev *azx_dev);
 };
 
 struct azx_pcm {
-- 
1.8.1.3.605.g02339dd
