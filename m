From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 6/7] ASoC: rt5651: Configure jack-detect source
	through a device-property
Date: Thu, 22 Feb 2018 18:07:37 +0100
Message-ID: <20180222170738.8508-7-hdegoede@redhat.com>
References: <20180222170738.8508-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AB6E2677B5
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 18:07:49 +0100 (CET)
In-Reply-To: <20180222170738.8508-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Configure the jack-detect source through a device-property which can be
set by code outside of the codec driver. Rather then putting platform
specific DMI quirks inside the generic codec driver.

And move the jack-detect-source quirk for the KIANO SlimNote 14.2, which
was present inside the codec driver to the machine driver, where we can
bundle it together with the other quirks already present for this laptop.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/sound/rt5651.txt |  6 ++++
 include/sound/rt5651.h                             |  4 +++
 sound/soc/codecs/rt5651.c                          | 31 ++++----------------
 sound/soc/intel/boards/bytcr_rt5651.c              | 34 ++++++++++++++++++----
 4 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5651.txt b/Documentation/devicetree/bindings/sound/rt5651.txt
index 3875233095f5..1632c0cf6123 100644
--- a/Documentation/devicetree/bindings/sound/rt5651.txt
+++ b/Documentation/devicetree/bindings/sound/rt5651.txt
@@ -16,6 +16,12 @@ Optional properties:
 - realtek,dmic-en
   Boolean. true if dmic is used.
 
+- realtek,jack-detect-source
+  u32. Valid values:
+  1: Use JD1_1 pin for jack-dectect
+  2: Use JD1_2 pin for jack-dectect
+  3: Use JD2 pin for jack-dectect
+
 Pins on the device (for linking into audio routes) for RT5651:
 
   * DMIC L1
diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
index 1612462bf5ad..0eadb1e90a84 100644
--- a/include/sound/rt5651.h
+++ b/include/sound/rt5651.h
@@ -11,6 +11,10 @@
 #ifndef __LINUX_SND_RT5651_H
 #define __LINUX_SND_RT5651_H
 
+/*
+ * Note the MUST match the values from the DT binding:
+ * Documentation/devicetree/bindings/sound/rt5651.txt
+ */
 enum rt5651_jd_src {
 	RT5651_JD_NULL,
 	RT5651_JD1_1,
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 476e424b32ef..a555ae7cccb0 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -19,7 +19,6 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
-#include <linux/dmi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -32,8 +31,6 @@
 #include "rl6231.h"
 #include "rt5651.h"
 
-#define RT5651_JD_MAP(quirk)	((quirk) & GENMASK(7, 0))
-
 #define RT5651_DEVICE_ID_VALUE 0x6281
 
 #define RT5651_PR_RANGE_BASE (0xff + 1)
@@ -41,8 +38,6 @@
 
 #define RT5651_PR_BASE (RT5651_PR_RANGE_BASE + (0 * RT5651_PR_SPACING))
 
-static unsigned long rt5651_quirk;
-
 static const struct regmap_range_cfg rt5651_ranges[] = {
 	{ .name = "PR", .range_min = RT5651_PR_BASE,
 	  .range_max = RT5651_PR_BASE + 0xb4,
@@ -1599,6 +1594,11 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
 	int ret;
+	u32 val;
+
+	if (device_property_read_u32(component->dev,
+				     "realtek,jack-detect-source", &val) == 0)
+		rt5651->jd_src = val;
 
 	if (!rt5651->irq)
 		return -EINVAL;
@@ -1824,24 +1824,6 @@ static const struct i2c_device_id rt5651_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5651_i2c_id);
 
-static int rt5651_quirk_cb(const struct dmi_system_id *id)
-{
-	rt5651_quirk = (unsigned long) id->driver_data;
-	return 1;
-}
-
-static const struct dmi_system_id rt5651_quirk_table[] = {
-	{
-		.callback = rt5651_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
-		},
-		.driver_data = (unsigned long *) RT5651_JD1_1,
-	},
-	{}
-};
-
 static int rt5651_jack_detect(struct snd_soc_component *component, int jack_insert)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
@@ -1920,9 +1902,6 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5651);
 
-	dmi_check_system(rt5651_quirk_table);
-	rt5651->jd_src = RT5651_JD_MAP(rt5651_quirk);
-
 	rt5651->regmap = devm_regmap_init_i2c(i2c, &rt5651_regmap);
 	if (IS_ERR(rt5651->regmap)) {
 		ret = PTR_ERR(rt5651->regmap);
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 8008a027cc93..ccefe356d528 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -42,10 +43,21 @@ enum {
 	BYT_RT5651_IN3_MAP,
 };
 
-#define BYT_RT5651_MAP(quirk)	((quirk) & GENMASK(7, 0))
-#define BYT_RT5651_DMIC_EN	BIT(16)
-#define BYT_RT5651_MCLK_EN	BIT(17)
-#define BYT_RT5651_MCLK_25MHZ	BIT(18)
+enum {
+	BYT_RT5651_JD_NULL	= (RT5651_JD_NULL << 4),
+	BYT_RT5651_JD1_1	= (RT5651_JD1_1 << 4),
+	BYT_RT5651_JD1_2	= (RT5651_JD1_2 << 4),
+	BYT_RT5651_JD2		= (RT5651_JD2 << 4),
+};
+
+#define BYT_RT5651_MAP(quirk)		((quirk) & GENMASK(3, 0))
+#define BYT_RT5651_JDSRC(quirk)		(((quirk) & GENMASK(7, 4)) >> 4)
+#define BYT_RT5651_DMIC_EN		BIT(16)
+#define BYT_RT5651_MCLK_EN		BIT(17)
+#define BYT_RT5651_MCLK_25MHZ		BIT(18)
+
+/* jack-detect-source + terminating empty entry */
+#define MAX_NO_PROPS 2
 
 struct byt_rt5651_private {
 	struct clk *mclk;
@@ -66,6 +78,9 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN2_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN3_MAP)
 		dev_info(dev, "quirk IN3_MAP enabled");
+	if (BYT_RT5651_JDSRC(byt_rt5651_quirk))
+		dev_info(dev, "quirk jack-detect src %ld\n",
+			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		dev_info(dev, "quirk DMIC enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
@@ -288,6 +303,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
 		},
 		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
+					BYT_RT5651_JD1_1 |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
@@ -298,8 +314,9 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_card *card = runtime->card;
 	struct snd_soc_component *codec = runtime->codec_dai->component;
 	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
+	struct property_entry props[MAX_NO_PROPS] = {};
 	const struct snd_soc_dapm_route *custom_map;
-	int num_routes;
+	int num_routes, no_props = 0;
 	int ret;
 
 	card->dapm.idle_bias_off = true;
@@ -360,6 +377,13 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 			dev_err(card->dev, "unable to set MCLK rate\n");
 	}
 
+	props[no_props++] = PROPERTY_ENTRY_U32("realtek,jack-detect-source",
+					  BYT_RT5651_JDSRC(byt_rt5651_quirk));
+
+	ret = device_add_properties(codec->dev, props);
+	if (ret)
+		return ret;
+
 	ret = snd_soc_card_jack_new(runtime->card, "Headset",
 				    SND_JACK_HEADSET, &priv->jack,
 				    bytcr_jack_pins, ARRAY_SIZE(bytcr_jack_pins));
-- 
2.14.3
