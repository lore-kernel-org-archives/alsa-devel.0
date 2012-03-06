From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Use audio mode for jack
	detection when system is active
Date: Tue,  6 Mar 2012 00:05:58 +0000
Message-ID: <1330992358-16479-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B44F24352
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 01:06:06 +0100 (CET)
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

When we are out of system sleep always use audio mode for jack detection
in order to avoid potential performance issues handing off between modes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   77 ++++++++++++++++++++++++++++-----------------
 sound/soc/codecs/wm8994.h |    1 +
 2 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 2417ef9..bc12d09 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -685,8 +685,6 @@ SOC_SINGLE_TLV("MIXINL IN1RP Boost Volume", WM8994_INPUT_MIXER_1, 8, 1, 0,
 static void wm1811_jackdet_set_mode(struct snd_soc_codec *codec, u16 mode)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	u16 old = snd_soc_read(codec, WM8994_ANTIPOP_2)
-		& WM1811_JACKDET_MODE_MASK;
 
 	if (!wm8994->jackdet || !wm8994->jack_cb)
 		return;
@@ -694,28 +692,17 @@ static void wm1811_jackdet_set_mode(struct snd_soc_codec *codec, u16 mode)
 	if (wm8994->active_refcount)
 		mode = WM1811_JACKDET_MODE_AUDIO;
 
-	if (mode == old)
+	if (mode == wm8994->jackdet_mode)
 		return;
 
-	snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
-			    WM1811_JACKDET_MODE_MASK, mode);
-
-	switch (mode) {
-	case WM1811_JACKDET_MODE_MIC:
-	case WM1811_JACKDET_MODE_AUDIO:
-		switch (old) {
-		case WM1811_JACKDET_MODE_MIC:
-		case WM1811_JACKDET_MODE_AUDIO:
-			break;
-		default:
-			msleep(2);
-			break;
-		}
+	wm8994->jackdet_mode = mode;
 
-	default:
-		break;
-	}
+	/* Always use audio mode to detect while the system is active */
+	if (mode != WM1811_JACKDET_MODE_NONE)
+		mode = WM1811_JACKDET_MODE_AUDIO;
 
+	snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+			    WM1811_JACKDET_MODE_MASK, mode);
 }
 
 static void active_reference(struct snd_soc_codec *codec)
@@ -2749,7 +2736,7 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 };
 
 #ifdef CONFIG_PM
-static int wm8994_suspend(struct snd_soc_codec *codec)
+static int wm8994_codec_suspend(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
@@ -2783,7 +2770,7 @@ static int wm8994_suspend(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int wm8994_resume(struct snd_soc_codec *codec)
+static int wm8994_codec_resume(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
@@ -2842,8 +2829,8 @@ static int wm8994_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 #else
-#define wm8994_suspend NULL
-#define wm8994_resume NULL
+#define wm8994_codec_suspend NULL
+#define wm8994_codec_resume NULL
 #endif
 
 static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
@@ -3955,8 +3942,8 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
 	.probe =	wm8994_codec_probe,
 	.remove =	wm8994_codec_remove,
-	.suspend =	wm8994_suspend,
-	.resume =	wm8994_resume,
+	.suspend =	wm8994_codec_suspend,
+	.resume =	wm8994_codec_resume,
 	.set_bias_level = wm8994_set_bias_level,
 };
 
@@ -3983,11 +3970,43 @@ static int __devexit wm8994_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int wm8994_suspend(struct device *dev)
+{
+	struct wm8994_priv *wm8994 = dev_get_drvdata(dev);
+
+	/* Drop down to power saving mode when system is suspended */
+	if (wm8994->jackdet && !wm8994->active_refcount)
+		regmap_update_bits(wm8994->wm8994->regmap, WM8994_ANTIPOP_2,
+				   WM1811_JACKDET_MODE_MASK,
+				   wm8994->jackdet_mode);
+
+	return 0;
+}
+
+static int wm8994_resume(struct device *dev)
+{
+	struct wm8994_priv *wm8994 = dev_get_drvdata(dev);
+
+	if (wm8994->jackdet && wm8994->jack_cb)
+		regmap_update_bits(wm8994->wm8994->regmap, WM8994_ANTIPOP_2,
+				   WM1811_JACKDET_MODE_MASK,
+				   WM1811_JACKDET_MODE_AUDIO);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops wm8994_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(wm8994_suspend, wm8994_resume)
+};
+
 static struct platform_driver wm8994_codec_driver = {
 	.driver = {
-		   .name = "wm8994-codec",
-		   .owner = THIS_MODULE,
-		   },
+		.name = "wm8994-codec",
+		.owner = THIS_MODULE,
+		.pm = &wm8994_pm_ops,
+	},
 	.probe = wm8994_probe,
 	.remove = __devexit_p(wm8994_remove),
 };
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index f996d14..2f4d2d1 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -122,6 +122,7 @@ struct wm8994_priv {
 	bool jack_mic;
 	int btn_mask;
 	bool jackdet;
+	int jackdet_mode;
 
 	wm8958_micdet_cb jack_cb;
 	void *jack_cb_data;
-- 
1.7.9.1
