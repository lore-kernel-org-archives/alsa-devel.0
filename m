From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use WM8994 FLL lock interrupt
Date: Tue, 12 Jul 2011 20:43:23 +0900
Message-ID: <1310471003-15107-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C0F7247C9
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 16:56:40 +0200 (CEST)
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

If we have interrupts then wait for the FLL lock interrupt rather than
using dead reckoning when waiting for the FLL to start.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   40 +++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm8994.h |    3 +++
 2 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index d2dcaa2..f89ae47 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1635,6 +1635,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	int reg_offset, ret;
 	struct fll_div fll;
 	u16 reg, aif1, aif2;
+	unsigned long timeout;
 
 	aif1 = snd_soc_read(codec, WM8994_AIF1_CLOCKING_1)
 		& WM8994_AIF1CLK_ENA;
@@ -1726,7 +1727,15 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 				    WM8994_FLL1_ENA | WM8994_FLL1_FRAC,
 				    reg);
 
-		msleep(5);
+		if (wm8994->fll_locked_irq) {
+			timeout = wait_for_completion_timeout(&wm8994->fll_locked[id],
+							      msecs_to_jiffies(10));
+			if (timeout == 0)
+				dev_warn(codec->dev,
+					 "Timed out waiting for FLL lock\n");
+		} else {
+			msleep(5);
+		}
 	}
 
 	wm8994->fll[id].in = freq_in;
@@ -1744,6 +1753,14 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	return 0;
 }
 
+static irqreturn_t wm8994_fll_locked_irq(int irq, void *data)
+{
+	struct completion *completion = data;
+
+	complete(completion);
+
+	return IRQ_HANDLED;
+}
 
 static int opclk_divs[] = { 10, 20, 30, 40, 55, 60, 80, 120, 160 };
 
@@ -2879,6 +2896,9 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	wm8994->pdata = dev_get_platdata(codec->dev->parent);
 	wm8994->codec = codec;
 
+	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
+		init_completion(&wm8994->fll_locked[i]);
+
 	if (wm8994->pdata && wm8994->pdata->micdet_irq)
 		wm8994->micdet_irq = wm8994->pdata->micdet_irq;
 	else if (wm8994->pdata && wm8994->pdata->irq_base)
@@ -2994,6 +3014,16 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		}
 	}
 
+	wm8994->fll_locked_irq = true;
+	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++) {
+		ret = wm8994_request_irq(codec->control_data,
+					 WM8994_IRQ_FLL1_LOCK + i,
+					 wm8994_fll_locked_irq, "FLL lock",
+					 &wm8994->fll_locked[i]);
+		if (ret != 0)
+			wm8994->fll_locked_irq = false;
+	}
+
 	/* Remember if AIFnLRCLK is configured as a GPIO.  This should be
 	 * configured on init - if a system wants to do this dynamically
 	 * at runtime we can deal with that then.
@@ -3179,6 +3209,9 @@ err_irq:
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT, wm8994);
 	if (wm8994->micdet_irq)
 		free_irq(wm8994->micdet_irq, wm8994);
+	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
+		wm8994_free_irq(codec->control_data, WM8994_IRQ_FLL1_LOCK + i,
+				&wm8994->fll_locked[i]);
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
 err:
@@ -3190,11 +3223,16 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = codec->control_data;
+	int i;
 
 	wm8994_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	pm_runtime_disable(codec->dev);
 
+	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
+		wm8994_free_irq(codec->control_data, WM8994_IRQ_FLL1_LOCK + i,
+				&wm8994->fll_locked[i]);
+
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_DCS_DONE,
 			&wm8994->hubs);
 
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 0a1db04..1ab2266 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -11,6 +11,7 @@
 
 #include <sound/soc.h>
 #include <linux/firmware.h>
+#include <linux/completion.h>
 
 #include "wm_hubs.h"
 
@@ -79,6 +80,8 @@ struct wm8994_priv {
 	int mclk[2];
 	int aifclk[2];
 	struct wm8994_fll_config fll[2], fll_suspend[2];
+	struct completion fll_locked[2];
+	bool fll_locked_irq;
 
 	int dac_rates[2];
 	int lrclk_shared[2];
-- 
1.7.5.4
