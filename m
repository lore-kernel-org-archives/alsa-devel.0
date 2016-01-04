From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 6/8] ASoC: Intel: bytcr_rt5640: fixup DAI
	codec_name with HID
Date: Mon,  4 Jan 2016 17:20:28 -0600
Message-ID: <1451949630-3475-7-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 79DDA2606C9
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 00:21:09 +0100 (CET)
In-Reply-To: <1451949630-3475-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Codec name is hard-coded in machine driver, pass information
from actual ACPI HID to help support BIOS variations

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c   | 17 ++++++++++++-----
 sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index b6ea0a5..f61e531 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -247,16 +247,23 @@ static int sst_acpi_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "ACPI device id: %x\n", dev_id);
 
-	plat_dev = platform_device_register_data(dev, pdata->platform, -1, NULL, 0);
+	plat_dev = platform_device_register_data(dev, pdata->platform, -1,
+						NULL, 0);
 	if (IS_ERR(plat_dev)) {
-		dev_err(dev, "Failed to create machine device: %s\n", pdata->platform);
+		dev_err(dev, "Failed to create machine device: %s\n",
+			pdata->platform);
 		return PTR_ERR(plat_dev);
 	}
 
-	/* Create platform device for sst machine driver */
-	mdev = platform_device_register_data(dev, mach->drv_name, -1, NULL, 0);
+	/*
+	 * Create platform device for sst machine driver,
+	 * pass machine info as pdata
+	 */
+	mdev = platform_device_register_data(dev, mach->drv_name, -1,
+					(const void *)mach, sizeof(*mach));
 	if (IS_ERR(mdev)) {
-		dev_err(dev, "Failed to create machine device: %s\n", mach->drv_name);
+		dev_err(dev, "Failed to create machine device: %s\n",
+			mach->drv_name);
 		return PTR_ERR(mdev);
 	}
 
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 0f2385f..74bb7cc 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -30,6 +30,7 @@
 #include <sound/jack.h>
 #include "../../codecs/rt5640.h"
 #include "../atom/sst-atom-controls.h"
+#include "../common/sst-acpi.h"
 
 static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
@@ -326,12 +327,21 @@ static struct snd_soc_card byt_rt5640_card = {
 	.fully_routed = true,
 };
 
+static char byt_rt5640_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
+	struct sst_acpi_mach *mach;
 
 	/* register the soc card */
 	byt_rt5640_card.dev = &pdev->dev;
+	mach = byt_rt5640_card.dev->platform_data;
+
+	/* fixup codec name based on HID */
+	snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
+		 "%s%s%s", "i2c-", mach->id, ":00");
+	byt_rt5640_dais[MERR_DPCM_COMPR+1].codec_name = byt_rt5640_codec_name;
 
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
 
-- 
1.9.1
