From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 11/22] ASoC: Intel: bytcr_rt5651: Pass
	jack-src info via device-properties
Date: Sun,  4 Mar 2018 15:35:59 +0100
Message-ID: <20180304143610.21125-12-hdegoede@redhat.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 377772673CB
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 15:36:29 +0100 (CET)
In-Reply-To: <20180304143610.21125-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

This commit add support for a new BYT_RT5651_JDSRC quirk, sets this
quirk for the KIANO SlimNote 14.2 laptop and uses the new "realtek,
jack-detect-source" property to pass this info to the codec driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-This has been split-out from the patch introducing the
 "realtek,jack-detect-source" property in the codec driver
-Apply properties before calling snd_soc_register_card, this avoids
 ordering issues and the need for a special rt5651_apply_properties() call
---
 sound/soc/intel/boards/bytcr_rt5651.c | 54 ++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 6d8555e0359e..abc44c9963bf 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -18,8 +18,10 @@
  */
 
 #include <linux/init.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -42,10 +44,21 @@ enum {
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
@@ -66,6 +79,9 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN2_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN3_MAP)
 		dev_info(dev, "quirk IN3_MAP enabled");
+	if (BYT_RT5651_JDSRC(byt_rt5651_quirk))
+		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
+			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
 	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
 		dev_info(dev, "quirk DMIC enabled");
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
@@ -288,11 +304,35 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
 		},
 		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
+					BYT_RT5651_JD1_1 |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
 	{}
 };
 
+/*
+ * Note this MUST be called before snd_soc_register_card(), so that the props
+ * are in place before the codec component driver's probe function parses them.
+ */
+static int byt_rt5651_add_codec_device_props(const char *i2c_dev_name)
+{
+	struct property_entry props[MAX_NO_PROPS] = {};
+	struct device *i2c_dev;
+	int ret, cnt = 0;
+
+	i2c_dev = bus_find_device_by_name(&i2c_bus_type, NULL, i2c_dev_name);
+	if (!i2c_dev)
+		return -EPROBE_DEFER;
+
+	props[cnt++] = PROPERTY_ENTRY_U32("realtek,jack-detect-source",
+				BYT_RT5651_JDSRC(byt_rt5651_quirk));
+
+	ret = device_add_properties(i2c_dev, props);
+	put_device(i2c_dev);
+
+	return ret;
+}
+
 static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
@@ -547,6 +587,12 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5651_quirk_table);
+
+	/* Must be called before register_card, also see declaration comment. */
+	ret_val = byt_rt5651_add_codec_device_props(byt_rt5651_codec_name);
+	if (ret_val)
+		return ret_val;
+
 	log_quirks(&pdev->dev);
 
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
-- 
2.14.3
