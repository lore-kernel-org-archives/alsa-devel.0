From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 2/2] ASoC: intel: byt: Introduce new custom IN2 map
Date: Wed, 18 Oct 2017 17:07:59 +0100
Message-ID: <20171018160759.18563-3-carlo@caione.org>
References: <20171018160759.18563-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018160759.18563-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

Introduce a new custom dapm routes map to quirk platforms with the
internal mic connected to IN2P.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index ec84454a232d..a8a9c83dfcc0 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -47,7 +47,6 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 	{"ssp2 Rx", NULL, "AIF1 Capture"},
 
 	{"Headset Mic", NULL, "micbias1"}, /* lowercase for rt5651 */
-	{"IN2P", NULL, "Headset Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 	{"Speaker", NULL, "LOUTL"},
@@ -55,22 +54,32 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic1_map[] = {
+	{"IN2P", NULL, "Headset Mic"},
 	{"DMIC1", NULL, "Internal Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic2_map[] = {
+	{"IN2P", NULL, "Headset Mic"},
 	{"DMIC2", NULL, "Internal Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
 	{"Internal Mic", NULL, "micbias1"},
 	{"IN1P", NULL, "Internal Mic"},
+	{"IN2P", NULL, "Headset Mic"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_map[] = {
+	{"Internal Mic", NULL, "micbias1"},
+	{"IN2P", NULL, "Internal Mic"},
+	{"IN1P", NULL, "Headset Mic"},
 };
 
 enum {
 	BYT_RT5651_DMIC1_MAP,
 	BYT_RT5651_DMIC2_MAP,
 	BYT_RT5651_IN1_MAP,
+	BYT_RT5651_IN2_MAP,
 };
 
 #define BYT_RT5651_MAP(quirk)	((quirk) & 0xff)
@@ -133,6 +142,10 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in1_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_map);
 		break;
+	case BYT_RT5651_IN2_MAP:
+		custom_map = byt_rt5651_intmic_in2_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in2_map);
+		break;
 	case BYT_RT5651_DMIC2_MAP:
 		custom_map = byt_rt5651_intmic_dmic2_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic2_map);
-- 
2.14.2
