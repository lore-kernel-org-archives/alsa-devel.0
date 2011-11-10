From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Move WM5100 platform data based setup
	into I2C probe
Date: Thu, 10 Nov 2011 16:15:40 +0000
Message-ID: <1320941740-29084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4DDD324396
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 17:15:44 +0100 (CET)
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

Get things configured as early as possible, especially useful for the
GPIOs which might be useful anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index f72de26..03cb0b0 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2580,24 +2580,6 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 		snd_soc_update_bits(codec, wm5100_dig_vu[i], WM5100_OUT_VU,
 				    WM5100_OUT_VU);
 
-	for (i = 0; i < ARRAY_SIZE(wm5100->pdata.in_mode); i++) {
-		snd_soc_update_bits(codec, WM5100_IN1L_CONTROL,
-				    WM5100_IN1_MODE_MASK |
-				    WM5100_IN1_DMIC_SUP_MASK,
-				    (wm5100->pdata.in_mode[i] <<
-				     WM5100_IN1_MODE_SHIFT) |
-				    (wm5100->pdata.dmic_sup[i] <<
-				     WM5100_IN1_DMIC_SUP_SHIFT));
-	}
-
-	for (i = 0; i < ARRAY_SIZE(wm5100->pdata.gpio_defaults); i++) {
-		if (!wm5100->pdata.gpio_defaults[i])
-			continue;
-
-		snd_soc_write(codec, WM5100_GPIO_CTRL_1 + i,
-			      wm5100->pdata.gpio_defaults[i]);
-	}
-
 	/* Don't debounce interrupts to support use of SYSCLK only */
 	snd_soc_write(codec, WM5100_IRQ_DEBOUNCE_1, 0);
 	snd_soc_write(codec, WM5100_IRQ_DEBOUNCE_2, 0);
@@ -2862,6 +2844,24 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 
 	wm5100_init_gpio(i2c);
 
+	for (i = 0; i < ARRAY_SIZE(wm5100->pdata.gpio_defaults); i++) {
+		if (!wm5100->pdata.gpio_defaults[i])
+			continue;
+
+		regmap_write(wm5100->regmap, WM5100_GPIO_CTRL_1 + i,
+			     wm5100->pdata.gpio_defaults[i]);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(wm5100->pdata.in_mode); i++) {
+		regmap_update_bits(wm5100->regmap, WM5100_IN1L_CONTROL,
+				   WM5100_IN1_MODE_MASK |
+				   WM5100_IN1_DMIC_SUP_MASK,
+				   (wm5100->pdata.in_mode[i] <<
+				    WM5100_IN1_MODE_SHIFT) |
+				   (wm5100->pdata.dmic_sup[i] <<
+				    WM5100_IN1_DMIC_SUP_SHIFT));
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm5100, wm5100_dai,
 				     ARRAY_SIZE(wm5100_dai));
-- 
1.7.7.2
