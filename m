From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 18/22] ASoC: Intel: bytcr_rt5651: Add new
	IN2_HS_IN3 input map and a quirk using it
Date: Sun,  4 Mar 2018 15:36:06 +0100
Message-ID: <20180304143610.21125-19-hdegoede@redhat.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id D46EE267408
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 15:36:38 +0100 (CET)
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

Add a new IN2_HS_IN3 input map and add a quirk for the input mapping and
jack-detect source for the Chuwi Vi8 Plus tablet, which uses this new map.

Note the Chuwi Vi8 Plus lists an extra GPIO in its codecs ACPI resources
which needs to be driven high to enable the external speaker amplifier,
this is not supported yet and will be fixed in a future patch.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 61af8904d5f4..2a5a817e6fb4 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -42,6 +42,7 @@ enum {
 	BYT_RT5651_IN2_MAP,
 	BYT_RT5651_IN1_IN2_MAP,
 	BYT_RT5651_IN1_HS_IN3_MAP,
+	BYT_RT5651_IN2_HS_IN3_MAP,
 };
 
 enum {
@@ -93,6 +94,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk IN2_MAP enabled");
 	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_HS_IN3_MAP)
 		dev_info(dev, "quirk IN1_HS_IN3_MAP enabled");
+	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_HS_IN3_MAP)
+		dev_info(dev, "quirk IN2_HS_IN3_MAP enabled");
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
 			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
@@ -258,6 +261,12 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_hs_in3_map[] = {
 	{"IN3P", NULL, "Headset Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_hs_in3_map[] = {
+	{"Internal Mic", NULL, "micbias1"},
+	{"IN2P", NULL, "Internal Mic"},
+	{"IN3P", NULL, "Headset Mic"},
+};
+
 static const struct snd_kcontrol_new byt_rt5651_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -323,6 +332,19 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 					BYT_RT5651_OVCD_SF_0P75 |
 					BYT_RT5651_IN1_IN2_MAP),
 	},
+	{
+		/* Chuwi Vi8 Plus (CWI519) */
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
+		},
+		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
+					BYT_RT5651_JD1_1 |
+					BYT_RT5651_OVCD_TH_2000UA |
+					BYT_RT5651_OVCD_SF_0P75 |
+					BYT_RT5651_IN2_HS_IN3_MAP),
+	},
 	{}
 };
 
@@ -386,6 +408,10 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_hs_in3_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_hs_in3_map);
 		break;
+	case BYT_RT5651_IN2_HS_IN3_MAP:
+		custom_map = byt_rt5651_intmic_in2_hs_in3_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in2_hs_in3_map);
+		break;
 	default:
 		custom_map = byt_rt5651_intmic_dmic_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic_map);
-- 
2.14.3
