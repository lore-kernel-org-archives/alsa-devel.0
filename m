From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support direct microphone detection IRQ
Date: Thu, 17 Feb 2011 20:06:23 -0800
Message-ID: <1298001983-8047-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C38B24454
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 05:06:09 +0100 (CET)
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

Allow direct routing of the WM8958 microphone detection signal to a GPIO
to be used, saving the need to demux the interrupt.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/pdata.h |    5 +++
 sound/soc/codecs/wm8994.c        |   57 +++++++++++++++++++++++--------------
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index 9eab263..0686946 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -103,6 +103,11 @@ struct wm8994_pdata {
         unsigned int lineout1fb:1;
         unsigned int lineout2fb:1;
 
+	/* IRQ for microphone detection if brought out directly as a
+	 * signal.
+	 */
+	int micdet_irq;
+
         /* Microphone biases: 0=0.9*AVDD1 1=0.65*AVVD1 */
         unsigned int micbias1_lvl:1;
         unsigned int micbias2_lvl:1;
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index c0adbf8..dce2aa7 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -104,6 +104,7 @@ struct wm8994_priv {
 	void *jack_cb_data;
 	bool jack_is_mic;
 	bool jack_is_video;
+	int micdet_irq;
 
 	int revision;
 	struct wm8994_pdata *pdata;
@@ -3103,6 +3104,12 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	wm8994->pdata = dev_get_platdata(codec->dev->parent);
 	wm8994->codec = codec;
 
+	if (wm8994->pdata && wm8994->pdata->micdet_irq)
+		wm8994->micdet_irq = wm8994->pdata->micdet_irq;
+	else if (wm8994->pdata && wm8994->pdata->irq_base)
+		wm8994->micdet_irq = wm8994->pdata->irq_base +
+				     WM8994_IRQ_MIC1_DET;
+
 	pm_runtime_enable(codec->dev);
 	pm_runtime_resume(codec->dev);
 
@@ -3151,14 +3158,17 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	switch (control->type) {
 	case WM8994:
-		ret = wm8994_request_irq(codec->control_data,
-					 WM8994_IRQ_MIC1_DET,
-					 wm8994_mic_irq, "Mic 1 detect",
-					 wm8994);
-		if (ret != 0)
-			dev_warn(codec->dev,
-				 "Failed to request Mic1 detect IRQ: %d\n",
-				 ret);
+		if (wm8994->micdet_irq) {
+			ret = request_threaded_irq(wm8994->micdet_irq, NULL,
+						   wm8994_mic_irq,
+						   IRQF_TRIGGER_RISING,
+						   "Mic1 detect",
+						   wm8994);
+			if (ret != 0)
+				dev_warn(codec->dev,
+					 "Failed to request Mic1 detect IRQ: %d\n",
+					 ret);
+		}
 
 		ret = wm8994_request_irq(codec->control_data,
 					 WM8994_IRQ_MIC1_SHRT,
@@ -3189,15 +3199,17 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 
 	case WM8958:
-		ret = wm8994_request_irq(codec->control_data,
-					 WM8994_IRQ_MIC1_DET,
-					 wm8958_mic_irq, "Mic detect",
-					 wm8994);
-		if (ret != 0)
-			dev_warn(codec->dev,
-				 "Failed to request Mic detect IRQ: %d\n",
-				 ret);
-		break;
+		if (wm8994->micdet_irq) {
+			ret = request_threaded_irq(wm8994->micdet_irq, NULL
+						   wm8958_mic_irq,
+						   IRQF_TRIGGER_RISING,
+						   "Mic detect",
+						   wm8994);
+			if (ret != 0)
+				dev_warn(codec->dev,
+					 "Failed to request Mic detect IRQ: %d\n",
+					 ret);
+		}
 	}
 
 	/* Remember if AIFnLRCLK is configured as a GPIO.  This should be
@@ -3329,7 +3341,8 @@ err_irq:
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_SHRT, wm8994);
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_DET, wm8994);
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT, wm8994);
-	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_DET, wm8994);
+	if (wm8994->micdet_irq)
+		free_irq(wm8994->micdet_irq, wm8994);
 err:
 	kfree(wm8994);
 	return ret;
@@ -3346,8 +3359,8 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 
 	switch (control->type) {
 	case WM8994:
-		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_SHRT,
-				wm8994);
+		if (wm8994->micdet_irq)
+			free_irq(wm8994->micdet_irq);
 		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_DET,
 				wm8994);
 		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT,
@@ -3357,8 +3370,8 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 		break;
 
 	case WM8958:
-		wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_DET,
-				wm8994);
+		if (wm8994->micdet_irq)
+			free_irq(wm8994->micdet_irq);
 		break;
 	}
 	kfree(wm8994->retune_mobile_texts);
-- 
1.7.2.3
