From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/9] ASoC: Intel: bytcr_rt5651: Fix IN1 map
	headsetmic mapping
Date: Sun, 24 Jun 2018 16:06:30 +0200
Message-ID: <20180624140634.16835-6-hdegoede@redhat.com>
References: <20180624140634.16835-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id F1536267353
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 16:06:46 +0200 (CEST)
In-Reply-To: <20180624140634.16835-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

The initial bytcr_rt5651 machine driver commit mapped IN2 as the headset
mic. In retrospect this is not correct as all known boards have the headset
mic on IN3. To workaround this special IN?_HS_IN3 mappings were added.

This commit fixes the original IN1 mapping to correctly have the headset
mic on IN3, moves all users of the IN1_HS_IN3 mapping over to the fixed
IN1_MAP and drops the now no longer needed IN1_HS_IN3 mapping.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 29 +++++++--------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index c1bc3d4df841..70067e31a33e 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -43,7 +43,6 @@ enum {
 	BYT_RT5651_DMIC_MAP,
 	BYT_RT5651_IN1_MAP,
 	BYT_RT5651_IN1_IN2_MAP,
-	BYT_RT5651_IN1_HS_IN3_MAP,
 };
 
 enum {
@@ -92,7 +91,7 @@ struct byt_rt5651_private {
 
 /* Default: jack-detect on JD1_1, internal mic on in1, headsetmic on in3 */
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_HS_IN3_MAP;
+					BYT_RT5651_IN1_MAP;
 
 static void log_quirks(struct device *dev)
 {
@@ -102,8 +101,6 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN1_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_IN2_MAP)
 		dev_info(dev, "quirk IN1_IN2_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_HS_IN3_MAP)
-		dev_info(dev, "quirk IN1_HS_IN3_MAP enabled");
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
 			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
@@ -249,7 +246,7 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
 	{"Internal Mic", NULL, "micbias1"},
 	{"IN1P", NULL, "Internal Mic"},
-	{"IN2P", NULL, "Headset Mic"},
+	{"IN3P", NULL, "Headset Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_in2_map[] = {
@@ -259,12 +256,6 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_in2_map[] = {
 	{"IN3P", NULL, "Headset Mic"},
 };
 
-static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_hs_in3_map[] = {
-	{"Internal Mic", NULL, "micbias1"},
-	{"IN1P", NULL, "Internal Mic"},
-	{"IN3P", NULL, "Headset Mic"},
-};
-
 static const struct snd_soc_dapm_route byt_rt5651_ssp0_aif1_map[] = {
 	{"ssp0 Tx", NULL, "modem_out"},
 	{"modem_in", NULL, "ssp0 Rx"},
@@ -350,7 +341,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
 		},
-		.driver_data = (void *)(BYT_RT5651_IN1_HS_IN3_MAP),
+		.driver_data = (void *)(BYT_RT5651_IN1_MAP),
 	},
 	{
 		.callback = byt_rt5651_quirk_cb,
@@ -359,7 +350,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Turbot"),
 		},
 		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_IN1_HS_IN3_MAP),
+					BYT_RT5651_IN1_MAP),
 	},
 	{
 		.callback = byt_rt5651_quirk_cb,
@@ -378,7 +369,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
 		},
 		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN1_HS_IN3_MAP),
+					BYT_RT5651_IN1_MAP),
 	},
 	{
 		/* VIOS LTH17 */
@@ -469,10 +460,6 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_in2_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_in2_map);
 		break;
-	case BYT_RT5651_IN1_HS_IN3_MAP:
-		custom_map = byt_rt5651_intmic_in1_hs_in3_map;
-		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_hs_in3_map);
-		break;
 	default:
 		custom_map = byt_rt5651_intmic_dmic_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic_map);
@@ -717,10 +704,8 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 {
-	const char * const intmic_name[] =
-		{ "dmic", "in1", "in12", "in1" };
-	const char * const hsmic_name[] =
-		{  "in2", "in2", "in3", "in3" };
+	const char * const intmic_name[] = { "dmic", "in1", "in12" };
+	const char * const hsmic_name[] = { "in2", "in3", "in3" };
 	struct byt_rt5651_private *priv;
 	struct snd_soc_acpi_mach *mach;
 	const char *i2c_name = NULL;
-- 
2.17.1
