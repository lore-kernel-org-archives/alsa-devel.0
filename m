From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 1/6] ALSA: hda/tegra: runtime power
	management support
Date: Tue, 22 Jan 2019 13:03:16 +0530
Message-ID: <1548142401-22841-2-git-send-email-spujar@nvidia.com>
References: <1548142401-22841-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id A19862667E7
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 08:33:39 +0100 (CET)
In-Reply-To: <1548142401-22841-1-git-send-email-spujar@nvidia.com>
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

This patch enables runtime power management(runtime PM) support for
hda. pm_runtime_enable() and pm_runtime_disable() are added during
device probe and remove respectively. The runtime PM callbacks will
be forbidden if hda controller does not have support for runtime PM.
pm_runtime_get_sync() and pm_runtime_put() are added for hda register
access. The callbacks for above will be added in subsequent patches.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 97a176d..2f9dd23 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/string.h>
+#include <linux/pm_runtime.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -512,6 +513,11 @@ static int hda_tegra_probe(struct platform_device *pdev)
 	card->private_data = chip;
 
 	dev_set_drvdata(&pdev->dev, card);
+
+	pm_runtime_enable(hda->dev);
+	if (!azx_has_pm_runtime(chip))
+		pm_runtime_forbid(hda->dev);
+
 	schedule_work(&hda->probe_work);
 
 	return 0;
@@ -528,6 +534,7 @@ static void hda_tegra_probe_work(struct work_struct *work)
 	struct platform_device *pdev = to_platform_device(hda->dev);
 	int err;
 
+	pm_runtime_get_sync(hda->dev);
 	err = hda_tegra_first_init(chip, pdev);
 	if (err < 0)
 		goto out_free;
@@ -549,12 +556,18 @@ static void hda_tegra_probe_work(struct work_struct *work)
 	snd_hda_set_power_save(&chip->bus, power_save * 1000);
 
  out_free:
+	pm_runtime_put(hda->dev);
 	return; /* no error return from async probe */
 }
 
 static int hda_tegra_remove(struct platform_device *pdev)
 {
-	return snd_card_free(dev_get_drvdata(&pdev->dev));
+	int ret;
+
+	ret = snd_card_free(dev_get_drvdata(&pdev->dev));
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
 }
 
 static void hda_tegra_shutdown(struct platform_device *pdev)
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
