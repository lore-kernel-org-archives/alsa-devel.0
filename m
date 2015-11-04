From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9713: convert to regmap" to the asoc
	tree
Date: Wed, 04 Nov 2015 14:31:10 +0000
Message-ID: <E1Ztz5i-0002La-8U@finisterre>
References: <1446405820-24923-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CD09326574A
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:31:24 +0100 (CET)
In-Reply-To: <1446405820-24923-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9713: convert to regmap

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

>From 7cf08e6a0193cad3f15b646e1ad0e7e9b5f618f0 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 1 Nov 2015 20:23:39 +0100
Subject: [PATCH] ASoC: wm9713: convert to regmap

Convert the Wolfson WM9713 to regmap API. This will leverage all the
regmap functions (debug, registers update, etc ...).

As a bonus, this will pave the path to gpio chip introduction, and
devicetree support. This was tested on the mioa701 board, pxa27x based,
in PCM playback, and through suspend/resume.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |   1 +
 sound/soc/codecs/wm9713.c | 174 ++++++++++++++++++++++++++++------------------
 2 files changed, 108 insertions(+), 67 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0c9733e..ba306f8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -879,6 +879,7 @@ config SND_SOC_WM9712
 
 config SND_SOC_WM9713
 	tristate
+	select REGMAP_AC97
 
 # Amp
 config SND_SOC_LM4857
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 4083a51..22985c4 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
@@ -39,33 +40,15 @@ struct wm9713_priv {
 	struct mutex lock;
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec,
-	unsigned int reg);
-static int ac97_write(struct snd_soc_codec *codec,
-	unsigned int reg, unsigned int val);
-
-/*
- * WM9713 register cache
- * Reg 0x3c bit 15 is used by touch driver.
- */
-static const u16 wm9713_reg[] = {
-	0x6174, 0x8080, 0x8080, 0x8080,
-	0xc880, 0xe808, 0xe808, 0x0808,
-	0x00da, 0x8000, 0xd600, 0xaaa0,
-	0xaaa0, 0xaaa0, 0x0000, 0x0000,
-	0x0f0f, 0x0040, 0x0000, 0x7f00,
-	0x0405, 0x0410, 0xbb80, 0xbb80,
-	0x0000, 0xbb80, 0x0000, 0x4523,
-	0x0000, 0x2000, 0x7eff, 0xffff,
-	0x0000, 0x0000, 0x0080, 0x0000,
-	0x0000, 0x0000, 0xfffe, 0xffff,
-	0x0000, 0x0000, 0x0000, 0xfffe,
-	0x4000, 0x0000, 0x0000, 0x0000,
-	0xb032, 0x3e00, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0006,
-	0x0001, 0x0000, 0x574d, 0x4c13,
-};
+static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int reg)
+{
+	return snd_soc_read(codec, reg);
+}
+static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
+		      unsigned int val)
+{
+	return snd_soc_write(codec, reg, val);
+}
 
 #define HPL_MIXER 0
 #define HPR_MIXER 1
@@ -674,39 +657,97 @@ static const struct snd_soc_dapm_route wm9713_audio_map[] = {
 	{"Capture Mono Mux", "Right", "Right Capture Source"},
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec,
-	unsigned int reg)
+static bool wm9713_readable_reg(struct device *dev, unsigned int reg)
 {
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
-	u16 *cache = codec->reg_cache;
-
-	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
-		reg == AC97_VENDOR_ID1 || reg == AC97_VENDOR_ID2 ||
-		reg == AC97_CD)
-		return soc_ac97_ops->read(wm9713->ac97, reg);
-	else {
-		reg = reg >> 1;
-
-		if (reg >= (ARRAY_SIZE(wm9713_reg)))
-			return -EIO;
-
-		return cache[reg];
+	switch (reg) {
+	case AC97_RESET ... AC97_PCM_SURR_DAC_RATE:
+	case AC97_PCM_LR_ADC_RATE:
+	case AC97_CENTER_LFE_MASTER:
+	case AC97_SPDIF ... AC97_LINE1_LEVEL:
+	case AC97_GPIO_CFG ... 0x5c:
+	case AC97_CODEC_CLASS_REV ... AC97_PCI_SID:
+	case 0x74 ... AC97_VENDOR_ID2:
+		return true;
+	default:
+		return false;
 	}
 }
 
