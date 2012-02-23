From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Convert interrupt handler to
	direct regmap usage
Date: Thu, 23 Feb 2012 21:51:21 +0000
Message-ID: <1330033881-367-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0380124142
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 22:51:28 +0100 (CET)
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

Avoids potential locking issues with anything that needs the CODEC lock.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   59 +++++++++++++++++++++++++++++---------------
 1 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 6ff7513..eb9da3a 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2981,54 +2981,73 @@ static void wm8962_mic_work(struct work_struct *work)
 
 static irqreturn_t wm8962_irq(int irq, void *data)
 {
-	struct snd_soc_codec *codec = data;
-	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	int mask;
-	int active;
-	int reg;
+	struct device *dev = data;
+	struct wm8962_priv *wm8962 = dev_get_drvdata(dev);
+	unsigned int mask;
+	unsigned int active;
+	int reg, ret;
+
+	ret = regmap_read(wm8962->regmap, WM8962_INTERRUPT_STATUS_2_MASK,
+			  &mask);
+	if (ret != 0) {
+		dev_err(dev, "Failed to read interrupt mask: %d\n",
+			ret);
+		return IRQ_NONE;
+	}
 
-	mask = snd_soc_read(codec, WM8962_INTERRUPT_STATUS_2_MASK);
+	ret = regmap_read(wm8962->regmap, WM8962_INTERRUPT_STATUS_2, &active);
+	if (ret != 0) {
+		dev_err(dev, "Failed to read interrupt: %d\n", ret);
+		return IRQ_NONE;
+	}
 
-	active = snd_soc_read(codec, WM8962_INTERRUPT_STATUS_2);
 	active &= ~mask;
 
 	if (!active)
 		return IRQ_NONE;
 
 	/* Acknowledge the interrupts */
-	snd_soc_write(codec, WM8962_INTERRUPT_STATUS_2, active);
+	ret = regmap_write(wm8962->regmap, WM8962_INTERRUPT_STATUS_2, active);
+	if (ret != 0)
+		dev_warn(dev, "Failed to ack interrupt: %d\n", ret);
 
 	if (active & WM8962_FLL_LOCK_EINT) {
-		dev_dbg(codec->dev, "FLL locked\n");
+		dev_dbg(dev, "FLL locked\n");
 		complete(&wm8962->fll_lock);
 	}
 
 	if (active & WM8962_FIFOS_ERR_EINT)
-		dev_err(codec->dev, "FIFO error\n");
+		dev_err(dev, "FIFO error\n");
 
 	if (active & WM8962_TEMP_SHUT_EINT) {
-		dev_crit(codec->dev, "Thermal shutdown\n");
+		dev_crit(dev, "Thermal shutdown\n");
 
-		reg = snd_soc_read(codec, WM8962_THERMAL_SHUTDOWN_STATUS);
+		ret = regmap_read(wm8962->regmap,
+				  WM8962_THERMAL_SHUTDOWN_STATUS,  &reg);
+		if (ret != 0) {
+			dev_warn(dev, "Failed to read thermal status: %d\n",
+				 ret);
+			reg = 0;
+		}
 
 		if (reg & WM8962_TEMP_ERR_HP)
-			dev_crit(codec->dev, "Headphone thermal error\n");
+			dev_crit(dev, "Headphone thermal error\n");
 		if (reg & WM8962_TEMP_WARN_HP)
-			dev_crit(codec->dev, "Headphone thermal warning\n");
+			dev_crit(dev, "Headphone thermal warning\n");
 		if (reg & WM8962_TEMP_ERR_SPK)
-			dev_crit(codec->dev, "Speaker thermal error\n");
+			dev_crit(dev, "Speaker thermal error\n");
 		if (reg & WM8962_TEMP_WARN_SPK)
-			dev_crit(codec->dev, "Speaker thermal warning\n");
+			dev_crit(dev, "Speaker thermal warning\n");
 	}
 
 	if (active & (WM8962_MICSCD_EINT | WM8962_MICD_EINT)) {
-		dev_dbg(codec->dev, "Microphone event detected\n");
+		dev_dbg(dev, "Microphone event detected\n");
 
 #ifndef CONFIG_SND_SOC_WM8962_MODULE
-		trace_snd_soc_jack_irq(dev_name(codec->dev));
+		trace_snd_soc_jack_irq(dev_name(dev));
 #endif
 
-		pm_wakeup_event(codec->dev, 300);
+		pm_wakeup_event(dev, 300);
 
 		schedule_delayed_work(&wm8962->mic_work,
 				      msecs_to_jiffies(250));
@@ -3534,7 +3553,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 
 		ret = request_threaded_irq(wm8962->irq, NULL, handler,
 					   trigger | IRQF_ONESHOT,
-					   "wm8962", codec);
+					   "wm8962", codec->dev);
 		if (ret != 0) {
 			dev_err(codec->dev, "Failed to request IRQ %d: %d\n",
 				wm8962->irq, ret);
-- 
1.7.9.1
