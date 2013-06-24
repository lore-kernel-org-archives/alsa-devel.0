From: mengdong.lin@intel.com
Subject: [RFC PATCH] ALSA: hda - reset hda link during
	system/runtime suspend
Date: Mon, 24 Jun 2013 10:18:54 -0400
Message-ID: <1372083534-9706-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 918DD261A67
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 09:10:17 +0200 (CEST)
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

If all the codecs report ClkStopOK (OK to stop bus clock) after being put to
D3, this patch will reset the HDA link before the controller is put to D3.

So the link will be in reset during system or runtime suspend, the bus clock
stops and the codecs are in D3(ClkStop) state.

This may help to reduce power consumption by dozens of mW on some peripheral
hda codecs.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index f089fa0..9f110c7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1120,6 +1120,20 @@ static void azx_load_dsp_cleanup(struct hda_bus *bus,
 				 struct snd_dma_buffer *dmab);
 #endif
 
+/* enter link reset */
+static void azx_reset_link(struct azx *chip)
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
+
 /* reset codec link */
 static int azx_reset(struct azx *chip, int full_reset)
 {
@@ -2894,6 +2908,7 @@ static int azx_suspend(struct device *dev)
 	if (chip->initialized)
 		snd_hda_suspend(chip->bus);
 	azx_stop_chip(chip);
+	azx_reset_link(chip);
 	if (chip->irq >= 0) {
 		free_irq(chip->irq, chip);
 		chip->irq = -1;
@@ -2946,6 +2961,7 @@ static int azx_runtime_suspend(struct device *dev)
 	struct azx *chip = card->private_data;
 
 	azx_stop_chip(chip);
+	azx_reset_link(chip);
 	azx_clear_irq_pending(chip);
 	return 0;
 }
-- 
1.7.10.4
