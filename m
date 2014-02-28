From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 18/22] ALSA: hda - Move azx_interrupt to
	hda_controller
Date: Fri, 28 Feb 2014 15:41:29 -0800
Message-ID: <1393630893-29010-19-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f202.google.com (mail-pd0-f202.google.com
 [209.85.192.202])
 by alsa0.perex.cz (Postfix) with ESMTP id C5B172659D3
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-pd0-f202.google.com with SMTP id fp1so174978pdb.1
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

This code will be reused by an hda_platform driver as it has no PCI
dependencies.  This allows update_rirb to be static as all users are
now in hda_controller.c.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_controller.c | 69 ++++++++++++++++++++++++++++++++++++++++--
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 65 ---------------------------------------
 3 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index bde4935..43b99b4 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -22,6 +22,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -1162,7 +1163,7 @@ static int azx_corb_send_cmd(struct hda_bus *bus, u32 val)
 #define ICH6_RIRB_EX_UNSOL_EV	(1<<4)
 
 /* retrieve RIRB entry - called from interrupt handler */
-void azx_update_rirb(struct azx *chip)
+static void azx_update_rirb(struct azx *chip)
 {
 	unsigned int rp, wp;
 	unsigned int addr;
@@ -1205,7 +1206,6 @@ void azx_update_rirb(struct azx *chip)
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(azx_update_rirb);
 
 /* receive a response */
 static unsigned int azx_rirb_get_response(struct hda_bus *bus,
@@ -1747,5 +1747,70 @@ void azx_stop_chip(struct azx *chip)
 	chip->initialized = 0;
 }
 
+/*
+ * interrupt handler
+ */
+irqreturn_t azx_interrupt(int irq, void *dev_id)
+{
+	struct azx *chip = dev_id;
+	struct azx_dev *azx_dev;
+	u32 status;
+	u8 sd_status;
+	int i;
+
+#ifdef CONFIG_PM_RUNTIME
+	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
+		if (chip->card->dev->power.runtime_status != RPM_ACTIVE)
+			return IRQ_NONE;
+#endif
+
+	spin_lock(&chip->reg_lock);
+
+	if (chip->disabled) {
+		spin_unlock(&chip->reg_lock);
+		return IRQ_NONE;
+	}
+
+	status = azx_readl(chip, INTSTS);
+	if (status == 0 || status == 0xffffffff) {
+		spin_unlock(&chip->reg_lock);
+		return IRQ_NONE;
+	}
+
+	for (i = 0; i < chip->num_streams; i++) {
+		azx_dev = &chip->azx_dev[i];
+		if (status & azx_dev->sd_int_sta_mask) {
+			sd_status = azx_sd_readb(chip, azx_dev, SD_STS);
+			azx_sd_writeb(chip, azx_dev, SD_STS, SD_INT_MASK);
+			if (!azx_dev->substream || !azx_dev->running ||
+			    !(sd_status & SD_INT_COMPLETE))
+				continue;
+			/* check whether this IRQ is really acceptable */
+			if (!chip->ops->position_check ||
+			    chip->ops->position_check(chip, azx_dev)) {
+				spin_unlock(&chip->reg_lock);
+				snd_pcm_period_elapsed(azx_dev->substream);
+				spin_lock(&chip->reg_lock);
+			}
+		}
+	}
+
+	/* clear rirb int */
+	status = azx_readb(chip, RIRBSTS);
+	if (status & RIRB_INT_MASK) {
+		if (status & RIRB_INT_RESPONSE) {
+			if (chip->driver_caps & AZX_DCAPS_RIRB_PRE_DELAY)
+				udelay(80);
+			azx_update_rirb(chip);
+		}
+		azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
+	}
+
+	spin_unlock(&chip->reg_lock);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(azx_interrupt);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Common HDA driver funcitons");
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 67d9f28..fac9299 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -50,7 +50,6 @@ void azx_free_stream_pages(struct azx *chip);
 /*
  * CORB / RIRB interface
  */
-void azx_update_rirb(struct azx *chip);
 int azx_send_cmd(struct hda_bus *bus, unsigned int val);
 unsigned int azx_get_response(struct hda_bus *bus,
 			      unsigned int addr);
@@ -59,5 +58,6 @@ unsigned int azx_get_response(struct hda_bus *bus,
 void azx_init_chip(struct azx *chip, int full_reset);
 void azx_stop_chip(struct azx *chip);
 void azx_enter_link_reset(struct azx *chip);
+irqreturn_t azx_interrupt(int irq, void *dev_id);
 
 #endif /* __SOUND_HDA_CONTROLLER_H */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 53e4b40..96c22a3 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -413,7 +413,6 @@ static void azx_init_pci(struct azx *chip)
         }
 }
 
-
 static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev);
 
 /* called from IRQ */
@@ -434,70 +433,6 @@ static int azx_position_check(struct azx *chip, struct azx_dev *azx_dev)
 }
 
 /*
- * interrupt handler
- */
-static irqreturn_t azx_interrupt(int irq, void *dev_id)
-{
-	struct azx *chip = dev_id;
-	struct azx_dev *azx_dev;
-	u32 status;
-	u8 sd_status;
-	int i;
-
-#ifdef CONFIG_PM_RUNTIME
-	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
-		if (chip->card->dev->power.runtime_status != RPM_ACTIVE)
-			return IRQ_NONE;
-#endif
-
-	spin_lock(&chip->reg_lock);
-
-	if (chip->disabled) {
-		spin_unlock(&chip->reg_lock);
-		return IRQ_NONE;
-	}
-
-	status = azx_readl(chip, INTSTS);
-	if (status == 0 || status == 0xffffffff) {
-		spin_unlock(&chip->reg_lock);
-		return IRQ_NONE;
-	}
-	
-	for (i = 0; i < chip->num_streams; i++) {
-		azx_dev = &chip->azx_dev[i];
-		if (status & azx_dev->sd_int_sta_mask) {
-			sd_status = azx_sd_readb(chip, azx_dev, SD_STS);
-			azx_sd_writeb(chip, azx_dev, SD_STS, SD_INT_MASK);
-			if (!azx_dev->substream || !azx_dev->running ||
-			    !(sd_status & SD_INT_COMPLETE))
-				continue;
-			/* check whether this IRQ is really acceptable */
-			if (!chip->ops->position_check ||
-			    chip->ops->position_check(chip, azx_dev)) {
-				spin_unlock(&chip->reg_lock);
-				snd_pcm_period_elapsed(azx_dev->substream);
-				spin_lock(&chip->reg_lock);
-			}
-		}
-	}
-
-	/* clear rirb int */
-	status = azx_readb(chip, RIRBSTS);
-	if (status & RIRB_INT_MASK) {
-		if (status & RIRB_INT_RESPONSE) {
-			if (chip->driver_caps & AZX_DCAPS_RIRB_PRE_DELAY)
-				udelay(80);
-			azx_update_rirb(chip);
-		}
-		azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
-	}
-
-	spin_unlock(&chip->reg_lock);
-	
-	return IRQ_HANDLED;
-}
-
-/*
  * Probe the given codec address
  */
 static int probe_codec(struct azx *chip, int addr)
-- 
1.8.1.3.605.g02339dd
