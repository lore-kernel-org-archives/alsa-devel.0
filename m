From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH v3 1/2] extcon: arizona: Add support for select
 accessory detect mode when headphone detection
Date: Wed, 22 Apr 2015 20:23:20 +0900
Message-ID: <1429701801-25287-2-git-send-email-ideal.song@samsung.com>
References: <1429701801-25287-1-git-send-email-ideal.song@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1429701801-25287-1-git-send-email-ideal.song@samsung.com>
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
 drivers/extcon/extcon-arizona.c   | 38 ++++++++++++++++++++++++++++++--------
 include/dt-bindings/mfd/arizona.h |  8 ++++++++
 include/linux/mfd/arizona/pdata.h |  3 +++
 3 files changed, 41 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/mfd/arizona.h

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 63f01c4..d9284af 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -32,13 +32,10 @@
 #include <linux/mfd/arizona/core.h>
 #include <linux/mfd/arizona/pdata.h>
 #include <linux/mfd/arizona/registers.h>
+#include <dt-bindings/mfd/arizona.h>
 
 #define ARIZONA_MAX_MICD_RANGE 8
 
-#define ARIZONA_ACCDET_MODE_MIC 0
-#define ARIZONA_ACCDET_MODE_HPL 1
-#define ARIZONA_ACCDET_MODE_HPR 2
-
 #define ARIZONA_MICD_CLAMP_MODE_JDL      0x4
 #define ARIZONA_MICD_CLAMP_MODE_JDH      0x5
 #define ARIZONA_MICD_CLAMP_MODE_JDL_GP5H 0x9
@@ -653,9 +650,9 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
 	ret = regmap_update_bits(arizona->regmap,
 				 ARIZONA_ACCESSORY_DETECT_MODE_1,
 				 ARIZONA_ACCDET_MODE_MASK,
-				 ARIZONA_ACCDET_MODE_HPL);
+				 arizona->pdata.hpdet_channel);
 	if (ret != 0) {
-		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
+		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
 		goto err;
 	}
 
@@ -705,9 +702,9 @@ static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info)
 				 ARIZONA_ACCESSORY_DETECT_MODE_1,
 				 ARIZONA_ACCDET_SRC | ARIZONA_ACCDET_MODE_MASK,
 				 info->micd_modes[0].src |
-				 ARIZONA_ACCDET_MODE_HPL);
+				 arizona->pdata.hpdet_channel);
 	if (ret != 0) {
-		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
+		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
 		goto err;
 	}
 
@@ -1103,6 +1100,26 @@ static void arizona_micd_set_level(struct arizona *arizona, int index,
 	regmap_update_bits(arizona->regmap, reg, mask, level);
 }
 
+static int arizona_extcon_of_get_pdata(struct arizona *arizona)
+{
+	struct arizona_pdata *pdata = &arizona->pdata;
+	unsigned int val;
+
+	of_property_read_u32(arizona->dev->of_node, "wlf,hpdet-channel", &val);
+	switch (val) {
+	case ARIZONA_ACCDET_MODE_HPL:
+	case ARIZONA_ACCDET_MODE_HPR:
+		pdata->hpdet_channel = val;
+		break;
+	default:
+		dev_err(arizona->dev,
+			"Wrong wlf,hpdet-channel DT value %d\n", val);
+		pdata->hpdet_channel = ARIZONA_ACCDET_MODE_HPL;
+	}
+
+	return 0;
+}
+
 static int arizona_extcon_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
@@ -1120,6 +1137,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (!dev_get_platdata(arizona->dev))
+			arizona_extcon_of_get_pdata(arizona);
+	}
+
 	info->micvdd = devm_regulator_get(&pdev->dev, "MICVDD");
 	if (IS_ERR(info->micvdd)) {
 		ret = PTR_ERR(info->micvdd);
diff --git a/include/dt-bindings/mfd/arizona.h b/include/dt-bindings/mfd/arizona.h
new file mode 100644
index 0000000..9ecff78
--- /dev/null
+++ b/include/dt-bindings/mfd/arizona.h
@@ -0,0 +1,8 @@
+#ifndef __DT_BINDINGS_ARIZONA_H__
+#define __DT_BINDINGS_ARIZONA_H__
+
+#define ARIZONA_ACCDET_MODE_MIC 0
+#define ARIZONA_ACCDET_MODE_HPL 1
+#define ARIZONA_ACCDET_MODE_HPR 2
+
+#endif /* __DT_BINDINGS_ARIZONA_H__ */
diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index 4578c72..2473a67 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -139,6 +139,9 @@ struct arizona_pdata {
 	/** GPIO used for mic isolation with HPDET */
 	int hpdet_id_gpio;
 
+	/** Channel to use for headphone detection */
+	unsigned int hpdet_channel;
+
 	/** Extra debounce timeout used during initial mic detection (ms) */
 	int micd_detect_debounce;
 
-- 
2.0.0.390.gcb682f8
