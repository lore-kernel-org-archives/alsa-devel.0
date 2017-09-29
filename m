From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v1 2/2] ASoC: codecs: msm8916-wcd-analog: configure micbias in mbhc setup
Date: Fri, 29 Sep 2017 13:42:46 -0400
Message-ID: <20170929174246.12144-3-damien.riegel@savoirfairelinux.com>
References: <20170929174246.12144-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929174246.12144-1-damien.riegel@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>
List-Id: alsa-devel@alsa-project.org

The very first time a headset is plugged in, detection is unreliable
because bias hasn't been configured yet, it's done once a mechanical
insertion interrupt has been triggered, so following insertions (and
thus detections) are not affected.

To fix the very first detection, the bias must also be configured in the 
function that setup the MBHC.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 9f08d998a79b..71494e9dbdcb 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -493,6 +493,7 @@ static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv *priv,
 static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
 {
 	struct snd_soc_codec *codec = wcd->codec;
+	bool micbias_enabled = false;
 	u32 plug_type = 0;
 	u32 int_en_mask;
 
@@ -524,6 +525,11 @@ static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
 			    DIG_CLK_CTL_D_MBHC_CLK_EN_MASK,
 			    DIG_CLK_CTL_D_MBHC_CLK_EN);
 
+	if (snd_soc_read(codec, CDC_A_MICB_2_EN) & CDC_A_MICB_2_EN_ENABLE)
+		micbias_enabled = true;
+
+	pm8916_mbhc_configure_bias(wcd, micbias_enabled);
+
 	int_en_mask = MBHC_SWITCH_INT;
 	if (wcd->mbhc_btn_enabled)
 		int_en_mask |= MBHC_BUTTON_PRESS_DET | MBHC_BUTTON_RELEASE_DET;
-- 
2.14.1
