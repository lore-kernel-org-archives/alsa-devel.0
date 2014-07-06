From: Himangi Saraogi <himangi774@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Use devm_ functions
Date: Sun, 6 Jul 2014 12:38:00 +0530
Message-ID: <20140706070800.GA2927@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 91DF0265044
 for <alsa-devel@alsa-project.org>; Sun,  6 Jul 2014 09:08:09 +0200 (CEST)
Received: by mail-pa0-f49.google.com with SMTP id lj1so3782926pab.36
 for <alsa-devel@alsa-project.org>; Sun, 06 Jul 2014 00:08:07 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: alsa-devel@alsa-project.org

This patch introduces the use of managed interfaces like devm_kzalloc,
devm_kstrdup and devm_regulator_register and does avay with the calls to
the functions to free the allocated memory in ldo_regulator_register and
ldo_regulator_remove. The ldo_regulator_remove function is completely
removed as it is no longer required. ldo_regulator_register is called
from a probe function and on failure its value is returned as the
result.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
To send to: Liam Girdwood <lgirdwood@gmail.com>,Mark Brown <broonie@kernel.org>,Jaroslav Kysela <perex@perex.cz>,Takashi Iwai <tiwai@suse.de>,alsa-devel@alsa-project.org,linux-kernel@vger.kernel.org
 sound/soc/codecs/sgtl5000.c | 46 +++++++--------------------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 249fadb..0efd6d6 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -841,14 +841,15 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 	struct regulator_config config = { };
 
-	ldo = kzalloc(sizeof(struct ldo_regulator), GFP_KERNEL);
+	ldo = devm_kzalloc(codec->dev, sizeof(struct ldo_regulator),
+			   GFP_KERNEL);
 
 	if (!ldo)
 		return -ENOMEM;
 
-	ldo->desc.name = kstrdup(dev_name(codec->dev), GFP_KERNEL);
+	ldo->desc.name = devm_kstrdup(codec->dev, dev_name(codec->dev),
+				      GFP_KERNEL);
 	if (!ldo->desc.name) {
-		kfree(ldo);
 		dev_err(codec->dev, "failed to allocate decs name memory\n");
 		return -ENOMEM;
 	}
@@ -865,35 +866,17 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 	config.driver_data = ldo;
 	config.init_data = init_data;
 
-	ldo->dev = regulator_register(&ldo->desc, &config);
+	ldo->dev = devm_regulator_register(codec->dev, &ldo->desc, &config);
 	if (IS_ERR(ldo->dev)) {
 		int ret = PTR_ERR(ldo->dev);
 
 		dev_err(codec->dev, "failed to register regulator\n");
-		kfree(ldo->desc.name);
-		kfree(ldo);
-
 		return ret;
 	}
 	sgtl5000->ldo = ldo;
 
 	return 0;
 }
-
-static int ldo_regulator_remove(struct snd_soc_codec *codec)
-{
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
-	struct ldo_regulator *ldo = sgtl5000->ldo;
-
-	if (!ldo)
-		return 0;
-
-	regulator_unregister(ldo->dev);
-	kfree(ldo->desc.name);
-	kfree(ldo);
-
-	return 0;
-}
 #else
 static int ldo_regulator_register(struct snd_soc_codec *codec,
 				struct regulator_init_data *init_data,
@@ -902,11 +885,6 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
 	dev_err(codec->dev, "this setup needs regulator support in the kernel\n");
 	return -EINVAL;
 }
-
-static int ldo_regulator_remove(struct snd_soc_codec *codec)
-{
-	return 0;
-}
 #endif
 
 /*
@@ -1278,23 +1256,17 @@ static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
 	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
 				 sgtl5000->supplies);
 	if (ret)
-		goto err_ldo_remove;
+		return ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
 					sgtl5000->supplies);
 	if (ret)
-		goto err_ldo_remove;
+		return ret;
 
 	/* wait for all power rails bring up */
 	udelay(10);
 
 	return 0;
-
-err_ldo_remove:
-	if (!external_vddd)
-		ldo_regulator_remove(codec);
-	return ret;
-
 }
 
 static int sgtl5000_probe(struct snd_soc_codec *codec)
@@ -1359,8 +1331,6 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 err:
 	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
-	ldo_regulator_remove(codec);
-
 	return ret;
 }
 
@@ -1372,8 +1342,6 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
 
 	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
 						sgtl5000->supplies);
-	ldo_regulator_remove(codec);
-
 	return 0;
 }
 
-- 
1.9.1
