From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: wm2200: Remove empty labels
Date: Wed, 28 Nov 2012 14:45:25 +0530
Message-ID: <1354094125-4506-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BEAB261570
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 10:21:58 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so6628329pbb.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 01:21:57 -0800 (PST)
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
Cc: broonie@opensource.wolfsonmicro.com, patches@linaro.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, sachin.kamat@linaro.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Removed unnecessary labels probably left out of some previous cleanup.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/wm2200.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 1730df8..ff45b02 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2205,7 +2205,7 @@ static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(wm2200->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
 	for (i = 0; i < 2; i++) {
@@ -2238,7 +2238,7 @@ static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to request core supplies: %d\n",
 			ret);
-		goto err_regmap;
+		return ret;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm2200->core_supplies),
@@ -2246,7 +2246,7 @@ static __devinit int wm2200_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to enable core supplies: %d\n",
 			ret);
-		goto err_core;
+		return ret;
 	}
 
 	if (wm2200->pdata.ldo_ena) {
@@ -2382,9 +2382,6 @@ err_ldo:
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm2200->core_supplies),
 			       wm2200->core_supplies);
-err_core:
-err_regmap:
-err:
 	return ret;
 }
 
-- 
1.7.4.1
