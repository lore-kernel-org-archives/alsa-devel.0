From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: arizona: Move request of DSP IRQ
	into bus probe
Date: Wed, 26 Oct 2016 10:59:58 +0100
Message-ID: <1477475998-20114-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1477475998-20114-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ABA126688A
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 11:59:55 +0200 (CEST)
In-Reply-To: <1477475998-20114-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

It is more idiomatic to request all resources in the bus level probe,
this patch moves the request of the DSP compressed data IRQ from the
ASoC level probe into the bus level probe.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs47l24.c | 26 +++++++++++++-------------
 sound/soc/codecs/wm5102.c  | 26 +++++++++++++-------------
 sound/soc/codecs/wm5110.c  | 28 +++++++++++++---------------
 3 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 17e52c1..c5c5a2d 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1116,7 +1116,6 @@ static int cs47l24_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct cs47l24_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = priv->core.arizona;
 	int ret;
 
 	priv->core.arizona->dapm = dapm;
@@ -1126,14 +1125,6 @@ static int cs47l24_codec_probe(struct snd_soc_codec *codec)
 	arizona_init_mono(codec);
 	arizona_init_notifiers(codec);
 
-	ret = arizona_request_irq(arizona, ARIZONA_IRQ_DSP_IRQ1,
-				  "ADSP2 Compressed IRQ", cs47l24_adsp2_irq,
-				  priv);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request DSP IRQ: %d\n", ret);
-		return ret;
-	}
-
 	ret = wm_adsp2_codec_probe(&priv->core.adsp[1], codec);
 	if (ret)
 		goto err_adsp2_codec_probe;
@@ -1161,15 +1152,12 @@ static int cs47l24_codec_probe(struct snd_soc_codec *codec)
 static int cs47l24_codec_remove(struct snd_soc_codec *codec)
 {
 	struct cs47l24_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = priv->core.arizona;
 
 	wm_adsp2_codec_remove(&priv->core.adsp[1], codec);
 	wm_adsp2_codec_remove(&priv->core.adsp[2], codec);
 
 	priv->core.arizona->dapm = NULL;
 
-	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
-
 	return 0;
 }
 
@@ -1285,9 +1273,17 @@ static int cs47l24_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	ret = arizona_request_irq(arizona, ARIZONA_IRQ_DSP_IRQ1,
+				  "ADSP2 Compressed IRQ", cs47l24_adsp2_irq,
+				  cs47l24);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to request DSP IRQ: %d\n", ret);
+		return ret;
+	}
+
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
-		return ret;
+		goto err_dsp_irq;
 
 	ret = snd_soc_register_platform(&pdev->dev, &cs47l24_compr_platform);
 	if (ret < 0) {
@@ -1308,6 +1304,8 @@ static int cs47l24_probe(struct platform_device *pdev)
 	snd_soc_unregister_platform(&pdev->dev);
 err_spk_irqs:
 	arizona_free_spk_irqs(arizona);
+err_dsp_irq:
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, cs47l24);
 
 	return ret;
 }
@@ -1325,6 +1323,8 @@ static int cs47l24_remove(struct platform_device *pdev)
 
 	arizona_free_spk_irqs(arizona);
 
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, cs47l24);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 6f40ee6..a80a680 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1932,17 +1932,8 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = priv->core.arizona;
 	int ret;
 
-	ret = arizona_request_irq(arizona, ARIZONA_IRQ_DSP_IRQ1,
-				  "ADSP2 Compressed IRQ", wm5102_adsp2_irq,
-				  priv);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request DSP IRQ: %d\n", ret);
-		return ret;
-	}
-
 	ret = wm_adsp2_codec_probe(&priv->core.adsp[0], codec);
 	if (ret)
 		return ret;
@@ -1970,14 +1961,11 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 static int wm5102_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = priv->core.arizona;
 
 	wm_adsp2_codec_remove(&priv->core.adsp[0], codec);
 
 	priv->core.arizona->dapm = NULL;
 
-	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
-
 	return 0;
 }
 
@@ -2095,9 +2083,17 @@ static int wm5102_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	ret = arizona_request_irq(arizona, ARIZONA_IRQ_DSP_IRQ1,
+				  "ADSP2 Compressed IRQ", wm5102_adsp2_irq,
+				  wm5102);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to request DSP IRQ: %d\n", ret);
+		return ret;
+	}
+
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
-		return ret;
+		goto err_dsp_irq;
 
 	ret = snd_soc_register_platform(&pdev->dev, &wm5102_compr_platform);
 	if (ret < 0) {
@@ -2118,6 +2114,8 @@ static int wm5102_probe(struct platform_device *pdev)
 	snd_soc_unregister_platform(&pdev->dev);
 err_spk_irqs:
 	arizona_free_spk_irqs(arizona);
+err_dsp_irq:
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5102);
 
 	return ret;
 }
@@ -2135,6 +2133,8 @@ static int wm5102_remove(struct platform_device *pdev)
 
 	arizona_free_spk_irqs(arizona);
 
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5102);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 667fc25..f1a4113 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2274,7 +2274,6 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = priv->core.arizona;
 	int i, ret;
 
 	priv->core.arizona->dapm = dapm;
@@ -2284,14 +2283,6 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	arizona_init_mono(codec);
 	arizona_init_notifiers(codec);
 
-	ret = arizona_request_irq(arizona, ARIZONA_IRQ_DSP_IRQ1,
-				  "ADSP2 Compressed IRQ", wm5110_adsp2_irq,
-				  priv);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request DSP IRQ: %d\n", ret);
-		return ret;
-	}
-
 	for (i = 0; i < WM5110_NUM_ADSP; ++i) {
 		ret = wm_adsp2_codec_probe(&priv->core.adsp[i], codec);
 		if (ret)
@@ -2312,15 +2303,12 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	for (--i; i >= 0; --i)
 		wm_adsp2_codec_remove(&priv->core.adsp[i], codec);
 
-	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
-
 	return ret;
 }
 
 static int wm5110_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = priv->core.arizona;
 	int i;
 
 	for (i = 0; i < WM5110_NUM_ADSP; ++i)
@@ -2328,8 +2316,6 @@ static int wm5110_codec_remove(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = NULL;
 
-	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, priv);
-
 	return 0;
 }
 
@@ -2451,9 +2437,17 @@ static int wm5110_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	ret = arizona_request_irq(arizona, ARIZONA_IRQ_DSP_IRQ1,
+				  "ADSP2 Compressed IRQ", wm5110_adsp2_irq,
+				  wm5110);
+	if (ret != 0) {
+		dev_err(&pdev->dev, "Failed to request DSP IRQ: %d\n", ret);
+		return ret;
+	}
+
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
-		return ret;
+		goto err_dsp_irq;
 
 	ret = snd_soc_register_platform(&pdev->dev, &wm5110_compr_platform);
 	if (ret < 0) {
@@ -2474,6 +2468,8 @@ static int wm5110_probe(struct platform_device *pdev)
 	snd_soc_unregister_platform(&pdev->dev);
 err_spk_irqs:
 	arizona_free_spk_irqs(arizona);
+err_dsp_irq:
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5110);
 
 	return ret;
 }
@@ -2493,6 +2489,8 @@ static int wm5110_remove(struct platform_device *pdev)
 
 	arizona_free_spk_irqs(arizona);
 
+	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5110);
+
 	return 0;
 }
 
-- 
2.1.4
