From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Fill up the IN3's support" to
	the asoc tree
Date: Fri, 23 Oct 2015 08:09:37 +0900
Message-ID: <E1ZpOzJ-0008SE-4f@finisterre>
References: <1445391966-24849-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 26E4C266B38
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:48 +0200 (CEST)
In-Reply-To: <1445391966-24849-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: Fill up the IN3's support

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 16566e47098211e30b3d8a0bc6a3576871ada8e8 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Wed, 21 Oct 2015 09:46:05 +0800
Subject: [PATCH] ASoC: rt5640: Fill up the IN3's support

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.6.1
