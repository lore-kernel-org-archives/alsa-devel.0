From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - clean up code to reset hda link
Date: Tue, 25 Jun 2013 05:58:49 -0400
Message-ID: <1372154329-8901-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 090842617B7
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 04:50:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: pshou@realtek.com, kailang@realtek.com, Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch is a cleanup to the previous patch "reset hda link during system/
runtime suspend".

In this patch
- azx_enter_link_reset() and azx_exit_link_reset() are defined for entering and
  exiting the link reset respectively. azx_link_reset() is no longer used and
  replaced by azx_enter_link_reset().
- azx_reset() reuses the above two new functions for a link reset cycle

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9f110c7..f39de90 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1121,7 +1121,7 @@ static void azx_load_dsp_cleanup(struct hda_bus *bus,
 #endif
 
 /* enter link reset */
-static void azx_reset_link(struct azx *chip)
+static void azx_enter_link_reset(struct azx *chip)
 {
 	unsigned long timeout;
 
@@ -1134,11 +1134,22 @@ static void azx_reset_link(struct azx *chip)
 		usleep_range(500, 1000);
 }
 
-/* reset codec link */
-static int azx_reset(struct azx *chip, int full_reset)
+/* exit link reset */
+static void azx_exit_link_reset(struct azx *chip)
 {
 	unsigned long timeout;
 
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
 	if (!full_reset)
 		goto __skip;
 
@@ -1146,12 +1157,7 @@ static int azx_reset(struct azx *chip, int full_reset)
 	azx_writeb(chip, STATESTS, STATESTS_INT_MASK);
 
 	/* reset controller */
-	azx_writel(chip, GCTL, azx_readl(chip, GCTL) & ~ICH6_GCTL_RESET);
-
-	timeout = jiffies + msecs_to_jiffies(100);
-	while (azx_readb(chip, GCTL) &&
-			time_before(jiffies, timeout))
-		usleep_range(500, 1000);
+	azx_enter_link_reset(chip);
 
 	/* delay for >= 100us for codec PLL to settle per spec
 	 * Rev 0.9 section 5.5.1
@@ -1159,12 +1165,7 @@ static int azx_reset(struct azx *chip, int full_reset)
 	usleep_range(500, 1000);
 
 	/* Bring controller out of reset */
-	azx_writeb(chip, GCTL, azx_readb(chip, GCTL) | ICH6_GCTL_RESET);
-
-	timeout = jiffies + msecs_to_jiffies(100);
-	while (!azx_readb(chip, GCTL) &&
-			time_before(jiffies, timeout))
-		usleep_range(500, 1000);
+	azx_exit_link_reset(chip);
 
 	/* Brent Chartrand said to wait >= 540us for codecs to initialize */
 	usleep_range(1000, 1200);
@@ -2908,7 +2909,7 @@ static int azx_suspend(struct device *dev)
 	if (chip->initialized)
 		snd_hda_suspend(chip->bus);
 	azx_stop_chip(chip);
-	azx_reset_link(chip);
+	azx_enter_link_reset(chip);
 	if (chip->irq >= 0) {
 		free_irq(chip->irq, chip);
 		chip->irq = -1;
@@ -2961,7 +2962,7 @@ static int azx_runtime_suspend(struct device *dev)
 	struct azx *chip = card->private_data;
 
 	azx_stop_chip(chip);
-	azx_reset_link(chip);
+	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
 	return 0;
 }
-- 
1.7.10.4
