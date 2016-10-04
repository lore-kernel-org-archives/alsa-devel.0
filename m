From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9712: Convert to regmap" to the asoc
	tree
Date: Tue, 04 Oct 2016 11:26:48 +0200
Message-ID: <E1brLzs-0003RX-0l@finisterre>
References: <1475256450-30612-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E8B02666B0
 for <alsa-devel@alsa-project.org>; Tue,  4 Oct 2016 11:27:16 +0200 (CEST)
In-Reply-To: <1475256450-30612-1-git-send-email-lars@metafoo.de>
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
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9712: Convert to regmap

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

>From 0e7dfbd12b81ee235cdeaee01a167738caf59774 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 30 Sep 2016 19:27:29 +0200
Subject: [PATCH] ASoC: wm9712: Convert to regmap

Currently the wm9712 driver still uses custom snd_soc_codec_driver IO
callbacks. This has been deprecated for a while, so convert the wm9712
driver to use regmap for its IO.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Marek Vasut <marex@denx.de>
Acked-by: Marek Vasut <marex@denx.de>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |   1 +
 sound/soc/codecs/wm9712.c | 143 +++++++++++++++++++++++++---------------------
 2 files changed, 79 insertions(+), 65 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c67667bb970f..f472254a575d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1057,6 +1057,7 @@ config SND_SOC_WM9705
 
 config SND_SOC_WM9712
 	tristate
+	select REGMAP_AC97
 
 config SND_SOC_WM9713
 	tristate
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 557709eac698..d2d0d2bb4412 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
@@ -32,31 +33,66 @@ struct wm9712_priv {
 	struct mutex lock;
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec,
-	unsigned int reg);
-static int ac97_write(struct snd_soc_codec *codec,
-	unsigned int reg, unsigned int val);
+static const struct reg_default wm9712_reg_defaults[] = {
+	{ 0x02, 0x8000 },
+	{ 0x04, 0x8000 },
+	{ 0x06, 0x8000 },
+	{ 0x08, 0x0f0f },
+	{ 0x0a, 0xaaa0 },
+	{ 0x0c, 0xc008 },
+	{ 0x0e, 0x6808 },
+	{ 0x10, 0xe808 },
+	{ 0x12, 0xaaa0 },
+	{ 0x14, 0xad00 },
+	{ 0x16, 0x8000 },
+	{ 0x18, 0xe808 },
+	{ 0x1a, 0x3000 },
+	{ 0x1c, 0x8000 },
+	{ 0x20, 0x0000 },
+	{ 0x22, 0x0000 },
+	{ 0x26, 0x000f },
+	{ 0x28, 0x0605 },
+	{ 0x2a, 0x0410 },
+	{ 0x2c, 0xbb80 },
+	{ 0x2e, 0xbb80 },
+	{ 0x32, 0xbb80 },
+	{ 0x34, 0x2000 },
+	{ 0x4c, 0xf83e },
+	{ 0x4e, 0xffff },
+	{ 0x50, 0x0000 },
+	{ 0x52, 0x0000 },
+	{ 0x56, 0xf83e },
+	{ 0x58, 0x0008 },
+	{ 0x5c, 0x0000 },
+	{ 0x60, 0xb032 },
+	{ 0x62, 0x3e00 },
+	{ 0x64, 0x0000 },
+	{ 0x76, 0x0006 },
+	{ 0x78, 0x0001 },
+	{ 0x7a, 0x0000 },
+};
 
-/*
- * WM9712 register cache
- */
-static const u16 wm9712_reg[] = {
-	0x6174, 0x8000, 0x8000, 0x8000, /*  6 */
-	0x0f0f, 0xaaa0, 0xc008, 0x6808, /*  e */
-	0xe808, 0xaaa0, 0xad00, 0x8000, /* 16 */
-	0xe808, 0x3000, 0x8000, 0x0000, /* 1e */
-	0x0000, 0x0000, 0x0000, 0x000f, /* 26 */
-	0x0405, 0x0410, 0xbb80, 0xbb80, /* 2e */
-	0x0000, 0xbb80, 0x0000, 0x0000, /* 36 */
-	0x0000, 0x2000, 0x0000, 0x0000, /* 3e */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 46 */
-	0x0000, 0x0000, 0xf83e, 0xffff, /* 4e */
-	0x0000, 0x0000, 0x0000, 0xf83e, /* 56 */
-	0x0008, 0x0000, 0x0000, 0x0000, /* 5e */
-	0xb032, 0x3e00, 0x0000, 0x0000, /* 66 */
-	0x0000, 0x0000, 0x0000, 0x0000, /* 6e */
-	0x0000, 0x0000, 0x0000, 0x0006, /* 76 */
-	0x0001, 0x0000, 0x574d, 0x4c12, /* 7e */
+static bool wm9712_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AC97_REC_GAIN:
+		return true;
+	default:
+		return regmap_ac97_default_volatile(dev, reg);
+	}
+}
+
+static const struct regmap_config wm9712_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.max_register = 0x7e,
+	.cache_type = REGCACHE_RBTREE,
+
+	.volatile_reg = wm9712_volatile_reg,
+
+	.reg_defaults = wm9712_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm9712_reg_defaults),
 };
 
 #define HPL_MIXER	0x0