-static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int val)
+static bool wm9713_writeable_reg(struct device *dev, unsigned int reg)
 {
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	switch (reg) {
+	case AC97_VENDOR_ID1:
+	case AC97_VENDOR_ID2:
+		return false;
+	default:
+		return wm9713_readable_reg(dev, reg);
+	}
+}
 
-	u16 *cache = codec->reg_cache;
-	soc_ac97_ops->write(wm9713->ac97, reg, val);
-	reg = reg >> 1;
-	if (reg < (ARRAY_SIZE(wm9713_reg)))
-		cache[reg] = val;
+static const struct reg_default wm9713_reg_defaults[] = {
+	{ 0x02, 0x8080 },	/* Speaker Output Volume */
+	{ 0x04, 0x8080 },	/* Headphone Output Volume */
+	{ 0x06, 0x8080 },	/* Out3/OUT4 Volume */
+	{ 0x08, 0xc880 },	/* Mono Volume */
+	{ 0x0a, 0xe808 },	/* LINEIN Volume */
+	{ 0x0c, 0xe808 },	/* DAC PGA Volume */
+	{ 0x0e, 0x0808 },	/* MIC PGA Volume */
+	{ 0x10, 0x00da },	/* MIC Routing Control */
+	{ 0x12, 0x8000 },	/* Record PGA Volume */
+	{ 0x14, 0xd600 },	/* Record Routing */
+	{ 0x16, 0xaaa0 },	/* PCBEEP Volume */
+	{ 0x18, 0xaaa0 },	/* VxDAC Volume */
+	{ 0x1a, 0xaaa0 },	/* AUXDAC Volume */
+	{ 0x1c, 0x0000 },	/* Output PGA Mux */
+	{ 0x1e, 0x0000 },	/* DAC 3D control */
+	{ 0x20, 0x0f0f },	/* DAC Tone Control*/
+	{ 0x22, 0x0040 },	/* MIC Input Select & Bias */
+	{ 0x24, 0x0000 },	/* Output Volume Mapping & Jack */
+	{ 0x26, 0x7f00 },	/* Powerdown Ctrl/Stat*/
+	{ 0x28, 0x0405 },	/* Extended Audio ID */
+	{ 0x2a, 0x0410 },	/* Extended Audio Start/Ctrl */
+	{ 0x2c, 0xbb80 },	/* Audio DACs Sample Rate */
+	{ 0x2e, 0xbb80 },	/* AUXDAC Sample Rate */
+	{ 0x32, 0xbb80 },	/* Audio ADCs Sample Rate */
+	{ 0x36, 0x4523 },	/* PCM codec control */
+	{ 0x3a, 0x2000 },	/* SPDIF control */
+	{ 0x3c, 0xfdff },	/* Powerdown 1 */
+	{ 0x3e, 0xffff },	/* Powerdown 2 */
+	{ 0x40, 0x0000 },	/* General Purpose */
+	{ 0x42, 0x0000 },	/* Fast Power-Up Control */
+	{ 0x44, 0x0080 },	/* MCLK/PLL Control */
+	{ 0x46, 0x0000 },	/* MCLK/PLL Control */
+	{ 0x4c, 0xfffe },	/* GPIO Pin Configuration */
+	{ 0x4e, 0xffff },	/* GPIO Pin Polarity / Type */
+	{ 0x50, 0x0000 },	/* GPIO Pin Sticky */
+	{ 0x52, 0x0000 },	/* GPIO Pin Wake-Up */
+				/* GPIO Pin Status */
+	{ 0x56, 0xfffe },	/* GPIO Pin Sharing */
+	{ 0x58, 0x4000 },	/* GPIO PullUp/PullDown */
+	{ 0x5a, 0x0000 },	/* Additional Functions 1 */
+	{ 0x5c, 0x0000 },	/* Additional Functions 2 */
+	{ 0x60, 0xb032 },	/* ALC Control */
+	{ 0x62, 0x3e00 },	/* ALC / Noise Gate Control */
+	{ 0x64, 0x0000 },	/* AUXDAC input control */
+	{ 0x74, 0x0000 },	/* Digitiser Reg 1 */
+	{ 0x76, 0x0006 },	/* Digitiser Reg 2 */
+	{ 0x78, 0x0001 },	/* Digitiser Reg 3 */
+	{ 0x7a, 0x0000 },	/* Digitiser Read Back */
+};
 
