From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] soc: remove driver_data direct access of
	struct device
Date: Mon, 11 May 2009 21:57:08 +0200
Message-ID: <4A088314.1000204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 3626D2440C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 21:57:09 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4064765ewy.32
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 12:57:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 510efa6..e4547de 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1473,8 +1473,8 @@ static int wm8400_codec_probe(struct platform_device *dev)
 
 	codec = &priv->codec;
 	codec->private_data = priv;
-	codec->control_data = dev->dev.driver_data;
-	priv->wm8400 = dev->dev.driver_data;
+	codec->control_data = dev_get_drvdata(&dev->dev);
+	priv->wm8400 = dev_get_drvdata(&dev->dev);
 
 	ret = regulator_bulk_get(priv->wm8400->dev,
 				 ARRAY_SIZE(power), &power[0]);
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index e043e3f..7a20587 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -666,14 +666,14 @@ static int __devinit wm8731_spi_probe(struct spi_device *spi)
 	codec->hw_write = (hw_write_t)wm8731_spi_write;
 	codec->dev = &spi->dev;
 
-	spi->dev.driver_data = wm8731;
+	dev_set_drvdata(&spi->dev, wm8731);
 
 	return wm8731_register(wm8731);
 }
 
 static int __devexit wm8731_spi_remove(struct spi_device *spi)
 {
-	struct wm8731_priv *wm8731 = spi->dev.driver_data;
+	struct wm8731_priv *wm8731 = dev_get_drvdata(&spi->dev);
 
 	wm8731_unregister(wm8731);
 
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index a6e8f3f..d121e58 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1822,14 +1822,14 @@ static int __devinit wm8753_spi_probe(struct spi_device *spi)
 	codec->hw_write = (hw_write_t)wm8753_spi_write;
 	codec->dev = &spi->dev;
 
-	spi->dev.driver_data = wm8753;
+	dev_set_drvdata(&spi->dev, wm8753);
 
 	return wm8753_register(wm8753);
 }
 
 static int __devexit wm8753_spi_remove(struct spi_device *spi)
 {
-	struct wm8753_priv *wm8753 = spi->dev.driver_data;
+	struct wm8753_priv *wm8753 = dev_get_drvdata(&spi->dev);
 	wm8753_unregister(wm8753);
 	return 0;
 }
