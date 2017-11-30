From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-wcd: Fix supported formats" to the asoc tree
Date: Thu, 30 Nov 2017 12:33:20 +0000
Message-ID: <E1eKO1o-0000f2-IA@debutante>
References: <20171130101502.4660-1-srinivas.kandagatla@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171130101502.4660-1-srinivas.kandagatla@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916-wcd: Fix supported formats

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 51f493ae71adc2c49a317a13c38e54e1cdf46005 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 30 Nov 2017 10:15:02 +0000
Subject: [PATCH] ASoC: codecs: msm8916-wcd: Fix supported formats

This codec is configurable for only 16 bit and 32 bit samples, so reflect
this in the supported formats also remove 24bit sample from supported list.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
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
