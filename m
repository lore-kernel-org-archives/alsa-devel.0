From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 6/7] ALSA: hda/tegra: fix kernel panic
Date: Mon, 21 Jan 2019 23:11:36 +0530
Message-ID: <1548092497-5459-7-git-send-email-spujar@nvidia.com>
References: <1548092497-5459-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CEEA12667E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 18:42:16 +0100 (CET)
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

Kernel panic is seen during device boot. It appears that before the
probe completes, runtime callbacks happen and the device setup is not
done yet. This could be initiated from framework through exposed
callbacks. This issue can be fixed by having a flag to indicate
completion of device probe. Hence 'probed' flag is introduced to notify
completion of probe and runtime callbacks can check this flag before
doing any device access.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 5546e29..80c4042 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -76,6 +76,7 @@ struct hda_tegra {
 	struct clk *hda2hdmi_clk;
 	void __iomem *regs;
 	struct work_struct probe_work;
+	bool probed;
 };
 
 #ifdef CONFIG_PM
@@ -265,9 +266,11 @@ static int hda_tegra_runtime_suspend(struct device *dev)
 	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
 	struct hdac_bus *bus = azx_bus(chip);
 
-	azx_stop_chip(chip);
-	synchronize_irq(bus->irq);
-	azx_enter_link_reset(chip);
+	if (hda->probed) {
+		azx_stop_chip(chip);
+		synchronize_irq(bus->irq);
+		azx_enter_link_reset(chip);
+	}
 	hda_tegra_disable_clocks(hda);
 
 	return 0;
@@ -283,8 +286,10 @@ static int hda_tegra_runtime_resume(struct device *dev)
 	rc = hda_tegra_enable_clocks(hda);
 	if (rc != 0)
 		return rc;
-	hda_tegra_init(hda);
-	azx_init_chip(chip, 1);
+	if (hda->probed) {
+		hda_tegra_init(hda);
+		azx_init_chip(chip, 1);
+	}
 
 	return 0;
 }
@@ -527,6 +532,7 @@ static int hda_tegra_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	hda->dev = &pdev->dev;
 	chip = &hda->chip;
+	hda->probed = false;
 
 	err = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
 			   THIS_MODULE, 0, &card);
@@ -585,6 +591,7 @@ static void hda_tegra_probe_work(struct work_struct *work)
 		goto out_free;
 
 	chip->running = 1;
+	hda->probed = true;
 	snd_hda_set_power_save(&chip->bus, power_save * 1000);
 
  out_free:
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
