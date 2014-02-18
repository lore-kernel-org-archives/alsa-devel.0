From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 044/102] ASoC: twl4030: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:00 +0100
Message-ID: <1392723517-12772-17-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 82C222655C5
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/twl4030.c | 84 ++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 682e4ac88939..975e0f760ac1 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -415,10 +415,9 @@ static const struct snd_kcontrol_new twl4030_dapm_carkitr_controls[] = {
 static const char *twl4030_handsfreel_texts[] =
 		{"Voice", "AudioL1", "AudioL2", "AudioR2"};
 
-static const struct soc_enum twl4030_handsfreel_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_HFL_CTL, 0,
-			ARRAY_SIZE(twl4030_handsfreel_texts),
-			twl4030_handsfreel_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_handsfreel_enum,
+			    TWL4030_REG_HFL_CTL, 0,
+			    twl4030_handsfreel_texts);
 
 static const struct snd_kcontrol_new twl4030_dapm_handsfreel_control =
 SOC_DAPM_ENUM("Route", twl4030_handsfreel_enum);
@@ -431,10 +430,9 @@ static const struct snd_kcontrol_new twl4030_dapm_handsfreelmute_control =
 static const char *twl4030_handsfreer_texts[] =
 		{"Voice", "AudioR1", "AudioR2", "AudioL2"};
 
-static const struct soc_enum twl4030_handsfreer_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_HFR_CTL, 0,
-			ARRAY_SIZE(twl4030_handsfreer_texts),
-			twl4030_handsfreer_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_handsfreer_enum,
+			    TWL4030_REG_HFR_CTL, 0,
+			    twl4030_handsfreer_texts);
 
 static const struct snd_kcontrol_new twl4030_dapm_handsfreer_control =
 SOC_DAPM_ENUM("Route", twl4030_handsfreer_enum);
@@ -448,10 +446,9 @@ static const struct snd_kcontrol_new twl4030_dapm_handsfreermute_control =
 static const char *twl4030_vibra_texts[] =
 		{"AudioL1", "AudioR1", "AudioL2", "AudioR2"};
 
-static const struct soc_enum twl4030_vibra_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_VIBRA_CTL, 2,
-			ARRAY_SIZE(twl4030_vibra_texts),
-			twl4030_vibra_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_vibra_enum,
+			    TWL4030_REG_VIBRA_CTL, 2,
+			    twl4030_vibra_texts);
 
 static const struct snd_kcontrol_new twl4030_dapm_vibra_control =
 SOC_DAPM_ENUM("Route", twl4030_vibra_enum);
@@ -460,10 +457,9 @@ SOC_DAPM_ENUM("Route", twl4030_vibra_enum);
 static const char *twl4030_vibrapath_texts[] =
 		{"Local vibrator", "Audio"};
 
-static const struct soc_enum twl4030_vibrapath_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_VIBRA_CTL, 4,
-			ARRAY_SIZE(twl4030_vibrapath_texts),
-			twl4030_vibrapath_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_vibrapath_enum,
+			    TWL4030_REG_VIBRA_CTL, 4,
+			    twl4030_vibrapath_texts);
 
 static const struct snd_kcontrol_new twl4030_dapm_vibrapath_control =
 SOC_DAPM_ENUM("Route", twl4030_vibrapath_enum);
@@ -490,10 +486,9 @@ static const struct snd_kcontrol_new twl4030_dapm_analogrmic_controls[] = {
 static const char *twl4030_micpathtx1_texts[] =
 		{"Analog", "Digimic0"};
 
-static const struct soc_enum twl4030_micpathtx1_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_ADCMICSEL, 0,
-			ARRAY_SIZE(twl4030_micpathtx1_texts),
-			twl4030_micpathtx1_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_micpathtx1_enum,
+			    TWL4030_REG_ADCMICSEL, 0,
+			    twl4030_micpathtx1_texts);
 
 static const struct snd_kcontrol_new twl4030_dapm_micpathtx1_control =
 SOC_DAPM_ENUM("Route", twl4030_micpathtx1_enum);
