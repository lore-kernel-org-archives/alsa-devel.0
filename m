From: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [alsa-devel] [PATCH v5 1/2] extcon: arizona: Add support for select
 accessory detect mode when headphone detection
Date: Mon, 04 May 2015 13:42:13 +0900
Message-ID: <1430714534-28772-2-git-send-email-ideal.song@samsung.com>
References: <1430714534-28772-1-git-send-email-ideal.song@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1430714534-28772-1-git-send-email-ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch add support for select accessory detect mode to HPDETL or HPDETR.
Arizona provides a headphone detection circuit on the HPDETL and HPDETR pins
to measure the impedance of an external load connected to the headphone.

Depending on board design, headphone detect pins can change to HPDETR or HPDETL.

Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/extcon/extcon-arizona.c   | 38 ++++++++++++++++++++++++++++++--------
 include/dt-bindings/mfd/arizona.h |  4 ++++
 include/linux/mfd/arizona/pdata.h |  3 +++
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 5e08c35..1ec06b4 100644
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
@@ -671,9 +668,9 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
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
 
@@ -723,9 +720,9 @@ static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info)
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
 
@@ -1121,6 +1118,26 @@ static void arizona_micd_set_level(struct arizona *arizona, int index,
 	regmap_update_bits(arizona->regmap, reg, mask, level);
 }
 
+static int arizona_extcon_of_get_pdata(struct arizona *arizona)
+{
+	struct arizona_pdata *pdata = &arizona->pdata;
+	unsigned int val = ARIZONA_ACCDET_MODE_HPL;
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
@@ -1138,6 +1155,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
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
index c7af7c7..fee48e6 100644
--- a/include/dt-bindings/mfd/arizona.h
+++ b/include/dt-bindings/mfd/arizona.h
@@ -90,4 +90,8 @@
 #define ARIZONA_INMODE_SE   1
 #define ARIZONA_INMODE_DMIC 2
 
+#define ARIZONA_ACCDET_MODE_MIC 0
+#define ARIZONA_ACCDET_MODE_HPL 1
+#define ARIZONA_ACCDET_MODE_HPR 2
+
 #endif
diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index 1789cb0..aa5c48b 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -121,6 +121,9 @@ struct arizona_pdata {
 	/** GPIO used for mic isolation with HPDET */
 	int hpdet_id_gpio;
 
+	/** Channel to use for headphone detection */
+	unsigned int hpdet_channel;
+
 	/** Extra debounce timeout used during initial mic detection (ms) */
 	int micd_detect_debounce;
 
-- 
2.0.0.390.gcb682f8

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
