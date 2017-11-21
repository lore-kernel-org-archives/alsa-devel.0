From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 1/2] ASoC: intel: byt: Introduce new map for dual mics
Date: Tue, 21 Nov 2017 17:15:45 +0000
Message-ID: <20171121171546.5656-2-carlo@caione.org>
References: <20171121171546.5656-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171121171546.5656-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Carlo Caione <carlo@endlessm.com>

The RT5651 codec has 3 analog inputs. Some laptops have two different
internal analog microphones on the external case.
Add a new custom quirk mapping the two internal mics on IN1P / IN2P,
leaving the headset mic on IN3P.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index d955836c6870..e3d5e6ea707f 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -38,6 +38,7 @@ enum {
 	BYT_RT5651_DMIC_MAP,
 	BYT_RT5651_IN1_MAP,
 	BYT_RT5651_IN2_MAP,
+	BYT_RT5651_IN1_IN2_MAP,
 };
 
 #define BYT_RT5651_MAP(quirk)	((quirk) & GENMASK(7, 0))
@@ -171,6 +172,13 @@ static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_map[] = {
 	{"IN2P", NULL, "Internal Mic"},
 };
 
+static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_in2_map[] = {
+	{"Internal Mic", NULL, "micbias1"},
+	{"IN1P", NULL, "Internal Mic"},
+	{"IN2P", NULL, "Internal Mic"},
+	{"IN3P", NULL, "Headset Mic"},
+};
+
 static const struct snd_kcontrol_new byt_rt5651_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -281,6 +289,10 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		custom_map = byt_rt5651_intmic_in2_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in2_map);
 		break;
+	case BYT_RT5651_IN1_IN2_MAP:
+		custom_map = byt_rt5651_intmic_in1_in2_map;
+		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_in2_map);
+		break;
 	default:
 		custom_map = byt_rt5651_intmic_dmic_map;
 		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic_map);
-- 
2.14.1
