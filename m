From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: fixup DAI
	codec_name with HID" to the asoc tree
Date: Tue, 05 Jan 2016 17:49:13 +0000
Message-ID: <E1aGVjN-000362-Ik@debutante>
References: <1450406156-22246-18-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E0FD260410
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 18:49:24 +0100 (CET)
In-Reply-To: <1450406156-22246-18-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: fixup DAI codec_name with HID

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From caf94ed8629afb82d61a82ce76fb314145933a40 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 4 Jan 2016 17:20:28 -0600
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: fixup DAI codec_name with HID

Codec name is hard-coded in machine driver, pass information
from actual ACPI HID to help support BIOS variations

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c   | 17 ++++++++++++-----
 sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index b6ea0a58f9d3..f61e53106339 100644
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
index 0f2385f6f6ac..74bb7cc1f54a 100644
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
2.7.0.rc3
