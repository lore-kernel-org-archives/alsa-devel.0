From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Use delayed work to debounce WM8350
	jack IRQs
Date: Wed, 22 Dec 2010 00:09:18 +0000
Message-ID: <1292976559-11466-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EF165103B10
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 01:09:14 +0100 (CET)
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

This avoids blocking the IRQ thread and allows further bounces to extend
the debounce time.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.c |   62 +++++++++++++++++++++++++++++++-------------
 1 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 07ba7e3..3e0362e 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -53,6 +53,7 @@ struct wm8350_output {
 
 struct wm8350_jack_data {
 	struct snd_soc_jack *jack;
+	struct delayed_work work;
 	int report;
 	int short_report;
 };
@@ -1335,45 +1336,63 @@ static int wm8350_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static irqreturn_t wm8350_hp_jack_handler(int irq, void *data)
+static void wm8350_hp_work(struct wm8350_data *priv,
+			   struct wm8350_jack_data *jack,
+			   u16 mask)
 {
-	struct wm8350_data *priv = data;
 	struct wm8350 *wm8350 = priv->codec.control_data;
 	u16 reg;
 	int report;
-	int mask;
+
+	reg = wm8350_reg_read(wm8350, WM8350_JACK_PIN_STATUS);
+	if (reg & mask)
+		report = jack->report;
+	else
+		report = 0;
+
+	snd_soc_jack_report(jack->jack, report, jack->report);
+
+}
+
+static void wm8350_hpl_work(struct work_struct *work)
+{
+	struct wm8350_data *priv =
+	    container_of(work, struct wm8350_data, hpl.work.work);
+
+	wm8350_hp_work(priv, &priv->hpl, WM8350_JACK_L_LVL);
+}
+
+static void wm8350_hpr_work(struct work_struct *work)
+{
+	struct wm8350_data *priv =
+	    container_of(work, struct wm8350_data, hpr.work.work);
+	
+	wm8350_hp_work(priv, &priv->hpr, WM8350_JACK_R_LVL);
+}
+
+static irqreturn_t wm8350_hp_jack_handler(int irq, void *data)
+{
+	struct wm8350_data *priv = data;
+	struct wm8350 *wm8350 = priv->codec.control_data;
 	struct wm8350_jack_data *jack = NULL;
 
 	switch (irq - wm8350->irq_base) {
 	case WM8350_IRQ_CODEC_JCK_DET_L:
 		jack = &priv->hpl;
-		mask = WM8350_JACK_L_LVL;
 		break;
 
 	case WM8350_IRQ_CODEC_JCK_DET_R:
 		jack = &priv->hpr;
-		mask = WM8350_JACK_R_LVL;
 		break;
 
 	default:
 		BUG();
 	}
 
-	if (!jack->jack) {
-		dev_warn(wm8350->dev, "Jack interrupt called with no jack\n");
-		return IRQ_NONE;
-	}
+	if (device_may_wakeup(wm8350->dev))
+		pm_wakeup_event(wm8350->dev, 250);
 
-	/* Debounce */
-	msleep(200);
-
-	reg = wm8350_reg_read(wm8350, WM8350_JACK_PIN_STATUS);
-	if (reg & mask)
-		report = jack->report;
-	else
-		report = 0;
-
-	snd_soc_jack_report(jack->jack, report, jack->report);
+	schedule_delayed_work(&jack->work, 200);
 
 	return IRQ_HANDLED;
 }
@@ -1552,6 +1571,8 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
 	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8350_pga_work);
+	INIT_DELAYED_WORK(&priv->hpl.work, wm8350_hpl_work);
+	INIT_DELAYED_WORK(&priv->hpr.work, wm8350_hpr_work);
 
 	/* Enable the codec */
 	wm8350_set_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
@@ -1641,6 +1662,9 @@ static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 	priv->hpr.jack = NULL;
 	priv->mic.jack = NULL;
 
+	cancel_delayed_work_sync(&priv->hpl.work);
+	cancel_delayed_work_sync(&priv->hpr.work);
+
 	/* if there was any work waiting then we run it now and
 	 * wait for its completion */
 	flush_delayed_work_sync(&codec->dapm.delayed_work);
-- 
1.7.2.3
