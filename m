From: srinivas.kandagatla@linaro.org
Subject: [PATCH] ASoC: codecs: msm8916-wcd: Fix supported formats
Date: Thu, 30 Nov 2017 10:15:02 +0000
Message-ID: <20171130101502.4660-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This codec is configurable for only 16 bit and 32 bit samples, so reflect
this in the supported formats also remove 24bit sample from supported list.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c  | 2 +-
 sound/soc/codecs/msm8916-wcd-digital.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 5f3c42c4f74a..066ea2f4ce7b 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -267,7 +267,7 @@
 #define MSM8916_WCD_ANALOG_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
 			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000)
 #define MSM8916_WCD_ANALOG_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
-				    SNDRV_PCM_FMTBIT_S24_LE)
+				    SNDRV_PCM_FMTBIT_S32_LE)
 
 static int btn_mask = SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 	       SND_JACK_BTN_2 | SND_JACK_BTN_3 | SND_JACK_BTN_4;
diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index a10a724eb448..13354d6304a8 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -194,7 +194,7 @@
 				   SNDRV_PCM_RATE_32000 | \
 				   SNDRV_PCM_RATE_48000)
 #define MSM8916_WCD_DIGITAL_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
-				     SNDRV_PCM_FMTBIT_S24_LE)
+				     SNDRV_PCM_FMTBIT_S32_LE)
 
 struct msm8916_wcd_digital_priv {
 	struct clk *ahbclk, *mclk;
@@ -645,7 +645,7 @@ static int msm8916_wcd_digital_hw_params(struct snd_pcm_substream *substream,
 				    RX_I2S_CTL_RX_I2S_MODE_MASK,
 				    RX_I2S_CTL_RX_I2S_MODE_16);
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
 		snd_soc_update_bits(dai->codec, LPASS_CDC_CLK_TX_I2S_CTL,
 				    TX_I2S_CTL_TX_I2S_MODE_MASK,
 				    TX_I2S_CTL_TX_I2S_MODE_32);
-- 
2.15.0
