From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stac9766: Convert to regmap" to the
	asoc tree
Date: Fri, 04 Nov 2016 12:16:07 -0600
Message-ID: <E1c2j27-00084l-Jg@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A17952674DD
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 19:16:25 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stac9766: Convert to regmap

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6bbf787bb70c8a16509a2d51182423a6f6977742 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 4 Nov 2016 18:26:56 +0100
Subject: [PATCH] ASoC: stac9766: Convert to regmap

Currently the stac9766 driver still uses custom snd_soc_codec_driver IO
callbacks. This has been deprecated for a while, so convert the stac9766
driver to use regmap for its IO.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/stac9766.c | 108 ++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 49 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index f675d343b529..62cbeedf93b9 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
@@ -33,26 +34,49 @@
 #define AC97_STAC_ANALOG_SPECIAL 0x6E
 #define AC97_STAC_STEREO_MIC 0x78
 
-/*
- * STAC9766 register cache
- */
-static const u16 stac9766_reg[] = {
-	0x6A90, 0x8000, 0x8000, 0x8000, /* 6 */
-	0x0000, 0x0000, 0x8008, 0x8008, /* e */
-	0x8808, 0x8808, 0x8808, 0x8808, /* 16 */
-	0x8808, 0x0000, 0x8000, 0x0000, /* 1e */
-	0x0000, 0x0000, 0x0000, 0x000f, /* 26 */
-	0x0a05, 0x0400, 0xbb80, 0x0000, /* 2e */
-	0x0000, 0xbb80, 0x0000, 0x0000, /* 36 */
-	0x0000, 0x2000, 0x0000, 0x0100, /* 3e */
-	0x0000, 0x0000, 0x0080, 0x0000, /* 46 */
-	0x0000, 0x0000, 0x0003, 0xffff, /* 4e */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 56 */
-	0x4000, 0x0000, 0x0000, 0x0000, /* 5e */
-	0x1201, 0x0000, 0x0000, 0x0000, /* 66 */
-	0x0000, 0x0000, 0x0000, 0x1000, /* 6e */
-	0x0000, 0x0000, 0x0000, 0x0006, /* 76 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 7e */
+static const struct reg_default stac9766_reg_defaults[] = {
+	{ 0x02, 0x8000 },
+	{ 0x04, 0x8000 },
+	{ 0x06, 0x8000 },
+	{ 0x0a, 0x0000 },
+	{ 0x0c, 0x8008 },
+	{ 0x0e, 0x8008 },
+	{ 0x10, 0x8808 },
+	{ 0x12, 0x8808 },
+	{ 0x14, 0x8808 },
+	{ 0x16, 0x8808 },
+	{ 0x18, 0x8808 },
+	{ 0x1a, 0x0000 },
+	{ 0x1c, 0x8000 },
+	{ 0x20, 0x0000 },
+	{ 0x22, 0x0000 },
+	{ 0x28, 0x0a05 },
+	{ 0x2c, 0xbb80 },
+	{ 0x32, 0xbb80 },
+	{ 0x3a, 0x2000 },
+	{ 0x3e, 0x0100 },
+	{ 0x4c, 0x0300 },
+	{ 0x4e, 0xffff },
+	{ 0x50, 0x0000 },
+	{ 0x52, 0x0000 },
+	{ 0x54, 0x0000 },
+	{ 0x6a, 0x0000 },
+	{ 0x6e, 0x1000 },
+	{ 0x72, 0x0000 },
+	{ 0x78, 0x0000 },
+};
+
+static const struct regmap_config stac9766_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.max_register = 0x78,
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = regmap_ac97_default_volatile,
+
+	.reg_defaults = stac9766_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(stac9766_reg_defaults),
 };
 
 static const char *stac9766_record_mux[] = {"Mic", "CD", "Video", "AUX",
@@ -144,34 +168,13 @@ static const struct snd_kcontrol_new stac9766_snd_ac97_controls[] = {
 static int stac9766_ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 			       unsigned int val)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
-	u16 *cache = codec->reg_cache;
-
-	if (reg / 2 >= ARRAY_SIZE(stac9766_reg))
-		return -EIO;
-
-	soc_ac97_ops->write(ac97, reg, val);
-	cache[reg / 2] = val;
-	return 0;
+	return snd_soc_write(codec, reg, val);
 }
 
 static unsigned int stac9766_ac97_read(struct snd_soc_codec *codec,
 				       unsigned int reg)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
-	u16 val = 0, *cache = codec->reg_cache;
-
-	if (reg / 2 >= ARRAY_SIZE(stac9766_reg))
-		return -EIO;
-
-	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
-		reg == AC97_INT_PAGING || reg == AC97_VENDOR_ID1 ||
-		reg == AC97_VENDOR_ID2) {
-
-		val = soc_ac97_ops->read(ac97, reg);
-		return val;
-	}
-	return cache[reg / 2];
+	return snd_soc_read(codec, reg);
 }
 
 static int ac97_analog_prepare(struct snd_pcm_substream *substream,
@@ -290,21 +293,34 @@ static struct snd_soc_dai_driver stac9766_dai[] = {
 static int stac9766_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_ac97 *ac97;
+	struct regmap *regmap;
+	int ret;
 
 	ac97 = snd_soc_new_ac97_codec(codec, STAC9766_VENDOR_ID,
 			STAC9766_VENDOR_ID_MASK);
 	if (IS_ERR(ac97))
 		return PTR_ERR(ac97);
 
+	regmap = regmap_init_ac97(ac97, &stac9766_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto err_free_ac97;
+	}
+
+	snd_soc_codec_init_regmap(codec, regmap);
 	snd_soc_codec_set_drvdata(codec, ac97);
 
 	return 0;
+err_free_ac97:
+	snd_soc_free_ac97_codec(ac97);
+	return ret;
 }
 
 static int stac9766_codec_remove(struct snd_soc_codec *codec)
 {
 	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 
+	snd_soc_codec_exit_regmap(codec);
 	snd_soc_free_ac97_codec(ac97);
 	return 0;
 }
@@ -314,17 +330,11 @@ static struct snd_soc_codec_driver soc_codec_dev_stac9766 = {
 		.controls		= stac9766_snd_ac97_controls,
 		.num_controls		= ARRAY_SIZE(stac9766_snd_ac97_controls),
 	},
-	.write = stac9766_ac97_write,
-	.read = stac9766_ac97_read,
 	.set_bias_level = stac9766_set_bias_level,
 	.suspend_bias_off = true,
 	.probe = stac9766_codec_probe,
 	.remove = stac9766_codec_remove,
 	.resume = stac9766_codec_resume,
-	.reg_cache_size = ARRAY_SIZE(stac9766_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_step = 2,
-	.reg_cache_default = stac9766_reg,
 };
 
 static int stac9766_probe(struct platform_device *pdev)
-- 
2.10.1
