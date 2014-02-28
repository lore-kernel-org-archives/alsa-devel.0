From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 13/19] ALSA: hda - Move azx_interrupt to
	hda_shared
Date: Thu, 27 Feb 2014 22:35:56 -0800
Message-ID: <1393569362-27285-14-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f201.google.com (mail-pd0-f201.google.com
 [209.85.192.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CAA52650D1
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-pd0-f201.google.com with SMTP id x10so33852pdj.4
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:13 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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
now in hda_shared.c.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c  | 124 ------------------------------------------
 sound/pci/hda/hda_shared.c | 131 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_shared.h |   5 +-
 3 files changed, 132 insertions(+), 128 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 00f4482..da5c7d2 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -393,77 +393,6 @@ static void azx_init_pci(struct azx *chip)
         }
 }
 
-
-/*
- * interrupt handler
- */
-static irqreturn_t azx_interrupt(int irq, void *dev_id)
-{
-	struct azx *chip = dev_id;
-	struct azx_dev *azx_dev;
-	u32 status;
-	u8 sd_status;
-	int i, ok;
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
-			ok = azx_position_ok(chip, azx_dev);
-			if (ok == 1) {
-				azx_dev->irq_pending = 0;
-				spin_unlock(&chip->reg_lock);
-				snd_pcm_period_elapsed(azx_dev->substream);
-				spin_lock(&chip->reg_lock);
-			} else if (ok == 0 && chip->bus && chip->bus->workq) {
-				/* bogus IRQ, process it later */
-				azx_dev->irq_pending = 1;
-				queue_work(chip->bus->workq,
-					   &chip->irq_pending_work);
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
 /*
  * Probe the given codec address
  */
@@ -631,59 +560,6 @@ static int azx_codec_configure(struct azx *chip)
 }
 
 /*
- * The work for pending PCM period updates.
- */
-static void azx_irq_pending_work(struct work_struct *work)
-{
-	struct azx *chip = container_of(work, struct azx, irq_pending_work);
-	int i, pending, ok;
-
-	if (!chip->irq_pending_warned) {
-		dev_info(chip->card->dev,
-			 "IRQ timing workaround is activated for card #%d. Suggest a bigger bdl_pos_adj.\n",
-			 chip->card->number);
-		chip->irq_pending_warned = 1;
-	}
-
-	for (;;) {
-		pending = 0;
-		spin_lock_irq(&chip->reg_lock);
-		for (i = 0; i < chip->num_streams; i++) {
-			struct azx_dev *azx_dev = &chip->azx_dev[i];
-			if (!azx_dev->irq_pending ||
-			    !azx_dev->substream ||
-			    !azx_dev->running)
-				continue;
-			ok = azx_position_ok(chip, azx_dev);
-			if (ok > 0) {
-				azx_dev->irq_pending = 0;
-				spin_unlock(&chip->reg_lock);
-				snd_pcm_period_elapsed(azx_dev->substream);
-				spin_lock(&chip->reg_lock);
-			} else if (ok < 0) {
-				pending = 0;	/* too early */
-			} else
-				pending++;
-		}
-		spin_unlock_irq(&chip->reg_lock);
-		if (!pending)
-			return;
-		msleep(1);
-	}
-}
-
-/* clear irq_pending flags and assure no on-going workq */
-static void azx_clear_irq_pending(struct azx *chip)
-{
-	int i;
-
-	spin_lock_irq(&chip->reg_lock);
-	for (i = 0; i < chip->num_streams; i++)
-		chip->azx_dev[i].irq_pending = 0;
-	spin_unlock_irq(&chip->reg_lock);
-}
-
-/*
  * mixer creation - all stuff is implemented in hda module
  */
 static int azx_mixer_create(struct azx *chip)
diff --git a/sound/pci/hda/hda_shared.c b/sound/pci/hda/hda_shared.c
index de39752..2821363 100644
--- a/sound/pci/hda/hda_shared.c
+++ b/sound/pci/hda/hda_shared.c
@@ -22,6 +22,7 @@
 
 #include <linux/clocksource.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -1095,7 +1096,7 @@ int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
  * data is processed.  So, we need to process it afterwords in a
  * workqueue.
  */
-int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
+static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 {
 	u32 wallclk;
 	unsigned int pos;
@@ -1235,7 +1236,7 @@ static int azx_corb_send_cmd(struct hda_bus *bus, u32 val)
 #define ICH6_RIRB_EX_UNSOL_EV	(1<<4)
 
 /* retrieve RIRB entry - called from interrupt handler */
-void azx_update_rirb(struct azx *chip)
+static void azx_update_rirb(struct azx *chip)
 {
 	unsigned int rp, wp;
 	unsigned int addr;
@@ -1826,5 +1827,131 @@ void azx_stop_chip(struct azx *chip)
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
+	int i, ok;
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
+			ok = azx_position_ok(chip, azx_dev);
+			if (ok == 1) {
+				azx_dev->irq_pending = 0;
+				spin_unlock(&chip->reg_lock);
+				snd_pcm_period_elapsed(azx_dev->substream);
+				spin_lock(&chip->reg_lock);
+			} else if (ok == 0 && chip->bus && chip->bus->workq) {
+				/* bogus IRQ, process it later */
+				azx_dev->irq_pending = 1;
+				queue_work(chip->bus->workq,
+					   &chip->irq_pending_work);
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
+/*
+ * The work for pending PCM period updates.
+ */
+void azx_irq_pending_work(struct work_struct *work)
+{
+	struct azx *chip = container_of(work, struct azx, irq_pending_work);
+	int i, pending, ok;
+
+	if (!chip->irq_pending_warned) {
+		dev_info(chip->card->dev,
+			 "IRQ timing workaround is activated for card #%d. Suggest a bigger bdl_pos_adj.\n",
+			 chip->card->number);
+		chip->irq_pending_warned = 1;
+	}
+
+	for (;;) {
+		pending = 0;
+		spin_lock_irq(&chip->reg_lock);
+		for (i = 0; i < chip->num_streams; i++) {
+			struct azx_dev *azx_dev = &chip->azx_dev[i];
+			if (!azx_dev->irq_pending ||
+			    !azx_dev->substream ||
+			    !azx_dev->running)
+				continue;
+			ok = azx_position_ok(chip, azx_dev);
+			if (ok > 0) {
+				azx_dev->irq_pending = 0;
+				spin_unlock(&chip->reg_lock);
+				snd_pcm_period_elapsed(azx_dev->substream);
+				spin_lock(&chip->reg_lock);
+			} else if (ok < 0) {
+				pending = 0;	/* too early */
+			} else
+				pending++;
+		}
+		spin_unlock_irq(&chip->reg_lock);
+		if (!pending)
+			return;
+		msleep(1);
+	}
+}
+EXPORT_SYMBOL_GPL(azx_irq_pending_work);
+
+/* clear irq_pending flags and assure no on-going workq */
+void azx_clear_irq_pending(struct azx *chip)
+{
+	int i;
+
+	spin_lock_irq(&chip->reg_lock);
+	for (i = 0; i < chip->num_streams; i++)
+		chip->azx_dev[i].irq_pending = 0;
+	spin_unlock_irq(&chip->reg_lock);
+}
+EXPORT_SYMBOL_GPL(azx_clear_irq_pending);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Common HDA driver funcitons");
diff --git a/sound/pci/hda/hda_shared.h b/sound/pci/hda/hda_shared.h
index 4a35b46..8eed8cb 100644
--- a/sound/pci/hda/hda_shared.h
+++ b/sound/pci/hda/hda_shared.h
@@ -23,7 +23,6 @@
 /* PCM setup */
 int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
 			  struct hda_pcm *cpcm);
-int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev);
 static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
 {
 	return substream->runtime->private_data;
@@ -51,11 +50,13 @@ void azx_free_stream_pages(struct azx *chip);
 int azx_send_cmd(struct hda_bus *bus, unsigned int val);
 unsigned int azx_get_response(struct hda_bus *bus,
 			      unsigned int addr);
-void azx_update_rirb(struct azx *chip);
 
 /* Low level azx interface */
 void azx_init_chip(struct azx *chip, int full_reset);
 void azx_stop_chip(struct azx *chip);
 void azx_enter_link_reset(struct azx *chip);
+irqreturn_t azx_interrupt(int irq, void *dev_id);
+void azx_irq_pending_work(struct work_struct *work);
+void azx_clear_irq_pending(struct azx *chip);
 
 #endif /* __SOUND_HDA_SHARED_H */
-- 
1.8.1.3.605.g02339dd
