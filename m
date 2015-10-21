From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v2 2/2] ASoC: rt5640: Fill up the IN3's support
Date: Wed, 21 Oct 2015 09:46:06 +0800
Message-ID: <1445391966-24849-2-git-send-email-oder_chiou@realtek.com>
References: <1445391966-24849-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id DEEF22604FF
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 03:46:25 +0200 (CEST)
In-Reply-To: <1445391966-24849-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5640.txt |  5 ++++-
 include/sound/rt5640.h                             |  3 ++-
 sound/soc/codecs/rt5640.c                          | 22 +++++++++++++++++++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt b/Documentation/devicetree/bindings/sound/rt5640.txt
index 5d062a5..9e62f6e 100644
--- a/Documentation/devicetree/bindings/sound/rt5640.txt
+++ b/Documentation/devicetree/bindings/sound/rt5640.txt
@@ -14,7 +14,8 @@ Optional properties:
 
 - realtek,in1-differential
 - realtek,in2-differential
-  Boolean. Indicate MIC1/2 input are differential, rather than single-ended.
+- realtek,in3-differential
+  Boolean. Indicate MIC1/2/3 input are differential, rather than single-ended.
 
 - realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
 
@@ -27,6 +28,8 @@ Pins on the device (for linking into audio routes) for RT5639/RT5640:
   * IN1N
   * IN2P
   * IN2N
+  * IN3P
+  * IN3N
   * HPOL
   * HPOR
   * LOUTL
