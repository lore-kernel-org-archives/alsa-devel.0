From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Implement WM8994 thermal warning and
	shutdown interrupt support
Date: Tue, 16 Aug 2011 12:06:13 +0900
Message-ID: <1313463973-23644-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B102110381D
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 10:14:42 +0200 (CEST)
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

ALSA doesn't really have good mechanisms for dealing with these so we just
log them - the hardware already has automatic shutdown support.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index a0d6274..9412491 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3045,6 +3045,24 @@ static irqreturn_t wm8994_fifo_error(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t wm8994_temp_warn(int irq, void *data)
+{
+	struct snd_soc_codec *codec = data;
+
+	dev_err(codec->dev, "Thermal warning\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t wm8994_temp_shut(int irq, void *data)
+{
+	struct snd_soc_codec *codec = data;
+
+	dev_crit(codec->dev, "Thermal shutdown\n");
+
+	return IRQ_HANDLED;
+}
+
 static int wm8994_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm8994 *control;
@@ -3123,6 +3141,10 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	wm8994_request_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR,
 			   wm8994_fifo_error, "FIFO error", codec);
+	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_TEMP_WARN,
+			   wm8994_temp_warn, "Thermal warning", codec);
+	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT,
+			   wm8994_temp_shut, "Thermal shutdown", codec);
 
 	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
 				 wm_hubs_dcs_done, "DC servo done",
@@ -3387,6 +3409,8 @@ err_irq:
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR, codec);
+	wm8994_free_irq(codec->control_data, WM8994_IRQ_TEMP_SHUT, codec);
+	wm8994_free_irq(codec->control_data, WM8994_IRQ_TEMP_WARN, codec);
 err:
 	kfree(wm8994);
 	return ret;
@@ -3409,6 +3433,8 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR, codec);
+	wm8994_free_irq(codec->control_data, WM8994_IRQ_TEMP_SHUT, codec);
+	wm8994_free_irq(codec->control_data, WM8994_IRQ_TEMP_WARN, codec);
 
 	switch (control->type) {
 	case WM8994:
-- 
1.7.5.4
