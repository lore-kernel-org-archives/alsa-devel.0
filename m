From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v1 1/2] ASoC: codecs: msm8916-wcd-analog: move pm8916_wcd_setup_mbhc
Date: Fri, 29 Sep 2017 13:42:45 -0400
Message-ID: <20170929174246.12144-2-damien.riegel@savoirfairelinux.com>
References: <20170929174246.12144-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929174246.12144-1-damien.riegel@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>
List-Id: alsa-devel@alsa-project.org

In preparation of a fix for the initial detection of headset,
pm8916_wcd_setup_mbhc is moved to be defined after
pm8916_mbhc_configure_bias instead of before.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 88 +++++++++++++++++------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index f562f2d86907..9f08d998a79b 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -443,50 +443,6 @@ static int pm8916_wcd_analog_enable_micbias_int1(struct
 						     wcd->micbias1_cap_mode);
 }
 
-static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
-{
-	struct snd_soc_codec *codec = wcd->codec;
-	u32 plug_type = 0;
-	u32 int_en_mask;
-
-	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_1,
-		      CDC_A_MBHC_DET_CTL_L_DET_EN |
-		      CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_INSERTION |
-		      CDC_A_MBHC_DET_CTL_MIC_CLAMP_CTL_AUTO |
-		      CDC_A_MBHC_DET_CTL_MBHC_BIAS_EN);
-
-	if (wcd->hphl_jack_type_normally_open)
-		plug_type |= CDC_A_HPHL_PLUG_TYPE_NO;
-
-	if (wcd->gnd_jack_type_normally_open)
-		plug_type |= CDC_A_GND_PLUG_TYPE_NO;
-
-	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_2,
-		      CDC_A_MBHC_DET_CTL_HS_L_DET_PULL_UP_CTRL_I_3P0 |
-		      CDC_A_MBHC_DET_CTL_HS_L_DET_COMPA_CTRL_V0P9_VDD |
-		      plug_type |
-		      CDC_A_MBHC_DET_CTL_HPHL_100K_TO_GND_EN);
-
-
-	snd_soc_write(codec, CDC_A_MBHC_DBNC_TIMER,
-		      CDC_A_MBHC_DBNC_TIMER_INSREM_DBNC_T_256_MS |
-		      CDC_A_MBHC_DBNC_TIMER_BTN_DBNC_T_16MS);
-
-	/* enable MBHC clock */
-	snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
-			    DIG_CLK_CTL_D_MBHC_CLK_EN_MASK,
-			    DIG_CLK_CTL_D_MBHC_CLK_EN);
-
-	int_en_mask = MBHC_SWITCH_INT;
-	if (wcd->mbhc_btn_enabled)
-		int_en_mask |= MBHC_BUTTON_PRESS_DET | MBHC_BUTTON_RELEASE_DET;
-
-	snd_soc_update_bits(codec, CDC_D_INT_EN_CLR, int_en_mask, 0);
-	snd_soc_update_bits(codec, CDC_D_INT_EN_SET, int_en_mask, int_en_mask);
-	wcd->mbhc_btn0_released = false;
-	wcd->detect_accessory_type = true;
-}
-
 static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv *priv,
 				      bool micbias2_enabled)
 {
@@ -534,6 +490,50 @@ static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv *priv,
 	return 0;
 }
 
+static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
+{
+	struct snd_soc_codec *codec = wcd->codec;
+	u32 plug_type = 0;
+	u32 int_en_mask;
+
+	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_1,
+		      CDC_A_MBHC_DET_CTL_L_DET_EN |
+		      CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_INSERTION |
+		      CDC_A_MBHC_DET_CTL_MIC_CLAMP_CTL_AUTO |
+		      CDC_A_MBHC_DET_CTL_MBHC_BIAS_EN);
+
+	if (wcd->hphl_jack_type_normally_open)
+		plug_type |= CDC_A_HPHL_PLUG_TYPE_NO;
+
+	if (wcd->gnd_jack_type_normally_open)
+		plug_type |= CDC_A_GND_PLUG_TYPE_NO;
+
+	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_2,
+		      CDC_A_MBHC_DET_CTL_HS_L_DET_PULL_UP_CTRL_I_3P0 |
+		      CDC_A_MBHC_DET_CTL_HS_L_DET_COMPA_CTRL_V0P9_VDD |
+		      plug_type |
+		      CDC_A_MBHC_DET_CTL_HPHL_100K_TO_GND_EN);
+
+
+	snd_soc_write(codec, CDC_A_MBHC_DBNC_TIMER,
+		      CDC_A_MBHC_DBNC_TIMER_INSREM_DBNC_T_256_MS |
+		      CDC_A_MBHC_DBNC_TIMER_BTN_DBNC_T_16MS);
+
+	/* enable MBHC clock */
+	snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+			    DIG_CLK_CTL_D_MBHC_CLK_EN_MASK,
+			    DIG_CLK_CTL_D_MBHC_CLK_EN);
+
+	int_en_mask = MBHC_SWITCH_INT;
+	if (wcd->mbhc_btn_enabled)
+		int_en_mask |= MBHC_BUTTON_PRESS_DET | MBHC_BUTTON_RELEASE_DET;
+
+	snd_soc_update_bits(codec, CDC_D_INT_EN_CLR, int_en_mask, 0);
+	snd_soc_update_bits(codec, CDC_D_INT_EN_SET, int_en_mask, int_en_mask);
+	wcd->mbhc_btn0_released = false;
+	wcd->detect_accessory_type = true;
+}
+
 static int pm8916_wcd_analog_enable_micbias_int2(struct
 						  snd_soc_dapm_widget
 						  *w, struct snd_kcontrol
-- 
2.14.1
