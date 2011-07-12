From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Implement DC servo completion IRQ
	handling for wm_hubs devices
Date: Tue, 12 Jul 2011 16:59:18 +0900
Message-ID: <1310457559-30789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6CEE924473
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 09:59:34 +0200 (CEST)
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

The individual devices should set the flag dcs_done_irq in the hubs
shared data structure to indicate that they will flag the interrupt
by calling wm_hubs_dcs_done().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |   34 +++++++++++++++++++++++++++++-----
 sound/soc/codecs/wm_hubs.h |    8 ++++++++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 7e60e22..5c2d565 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -63,9 +63,11 @@ static const struct soc_enum speaker_mode =
 
 static void wait_for_dc_servo(struct snd_soc_codec *codec, unsigned int op)
 {
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg;
 	int count = 0;
 	unsigned int val;
+	unsigned long timeout;
 
 	val = op | WM8993_DCS_ENA_CHAN_0 | WM8993_DCS_ENA_CHAN_1;
 
@@ -74,18 +76,37 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, unsigned int op)
 
 	dev_dbg(codec->dev, "Waiting for DC servo...\n");
 
-	do {
-		count++;
-		msleep(1);
+	if (hubs->dcs_done_irq) {
+		timeout = wait_for_completion_timeout(&hubs->dcs_done,
+						      msecs_to_jiffies(500));
+		if (timeout == 0)
+			dev_warn(codec->dev, "No DC servo interrupt\n");
+
 		reg = snd_soc_read(codec, WM8993_DC_SERVO_0);
-		dev_dbg(codec->dev, "DC servo: %x\n", reg);
-	} while (reg & op && count < 400);
+	} else {
+		do {
+			count++;
+			msleep(1);
+			reg = snd_soc_read(codec, WM8993_DC_SERVO_0);
+			dev_dbg(codec->dev, "DC servo: %x\n", reg);
+		} while (reg & op && count < 400);
+	}
 
 	if (reg & op)
 		dev_err(codec->dev, "Timed out waiting for DC Servo %x\n",
 			op);
 }
 
+irqreturn_t wm_hubs_dcs_done(int irq, void *data)
+{
+	struct wm_hubs_data *hubs = data;
+
+	complete(&hubs->dcs_done);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(wm_hubs_dcs_done);
+
 /*
  * Startup calibration of the DC servo
  */
@@ -863,8 +884,11 @@ EXPORT_SYMBOL_GPL(wm_hubs_add_analogue_controls);
 int wm_hubs_add_analogue_routes(struct snd_soc_codec *codec,
 				int lineout1_diff, int lineout2_diff)
 {
+	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
+	init_completion(&hubs->dcs_done);
+
 	snd_soc_dapm_add_routes(dapm, analogue_routes,
 				ARRAY_SIZE(analogue_routes));
 
diff --git a/sound/soc/codecs/wm_hubs.h b/sound/soc/codecs/wm_hubs.h
index 0d290d2..676b125 100644
--- a/sound/soc/codecs/wm_hubs.h
+++ b/sound/soc/codecs/wm_hubs.h
@@ -14,6 +14,9 @@
 #ifndef _WM_HUBS_H
 #define _WM_HUBS_H
 
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+
 struct snd_soc_codec;
 
 extern const unsigned int wm_hubs_spkmix_tlv[];
@@ -28,6 +31,9 @@ struct wm_hubs_data {
 
 	bool class_w;
 	u16 class_w_dcs;
+
+	bool dcs_done_irq;
+	struct completion dcs_done;
 };
 
 extern int wm_hubs_add_analogue_controls(struct snd_soc_codec *);
@@ -38,4 +44,6 @@ extern int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *,
 					 int jd_scthr, int jd_thr,
 					 int micbias1_lvl, int micbias2_lvl);
 
+extern irqreturn_t wm_hubs_dcs_done(int irq, void *data);
+
 #endif
-- 
1.7.5.4
