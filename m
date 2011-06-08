From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/6] ASoC: Defer all WM8962 clocking
	configuration until power up
Date: Wed,  8 Jun 2011 14:50:54 +0100
Message-ID: <1307541055-10150-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D1BB103929
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 15:51:03 +0200 (CEST)
In-Reply-To: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Don't require an audio rate SYSCLK in hw_params() in order to better
support microphone detection use cases.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   60 ++++++++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 56934d3..8499c56 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2790,18 +2790,44 @@ static const int bclk_divs[] = {
 	1, -1, 2, 3, 4, -1, 6, 8, -1, 12, 16, 24, -1, 32, 32, 32
 };
 
+static const int sysclk_rates[] = {
+	64, 128, 192, 256, 384, 512, 768, 1024, 1408, 1536,
+};
+
 static void wm8962_configure_bclk(struct snd_soc_codec *codec)
 {
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	int dspclk, i;
 	int clocking2 = 0;
+	int clocking4 = 0;
 	int aif2 = 0;
 
-	if (!wm8962->bclk) {
-		dev_dbg(codec->dev, "No BCLK rate configured\n");
+	if (!wm8962->sysclk_rate) {
+		dev_dbg(codec->dev, "No SYSCLK configured\n");
 		return;
 	}
 
+	if (!wm8962->bclk || !wm8962->lrclk) {
+		dev_dbg(codec->dev, "No audio clocks configured\n");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sysclk_rates); i++) {
+		if (sysclk_rates[i] == wm8962->sysclk_rate / wm8962->lrclk) {
+			clocking4 |= i << WM8962_SYSCLK_RATE_SHIFT;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(sysclk_rates)) {
+		dev_err(codec->dev, "Unsupported sysclk ratio %d\n",
+			wm8962->sysclk_rate / wm8962->lrclk);
+		return;
+	}
+
+	snd_soc_update_bits(codec, WM8962_CLOCKING_4,
+			    WM8962_SYSCLK_RATE_MASK, clocking4);
+
 	dspclk = snd_soc_read(codec, WM8962_CLOCKING1);
 	if (dspclk < 0) {
 		dev_err(codec->dev, "Failed to read DSPCLK: %d\n", dspclk);
@@ -2871,6 +2897,8 @@ static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 		/* VMID 2*50k */
 		snd_soc_update_bits(codec, WM8962_PWR_MGMT_1,
 				    WM8962_VMID_SEL_MASK, 0x80);
+
+		wm8962_configure_bclk(codec);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
@@ -2903,8 +2931,6 @@ static int wm8962_set_bias_level(struct snd_soc_codec *codec,
 			snd_soc_update_bits(codec, WM8962_CLOCKING2,
 					    WM8962_CLKREG_OVD,
 					    WM8962_CLKREG_OVD);
-
-			wm8962_configure_bclk(codec);
 		}
 
 		/* VMID 2*250k */
@@ -2945,10 +2971,6 @@ static const struct {
 	{ 96000, 6 },
 };
 
-static const int sysclk_rates[] = {
-	64, 128, 192, 256, 384, 512, 768, 1024, 1408, 1536,
-};
-
 static int wm8962_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
@@ -2956,41 +2978,27 @@ static int wm8962_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	int rate = params_rate(params);
 	int i;
 	int aif0 = 0;
 	int adctl3 = 0;
-	int clocking4 = 0;
 
 	wm8962->bclk = snd_soc_params_to_bclk(params);
 	wm8962->lrclk = params_rate(params);
 
 	for (i = 0; i < ARRAY_SIZE(sr_vals); i++) {
-		if (sr_vals[i].rate == rate) {
+		if (sr_vals[i].rate == wm8962->lrclk) {
 			adctl3 |= sr_vals[i].reg;
 			break;
 		}
 	}
 	if (i == ARRAY_SIZE(sr_vals)) {
-		dev_err(codec->dev, "Unsupported rate %dHz\n", rate);
+		dev_err(codec->dev, "Unsupported rate %dHz\n", wm8962->lrclk);
 		return -EINVAL;
 	}
 
-	if (rate % 8000 == 0)
+	if (wm8962->lrclk % 8000 == 0)
 		adctl3 |= WM8962_SAMPLE_RATE_INT_MODE;
 
-	for (i = 0; i < ARRAY_SIZE(sysclk_rates); i++) {
-		if (sysclk_rates[i] == wm8962->sysclk_rate / rate) {
-			clocking4 |= i << WM8962_SYSCLK_RATE_SHIFT;
-			break;
-		}
-	}
-	if (i == ARRAY_SIZE(sysclk_rates)) {
-		dev_err(codec->dev, "Unsupported sysclk ratio %d\n",
-			wm8962->sysclk_rate / rate);
-		return -EINVAL;
-	}
-
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		break;
@@ -3012,8 +3020,6 @@ static int wm8962_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_update_bits(codec, WM8962_ADDITIONAL_CONTROL_3,
 			    WM8962_SAMPLE_RATE_INT_MODE |
 			    WM8962_SAMPLE_RATE_MASK, adctl3);
-	snd_soc_update_bits(codec, WM8962_CLOCKING_4,
-			    WM8962_SYSCLK_RATE_MASK, clocking4);
 
 	wm8962_configure_bclk(codec);
 
-- 
1.7.5.3
