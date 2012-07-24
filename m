From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Hold runtime PM reference while
	handling mic and jack IRQs
Date: Tue, 24 Jul 2012 15:49:49 +0100
Message-ID: <1343141389-18860-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E33072652AD
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 16:56:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girwdood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensures that we don't interact badly with the power management framework,
especially in the cases where we're doing deferred work or we're using a
direct GPIO for these signals.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 09f3d2a..1abf279 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3262,10 +3262,13 @@ static void wm8994_mic_work(struct work_struct *work)
 	int ret;
 	int report;
 
+	pm_runtime_get_sync(dev);
+
 	ret = regmap_read(regmap, WM8994_INTERRUPT_RAW_STATUS_2, &reg);
 	if (ret < 0) {
 		dev_err(dev, "Failed to read microphone status: %d\n",
 			ret);
+		pm_runtime_put(dev);
 		return;
 	}
 
@@ -3308,6 +3311,8 @@ static void wm8994_mic_work(struct work_struct *work)
 
 	snd_soc_jack_report(priv->micdet[1].jack, report,
 			    SND_JACK_HEADSET | SND_JACK_BTN_0);
+
+	pm_runtime_put(dev);
 }
 
 static irqreturn_t wm8994_mic_irq(int irq, void *data)
@@ -3430,12 +3435,15 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	int reg;
 	bool present;
 
+	pm_runtime_get_sync(codec->dev);
+
 	mutex_lock(&wm8994->accdet_lock);
 
 	reg = snd_soc_read(codec, WM1811_JACKDET_CTRL);
 	if (reg < 0) {
 		dev_err(codec->dev, "Failed to read jack status: %d\n", reg);
 		mutex_unlock(&wm8994->accdet_lock);
+		pm_runtime_put(codec->dev);
 		return IRQ_NONE;
 	}
 
@@ -3500,6 +3508,7 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 				    SND_JACK_MECHANICAL | SND_JACK_HEADSET |
 				    wm8994->btn_mask);
 
+	pm_runtime_put(codec->dev);
 	return IRQ_HANDLED;
 }
 
@@ -3611,6 +3620,8 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 	if (!(snd_soc_read(codec, WM8958_MIC_DETECT_1) & WM8958_MICD_ENA))
 		return IRQ_HANDLED;
 
+	pm_runtime_get_sync(codec->dev);
+
 	/* We may occasionally read a detection without an impedence
 	 * range being provided - if that happens loop again.
 	 */
@@ -3621,6 +3632,7 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 			dev_err(codec->dev,
 				"Failed to read mic detect status: %d\n",
 				reg);
+			pm_runtime_put(codec->dev);
 			return IRQ_NONE;
 		}
 
@@ -3648,6 +3660,7 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 		dev_warn(codec->dev, "Accessory detection with no callback\n");
 
 out:
+	pm_runtime_put(codec->dev);
 	return IRQ_HANDLED;
 }
 
-- 
1.7.10.4
