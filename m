From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8350: Don't use irq_base
Date: Sun, 13 May 2012 23:53:18 +0100
Message-ID: <1336949598-6710-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59214103FBC
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 00:53:26 +0200 (CEST)
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

In preparation for irq_domain support change the code to the not switch
based on the irq number. This actually makes things simpler, if slightly
repetitive.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.c |   46 ++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 8006149..8cee548 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1291,35 +1291,36 @@ static void wm8350_hpr_work(struct work_struct *work)
 	wm8350_hp_work(priv, &priv->hpr, WM8350_JACK_R_LVL);
 }
 
-static irqreturn_t wm8350_hp_jack_handler(int irq, void *data)
+static irqreturn_t wm8350_hpl_jack_handler(int irq, void *data)
 {
 	struct wm8350_data *priv = data;
 	struct wm8350 *wm8350 = priv->wm8350;
-	struct wm8350_jack_data *jack = NULL;
 
-	switch (irq - wm8350->irq_base) {
-	case WM8350_IRQ_CODEC_JCK_DET_L:
 #ifndef CONFIG_SND_SOC_WM8350_MODULE
-		trace_snd_soc_jack_irq("WM8350 HPL");
+	trace_snd_soc_jack_irq("WM8350 HPL");
 #endif
-		jack = &priv->hpl;
-		break;
 
-	case WM8350_IRQ_CODEC_JCK_DET_R:
+	if (device_may_wakeup(wm8350->dev))
+		pm_wakeup_event(wm8350->dev, 250);
+
+	schedule_delayed_work(&priv->hpl.work, 200);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t wm8350_hpr_jack_handler(int irq, void *data)
+{
+	struct wm8350_data *priv = data;
+	struct wm8350 *wm8350 = priv->wm8350;
+
 #ifndef CONFIG_SND_SOC_WM8350_MODULE
-		trace_snd_soc_jack_irq("WM8350 HPR");
+	trace_snd_soc_jack_irq("WM8350 HPR");
 #endif
-		jack = &priv->hpr;
-		break;
-
-	default:
-		BUG();
-	}
 
 	if (device_may_wakeup(wm8350->dev))
 		pm_wakeup_event(wm8350->dev, 250);
 
-	schedule_delayed_work(&jack->work, 200);
+	schedule_delayed_work(&priv->hpr.work, 200);
 
 	return IRQ_HANDLED;
 }
@@ -1370,7 +1371,14 @@ int wm8350_hp_jack_detect(struct snd_soc_codec *codec, enum wm8350_jack which,
 	}
 
 	/* Sync status */
-	wm8350_hp_jack_handler(irq + wm8350->irq_base, priv);
+	switch (which) {
+	case WM8350_JDL:
+		wm8350_hpl_jack_handler(0, priv);
+		break;
+	case WM8350_JDR:
+		wm8350_hpr_jack_handler(0, priv);
+		break;
+	}
 
 	return 0;
 }
@@ -1554,10 +1562,10 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 			  WM8350_JDL_ENA | WM8350_JDR_ENA);
 
 	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_L,
-			    wm8350_hp_jack_handler, 0, "Left jack detect",
+			    wm8350_hpl_jack_handler, 0, "Left jack detect",
 			    priv);
 	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_JCK_DET_R,
-			    wm8350_hp_jack_handler, 0, "Right jack detect",
+			    wm8350_hpr_jack_handler, 0, "Right jack detect",
 			    priv);
 	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_MICSCD,
 			    wm8350_mic_handler, 0, "Microphone short", priv);
-- 
1.7.10
