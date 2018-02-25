From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 27/32] ASoC: Intel: bytcr_rt5651: Rename
	IN3_MAP to IN1_HS_IN3_MAP
Date: Sun, 25 Feb 2018 11:47:08 +0100
Message-ID: <20180225104713.4745-28-hdegoede@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id BDB702674F6
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:47:55 +0100 (CET)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
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

All the mappings are named for where the internal mic is routed and in that
sense the newly added in3_map really is the same as in1_map, what makes it
different is that it maps the headset mic at IN3 rather then at IN2.

Rename in3_map to in1_hs_in3_map to better reflect what it actually does.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 0c024e38cf47..c3b759de9a8d 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -40,7 +40,7 @@ enum {
 	BYT_RT5651_IN1_MAP,
 	BYT_RT5651_IN2_MAP,
 	BYT_RT5651_IN1_IN2_MAP,
-	BYT_RT5651_IN3_MAP,
+	BYT_RT5651_IN1_HS_IN3_MAP,
 };
 
 enum {
@@ -90,8 +90,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN1_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_MAP)
 		dev_info(dev, "quirk IN2_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN3_MAP)
-		dev_info(dev, "quirk IN3_MAP enabled");
+	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_HS_IN3_MAP)
+		dev_info(dev, "quirk IN1_HS_IN3_MAP enabled");
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
 			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
@@ -234,8 +234,8 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
 	{"Internal Mic", NULL, "micbias1"},
-	{"IN2P", NULL, "Headset Mic"},
 	{"IN1P", NULL, "Internal Mic"},
+	{"IN2P", NULL, "Headset Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_map[] = {
@@ -251,10 +251,10 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_in2_map[] = {
 	{"IN3P", NULL, "Headset Mic"},
 };
 
-static const struct snd_soc_dapm_route byt_rt5651_intmic_in3_map[] = {
+static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_hs_in3_map[] = {
 	{"Internal Mic", NULL, "micbias1"},
-	{"IN3P", NULL, "Headset Mic"},
 	{"IN1P", NULL, "Internal Mic"},
+	{"IN3P", NULL, "Headset Mic"},
 };
 
 static const struct snd_kcontrol_new byt_rt5651_controls[] = {
@@ -299,7 +299,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
 		},
-		.driver_data = (void *)(BYT_RT5651_IN3_MAP),
+		.driver_data = (void *)(BYT_RT5651_IN1_HS_IN3_MAP),
 	},
 	{
 		.callback = byt_rt5651_quirk_cb,
@@ -308,7 +308,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Turbot"),
 		},
 		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
-					BYT_RT5651_IN3_MAP),
+					BYT_RT5651_IN1_HS_IN3_MAP),
 	},
 	{
 		.callback = byt_rt5651_quirk_cb,
@@ -350,9 +350,9 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_in2_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_in2_map);
 		break;
-	case BYT_RT5651_IN3_MAP:
-		custom_map = byt_rt5651_intmic_in3_map;
-		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in3_map);
+	case BYT_RT5651_IN1_HS_IN3_MAP:
+		custom_map = byt_rt5651_intmic_in1_hs_in3_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_hs_in3_map);
 		break;
 	default:
 		custom_map = byt_rt5651_intmic_dmic_map;
-- 
2.14.3
