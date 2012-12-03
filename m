From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: da7210: Remove unnecessary
	regmap_exit call
Date: Mon,  3 Dec 2012 13:43:43 +0530
Message-ID: <1354522423-28874-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B190A2615DC
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 09:20:33 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so1540235pbb.38
 for <alsa-devel@alsa-project.org>; Mon, 03 Dec 2012 00:20:32 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: patches@linaro.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, sachin.kamat@linaro.org, dchen@diasemi.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Use of devm_regmap_init_spi does not require an explicit
regmap_exit call.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/da7210.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index ab1ee5b..843c1eb 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1337,24 +1337,15 @@ static int __devinit da7210_spi_probe(struct spi_device *spi)
 	if (ret != 0)
 		dev_warn(&spi->dev, "Failed to apply regmap patch: %d\n", ret);
 
-	ret =  snd_soc_register_codec(&spi->dev,
+	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_da7210, &da7210_dai, 1);
-	if (ret < 0)
-		goto err_regmap;
-
-	return ret;
-
-err_regmap:
-	regmap_exit(da7210->regmap);
 
 	return ret;
 }
 
 static int __devexit da7210_spi_remove(struct spi_device *spi)
 {
-	struct da7210_priv *da7210 = spi_get_drvdata(spi);
 	snd_soc_unregister_codec(&spi->dev);
-	regmap_exit(da7210->regmap);
 	return 0;
 }
 
-- 
1.7.4.1
