From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 01/10] ASoC: Intel: bytcr_rt5640: Use device
	properties for setting up dmic
Date: Sun, 13 May 2018 09:24:26 +0200
Message-ID: <20180513072435.3358-2-hdegoede@redhat.com>
References: <20180513072435.3358-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 049C326766C
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 09:24:47 +0200 (CEST)
In-Reply-To: <20180513072435.3358-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Use device-properties for setting up the dmic, based on the
BYT_RT5640_MAP() value, instead of using the codec specific
rt5640_dmic_enable() function for this.  This also removes the need
for the BYT_RT5640_DMIC_EN quirk, which was always set together with
a MAP() quirk of DMIC1_MAP or DMIC2_MAP.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 42 +++++++++------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index fe46f3b2aecc..cc607cfeda56 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -34,6 +34,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 #include <sound/soc-acpi.h>
+#include <dt-bindings/sound/rt5640.h>
 #include "../../codecs/rt5640.h"
 #include "../atom/sst-atom-controls.h"
 #include "../common/sst-dsp.h"
@@ -46,7 +47,6 @@ enum {
 };
 
 #define BYT_RT5640_MAP(quirk)	((quirk) &  GENMASK(7, 0))
-#define BYT_RT5640_DMIC_EN	BIT(16)
 #define BYT_RT5640_MONO_SPEAKER BIT(17)
 #define BYT_RT5640_DIFF_MIC     BIT(18) /* defaut is single-ended */
 #define BYT_RT5640_SSP2_AIF2    BIT(19) /* default is using AIF1  */
@@ -55,7 +55,7 @@ enum {
 #define BYT_RT5640_MCLK_EN	BIT(22)
 #define BYT_RT5640_MCLK_25MHZ	BIT(23)
 
-/* in-diff + terminating empty entry */
+/* in-diff or dmic-pin + terminating empty entry */
 #define MAX_NO_PROPS 2
 
 struct byt_rt5640_private {
@@ -71,7 +71,6 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 static void log_quirks(struct device *dev)
 {
 	int map;
-	bool has_dmic = false;
 	bool has_mclk = false;
 	bool has_ssp0 = false;
 	bool has_ssp0_aif1 = false;
@@ -82,11 +81,9 @@ static void log_quirks(struct device *dev)
 	switch (map) {
 	case BYT_RT5640_DMIC1_MAP:
 		dev_info(dev, "quirk DMIC1_MAP enabled\n");
-		has_dmic = true;
 		break;
 	case BYT_RT5640_DMIC2_MAP:
 		dev_info(dev, "quirk DMIC2_MAP enabled\n");
-		has_dmic = true;
 		break;
 	case BYT_RT5640_IN1_MAP:
 		dev_info(dev, "quirk IN1_MAP enabled\n");
@@ -98,20 +95,10 @@ static void log_quirks(struct device *dev)
 		dev_err(dev, "quirk map 0x%x is not supported, microphone input will not work\n", map);
 		break;
 	}
-	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
-		if (has_dmic)
-			dev_info(dev, "quirk DMIC enabled\n");
-		else
-			dev_err(dev, "quirk DMIC enabled but no DMIC input set, will be ignored\n");
-	}
 	if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER)
 		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
-	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC) {
-		if (!has_dmic)
-			dev_info(dev, "quirk DIFF_MIC enabled\n");
-		else
-			dev_info(dev, "quirk DIFF_MIC enabled but DMIC input selected, will be ignored\n");
-	}
+	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
+		dev_info(dev, "quirk DIFF_MIC enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) {
 		dev_info(dev, "quirk SSP0_AIF1 enabled\n");
 		has_ssp0 = true;
@@ -387,7 +374,6 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
 		},
 		.driver_data = (void *)(BYT_RT5640_DMIC2_MAP |
-					BYT_RT5640_DMIC_EN |
 					BYT_RT5640_MCLK_EN),
 	},
 	{
@@ -405,8 +391,7 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
 		},
-		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
-					BYT_RT5640_DMIC_EN),
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP),
 	},
 	{
 		.callback = byt_rt5640_quirk_cb,
@@ -457,6 +442,14 @@ static int byt_rt5640_add_codec_device_props(const char *i2c_dev_name)
 		return -EPROBE_DEFER;
 
 	switch (BYT_RT5640_MAP(byt_rt5640_quirk)) {
+	case BYT_RT5640_DMIC1_MAP:
+		props[cnt++] = PROPERTY_ENTRY_U32("realtek,dmic1-data-pin",
+						  RT5640_DMIC1_DATA_PIN_IN1P);
+		break;
+	case BYT_RT5640_DMIC2_MAP:
+		props[cnt++] = PROPERTY_ENTRY_U32("realtek,dmic2-data-pin",
+						  RT5640_DMIC2_DATA_PIN_IN1N);
+		break;
 	case BYT_RT5640_IN1_MAP:
 		if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
 			props[cnt++] =
@@ -556,12 +549,6 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
-	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
-		ret = rt5640_dmic_enable(component, 0, 0);
-		if (ret)
-			return ret;
-	}
-
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
 
@@ -862,8 +849,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		byt_rt5640_quirk |= BYT_RT5640_IN1_MAP;
 		byt_rt5640_quirk |= BYT_RT5640_DIFF_MIC;
 	} else {
-		byt_rt5640_quirk |= (BYT_RT5640_DMIC1_MAP |
-				BYT_RT5640_DMIC_EN);
+		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP;
 	}
 
 	/* check quirks before creating card */
-- 
2.17.0
