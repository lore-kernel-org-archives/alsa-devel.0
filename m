From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] ASoC: max98090 - Expose HP out enable.
Date: Mon, 24 Jul 2017 11:05:25 +0200
Message-ID: <20170724090525.12710-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Hsin-Yu Chao <hychao@chromium.org>
List-Id: alsa-devel@alsa-project.org

From: Hsin-Yu Chao <hychao@chromium.org>

Expose the headphone output enables to user space.  This will allow
userspace to ensure that there is stable output before the headphones
are turned on, avoiding a pop on insertion.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 sound/soc/codecs/max98090.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 6682848..f38c051 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1074,6 +1074,15 @@ static SOC_ENUM_SINGLE_DECL(mixhprsel_mux_enum,
 static const struct snd_kcontrol_new max98090_mixhprsel_mux =
 	SOC_DAPM_ENUM("MIXHPRSEL Mux", mixhprsel_mux_enum);
 
+/* HP output enables. */
+static const struct snd_kcontrol_new max98090_hpl_enable =
+	SOC_DAPM_SINGLE("Switch", M98090_REG_OUTPUT_ENABLE,
+			M98090_HPLEN_SHIFT, 1, 0);
+
+static const struct snd_kcontrol_new max98090_hpr_enable =
+	SOC_DAPM_SINGLE("Switch", M98090_REG_OUTPUT_ENABLE,
+			M98090_HPREN_SHIFT, 1, 0);
+
 static const struct snd_soc_dapm_widget max98090_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("MIC1"),
 	SND_SOC_DAPM_INPUT("MIC2"),
@@ -1218,10 +1227,10 @@ static const struct snd_soc_dapm_widget max98090_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("MIXHPRSEL Mux", M98090_REG_HP_CONTROL,
 		M98090_MIXHPRSEL_SHIFT, 0, &max98090_mixhprsel_mux),
 
-	SND_SOC_DAPM_PGA("HP Left Out", M98090_REG_OUTPUT_ENABLE,
-		M98090_HPLEN_SHIFT, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("HP Right Out", M98090_REG_OUTPUT_ENABLE,
-		M98090_HPREN_SHIFT, 0, NULL, 0),
+	SND_SOC_DAPM_SWITCH("HP Left Out", SND_SOC_NOPM, 0, 0,
+			    &max98090_hpl_enable),
+	SND_SOC_DAPM_SWITCH("HP Right Out", SND_SOC_NOPM, 0, 0,
+			    &max98090_hpr_enable),
 
 	SND_SOC_DAPM_PGA("SPK Left Out", M98090_REG_OUTPUT_ENABLE,
 		M98090_SPLEN_SHIFT, 0, NULL, 0),
@@ -1405,8 +1414,8 @@ static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
 	 * Disable this for lowest power if bypassing
 	 * the DAC with an analog signal
 	 */
-	{"HP Left Out", NULL, "DACL"},
-	{"HP Left Out", NULL, "MIXHPLSEL Mux"},
+	{"HP Left Out", "Switch", "DACL"},
+	{"HP Left Out", "Switch", "MIXHPLSEL Mux"},
 
 	{"MIXHPRSEL Mux", "HP Mixer", "Right Headphone Mixer"},
 
@@ -1414,8 +1423,8 @@ static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
 	 * Disable this for lowest power if bypassing
 	 * the DAC with an analog signal
 	 */
-	{"HP Right Out", NULL, "DACR"},
-	{"HP Right Out", NULL, "MIXHPRSEL Mux"},
+	{"HP Right Out", "Switch", "DACR"},
+	{"HP Right Out", "Switch", "MIXHPRSEL Mux"},
 
 	{"SPK Left Out", NULL, "Left Speaker Mixer"},
 	{"SPK Right Out", NULL, "Right Speaker Mixer"},
-- 
2.9.3
