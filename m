From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: cs42xx8: Move the code checking
 *regmap argument earlier
Date: Thu, 25 Jun 2015 21:41:43 +0800
Message-ID: <1435239703.22170.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 36B80260577
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 15:41:53 +0200 (CEST)
Received: by pabvl15 with SMTP id vl15so50280815pab.1
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 06:41:49 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Slightly improve the readability by moving the code checking *regmap
argument earlier. Also move the assignment of of_id close to the place
testing it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42xx8.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index e1d4686..ab39514 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -435,16 +435,24 @@ EXPORT_SYMBOL_GPL(cs42xx8_of_match);
 
 int cs42xx8_probe(struct device *dev, struct regmap *regmap)
 {
-	const struct of_device_id *of_id = of_match_device(cs42xx8_of_match, dev);
+	const struct of_device_id *of_id;
 	struct cs42xx8_priv *cs42xx8;
 	int ret, val, i;
 
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(dev, "failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
 	cs42xx8 = devm_kzalloc(dev, sizeof(*cs42xx8), GFP_KERNEL);
 	if (cs42xx8 == NULL)
 		return -ENOMEM;
 
+	cs42xx8->regmap = regmap;
 	dev_set_drvdata(dev, cs42xx8);
 
+	of_id = of_match_device(cs42xx8_of_match, dev);
 	if (of_id)
 		cs42xx8->drvdata = of_id->data;
 
@@ -482,13 +490,6 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap)
 	/* Make sure hardware reset done */
 	msleep(5);
 
-	cs42xx8->regmap = regmap;
-	if (IS_ERR(cs42xx8->regmap)) {
-		ret = PTR_ERR(cs42xx8->regmap);
-		dev_err(dev, "failed to allocate regmap: %d\n", ret);
-		goto err_enable;
-	}
-
 	/*
 	 * We haven't marked the chip revision as volatile due to
 	 * sharing a register with the right input volume; explicitly
-- 
2.1.0
