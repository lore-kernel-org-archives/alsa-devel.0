From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: Implement WM8350 headphone jack
	detection
Date: Thu,  8 Jan 2009 19:38:01 +0000
Message-ID: <1231443481-29352-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090108193718.GA29183@sirena.org.uk>
	<1231443481-29352-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B6ED24373
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 20:38:11 +0100 (CET)
In-Reply-To: <1231443481-29352-6-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8350/audio.h |    1 +
 sound/soc/codecs/wm8350.c        |  116 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/wm8350.h        |    8 +++
 3 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/wm8350/audio.h b/include/linux/mfd/wm8350/audio.h
index af95a1d..d899dc0 100644
--- a/include/linux/mfd/wm8350/audio.h
+++ b/include/linux/mfd/wm8350/audio.h
@@ -490,6 +490,7 @@
 /*
  * R231 (0xE7) - Jack Status
  */
+#define WM8350_JACK_L_LVL			0x0800
 #define WM8350_JACK_R_LVL                       0x0400
 
 /*
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index e3989d4..47a9dab 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -51,10 +51,17 @@ struct wm8350_output {
 	u16 mute;
 };
 
+struct wm8350_jack_data {
+	struct snd_soc_jack *jack;
+	int report;
+};
+
 struct wm8350_data {
 	struct snd_soc_codec codec;
 	struct wm8350_output out1;
 	struct wm8350_output out2;
+	struct wm8350_jack_data hpl;
+	struct wm8350_jack_data hpr;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 };
 
@@ -1328,6 +1335,95 @@ static int wm8350_resume(struct platform_device *pdev)
 	return 0;
 }
 
+static void wm8350_hp_jack_handler(struct wm8350 *wm8350, int irq, void *data)
+{
+	struct wm8350_data *priv = data;
+	u16 reg;
+	int report;
+	int mask;
+	struct wm8350_jack_data *jack = NULL;
+
+	switch (irq) {
+	case WM8350_IRQ_CODEC_JCK_DET_L:
+		jack = &priv->hpl;
+		mask = WM8350_JACK_L_LVL;
+		break;
+
+	case WM8350_IRQ_CODEC_JCK_DET_R:
+		jack = &priv->hpr;
+		mask = WM8350_JACK_R_LVL;
+		break;
+
+	default:
+		BUG();
+	}
+
+	if (!jack->jack) {
+		dev_warn(wm8350->dev, "Jack interrupt called with no jack\n");
+		return;
+	}
+
+	/* Debounce */
+	msleep(200);
+
+	reg = wm8350_reg_read(wm8350, WM8350_JACK_PIN_STATUS);
+	if (reg & mask)
+		report = jack->report;
+	else
+		report = 0;
+
+	snd_soc_jack_report(jack->jack, report, jack->report);
+}
+
+/**
+ * wm8350_hp_jack_detect - Enable headphone jack detection.
+ *
+ * @codec:  WM8350 codec
+ * @which:  left or right jack detect signal
+ * @jack:   jack to report detection events on
+ * @report: value to report
+ *
+ * Enables the headphone jack detection of the WM8350.
+ */
+int wm8350_hp_jack_detect(struct snd_soc_codec *codec, enum wm8350_jack which,
+			  struct snd_soc_jack *jack, int report)
+{
+	struct wm8350_data *priv = codec->private_data;
+	struct wm8350 *wm8350 = codec->control_data;
+	int irq;
+	int ena;
+
+	switch (which) {
+	case WM8350_JDL:
+		priv->hpl.jack = jack;
+		priv->hpl.report = report;
+		irq = WM8350_IRQ_CODEC_JCK_DET_L;
+		ena = WM8350_JDL_ENA;
+		break;
+
+	case WM8350_JDR:
+		priv->hpr.jack = jack;
+		priv->hpr.report = report;
+		irq = WM8350_IRQ_CODEC_JCK_DET_R;
+		ena = WM8350_JDR_ENA;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	wm8350_set_bits(wm8350, WM8350_POWER_MGMT_4, WM8350_TOCLK_ENA);
+	wm8350_set_bits(wm8350, WM8350_JACK_DETECT, ena);
+
+	/* Sync status */
+	wm8350_hp_jack_handler(wm8350, irq, priv);
+
+	wm8350_unmask_irq(wm8350, irq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm8350_hp_jack_detect);
+
 static struct snd_soc_codec *wm8350_codec;
 
 static int wm8350_probe(struct platform_device *pdev)
@@ -1381,6 +1477,13 @@ static int wm8350_probe(struct platform_device *pdev)
 	wm8350_set_bits(wm8350, WM8350_ROUT2_VOLUME,
 			WM8350_OUT2_VU | WM8350_OUT2R_MUTE);
 
+	wm8350_mask_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_L);
+	wm8350_mask_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_R);
+	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_L,
+			    wm8350_hp_jack_handler, priv);
+	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_R,
+			    wm8350_hp_jack_handler, priv);
+
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to create pcms\n");
@@ -1411,8 +1514,21 @@ static int wm8350_remove(struct platform_device *pdev)
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->codec;
 	struct wm8350 *wm8350 = codec->control_data;
+	struct wm8350_data *priv = codec->private_data;
 	int ret;
 
+	wm8350_clear_bits(wm8350, WM8350_JACK_DETECT,
+			  WM8350_JDL_ENA | WM8350_JDR_ENA);
+	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_4, WM8350_TOCLK_ENA);
+
+	wm8350_mask_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_L);
+	wm8350_mask_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_R);
+	wm8350_free_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_L);
+	wm8350_free_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_R);
+
+	priv->hpl.jack = NULL;
+	priv->hpr.jack = NULL;
+
 	/* cancel any work waiting to be queued. */
 	ret = cancel_delayed_work(&codec->delayed_work);
 
diff --git a/sound/soc/codecs/wm8350.h b/sound/soc/codecs/wm8350.h
index cc2887a..d11bd92 100644
--- a/sound/soc/codecs/wm8350.h
+++ b/sound/soc/codecs/wm8350.h
@@ -17,4 +17,12 @@
 extern struct snd_soc_dai wm8350_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8350;
 
+enum wm8350_jack {
+	WM8350_JDL = 1,
+	WM8350_JDR = 2,
+};
+
+int wm8350_hp_jack_detect(struct snd_soc_codec *codec, enum wm8350_jack which,
+			  struct snd_soc_jack *jack, int report);
+
 #endif
-- 
1.5.6.5
