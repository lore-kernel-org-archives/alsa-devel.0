From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Don't use control_data to get struct
	wm8994
Date: Mon, 28 Nov 2011 23:15:48 +0000
Message-ID: <1322522150-4350-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111128231513.GA1608@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78E2810396B
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 00:15:59 +0100 (CET)
In-Reply-To: <20111128231513.GA1608@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This will support refactoring to make use of the regmap API more directly
in the core.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   72 +++++++++++++++++++++++---------------------
 sound/soc/codecs/wm8994.h |    5 ++-
 2 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 9c982e4..eb0020f 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -56,7 +56,7 @@ static int wm8994_retune_mobile_base[] = {
 static int wm8994_readable(struct snd_soc_codec *codec, unsigned int reg)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994 *control = codec->control_data;
+	struct wm8994 *control = wm8994->wm8994;
 
 	switch (reg) {
 	case WM8994_GPIO_1:
@@ -1768,7 +1768,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 			  unsigned int freq_in, unsigned int freq_out)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994 *control = codec->control_data;
+	struct wm8994 *control = wm8994->wm8994;
 	int reg_offset, ret;
 	struct fll_div fll;
 	u16 reg, aif1, aif2;
@@ -2017,8 +2017,8 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8994 *control = codec->control_data;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994 *control = wm8994->wm8994;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -2095,7 +2095,8 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct wm8994 *control = codec->control_data;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994 *control = wm8994->wm8994;
 	int ms_reg;
 	int aif1_reg;
 	int ms = 0;
@@ -2390,7 +2391,8 @@ static int wm8994_aif3_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct wm8994 *control = codec->control_data;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994 *control = wm8994->wm8994;
 	int aif1_reg;
 	int aif1 = 0;
 
@@ -2621,7 +2623,7 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 static int wm8994_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994 *control = codec->control_data;
+	struct wm8994 *control = wm8994->wm8994;
 	int i, ret;
 
 	switch (control->type) {
@@ -2652,7 +2654,7 @@ static int wm8994_suspend(struct snd_soc_codec *codec, pm_message_t state)
 static int wm8994_resume(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994 *control = codec->control_data;
+	struct wm8994 *control = wm8994->wm8994;
 	int i, ret;
 	unsigned int val, mask;
 
@@ -2874,7 +2876,7 @@ int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994_micdet *micdet;
-	struct wm8994 *control = codec->control_data;
+	struct wm8994 *control = wm8994->wm8994;
 	int reg;
 
 	if (control->type != WM8994)
@@ -2994,7 +2996,7 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		      wm8958_micdet_cb cb, void *cb_data)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994 *control = codec->control_data;
+	struct wm8994 *control = wm8994->wm8994;
 
 	switch (control->type) {
 	case WM1811:
@@ -3114,6 +3116,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, wm8994);
 
+
+	wm8994->wm8994 = dev_get_drvdata(codec->dev->parent);
 	wm8994->pdata = dev_get_platdata(codec->dev->parent);
 	wm8994->codec = codec;
 
@@ -3193,14 +3197,14 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
-	wm8994_request_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR,
+	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR,
 			   wm8994_fifo_error, "FIFO error", codec);
-	wm8994_request_irq(codec->control_data, WM8994_IRQ_TEMP_WARN,
+	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN,
 			   wm8994_temp_warn, "Thermal warning", codec);
-	wm8994_request_irq(codec->control_data, WM8994_IRQ_TEMP_SHUT,
+	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT,
 			   wm8994_temp_shut, "Thermal shutdown", codec);
 
-	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
+	ret = wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_DCS_DONE,
 				 wm_hubs_dcs_done, "DC servo done",
 				 &wm8994->hubs);
 	if (ret == 0)
@@ -3220,7 +3224,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 					 ret);
 		}
 
-		ret = wm8994_request_irq(codec->control_data,
+		ret = wm8994_request_irq(wm8994->wm8994,
 					 WM8994_IRQ_MIC1_SHRT,
 					 wm8994_mic_irq, "Mic 1 short",
 					 wm8994);
@@ -3229,7 +3233,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 				 "Failed to request Mic1 short IRQ: %d\n",
 				 ret);
 
-		ret = wm8994_request_irq(codec->control_data,
+		ret = wm8994_request_irq(wm8994->wm8994,
 					 WM8994_IRQ_MIC2_DET,
 					 wm8994_mic_irq, "Mic 2 detect",
 					 wm8994);
@@ -3238,7 +3242,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 				 "Failed to request Mic2 detect IRQ: %d\n",
 				 ret);
 
-		ret = wm8994_request_irq(codec->control_data,
+		ret = wm8994_request_irq(wm8994->wm8994,
 					 WM8994_IRQ_MIC2_SHRT,
 					 wm8994_mic_irq, "Mic 2 short",
 					 wm8994);
@@ -3265,7 +3269,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	wm8994->fll_locked_irq = true;
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++) {
-		ret = wm8994_request_irq(codec->control_data,
+		ret = wm8994_request_irq(wm8994->wm8994,
 					 WM8994_IRQ_FLL1_LOCK + i,
 					 wm8994_fll_locked_irq, "FLL lock",
 					 &wm8994->fll_locked[i]);
@@ -3472,19 +3476,19 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 
 err_irq:
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_SHRT, wm8994);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_DET, wm8994);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT, wm8994);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_MIC2_SHRT, wm8994);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_MIC2_DET, wm8994);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_MIC1_SHRT, wm8994);
 	if (wm8994->micdet_irq)
 		free_irq(wm8994->micdet_irq, wm8994);
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
-		wm8994_free_irq(codec->control_data, WM8994_IRQ_FLL1_LOCK + i,
+		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FLL1_LOCK + i,
 				&wm8994->fll_locked[i]);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR, codec);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_TEMP_SHUT, codec);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_TEMP_WARN, codec);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, codec);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, codec);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, codec);
 err:
 	kfree(wm8994);
 	return ret;
@@ -3493,7 +3497,7 @@ err:
 static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994 *control = codec->control_data;
+	struct wm8994 *control = wm8994->wm8994;
 	int i;
 
 	wm8994_set_bias_level(codec, SND_SOC_BIAS_OFF);
@@ -3501,24 +3505,24 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 	pm_runtime_disable(codec->dev);
 
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
-		wm8994_free_irq(codec->control_data, WM8994_IRQ_FLL1_LOCK + i,
+		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FLL1_LOCK + i,
 				&wm8994->fll_locked[i]);
 
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR, codec);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_TEMP_SHUT, codec);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_TEMP_WARN, codec);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_FIFOS_ERR, codec);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT, codec);
+	wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN, codec);
 
 	switch (control->type) {
 	case WM8994:
 		if (wm8994->micdet_irq)
 			free_irq(wm8994->micdet_irq, wm8994);
-		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_DET,
+		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_MIC2_DET,
 				wm8994);
-		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT,
+		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_MIC1_SHRT,
 				wm8994);
-		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_DET,
+		wm8994_free_irq(wm8994->wm8994, WM8994_IRQ_MIC1_DET,
 				wm8994);
 		break;
 
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index f4f1355..09538f6 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -70,10 +70,11 @@ struct wm8994_fll_config {
 #define WM8994_NUM_DRC 3
 #define WM8994_NUM_EQ  3
 
+struct wm8994;
+
 struct wm8994_priv {
 	struct wm_hubs_data hubs;
-	enum snd_soc_control_type control_type;
-	void *control_data;
+	struct wm8994 *wm8994;
 	struct snd_soc_codec *codec;
 	int sysclk[2];
 	int sysclk_rate[2];
-- 
1.7.7.3
