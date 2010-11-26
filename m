From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Initial WM8958 audio configuration
Date: Fri, 26 Nov 2010 15:21:06 +0000
Message-ID: <1290784869-22204-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D87924502
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 16:23:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM8958 is a WM8994 derivative. This patch merely ensures that some
revision specific configuration for WM8994 is not enabled on WM8994,
additional patches will add support for the new features introduced on
the WM8958.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |  110 +++++++++++++++++++++++++++++++--------------
 1 files changed, 76 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2833994..8232d5e 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1535,6 +1535,7 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm8994 *control = codec->control_data;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	switch (level) {
@@ -1551,7 +1552,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			/* Tweak DC servo and DSP configuration for
 			 * improved performance. */
-			if (wm8994->revision < 4) {
+			if (control->type == WM8994 && wm8994->revision < 4) {
 				/* Tweak DC servo and DSP configuration for
 				 * improved performance. */
 				snd_soc_write(codec, 0x102, 0x3);
@@ -2264,8 +2265,12 @@ int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994_micdet *micdet;
+	struct wm8994 *control = codec->control_data;
 	int reg;
 
+	if (control->type != WM8994)
+		return -EINVAL;
+
 	switch (micbias) {
 	case 1:
 		micdet = &wm8994->micdet[0];
@@ -2334,11 +2339,13 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 
 static int wm8994_codec_probe(struct snd_soc_codec *codec)
 {
+	struct wm8994 *control;
 	struct wm8994_priv *wm8994;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret, i;
 
 	codec->control_data = dev_get_drvdata(codec->dev->parent);
+	control = codec->control_data;
 
 	wm8994 = kzalloc(sizeof(struct wm8994_priv), GFP_KERNEL);
 	if (wm8994 == NULL)
@@ -2369,41 +2376,67 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	/* Set revision-specific configuration */
 	wm8994->revision = snd_soc_read(codec, WM8994_CHIP_REVISION);
-	switch (wm8994->revision) {
-	case 2:
-	case 3:
-		wm8994->hubs.dcs_codes = -5;
-		wm8994->hubs.hp_startup_mode = 1;
+	switch (control->type) {
+	case WM8994:
+		switch (wm8994->revision) {
+		case 2:
+		case 3:
+			wm8994->hubs.dcs_codes = -5;
+			wm8994->hubs.hp_startup_mode = 1;
+			wm8994->hubs.dcs_readback_mode = 1;
+			break;
+		default:
+			wm8994->hubs.dcs_readback_mode = 1;
+			break;
+		}
+
+	case WM8958:
 		wm8994->hubs.dcs_readback_mode = 1;
 		break;
+
 	default:
-		wm8994->hubs.dcs_readback_mode = 1;
 		break;
 	}
 
-	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_MIC1_DET,
-				 wm8994_mic_irq, "Mic 1 detect", wm8994);
-	if (ret != 0)
-		dev_warn(codec->dev,
-			 "Failed to request Mic1 detect IRQ: %d\n", ret);
-
-	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT,
-				 wm8994_mic_irq, "Mic 1 short", wm8994);
-	if (ret != 0)
-		dev_warn(codec->dev,
-			 "Failed to request Mic1 short IRQ: %d\n", ret);
-
-	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_MIC2_DET,
-				 wm8994_mic_irq, "Mic 2 detect", wm8994);
-	if (ret != 0)
-		dev_warn(codec->dev,
-			 "Failed to request Mic2 detect IRQ: %d\n", ret);
-
-	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_MIC2_SHRT,
-				 wm8994_mic_irq, "Mic 2 short", wm8994);
-	if (ret != 0)
-		dev_warn(codec->dev,
-			 "Failed to request Mic2 short IRQ: %d\n", ret);
+	switch (control->type) {
+	case WM8994:
+		ret = wm8994_request_irq(codec->control_data,
+					 WM8994_IRQ_MIC1_DET,
+					 wm8994_mic_irq, "Mic 1 detect",
+					 wm8994);
+		if (ret != 0)
+			dev_warn(codec->dev,
+				 "Failed to request Mic1 detect IRQ: %d\n",
+				 ret);
+
+		ret = wm8994_request_irq(codec->control_data,
+					 WM8994_IRQ_MIC1_SHRT,
+					 wm8994_mic_irq, "Mic 1 short",
+					 wm8994);
+		if (ret != 0)
+			dev_warn(codec->dev,
+				 "Failed to request Mic1 short IRQ: %d\n",
+				 ret);
+
+		ret = wm8994_request_irq(codec->control_data,
+					 WM8994_IRQ_MIC2_DET,
+					 wm8994_mic_irq, "Mic 2 detect",
+					 wm8994);
+		if (ret != 0)
+			dev_warn(codec->dev,
+				 "Failed to request Mic2 detect IRQ: %d\n",
+				 ret);
+
+		ret = wm8994_request_irq(codec->control_data,
+					 WM8994_IRQ_MIC2_SHRT,
+					 wm8994_mic_irq, "Mic 2 short",
+					 wm8994);
+		if (ret != 0)
+			dev_warn(codec->dev,
+				 "Failed to request Mic2 short IRQ: %d\n",
+				 ret);
+		break;
+	}
 
 	/* Remember if AIFnLRCLK is configured as a GPIO.  This should be
 	 * configured on init - if a system wants to do this dynamically
@@ -2496,13 +2529,22 @@ err:
 static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994 *control = codec->control_data;
 
 	wm8994_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_SHRT, wm8994);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_DET, wm8994);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT, wm8994);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_DET, wm8994);
+	switch (control->type) {
+	case WM8994:
+		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_SHRT,
+				wm8994);
+		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_DET,
+				wm8994);
+		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT,
+				wm8994);
+		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_DET,
+				wm8994);
+		break;
+	}
 	kfree(wm8994->retune_mobile_texts);
 	kfree(wm8994->drc_texts);
 	kfree(wm8994);
-- 
1.7.1