diff --git a/include/sound/rt5640.h b/include/sound/rt5640.h
index 59d26dd..e3c84b9 100644
--- a/include/sound/rt5640.h
+++ b/include/sound/rt5640.h
@@ -12,9 +12,10 @@
 #define __LINUX_SND_RT5640_H
 
 struct rt5640_platform_data {
-	/* IN1 & IN2 can optionally be differential */
+	/* IN1 & IN2 & IN3 can optionally be differential */
 	bool in1_diff;
 	bool in2_diff;
+	bool in3_diff;
 
 	bool dmic_en;
 	bool dmic1_data_pin; /* 0 = IN1P; 1 = GPIO3 */
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index e1ceeb8..f2beb1a 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -405,11 +405,14 @@ static const struct snd_kcontrol_new rt5640_snd_controls[] = {
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5640_DAC1_DIG_VOL,
 			RT5640_L_VOL_SFT, RT5640_R_VOL_SFT,
 			175, 0, dac_vol_tlv),
-	/* IN1/IN2 Control */
+	/* IN1/IN2/IN3 Control */
 	SOC_SINGLE_TLV("IN1 Boost", RT5640_IN1_IN2,
 		RT5640_BST_SFT1, 8, 0, bst_tlv),
 	SOC_SINGLE_TLV("IN2 Boost", RT5640_IN3_IN4,
 		RT5640_BST_SFT2, 8, 0, bst_tlv),
+	SOC_SINGLE_TLV("IN3 Boost", RT5640_IN1_IN2,
+		RT5640_BST_SFT2, 8, 0, bst_tlv),
+
 	/* INL/INR Volume Control */
 	SOC_DOUBLE_TLV("IN Capture Volume", RT5640_INL_INR_VOL,
 			RT5640_INL_VOL_SFT, RT5640_INR_VOL_SFT,
@@ -598,6 +601,8 @@ static const struct snd_kcontrol_new rt5640_rec_l_mix[] = {
 			RT5640_M_HP_L_RM_L_SFT, 1, 1),
 	SOC_DAPM_SINGLE("INL Switch", RT5640_REC_L2_MIXER,
 			RT5640_M_IN_L_RM_L_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST3 Switch", RT5640_REC_L2_MIXER,
+			RT5640_M_BST2_RM_L_SFT, 1, 1),
 	SOC_DAPM_SINGLE("BST2 Switch", RT5640_REC_L2_MIXER,
 			RT5640_M_BST4_RM_L_SFT, 1, 1),
 	SOC_DAPM_SINGLE("BST1 Switch", RT5640_REC_L2_MIXER,
@@ -611,6 +616,8 @@ static const struct snd_kcontrol_new rt5640_rec_r_mix[] = {
 			RT5640_M_HP_R_RM_R_SFT, 1, 1),
 	SOC_DAPM_SINGLE("INR Switch", RT5640_REC_R2_MIXER,
 			RT5640_M_IN_R_RM_R_SFT, 1, 1),
+	SOC_DAPM_SINGLE("BST3 Switch", RT5640_REC_R2_MIXER,
+			RT5640_M_BST2_RM_R_SFT, 1, 1),
 	SOC_DAPM_SINGLE("BST2 Switch", RT5640_REC_R2_MIXER,
 			RT5640_M_BST4_RM_R_SFT, 1, 1),
 	SOC_DAPM_SINGLE("BST1 Switch", RT5640_REC_R2_MIXER,
@@ -1065,6 +1072,8 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("IN1N"),
 	SND_SOC_DAPM_INPUT("IN2P"),
 	SND_SOC_DAPM_INPUT("IN2N"),
+	SND_SOC_DAPM_INPUT("IN3P"),
+	SND_SOC_DAPM_INPUT("IN3N"),
 	SND_SOC_DAPM_PGA("DMIC L1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("DMIC R1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("DMIC L2", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -1081,6 +1090,8 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 		RT5640_PWR_BST1_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("BST2", RT5640_PWR_ANLG2,
 		RT5640_PWR_BST4_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("BST3", RT5640_PWR_ANLG2,
+		RT5640_PWR_BST2_BIT, 0, NULL, 0),
 	/* Input Volume */
 	SND_SOC_DAPM_PGA("INL VOL", RT5640_PWR_VOL,
 		RT5640_PWR_IN_L_BIT, 0, NULL, 0),
@@ -1310,6 +1321,7 @@ static const struct snd_soc_dapm_widget rt5639_specific_dapm_widgets[] = {
 static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"IN1P", NULL, "LDO2"},
 	{"IN2P", NULL, "LDO2"},
+	{"IN3P", NULL, "LDO2"},
 
 	{"DMIC L1", NULL, "DMIC1"},
 	{"DMIC R1", NULL, "DMIC1"},
@@ -1320,18 +1332,22 @@ static const struct snd_soc_dapm_route rt5640_dapm_routes[] = {
 	{"BST1", NULL, "IN1N"},
 	{"BST2", NULL, "IN2P"},
 	{"BST2", NULL, "IN2N"},
+	{"BST3", NULL, "IN3P"},
+	{"BST3", NULL, "IN3N"},
 
 	{"INL VOL", NULL, "IN2P"},
 	{"INR VOL", NULL, "IN2N"},
 
 	{"RECMIXL", "HPOL Switch", "HPOL"},
 	{"RECMIXL", "INL Switch", "INL VOL"},
+	{"RECMIXL", "BST3 Switch", "BST3"},
 	{"RECMIXL", "BST2 Switch", "BST2"},
 	{"RECMIXL", "BST1 Switch", "BST1"},
 	{"RECMIXL", "OUT MIXL Switch", "OUT MIXL"},
 
 	{"RECMIXR", "HPOR Switch", "HPOR"},
 	{"RECMIXR", "INR Switch", "INR VOL"},
+	{"RECMIXR", "BST3 Switch", "BST3"},
 	{"RECMIXR", "BST2 Switch", "BST2"},
 	{"RECMIXR", "BST1 Switch", "BST1"},
 	{"RECMIXR", "OUT MIXR Switch", "OUT MIXR"},
@@ -2260,6 +2276,10 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5640->regmap, RT5640_IN3_IN4,
 					RT5640_IN_DF2, RT5640_IN_DF2);
 
+	if (rt5640->pdata.in3_diff)
+		regmap_update_bits(rt5640->regmap, RT5640_IN1_IN2,
+					RT5640_IN_DF2, RT5640_IN_DF2);
+
 	rt5640->hp_mute = 1;
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
-- 
1.8.1.1.439.g50a6b54
