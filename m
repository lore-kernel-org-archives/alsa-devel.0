From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Support FLL lock interrupt on WM8962
Date: Mon, 25 Apr 2011 18:28:07 +0100
Message-ID: <1303752487-21607-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6300243FD
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Apr 2011 19:28:00 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 500011e..d6b78b2 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -58,6 +58,7 @@ struct wm8962_priv {
 	int bclk;  /* Desired BCLK */
 	int lrclk;
 
+	struct completion fll_lock;
 	int fll_src;
 	int fll_fref;
 	int fll_fout;
@@ -3178,6 +3179,7 @@ static int wm8962_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	struct _fll_div fll_div;
+	unsigned long timeout;
 	int ret;
 	int fll1 = snd_soc_read(codec, WM8962_FLL_CONTROL_1) & WM8962_FLL_ENA;
 
@@ -3244,6 +3246,11 @@ static int wm8962_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 
 	dev_dbg(codec->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
 
+	/* This should be a massive overestimate */
+	timeout = msecs_to_jiffies(1);
+
+	wait_for_completion_timeout(&wm8962->fll_lock, timeout);
+
 	wm8962->fll_fref = Fref;
 	wm8962->fll_fout = Fout;
 	wm8962->fll_src = source;
@@ -3340,6 +3347,11 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 	active = snd_soc_read(codec, WM8962_INTERRUPT_STATUS_2);
 	active &= ~mask;
 
+	if (active & WM8962_FLL_LOCK_EINT) {
+		dev_dbg(codec->dev, "FLL locked\n");
+		complete(&wm8962->fll_lock);
+	}
+
 	if (active & WM8962_FIFOS_ERR_EINT)
 		dev_err(codec->dev, "FIFO error\n");
 
@@ -3712,6 +3724,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 
 	wm8962->codec = codec;
 	INIT_DELAYED_WORK(&wm8962->mic_work, wm8962_mic_work);
+	init_completion(&wm8962->fll_lock);
 
 	codec->cache_sync = 1;
 	codec->dapm.idle_bias_off = 1;
@@ -3868,9 +3881,10 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 				i2c->irq, ret);
 			/* Non-fatal */
 		} else {
-			/* Enable error reporting IRQs by default */
+			/* Enable some IRQs by default */
 			snd_soc_update_bits(codec,
 					    WM8962_INTERRUPT_STATUS_2_MASK,
+					    WM8962_FLL_LOCK_EINT |
 					    WM8962_TEMP_SHUT_EINT |
 					    WM8962_FIFOS_ERR_EINT, 0);
 		}
-- 
1.7.4.1
