From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: tas2552: Return proper error for probe
	error paths
Date: Wed, 23 Jul 2014 16:42:21 +0800
Message-ID: <1406104941.666.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 69017265635
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 10:42:29 +0200 (CEST)
Received: by mail-pa0-f54.google.com with SMTP id fa1so1319856pad.27
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 01:42:26 -0700 (PDT)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Dan Murphy <dmurphy@ti.com>
List-Id: alsa-devel@alsa-project.org

Return error if devm_regulator_bulk_get() or snd_soc_register_codec() fails.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/tas2552.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index f0760af..05f3737 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -480,8 +480,10 @@ static int tas2552_probe(struct i2c_client *client,
 
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
 				      data->supplies);
-	if (ret != 0)
+	if (ret != 0) {
 		dev_err(dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
 
 	pm_runtime_set_active(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
@@ -498,7 +500,7 @@ static int tas2552_probe(struct i2c_client *client,
 	if (ret < 0)
 		dev_err(&client->dev, "Failed to register codec: %d\n", ret);
 
-	return 0;
+	return ret;
 }
 
 static int tas2552_i2c_remove(struct i2c_client *client)
-- 
1.9.1
