From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm0010: Move resource acquisition to
	device probe
Date: Sat, 25 Aug 2012 13:04:33 -0700
Message-ID: <1345925073-16529-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FF82265DC7
 for <alsa-devel@alsa-project.org>; Sat, 25 Aug 2012 22:04:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is more idimatic for modern drivers. Also fix a couple of return
codes while we're at it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c |   54 ++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 30ec0bd..5f99148 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -799,14 +799,35 @@ static irqreturn_t wm0010_irq(int irq, void *data)
 static int wm0010_probe(struct snd_soc_codec *codec)
 {
 	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
-	struct spi_device *spi = to_spi_device(wm0010->dev);
+
+	wm0010->codec = codec;
+
+	return 0;
+}
+
+static int __devinit wm0010_spi_probe(struct spi_device *spi)
+{
 	unsigned long flags;
 	unsigned long gpio_flags;
 	int ret;
 	int trigger;
 	int irq;
+	struct wm0010_priv *wm0010;
 
-	wm0010->codec = codec;
+	wm0010 = devm_kzalloc(&spi->dev, sizeof(*wm0010),
+			      GFP_KERNEL);
+	if (!wm0010)
+		return -ENOMEM;
+
+	mutex_init(&wm0010->lock);
+	spin_lock_init(&wm0010->irq_lock);
+
+	spi_set_drvdata(spi, wm0010);
+	wm0010->dev = &spi->dev;
+
+	if (dev_get_platdata(&spi->dev))
+		memcpy(&wm0010->pdata, dev_get_platdata(&spi->dev),
+		       sizeof(wm0010->pdata));
 
 	init_completion(&wm0010->boot_completion);
 
@@ -850,7 +871,7 @@ static int wm0010_probe(struct snd_soc_codec *codec)
 		}
 	} else {
 		dev_err(wm0010->dev, "No reset GPIO configured\n");
-		return ret;
+		return -EINVAL;
 	}
 
 	irq = spi->irq;
@@ -862,9 +883,11 @@ static int wm0010_probe(struct snd_soc_codec *codec)
 
 	ret = request_threaded_irq(irq, NULL, wm0010_irq, trigger,
 				   "wm0010", wm0010);
-	if (ret)
+	if (ret) {
 		dev_err(wm0010->dev, "Failed to request IRQ %d: %d\n",
 			irq, ret);
+		return ret;
+	}
 	wm0010->irq = irq;
 
 	if (spi->max_speed_hz)
@@ -876,29 +899,6 @@ static int wm0010_probe(struct snd_soc_codec *codec)
 	wm0010->state = WM0010_POWER_OFF;
 	spin_unlock_irqrestore(&wm0010->irq_lock, flags);
 
-	return 0;
-}
-
-static int __devinit wm0010_spi_probe(struct spi_device *spi)
-{
-	struct wm0010_priv *wm0010;
-	int ret;
-
-	wm0010 = devm_kzalloc(&spi->dev, sizeof(*wm0010),
-			      GFP_KERNEL);
-	if (!wm0010)
-		return -ENOMEM;
-
-	mutex_init(&wm0010->lock);
-	spin_lock_init(&wm0010->irq_lock);
-
-	spi_set_drvdata(spi, wm0010);
-	wm0010->dev = &spi->dev;
-
-	if (dev_get_platdata(&spi->dev))
-		memcpy(&wm0010->pdata, dev_get_platdata(&spi->dev),
-		       sizeof(wm0010->pdata));
-
 	ret = snd_soc_register_codec(&spi->dev,
 				     &soc_codec_dev_wm0010, wm0010_dai,
 				     ARRAY_SIZE(wm0010_dai));
-- 
1.7.10.4
