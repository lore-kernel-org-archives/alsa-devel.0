From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm8994: Add debounce to wm8994 mic
	detection
Date: Wed,  9 May 2012 19:30:25 +0100
Message-ID: <1336588226-32725-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82E90103FDC
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 20:30:34 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   27 ++++++++++++++++++++-------
 sound/soc/codecs/wm8994.h |    2 ++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index dfc4e90..93d81a9 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3227,22 +3227,20 @@ int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 }
 EXPORT_SYMBOL_GPL(wm8994_mic_detect);
 
-static irqreturn_t wm8994_mic_irq(int irq, void *data)
+static void wm8994_mic_work(struct work_struct *work)
 {
-	struct wm8994_priv *priv = data;
+	struct wm8994_priv *priv = container_of(work,
+						struct wm8994_priv,
+						mic_work.work);
 	struct snd_soc_codec *codec = priv->codec;
 	int reg;
 	int report;
 
-#ifndef CONFIG_SND_SOC_WM8994_MODULE
-	trace_snd_soc_jack_irq(dev_name(codec->dev));
-#endif
-
 	reg = snd_soc_read(codec, WM8994_INTERRUPT_RAW_STATUS_2);
 	if (reg < 0) {
 		dev_err(codec->dev, "Failed to read microphone status: %d\n",
 			reg);
-		return IRQ_HANDLED;
+		return;
 	}
 
 	dev_dbg(codec->dev, "Microphone status: %x\n", reg);
@@ -3284,6 +3282,20 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 
 	snd_soc_jack_report(priv->micdet[1].jack, report,
 			    SND_JACK_HEADSET | SND_JACK_BTN_0);
+}
+
+static irqreturn_t wm8994_mic_irq(int irq, void *data)
+{
+	struct wm8994_priv *priv = data;
+	struct snd_soc_codec *codec = priv->codec;
+
+#ifndef CONFIG_SND_SOC_WM8994_MODULE
+	trace_snd_soc_jack_irq(dev_name(codec->dev));
+#endif
+
+	pm_wakeup_event(codec->dev, 300);
+
+	schedule_delayed_work(&priv->mic_work, msecs_to_jiffies(250));
 
 	return IRQ_HANDLED;
 }
@@ -3656,6 +3668,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	wm8994->codec = codec;
 
 	mutex_init(&wm8994->accdet_lock);
+	INIT_DELAYED_WORK(&wm8994->mic_work, wm8994_mic_work);
 
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
 		init_completion(&wm8994->fll_locked[i]);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 91650bb..d77e06f 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -12,6 +12,7 @@
 #include <sound/soc.h>
 #include <linux/firmware.h>
 #include <linux/completion.h>
+#include <linux/workqueue.h>
 
 #include "wm_hubs.h"
 
@@ -127,6 +128,7 @@ struct wm8994_priv {
 
 	struct mutex accdet_lock;
 	struct wm8994_micdet micdet[2];
+	struct delayed_work mic_work;
 	bool mic_detecting;
 	bool jack_mic;
 	int btn_mask;
-- 
1.7.10
