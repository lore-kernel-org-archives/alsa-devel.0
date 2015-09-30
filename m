From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH] ASoC: Codec: wm8962: balance pm_runtime_enable
Date: Wed, 30 Sep 2015 13:54:13 +0900
Message-ID: <1443588853-8778-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id A4ACC260666
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 06:54:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

pm_runtime_enable is called in probe to enable runtime PM
for wm8962 codec, but pm_runtime_disable isn't called in remove
callback, nor is called in error path if probe fails after runtime
PM is enabled, this causes unbalanced pm_runtime_enable.

This patch Adds pm_runtime_disable in remove callback and error path,
to balance pm_runtime_enable.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/codecs/wm8962.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 293e47a..2fbc6ef 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3760,7 +3760,7 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm8962, &wm8962_dai, 1);
 	if (ret < 0)
-		goto err_enable;
+		goto err_pm_runtime;
 
 	regcache_cache_only(wm8962->regmap, true);
 
@@ -3769,6 +3769,8 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 
 	return 0;
 
+err_pm_runtime:
+	pm_runtime_disable(&i2c->dev);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8962->supplies), wm8962->supplies);
 err:
@@ -3778,6 +3780,7 @@ err:
 static int wm8962_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
+	pm_runtime_disable(&client->dev);
 	return 0;
 }
 
-- 
2.4.5
