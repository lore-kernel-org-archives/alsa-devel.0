From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 5/7] ALSA: hda/tegra: implement runtime
	suspend/resume
Date: Mon, 21 Jan 2019 23:11:35 +0530
Message-ID: <1548092497-5459-6-git-send-email-spujar@nvidia.com>
References: <1548092497-5459-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 169E7267478
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 18:42:12 +0100 (CET)
In-Reply-To: <1548092497-5459-1-git-send-email-spujar@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

This patch moves clock enable/disable from system resume/suspend to
runtime resume/suspend respectively. Along with this hda controller
chip init or stop is also moved. System resume/suspend can invoke
runtime callbacks and do necessary setup.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index f068b1e..5546e29 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -233,32 +233,24 @@ static void hda_tegra_disable_clocks(struct hda_tegra *data)
 static int hda_tegra_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct azx *chip = card->private_data;
-	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
-	struct hdac_bus *bus = azx_bus(chip);
+	int rc;
 
+	rc = pm_runtime_force_suspend(dev);
+	if (rc < 0)
+		return rc;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
-	azx_stop_chip(chip);
-	synchronize_irq(bus->irq);
-	azx_enter_link_reset(chip);
-	hda_tegra_disable_clocks(hda);
-
 	return 0;
 }
 
 static int hda_tegra_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct azx *chip = card->private_data;
-	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
-
-	hda_tegra_enable_clocks(hda);
-
-	hda_tegra_init(hda);
-
-	azx_init_chip(chip, 1);
+	int rc;
 
+	rc = pm_runtime_force_resume(dev);
+	if (rc < 0)
+		return rc;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 
 	return 0;
@@ -268,11 +260,32 @@ static int hda_tegra_resume(struct device *dev)
 #ifdef CONFIG_PM
 static int hda_tegra_runtime_suspend(struct device *dev)
 {
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
+	struct hdac_bus *bus = azx_bus(chip);
+
+	azx_stop_chip(chip);
+	synchronize_irq(bus->irq);
+	azx_enter_link_reset(chip);
+	hda_tegra_disable_clocks(hda);
+
 	return 0;
 }
 
 static int hda_tegra_runtime_resume(struct device *dev)
 {
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip = card->private_data;
+	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
+	int rc;
+
+	rc = hda_tegra_enable_clocks(hda);
+	if (rc != 0)
+		return rc;
+	hda_tegra_init(hda);
+	azx_init_chip(chip, 1);
+
 	return 0;
 }
 #endif /* CONFIG_PM */
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
