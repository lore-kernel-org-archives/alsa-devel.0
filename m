From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 16/22] ALSA: hda - Move low level functions to
	hda_controller
Date: Fri, 28 Feb 2014 15:41:27 -0800
Message-ID: <1393630893-29010-17-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f74.google.com (mail-pa0-f74.google.com
 [209.85.220.74])
 by alsa0.perex.cz (Postfix) with ESMTP id AF8192659C9
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-pa0-f74.google.com with SMTP id fa1so173458pad.1
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

Share more code from hda_intel.  This moves the link control and
initialization to hda_controller.  The code will also be used by an
hda platform driver.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_controller.c | 177 ++++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_controller.h |   7 +-
 sound/pci/hda/hda_intel.c      | 175 ----------------------------------------
 3 files changed, 180 insertions(+), 179 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index a7c5a5d..bde4935 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1039,7 +1039,7 @@ static int azx_alloc_cmd_io(struct azx *chip)
 }
 EXPORT_SYMBOL_GPL(azx_alloc_cmd_io);
 
-void azx_init_cmd_io(struct azx *chip)
+static void azx_init_cmd_io(struct azx *chip)
 {
 	int timeout;
 
@@ -1102,7 +1102,7 @@ void azx_init_cmd_io(struct azx *chip)
 }
 EXPORT_SYMBOL_GPL(azx_init_cmd_io);
 
-void azx_free_cmd_io(struct azx *chip)
+static void azx_free_cmd_io(struct azx *chip)
 {
 	spin_lock_irq(&chip->reg_lock);
 	/* disable ringbuffer DMAs */
@@ -1574,5 +1574,178 @@ void azx_free_stream_pages(struct azx *chip)
 }
 EXPORT_SYMBOL_GPL(azx_free_stream_pages);
 
+/*
+ * Lowlevel interface
+ */
+
+/* enter link reset */
+void azx_enter_link_reset(struct azx *chip)
+{
+	unsigned long timeout;
+
+	/* reset controller */
+	azx_writel(chip, GCTL, azx_readl(chip, GCTL) & ~ICH6_GCTL_RESET);
+
+	timeout = jiffies + msecs_to_jiffies(100);
+	while ((azx_readb(chip, GCTL) & ICH6_GCTL_RESET) &&
+			time_before(jiffies, timeout))
+		usleep_range(500, 1000);
+}
+EXPORT_SYMBOL_GPL(azx_enter_link_reset);
+
+/* exit link reset */
+static void azx_exit_link_reset(struct azx *chip)
+{
+	unsigned long timeout;
+
+	azx_writeb(chip, GCTL, azx_readb(chip, GCTL) | ICH6_GCTL_RESET);
+
+	timeout = jiffies + msecs_to_jiffies(100);
+	while (!azx_readb(chip, GCTL) &&
+			time_before(jiffies, timeout))
+		usleep_range(500, 1000);
+}
+
+/* reset codec link */
+static int azx_reset(struct azx *chip, int full_reset)
+{
+	if (!full_reset)
+		goto __skip;
+
+	/* clear STATESTS */
+	azx_writew(chip, STATESTS, STATESTS_INT_MASK);
+
+	/* reset controller */
+	azx_enter_link_reset(chip);
+
+	/* delay for >= 100us for codec PLL to settle per spec
+	 * Rev 0.9 section 5.5.1
+	 */
+	usleep_range(500, 1000);
+
+	/* Bring controller out of reset */
+	azx_exit_link_reset(chip);
+
+	/* Brent Chartrand said to wait >= 540us for codecs to initialize */
+	usleep_range(1000, 1200);
+
+      __skip:
+	/* check to see if controller is ready */
+	if (!azx_readb(chip, GCTL)) {
+		dev_dbg(chip->card->dev, "azx_reset: controller not ready!\n");
+		return -EBUSY;
+	}
+
+	/* Accept unsolicited responses */
+	if (!chip->single_cmd)
+		azx_writel(chip, GCTL, azx_readl(chip, GCTL) |
+			   ICH6_GCTL_UNSOL);
+
+	/* detect codecs */
+	if (!chip->codec_mask) {
+		chip->codec_mask = azx_readw(chip, STATESTS);
+		dev_dbg(chip->card->dev, "codec_mask = 0x%x\n",
+			chip->codec_mask);
+	}
+
+	return 0;
+}
+
+/* enable interrupts */
+static void azx_int_enable(struct azx *chip)
+{
+	/* enable controller CIE and GIE */
+	azx_writel(chip, INTCTL, azx_readl(chip, INTCTL) |
+		   ICH6_INT_CTRL_EN | ICH6_INT_GLOBAL_EN);
+}
+
+/* disable interrupts */
+static void azx_int_disable(struct azx *chip)
+{
+	int i;
+
+	/* disable interrupts in stream descriptor */
+	for (i = 0; i < chip->num_streams; i++) {
+		struct azx_dev *azx_dev = &chip->azx_dev[i];
+		azx_sd_writeb(chip, azx_dev, SD_CTL,
+			      azx_sd_readb(chip, azx_dev, SD_CTL) &
+					~SD_INT_MASK);
+	}
+
+	/* disable SIE for all streams */
+	azx_writeb(chip, INTCTL, 0);
+
+	/* disable controller CIE and GIE */
+	azx_writel(chip, INTCTL, azx_readl(chip, INTCTL) &
+		   ~(ICH6_INT_CTRL_EN | ICH6_INT_GLOBAL_EN));
+}
+
+/* clear interrupts */
+static void azx_int_clear(struct azx *chip)
+{
+	int i;
+
+	/* clear stream status */
+	for (i = 0; i < chip->num_streams; i++) {
+		struct azx_dev *azx_dev = &chip->azx_dev[i];
+		azx_sd_writeb(chip, azx_dev, SD_STS, SD_INT_MASK);
+	}
+
+	/* clear STATESTS */
+	azx_writew(chip, STATESTS, STATESTS_INT_MASK);
+
+	/* clear rirb status */
+	azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
+
+	/* clear int status */
+	azx_writel(chip, INTSTS, ICH6_INT_CTRL_EN | ICH6_INT_ALL_STREAM);
+}
+
+/*
+ * reset and start the controller registers
+ */
+void azx_init_chip(struct azx *chip, int full_reset)
+{
+	if (chip->initialized)
+		return;
+
+	/* reset controller */
+	azx_reset(chip, full_reset);
+
+	/* initialize interrupts */
+	azx_int_clear(chip);
+	azx_int_enable(chip);
+
+	/* initialize the codec command I/O */
+	if (!chip->single_cmd)
+		azx_init_cmd_io(chip);
+
+	/* program the position buffer */
+	azx_writel(chip, DPLBASE, (u32)chip->posbuf.addr);
+	azx_writel(chip, DPUBASE, upper_32_bits(chip->posbuf.addr));
+
+	chip->initialized = 1;
+}
+EXPORT_SYMBOL_GPL(azx_init_chip);
+
+void azx_stop_chip(struct azx *chip)
+{
+	if (!chip->initialized)
+		return;
+
+	/* disable interrupts */
+	azx_int_disable(chip);
+	azx_int_clear(chip);
+
+	/* disable CORB/RIRB */
+	azx_free_cmd_io(chip);
+
+	/* disable position buffer */
+	azx_writel(chip, DPLBASE, 0);
+	azx_writel(chip, DPUBASE, 0);
+
+	chip->initialized = 0;
+}
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Common HDA driver funcitons");
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 3a3d78e..67d9f28 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -50,11 +50,14 @@ void azx_free_stream_pages(struct azx *chip);
 /*
  * CORB / RIRB interface
  */
