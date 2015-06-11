From: Zidan Wang <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 1/4] ASoC: wm8960: codec mclk should be enabled early to avoid jack detect error
Date: Thu, 11 Jun 2015 19:14:33 +0800
Message-ID: <880838f666b591f5ffb0de1e39df5e3734846246.1434020423.git.zidan.wang@freescale.com>
References: <cover.1434020423.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434020423.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

It will playback from speaker in the first 2 seconds, then switch to
headphone. Steps to reproduce this issue:
1. plug out headphone and playback a wav.
2. stop playback and wait for at least 5 seconds, then
   plug in headphone and playback a wav.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 73 +++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 761418f..729205f 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -491,6 +491,34 @@ static int wm8960_add_widgets(struct snd_soc_codec *codec)
 	return 0;
 }
 
+int wm8960_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *codec_dai)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	if (!IS_ERR(wm8960->mclk)) {
+		ret = clk_prepare_enable(wm8960->mclk);
+		if (ret) {
+			dev_err(codec->dev,
+				"Failed to enable MCLK: %d\n", ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+void wm8960_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *codec_dai)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+
+	if (!IS_ERR(wm8960->mclk))
+		clk_disable_unprepare(wm8960->mclk);
+}
+
 static int wm8960_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
@@ -702,38 +730,14 @@ static int wm8960_set_bias_level_out3(struct snd_soc_codec *codec,
 				      enum snd_soc_bias_level level)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
-	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
-		switch (snd_soc_codec_get_bias_level(codec)) {
-		case SND_SOC_BIAS_STANDBY:
-			if (!IS_ERR(wm8960->mclk)) {
-				ret = clk_prepare_enable(wm8960->mclk);
-				if (ret) {
-					dev_err(codec->dev,
-						"Failed to enable MCLK: %d\n",
-						ret);
-					return ret;
-				}
-			}
-
-			/* Set VMID to 2x50k */
-			snd_soc_update_bits(codec, WM8960_POWER1, 0x180, 0x80);
-			break;
-
-		case SND_SOC_BIAS_ON:
-			if (!IS_ERR(wm8960->mclk))
-				clk_disable_unprepare(wm8960->mclk);
-			break;
-
-		default:
-			break;
-		}
-
+		/* Set VMID to 2x50k */
+		snd_soc_update_bits(codec, WM8960_POWER1, 0x180, 0x80);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -780,7 +784,7 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 					 enum snd_soc_bias_level level)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
-	int reg, ret;
+	int reg;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -821,22 +825,9 @@ static int wm8960_set_bias_level_capless(struct snd_soc_codec *codec,
 					    WM8960_VREF, WM8960_VREF);
 
 			msleep(100);
-
-			if (!IS_ERR(wm8960->mclk)) {
-				ret = clk_prepare_enable(wm8960->mclk);
-				if (ret) {
-					dev_err(codec->dev,
-						"Failed to enable MCLK: %d\n",
-						ret);
-					return ret;
-				}
-			}
 			break;
 
 		case SND_SOC_BIAS_ON:
-			if (!IS_ERR(wm8960->mclk))
-				clk_disable_unprepare(wm8960->mclk);
-
 			/* Enable anti-pop mode */
 			snd_soc_update_bits(codec, WM8960_APOP1,
 					    WM8960_POBCTRL | WM8960_SOFT_ST |
@@ -1059,6 +1050,8 @@ static int wm8960_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops wm8960_dai_ops = {
+	.startup = wm8960_startup,
+	.shutdown = wm8960_shutdown,
 	.hw_params = wm8960_hw_params,
 	.digital_mute = wm8960_mute,
 	.set_fmt = wm8960_set_dai_fmt,
-- 
1.9.1
