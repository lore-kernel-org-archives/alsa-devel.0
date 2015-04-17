From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH 1/2] extcon: arizona: Add support for select
 accessory detect mode when headphone detection"
Date: Fri, 17 Apr 2015 17:32:58 +0900
Message-ID: <1429259579-16563-2-git-send-email-ideal.song@samsung.com>
References: <1429259579-16563-1-git-send-email-ideal.song@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1429259579-16563-1-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, cw00.choi@samsung.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, Inha Song <ideal.song@samsung.com>
List-Id: alsa-devel@alsa-project.org

This patch add support for select accessory detect mode to HPDETL or HPDETR.
Arizona provides a headphone detection circuit on the HPDETL and HPDETR pins
to measure the impedance of an external load connected to the headphone.

Depending on board design, headphone detect pins can change to HPDETR or HPDETL.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 drivers/extcon/extcon-arizona.c   | 34 ++++++++++++++++++++++++++++++----
 include/linux/mfd/arizona/pdata.h |  3 +++
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 63f01c4..7bc9159 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -95,6 +95,7 @@ struct arizona_extcon_info {
 	int jack_flips;
 
 	int hpdet_ip;
+	int hpdet_channel;
 
 	struct extcon_dev *edev;
 };
@@ -653,9 +654,9 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
 	ret = regmap_update_bits(arizona->regmap,
 				 ARIZONA_ACCESSORY_DETECT_MODE_1,
 				 ARIZONA_ACCDET_MODE_MASK,
-				 ARIZONA_ACCDET_MODE_HPL);
+				 info->hpdet_channel);
 	if (ret != 0) {
-		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
+		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
 		goto err;
 	}
 
@@ -705,9 +706,9 @@ static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info)
 				 ARIZONA_ACCESSORY_DETECT_MODE_1,
 				 ARIZONA_ACCDET_SRC | ARIZONA_ACCDET_MODE_MASK,
 				 info->micd_modes[0].src |
-				 ARIZONA_ACCDET_MODE_HPL);
+				 info->hpdet_channel);
 	if (ret != 0) {
-		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
+		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
 		goto err;
 	}
 
@@ -1103,6 +1104,23 @@ static void arizona_micd_set_level(struct arizona *arizona, int index,
 	regmap_update_bits(arizona->regmap, reg, mask, level);
 }
 
+#ifdef CONFIG_OF
+static int arizona_of_get_extcon_pdata(struct arizona *arizona)
+{
+	struct arizona_pdata *pdata = &arizona->pdata;
+
+	of_property_read_u32(arizona->dev->of_node, "wlf,hpdet-channel",
+			     &pdata->hpdet_channel);
+
+	return 0;
+}
+#else
+static inline int arizona_of_get_extcon_pdata(struct arizona *arizona)
+{
+	return 0;
+}
+#endif
+
 static int arizona_extcon_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
@@ -1120,6 +1138,9 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
+	if (!dev_get_platdata(arizona->dev))
+		arizona_of_get_extcon_pdata(arizona);
+
 	info->micvdd = devm_regulator_get(&pdev->dev, "MICVDD");
 	if (IS_ERR(info->micvdd)) {
 		ret = PTR_ERR(info->micvdd);
@@ -1338,6 +1359,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 
 	arizona_extcon_set_mode(info, 0);
 
+	if (arizona->pdata.hpdet_channel)
+		info->hpdet_channel = ARIZONA_ACCDET_MODE_HPR;
+	else
+		info->hpdet_channel = ARIZONA_ACCDET_MODE_HPL;
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index 4578c72..feb5903 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -139,6 +139,9 @@ struct arizona_pdata {
 	/** GPIO used for mic isolation with HPDET */
 	int hpdet_id_gpio;
 
+	/** Channel to use for headphone detection */
+	int hpdet_channel;
+
 	/** Extra debounce timeout used during initial mic detection (ms) */
 	int micd_detect_debounce;
 
-- 
2.0.0.390.gcb682f8
