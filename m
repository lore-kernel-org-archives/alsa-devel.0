From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Optimise power consumption for
	IN4 DC measurement usage
Date: Tue, 24 Jan 2012 21:17:00 +0000
Message-ID: <1327439820-28465-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D26C103B28
	for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2012 22:17:07 +0100 (CET)
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

When the hardware is configured with one or both of the IN4 inputs used
for DC measurement (with no DC blocking capacitor connected) then we can
improve power consumption slightly in idle modes by applying a register
write sequence. Provide platform data to enable this, implemented using
a regmap patch.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/wm8962.h    |    6 ++++++
 sound/soc/codecs/wm8962.c |   18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/include/sound/wm8962.h b/include/sound/wm8962.h
index f131cd2..39477a7 100644
--- a/include/sound/wm8962.h
+++ b/include/sound/wm8962.h
@@ -50,6 +50,12 @@ struct wm8962_pdata {
 	bool irq_edge;
 
 	bool spk_mono;   /* Speaker outputs tied together as mono */
+
+	/**
+	 * This flag should be set if one or both IN4 inputs is wired
+	 * in a DC measurement configuration.
+	 */
+	bool in4_dc_measure;
 };
 
 #endif
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 9faef60..f1fd630 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3668,6 +3668,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8962 = {
 	.volatile_register = wm8962_soc_volatile,
 };
 
+/* Improve power consumption for IN4 DC measurement mode */
+static const struct reg_default wm8962_dc_measure[] = {
+	{ 0xfd, 0x1 },
+	{ 0xcc, 0x40 },
+	{ 0xfd, 0 },
+};
+
 static const struct regmap_config wm8962_regmap = {
 	.reg_bits = 16,
 	.val_bits = 16,
@@ -3683,6 +3690,7 @@ static const struct regmap_config wm8962_regmap = {
 static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
+	struct wm8962_pdata *pdata = dev_get_platdata(&i2c->dev);
 	struct wm8962_priv *wm8962;
 	unsigned int reg;
 	int ret, i;
@@ -3761,6 +3769,16 @@ static __devinit int wm8962_i2c_probe(struct i2c_client *i2c,
 		goto err_regmap;
 	}
 
+	if (pdata && pdata->in4_dc_measure) {
+		ret = regmap_register_patch(wm8962->regmap,
+					    wm8962_dc_measure,
+					    ARRAY_SIZE(wm8962_dc_measure));
+		if (ret != 0)
+			dev_err(&i2c->dev,
+				"Failed to configure for DC mesurement: %d\n",
+				ret);
+	}
+
 	regcache_cache_only(wm8962->regmap, true);
 
 	ret = snd_soc_register_codec(&i2c->dev,
-- 
1.7.9.rc1