-void azx_init_cmd_io(struct azx *chip);
-void azx_free_cmd_io(struct azx *chip);
 void azx_update_rirb(struct azx *chip);
 int azx_send_cmd(struct hda_bus *bus, unsigned int val);
 unsigned int azx_get_response(struct hda_bus *bus,
 			      unsigned int addr);
 
+/* Low level azx interface */
+void azx_init_chip(struct azx *chip, int full_reset);
+void azx_stop_chip(struct azx *chip);
+void azx_enter_link_reset(struct azx *chip);
+
 #endif /* __SOUND_HDA_CONTROLLER_H */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 3d6ccb8..4f693ef 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -340,159 +340,6 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect);
 static void azx_power_notify(struct hda_bus *bus, bool power_up);
 #endif
 
-/* enter link reset */
-static void azx_enter_link_reset(struct azx *chip)
-{
-	unsigned long timeout;
-
-	/* reset controller */
-	azx_writel(chip, GCTL, azx_readl(chip, GCTL) & ~ICH6_GCTL_RESET);
-
-	timeout = jiffies + msecs_to_jiffies(100);
-	while ((azx_readb(chip, GCTL) & ICH6_GCTL_RESET) &&
-			time_before(jiffies, timeout))
-		usleep_range(500, 1000);
-}
-
-/* exit link reset */
-static void azx_exit_link_reset(struct azx *chip)
-{
-	unsigned long timeout;
-
-	azx_writeb(chip, GCTL, azx_readb(chip, GCTL) | ICH6_GCTL_RESET);
-
-	timeout = jiffies + msecs_to_jiffies(100);
-	while (!azx_readb(chip, GCTL) &&
-			time_before(jiffies, timeout))
-		usleep_range(500, 1000);
-}
-
-/* reset codec link */
-static int azx_reset(struct azx *chip, int full_reset)
-{
-	if (!full_reset)
-		goto __skip;
-
-	/* clear STATESTS */
-	azx_writew(chip, STATESTS, STATESTS_INT_MASK);
-
-	/* reset controller */
-	azx_enter_link_reset(chip);
-
-	/* delay for >= 100us for codec PLL to settle per spec
-	 * Rev 0.9 section 5.5.1
-	 */
-	usleep_range(500, 1000);
-
-	/* Bring controller out of reset */
-	azx_exit_link_reset(chip);
-
-	/* Brent Chartrand said to wait >= 540us for codecs to initialize */
-	usleep_range(1000, 1200);
-
-      __skip:
-	/* check to see if controller is ready */
-	if (!azx_readb(chip, GCTL)) {
-		dev_dbg(chip->card->dev, "azx_reset: controller not ready!\n");
-		return -EBUSY;
-	}
-
-	/* Accept unsolicited responses */
-	if (!chip->single_cmd)
-		azx_writel(chip, GCTL, azx_readl(chip, GCTL) |
-			   ICH6_GCTL_UNSOL);
-
-	/* detect codecs */
-	if (!chip->codec_mask) {
-		chip->codec_mask = azx_readw(chip, STATESTS);
-		dev_dbg(chip->card->dev, "codec_mask = 0x%x\n",
-			chip->codec_mask);
-	}
-
-	return 0;
-}
-
-
-/*
- * Lowlevel interface
- */  
-
-/* enable interrupts */
-static void azx_int_enable(struct azx *chip)
-{
-	/* enable controller CIE and GIE */
-	azx_writel(chip, INTCTL, azx_readl(chip, INTCTL) |
-		   ICH6_INT_CTRL_EN | ICH6_INT_GLOBAL_EN);
-}
-
-/* disable interrupts */
-static void azx_int_disable(struct azx *chip)
-{
-	int i;
-
-	/* disable interrupts in stream descriptor */
-	for (i = 0; i < chip->num_streams; i++) {
-		struct azx_dev *azx_dev = &chip->azx_dev[i];
-		azx_sd_writeb(chip, azx_dev, SD_CTL,
-			      azx_sd_readb(chip, azx_dev, SD_CTL) &
-					~SD_INT_MASK);
-	}
-
-	/* disable SIE for all streams */
-	azx_writeb(chip, INTCTL, 0);
-
-	/* disable controller CIE and GIE */
-	azx_writel(chip, INTCTL, azx_readl(chip, INTCTL) &
-		   ~(ICH6_INT_CTRL_EN | ICH6_INT_GLOBAL_EN));
-}
-
-/* clear interrupts */
-static void azx_int_clear(struct azx *chip)
-{
-	int i;
-
-	/* clear stream status */
-	for (i = 0; i < chip->num_streams; i++) {
-		struct azx_dev *azx_dev = &chip->azx_dev[i];
-		azx_sd_writeb(chip, azx_dev, SD_STS, SD_INT_MASK);
-	}
-
-	/* clear STATESTS */
-	azx_writew(chip, STATESTS, STATESTS_INT_MASK);
-
-	/* clear rirb status */
-	azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
-
-	/* clear int status */
-	azx_writel(chip, INTSTS, ICH6_INT_CTRL_EN | ICH6_INT_ALL_STREAM);
-}
-
-/*
- * reset and start the controller registers
- */
-static void azx_init_chip(struct azx *chip, int full_reset)
-{
-	if (chip->initialized)
-		return;
-
-	/* reset controller */
-	azx_reset(chip, full_reset);
-
-	/* initialize interrupts */
-	azx_int_clear(chip);
-	azx_int_enable(chip);
-
-	/* initialize the codec command I/O */
-	if (!chip->single_cmd)
-		azx_init_cmd_io(chip);
-
-	/* program the position buffer */
-	azx_writel(chip, DPLBASE, (u32)chip->posbuf.addr);
-	azx_writel(chip, DPUBASE, upper_32_bits(chip->posbuf.addr));
-
-	chip->initialized = 1;
-}
-
 /*
  * initialize the PCI registers
  */
@@ -660,8 +507,6 @@ static int probe_codec(struct azx *chip, int addr)
 	return 0;
 }
 
-static void azx_stop_chip(struct azx *chip);
-
 static void azx_bus_reset(struct hda_bus *bus)
 {
 	struct azx *chip = bus->private_data;
@@ -942,26 +787,6 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect)
 	return 0;
 }
 
-
-static void azx_stop_chip(struct azx *chip)
-{
-	if (!chip->initialized)
-		return;
-
-	/* disable interrupts */
-	azx_int_disable(chip);
-	azx_int_clear(chip);
-
-	/* disable CORB/RIRB */
-	azx_free_cmd_io(chip);
-
-	/* disable position buffer */
-	azx_writel(chip, DPLBASE, 0);
-	azx_writel(chip, DPUBASE, 0);
-
-	chip->initialized = 0;
-}
-
 #ifdef CONFIG_PM
 /* power-up/down the controller */
 static void azx_power_notify(struct hda_bus *bus, bool power_up)
-- 
1.8.1.3.605.g02339dd
