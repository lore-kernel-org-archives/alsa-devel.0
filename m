From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/5] ASoC: Convert ak4104 to devm_kzalloc()
Date: Tue, 20 Dec 2011 14:37:12 +0800
Message-ID: <1324363032.5632.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 54D7B10388C
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 07:37:24 +0100 (CET)
Received: by ghrr11 with SMTP id r11so4015744ghr.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 22:37:23 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@caiaq.de>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/ak4104.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 152420c..d27b5e4 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -261,7 +261,8 @@ static int ak4104_spi_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	ak4104 = kzalloc(sizeof(struct ak4104_private), GFP_KERNEL);
+	ak4104 = devm_kzalloc(&spi->dev, sizeof(struct ak4104_private),
+			      GFP_KERNEL);
 	if (ak4104 == NULL)
 		return -ENOMEM;
 
@@ -271,15 +272,12 @@ static int ak4104_spi_probe(struct spi_device *spi)
 
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_device_ak4104, &ak4104_dai, 1);
-	if (ret < 0)
-		kfree(ak4104);
 	return ret;
 }
 
 static int __devexit ak4104_spi_remove(struct spi_device *spi)
 {
 	snd_soc_unregister_codec(&spi->dev);
-	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
-- 
1.7.5.4
