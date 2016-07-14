From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RESEND] ASoC: rt5514-spi: Convert to use devm_*
	API
Date: Thu, 14 Jul 2016 16:57:05 +0800
Message-ID: <1468486625.10067.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
 [209.85.220.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C18D1266EEB
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 10:57:12 +0200 (CEST)
Received: by mail-pa0-f65.google.com with SMTP id q2so4323714pap.0
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 01:57:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use devm_* API to simplify the code.
This patch also fixes the return value in probe error paths.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5514-spi.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 8a9382e..e1b326d 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -409,33 +409,21 @@ static int rt5514_spi_probe(struct spi_device *spi)
 
 	rt5514_spi = spi;
 
-	ret = snd_soc_register_platform(&spi->dev, &rt5514_spi_platform);
+	ret = devm_snd_soc_register_platform(&spi->dev, &rt5514_spi_platform);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to register platform.\n");
-		goto err_plat;
+		return ret;
 	}
 
-	ret = snd_soc_register_component(&spi->dev, &rt5514_spi_dai_component,
-					 &rt5514_spi_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+					      &rt5514_spi_dai_component,
+					      &rt5514_spi_dai, 1);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to register component.\n");
-		goto err_comp;
+		return ret;
 	}
 
 	return 0;
-err_comp:
-	snd_soc_unregister_platform(&spi->dev);
-err_plat:
-
-	return 0;
-}
-
-static int rt5514_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_component(&spi->dev);
-	snd_soc_unregister_platform(&spi->dev);
-
-	return 0;
 }
 
 static const struct of_device_id rt5514_of_match[] = {
@@ -450,7 +438,6 @@ static struct spi_driver rt5514_spi_driver = {
 		.of_match_table = of_match_ptr(rt5514_of_match),
 	},
 	.probe = rt5514_spi_probe,
-	.remove = rt5514_spi_remove,
 };
 module_spi_driver(rt5514_spi_driver);
 
-- 
2.5.0
