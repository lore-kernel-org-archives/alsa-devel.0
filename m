From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 09/19] ASoC: Intel: bytcr_rt5640: Use
	device-property for differential mics
Date: Tue,  8 May 2018 17:35:54 +0200
Message-ID: <20180508153604.23711-10-hdegoede@redhat.com>
References: <20180508153604.23711-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id E17C3267706
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 17:36:21 +0200 (CEST)
In-Reply-To: <20180508153604.23711-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Set the "realtek,in1-differential" or "realtek,in3-differential"
device-property when the BYT_RT5640_DIFF_MIC quirk is set instead of
directly poking the codec registers.

This also fixes the BYT_RT5640_DIFF_MIC quirk not working when
combined with BYT_RT5640_IN3_MAP.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 48 ++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 0f587d394b06..81d0d07449a8 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -17,6 +17,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
+#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -54,6 +55,9 @@ enum {
 #define BYT_RT5640_MCLK_EN	BIT(22)
 #define BYT_RT5640_MCLK_25MHZ	BIT(23)
 
+/* in-diff + terminating empty entry */
+#define MAX_NO_PROPS 2
+
 struct byt_rt5640_private {
 	struct clk *mclk;
 };
@@ -438,6 +442,39 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 	{}
 };
 
+/*
+ * Note this MUST be called before snd_soc_register_card(), so that the props
+ * are in place before the codec component driver's probe function parses them.
+ */
+static int byt_rt5640_add_codec_device_props(const char *i2c_dev_name)
+{
+	struct property_entry props[MAX_NO_PROPS] = {};
+	struct device *i2c_dev;
+	int ret, cnt = 0;
+
+	i2c_dev = bus_find_device_by_name(&i2c_bus_type, NULL, i2c_dev_name);
+	if (!i2c_dev)
+		return -EPROBE_DEFER;
+
+	switch (BYT_RT5640_MAP(byt_rt5640_quirk)) {
+	case BYT_RT5640_IN1_MAP:
+		if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
+			props[cnt++] =
+				PROPERTY_ENTRY_BOOL("realtek,in1-differential");
+		break;
+	case BYT_RT5640_IN3_MAP:
+		if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
+			props[cnt++] =
+				PROPERTY_ENTRY_BOOL("realtek,in3-differential");
+		break;
+	}
+
+	ret = device_add_properties(i2c_dev, props);
+	put_device(i2c_dev);
+
+	return ret;
+}
+
 static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
@@ -519,11 +556,6 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
-	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC) {
-		snd_soc_component_update_bits(component,  RT5640_IN1_IN2, RT5640_IN_DF1,
-				    RT5640_IN_DF1);
-	}
-
 	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
 		ret = rt5640_dmic_enable(component, 0, 0);
 		if (ret)
@@ -837,6 +869,12 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			 (unsigned int)byt_rt5640_quirk, quirk_override);
 		byt_rt5640_quirk = quirk_override;
 	}
+
+	/* Must be called before register_card, also see declaration comment. */
+	ret_val = byt_rt5640_add_codec_device_props(byt_rt5640_codec_name);
+	if (ret_val)
+		return ret_val;
+
 	log_quirks(&pdev->dev);
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
-- 
2.17.0
