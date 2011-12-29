From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 11/14] ASoC: Convert tlv320aic26 to
	devm_kzalloc()
Date: Thu, 29 Dec 2011 12:08:36 +0800
Message-ID: <1325131716.19977.15.camel@phoenix>
References: <1325130983.19977.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 401BF24655
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 05:08:43 +0100 (CET)
Received: by ggnv5 with SMTP id v5so8433369ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 20:08:42 -0800 (PST)
In-Reply-To: <1325130983.19977.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320aic26.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 86d1fa3..a038dae 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -416,7 +416,7 @@ static int aic26_spi_probe(struct spi_device *spi)
 	dev_dbg(&spi->dev, "probing tlv320aic26 spi device\n");
 
 	/* Allocate driver data */
-	aic26 = kzalloc(sizeof *aic26, GFP_KERNEL);
+	aic26 = devm_kzalloc(&spi->dev, sizeof *aic26, GFP_KERNEL);
 	if (!aic26)
 		return -ENOMEM;
 
@@ -427,18 +427,12 @@ static int aic26_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&aic26_soc_codec_dev, &aic26_dai, 1);
-	if (ret < 0)
-		kfree(aic26);
 	return ret;
-
-	dev_dbg(&spi->dev, "SPI device initialized\n");
-	return 0;
 }
 
 static int aic26_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
-- 
1.7.5.4
