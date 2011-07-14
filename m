From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Log WM8994 FIFO errors from the interrupt
Date: Thu, 14 Jul 2011 12:39:21 +0900
Message-ID: <1310614761-27770-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D785D103994
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jul 2011 09:15:58 +0200 (CEST)
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

We should spot them anyway on state changes but logging them gives us
better time information about when the misconfiguration happened.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index fcd067f..d774fd7a 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2894,6 +2894,15 @@ out:
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t wm8994_fifo_error(int irq, void *data)
+{
+	struct snd_soc_codec *codec = data;
+
+	dev_err(codec->dev, "FIFO error\n");
+
+	return IRQ_HANDLED;
+}
+
 static int wm8994_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm8994 *control;
@@ -2973,6 +2982,9 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
+	wm8994_request_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR,
+			   wm8994_fifo_error, "FIFO error", codec);
+
 	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
 				 wm_hubs_dcs_done, "DC servo done",
 				 &wm8994->hubs);
@@ -3255,6 +3267,7 @@ err_irq:
 				&wm8994->fll_locked[i]);
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
+	wm8994_free_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR, codec);
 err:
 	kfree(wm8994);
 	return ret;
@@ -3276,6 +3289,7 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
+	wm8994_free_irq(codec->control_data, WM8994_IRQ_FIFOS_ERR, codec);
 
 	switch (control->type) {
 	case WM8994:
-- 
1.7.5.4