@@ -502,10 +497,9 @@ SOC_DAPM_ENUM("Route", twl4030_micpathtx1_enum);
 static const char *twl4030_micpathtx2_texts[] =
 		{"Analog", "Digimic1"};
 
-static const struct soc_enum twl4030_micpathtx2_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_ADCMICSEL, 2,
-			ARRAY_SIZE(twl4030_micpathtx2_texts),
-			twl4030_micpathtx2_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_micpathtx2_enum,
+			    TWL4030_REG_ADCMICSEL, 2,
+			    twl4030_micpathtx2_texts);
 
 static const struct snd_kcontrol_new twl4030_dapm_micpathtx2_control =
 SOC_DAPM_ENUM("Route", twl4030_micpathtx2_enum);
@@ -955,10 +949,9 @@ static const char *twl4030_op_modes_texts[] = {
 	"Option 2 (voice/audio)", "Option 1 (audio)"
 };
 
-static const struct soc_enum twl4030_op_modes_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_CODEC_MODE, 0,
-			ARRAY_SIZE(twl4030_op_modes_texts),
-			twl4030_op_modes_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_op_modes_enum,
+			    TWL4030_REG_CODEC_MODE, 0,
+			    twl4030_op_modes_texts);
 
 static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
@@ -1029,10 +1022,9 @@ static const char *twl4030_avadc_clk_priority_texts[] = {
 	"Voice high priority", "HiFi high priority"
 };
 
-static const struct soc_enum twl4030_avadc_clk_priority_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_AVADC_CTL, 2,
-			ARRAY_SIZE(twl4030_avadc_clk_priority_texts),
-			twl4030_avadc_clk_priority_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_avadc_clk_priority_enum,
+			    TWL4030_REG_AVADC_CTL, 2,
+			    twl4030_avadc_clk_priority_texts);
 
 static const char *twl4030_rampdelay_texts[] = {
 	"27/20/14 ms", "55/40/27 ms", "109/81/55 ms", "218/161/109 ms",
@@ -1040,40 +1032,36 @@ static const char *twl4030_rampdelay_texts[] = {
 	"3495/2581/1748 ms"
 };
 
-static const struct soc_enum twl4030_rampdelay_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_HS_POPN_SET, 2,
-			ARRAY_SIZE(twl4030_rampdelay_texts),
-			twl4030_rampdelay_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_rampdelay_enum,
+			    TWL4030_REG_HS_POPN_SET, 2,
+			    twl4030_rampdelay_texts);
 
 /* Vibra H-bridge direction mode */
 static const char *twl4030_vibradirmode_texts[] = {
 	"Vibra H-bridge direction", "Audio data MSB",
 };
 
-static const struct soc_enum twl4030_vibradirmode_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_VIBRA_CTL, 5,
-			ARRAY_SIZE(twl4030_vibradirmode_texts),
-			twl4030_vibradirmode_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_vibradirmode_enum,
+			    TWL4030_REG_VIBRA_CTL, 5,
+			    twl4030_vibradirmode_texts);
 
 /* Vibra H-bridge direction */
 static const char *twl4030_vibradir_texts[] = {
 	"Positive polarity", "Negative polarity",
 };
 
-static const struct soc_enum twl4030_vibradir_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_VIBRA_CTL, 1,
-			ARRAY_SIZE(twl4030_vibradir_texts),
-			twl4030_vibradir_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_vibradir_enum,
+			    TWL4030_REG_VIBRA_CTL, 1,
+			    twl4030_vibradir_texts);
 
 /* Digimic Left and right swapping */
 static const char *twl4030_digimicswap_texts[] = {
 	"Not swapped", "Swapped",
 };
 
-static const struct soc_enum twl4030_digimicswap_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_MISC_SET_1, 0,
-			ARRAY_SIZE(twl4030_digimicswap_texts),
-			twl4030_digimicswap_texts);
+static SOC_ENUM_SINGLE_DECL(twl4030_digimicswap_enum,
+			    TWL4030_REG_MISC_SET_1, 0,
+			    twl4030_digimicswap_texts);
 
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	/* Codec operation mode control */
-- 
1.8.5.2
