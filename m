From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: wm9705: Convert to regmap
Date: Fri, 21 Oct 2016 10:27:07 +0200
Message-ID: <1477038428-4480-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 700EA267167
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 10:27:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently the wm9712 driver still uses custom snd_soc_codec_driver IO
callbacks. This has been deprecated for a while, so convert the wm9705
driver to use regmap for its IO.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Untested, but same changes as for all the other AC97 drivers, so hopefully
it will just work.
---
 sound/soc/codecs/Kconfig  |   1 +
 sound/soc/codecs/wm9705.c | 123 ++++++++++++++++++++++++----------------------
 2 files changed, 64 insertions(+), 60 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 091c0f0..a92ea7c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1059,6 +1059,7 @@ config SND_SOC_WM9090
 
 config SND_SOC_WM9705
 	tristate
+	select REGMAP_AC97
 
 config SND_SOC_WM9712
 	tristate
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index dcdd055..70ab607 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
@@ -25,26 +26,48 @@
 #define WM9705_VENDOR_ID 0x574d4c05
 #define WM9705_VENDOR_ID_MASK 0xffffffff
 
-/*
- * WM9705 register cache
- */
-static const u16 wm9705_reg[] = {
-	0x6150, 0x8000, 0x8000, 0x8000, /* 0x0  */
-	0x0000, 0x8000, 0x8008, 0x8008, /* 0x8  */
-	0x8808, 0x8808, 0x8808, 0x8808, /* 0x10 */
-	0x8808, 0x0000, 0x8000, 0x0000, /* 0x18 */
-	0x0000, 0x0000, 0x0000, 0x000f, /* 0x20 */
-	0x0605, 0x0000, 0xbb80, 0x0000, /* 0x28 */
-	0x0000, 0xbb80, 0x0000, 0x0000, /* 0x30 */
-	0x0000, 0x2000, 0x0000, 0x0000, /* 0x38 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 0x40 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 0x48 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 0x50 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 0x58 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 0x60 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 0x68 */
-	0x0000, 0x0808, 0x0000, 0x0006, /* 0x70 */
-	0x0000, 0x0000, 0x574d, 0x4c05, /* 0x78 */
+static const struct reg_default wm9705_reg_defaults[] = {
+	{ 0x02, 0x8000 },
+	{ 0x04, 0x8000 },
+	{ 0x06, 0x8000 },
+	{ 0x0a, 0x8000 },
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
+	{ 0x26, 0x000f },
+	{ 0x28, 0x0605 },
+	{ 0x2a, 0x0000 },
+	{ 0x2c, 0xbb80 },
+	{ 0x32, 0xbb80 },
+	{ 0x34, 0x2000 },
+	{ 0x5a, 0x0000 },
+	{ 0x5c, 0x0000 },
+	{ 0x72, 0x0808 },
+	{ 0x74, 0x0000 },
+	{ 0x76, 0x0006 },
+	{ 0x78, 0x0000 },
+	{ 0x7a, 0x0000 },
+};
+
+static const struct regmap_config wm9705_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.max_register = 0x7e,
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = regmap_ac97_default_volatile,
+
+	.reg_defaults = wm9705_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm9705_reg_defaults),
 };
 
 static const struct snd_kcontrol_new wm9705_snd_ac97_controls[] = {
@@ -203,39 +226,15 @@ static const struct snd_soc_dapm_route wm9705_audio_map[] = {
 	{"Right ADC", NULL, "ADC PGA"},
 };
 
-/* We use a register cache to enhance read performance. */
 static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int reg)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
-	u16 *cache = codec->reg_cache;
-
-	switch (reg) {
-	case AC97_RESET:
-	case AC97_VENDOR_ID1:
-	case AC97_VENDOR_ID2:
-		return soc_ac97_ops->read(ac97, reg);
-	default:
-		reg = reg >> 1;
-
-		if (reg >= (ARRAY_SIZE(wm9705_reg)))
-			return -EIO;
-
-		return cache[reg];
-	}
+	return snd_soc_read(codec, reg);
 }
 
 static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
-	u16 *cache = codec->reg_cache;
-
-	soc_ac97_ops->write(ac97, reg, val);
-	reg = reg >> 1;
-	if (reg < (ARRAY_SIZE(wm9705_reg)))
-		cache[reg] = val;
-
-	return 0;
+	return snd_soc_write(codec, reg, val);
 }
 
 static int ac97_prepare(struct snd_pcm_substream *substream,
@@ -299,9 +298,9 @@ static struct snd_soc_dai_driver wm9705_dai[] = {
 #ifdef CONFIG_PM
 static int wm9705_soc_suspend(struct snd_soc_codec *codec)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
-
-	soc_ac97_ops->write(ac97, AC97_POWERDOWN, 0xffff);
+	regcache_cache_bypass(codec->component.regmap, true);
+	ac97_write(codec, AC97_POWERDOWN, 0xffff);
+	regcache_cache_bypass(codec->component.regmap, false);
 
 	return 0;
 }
@@ -309,17 +308,14 @@ static int wm9705_soc_suspend(struct snd_soc_codec *codec)
 static int wm9705_soc_resume(struct snd_soc_codec *codec)
 {
 	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
-	int i, ret;
-	u16 *cache = codec->reg_cache;
+	int ret;
 
 	ret = snd_ac97_reset(ac97, true, WM9705_VENDOR_ID,
 		WM9705_VENDOR_ID_MASK);
 	if (ret < 0)
 		return ret;
 
-	for (i = 2; i < ARRAY_SIZE(wm9705_reg) << 1; i += 2) {
-		soc_ac97_ops->write(ac97, i, cache[i>>1]);
-	}
+	regcache_sync(codec->component.regmap);
 
 	return 0;
 }
@@ -331,6 +327,8 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 static int wm9705_soc_probe(struct snd_soc_codec *codec)
 {
 	struct snd_ac97 *ac97;
+	struct regmap *regmap;
+	int ret;
 
 	ac97 = snd_soc_new_ac97_codec(codec, WM9705_VENDOR_ID,
 		WM9705_VENDOR_ID_MASK);
@@ -339,15 +337,26 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 		return PTR_ERR(ac97);
 	}
 
+	regmap = regmap_init_ac97(ac97, &wm9705_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto err_free_ac97_codec;
+	}
+
 	snd_soc_codec_set_drvdata(codec, ac97);
+	snd_soc_codec_init_regmap(codec, regmap);
 
 	return 0;
+err_free_ac97_codec:
+	snd_soc_free_ac97_codec(ac97);
+	return ret;
 }
 
 static int wm9705_soc_remove(struct snd_soc_codec *codec)
 {
 	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 
+	snd_soc_codec_exit_regmap(codec);
 	snd_soc_free_ac97_codec(ac97);
 	return 0;
 }
@@ -357,12 +366,6 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
 	.remove = 	wm9705_soc_remove,
 	.suspend =	wm9705_soc_suspend,
 	.resume =	wm9705_soc_resume,
-	.read = ac97_read,
-	.write = ac97_write,
-	.reg_cache_size = ARRAY_SIZE(wm9705_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_step = 2,
-	.reg_cache_default = wm9705_reg,
 
 	.component_driver = {
 		.controls		= wm9705_snd_ac97_controls,
-- 
2.1.4
