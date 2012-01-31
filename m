From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8993: Convert to use a regmap patch
Date: Tue, 31 Jan 2012 15:21:13 +0000
Message-ID: <1328023273-5416-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D9EE103835
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 16:21:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index dd687c3..474dc72 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1077,11 +1077,6 @@ static int wm8993_set_bias_level(struct snd_soc_codec *codec,
 			regcache_cache_only(wm8993->regmap, false);
 			regcache_sync(wm8993->regmap);
 
-			/* Tune DC servo configuration */
-			snd_soc_write(codec, 0x44, 3);
-			snd_soc_write(codec, 0x56, 3);
-			snd_soc_write(codec, 0x44, 0);
-
 			/* Bring up VMID with fast soft start */
 			snd_soc_update_bits(codec, WM8993_ANTIPOP2,
 					    WM8993_STARTUP_BIAS_ENA |
@@ -1691,6 +1686,13 @@ static int wm8993_resume(struct snd_soc_codec *codec)
 #define wm8993_resume NULL
 #endif
 
+/* Tune DC servo configuration */
+static struct reg_default wm8993_regmap_patch[] = {
+	{ 0x44, 3 },
+	{ 0x56, 3 },
+	{ 0x44, 0 },
+};
+
 static const struct regmap_config wm8993_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -1769,6 +1771,12 @@ static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		goto err_enable;
 
+	ret = regmap_register_patch(wm8993->regmap, wm8993_regmap_patch,
+				    ARRAY_SIZE(wm8993_regmap_patch));
+	if (ret != 0)
+		dev_warn(wm8993->dev, "Failed to apply regmap patch: %d\n",
+			 ret);
+
 	if (i2c->irq) {
 		/* Put GPIO1 into interrupt mode (only GPIO1 can output IRQ) */
 		ret = regmap_update_bits(wm8993->regmap, WM8993_GPIO1,
-- 
1.7.9.rc1