-	return 0;
-}
+static const struct regmap_config wm9713_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.max_register = 0x7e,
+	.cache_type = REGCACHE_RBTREE,
+
+	.reg_defaults = wm9713_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm9713_reg_defaults),
+	.volatile_reg = regmap_ac97_default_volatile,
+	.readable_reg = wm9713_readable_reg,
+	.writeable_reg = wm9713_writeable_reg,
+};
 
 /* PLL divisors */
 struct _pll_div {
@@ -1173,8 +1214,7 @@ static int wm9713_soc_suspend(struct snd_soc_codec *codec)
 static int wm9713_soc_resume(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
-	int i, ret;
-	u16 *cache = codec->reg_cache;
+	int ret;
 
 	ret = snd_ac97_reset(wm9713->ac97, true, WM9713_VENDOR_ID,
 		WM9713_VENDOR_ID_MASK);
@@ -1189,12 +1229,8 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 
 	/* only synchronise the codec if warm reset failed */
 	if (ret == 0) {
-		for (i = 2; i < ARRAY_SIZE(wm9713_reg) << 1; i += 2) {
-			if (i == AC97_POWERDOWN || i == AC97_EXTENDED_MID ||
-				i == AC97_EXTENDED_MSTATUS || i > 0x66)
-				continue;
-			soc_ac97_ops->write(wm9713->ac97, i, cache[i>>1]);
-		}
+		regcache_mark_dirty(codec->component.regmap);
+		snd_soc_cache_sync(codec);
 	}
 
 	return ret;
@@ -1203,6 +1239,7 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	struct regmap *regmap;
 	int reg;
 
 	wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
@@ -1210,6 +1247,14 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	if (IS_ERR(wm9713->ac97))
 		return PTR_ERR(wm9713->ac97);
 
+	regmap = devm_regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
+	if (IS_ERR(regmap)) {
+		snd_soc_free_ac97_codec(wm9713->ac97);
+		return PTR_ERR(regmap);
+	}
+
+	snd_soc_codec_init_regmap(codec, regmap);
+
 	/* unmute the adc - move to kcontrol */
 	reg = ac97_read(codec, AC97_CD) & 0x7fff;
 	ac97_write(codec, AC97_CD, reg);
@@ -1221,6 +1266,7 @@ static int wm9713_soc_remove(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 
+	snd_soc_codec_exit_regmap(codec);
 	snd_soc_free_ac97_codec(wm9713->ac97);
 	return 0;
 }
@@ -1230,13 +1276,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
 	.remove = 	wm9713_soc_remove,
 	.suspend =	wm9713_soc_suspend,
 	.resume = 	wm9713_soc_resume,
-	.read = ac97_read,
-	.write = ac97_write,
 	.set_bias_level = wm9713_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm9713_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_step = 2,
-	.reg_cache_default = wm9713_reg,
 
 	.controls = wm9713_snd_ac97_controls,
 	.num_controls = ARRAY_SIZE(wm9713_snd_ac97_controls),
-- 
2.6.1