@@ -488,35 +524,13 @@ static const struct snd_soc_dapm_route wm9712_audio_map[] = {
 static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
-	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
-	u16 *cache = codec->reg_cache;
-
-	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
-		reg == AC97_VENDOR_ID1 || reg == AC97_VENDOR_ID2 ||
-		reg == AC97_REC_GAIN)
-		return soc_ac97_ops->read(wm9712->ac97, reg);
-	else {
-		reg = reg >> 1;
-
-		if (reg >= (ARRAY_SIZE(wm9712_reg)))
-			return -EIO;
-
-		return cache[reg];
-	}
+	return snd_soc_read(codec, reg);
 }
 
 static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
-	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
-	u16 *cache = codec->reg_cache;
-
-	soc_ac97_ops->write(wm9712->ac97, reg, val);
-	reg = reg >> 1;
-	if (reg < (ARRAY_SIZE(wm9712_reg)))
-		cache[reg] = val;
-
-	return 0;
+	return snd_soc_write(codec, reg, val);
 }
 
 static int ac97_prepare(struct snd_pcm_substream *substream,
@@ -619,8 +633,7 @@ static int wm9712_set_bias_level(struct snd_soc_codec *codec,
 static int wm9712_soc_resume(struct snd_soc_codec *codec)
 {
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
-	int i, ret;
-	u16 *cache = codec->reg_cache;
+	int ret;
 
 	ret = snd_ac97_reset(wm9712->ac97, true, WM9712_VENDOR_ID,
 		WM9712_VENDOR_ID_MASK);
@@ -629,15 +642,8 @@ static int wm9712_soc_resume(struct snd_soc_codec *codec)
 
 	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	if (ret == 0) {
-		/* Sync reg_cache with the hardware after cold reset */
-		for (i = 2; i < ARRAY_SIZE(wm9712_reg) << 1; i += 2) {
-			if (i == AC97_INT_PAGING || i == AC97_POWERDOWN ||
-			    (i > 0x58 && i != 0x5c))
-				continue;
-			soc_ac97_ops->write(wm9712->ac97, i, cache[i>>1]);
-		}
-	}
+	if (ret == 0)
+		regcache_sync(codec->component.regmap);
 
 	return ret;
 }
@@ -645,6 +651,7 @@ static int wm9712_soc_resume(struct snd_soc_codec *codec)
 static int wm9712_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
+	struct regmap *regmap;
 	int ret;
 
 	wm9712->ac97 = snd_soc_new_ac97_codec(codec, WM9712_VENDOR_ID,
@@ -655,16 +662,28 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+	regmap = regmap_init_ac97(wm9712->ac97, &wm9712_regmap_config);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto err_free_ac97_codec;
+	}
+
+	snd_soc_codec_init_regmap(codec, regmap);
+
 	/* set alc mux to none */
 	ac97_write(codec, AC97_VIDEO, ac97_read(codec, AC97_VIDEO) | 0x3000);
 
 	return 0;
+err_free_ac97_codec:
+	snd_soc_free_ac97_codec(wm9712->ac97);
+	return ret;
 }
 
 static int wm9712_soc_remove(struct snd_soc_codec *codec)
 {
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 
+	snd_soc_codec_exit_regmap(codec);
 	snd_soc_free_ac97_codec(wm9712->ac97);
 	return 0;
 }
@@ -673,14 +692,8 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
 	.probe = 	wm9712_soc_probe,
 	.remove = 	wm9712_soc_remove,
 	.resume =	wm9712_soc_resume,
-	.read = ac97_read,
-	.write = ac97_write,
 	.set_bias_level = wm9712_set_bias_level,
 	.suspend_bias_off = true,
-	.reg_cache_size = ARRAY_SIZE(wm9712_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_step = 2,
-	.reg_cache_default = wm9712_reg,
 
 	.component_driver = {
 		.controls		= wm9712_snd_ac97_controls,
-- 
2.9.3
