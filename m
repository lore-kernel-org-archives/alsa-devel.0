From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Constify reg_default tables" to the
	asoc tree
Date: Tue, 07 Jul 2015 14:57:43 +0100
Message-ID: <E1ZCTNX-0005Uk-9d@finisterre>
References: <1436089709.19902.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A324A2654DD
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:03 +0200 (CEST)
In-Reply-To: <1436089709.19902.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Peter Rosin <peda@axentia.se>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Constify reg_default tables

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

>From c418a84a8c8f98b1a0f30cd68d0cdf40d77aed01 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 5 Jul 2015 17:48:29 +0800
Subject: [PATCH] ASoC: Constify reg_default tables

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Peter Rosin <peda@axentia.se>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adav80x.c  | 2 +-
 sound/soc/codecs/alc5632.c  | 2 +-
 sound/soc/codecs/da7210.c   | 6 +++---
 sound/soc/codecs/da7213.c   | 2 +-
 sound/soc/codecs/da732x.c   | 2 +-
 sound/soc/codecs/da9055.c   | 2 +-
 sound/soc/codecs/isabelle.c | 2 +-
 sound/soc/codecs/lm49453.c  | 2 +-
 sound/soc/codecs/max9768.c  | 2 +-
 sound/soc/codecs/max9877.c  | 2 +-
 sound/soc/codecs/ml26124.c  | 2 +-
 sound/soc/codecs/rt286.c    | 4 ++--
 sound/soc/codecs/rt5651.c   | 2 +-
 sound/soc/codecs/tas2552.c  | 2 +-
 sound/soc/codecs/tfa9879.c  | 2 +-
 sound/soc/codecs/wm2200.c   | 2 +-
 sound/soc/codecs/wm8962.c   | 2 +-
 sound/soc/codecs/wm8993.c   | 4 ++--
 sound/soc/codecs/wm8996.c   | 2 +-
 sound/soc/codecs/wm9081.c   | 2 +-
 20 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index 36d8425..88fd37c 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -113,7 +113,7 @@
 
 #define ADAV80X_PLL_OUTE_SYSCLKPD(x)		BIT(2 - (x))
 
-static struct reg_default adav80x_reg_defaults[] = {
+static const struct reg_default adav80x_reg_defaults[] = {
 	{ ADAV80X_PLAYBACK_CTRL,	0x01 },
 	{ ADAV80X_AUX_IN_CTRL,		0x01 },
 	{ ADAV80X_REC_CTRL,		0x02 },
diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 607a63b..29a2645 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -35,7 +35,7 @@
 /*
  * ALC5632 register cache
  */
-static struct reg_default  alc5632_reg_defaults[] = {
+static const struct reg_default alc5632_reg_defaults[] = {
 	{   2, 0x8080 },	/* R2   - Speaker Output Volume */
 	{   4, 0x8080 },	/* R4   - Headphone Output Volume */
 	{   6, 0x8080 },	/* R6   - AUXOUT Volume */
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 21810e5..a44ead6 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -680,7 +680,7 @@ struct da7210_priv {
 	int master;
 };
 
-static struct reg_default da7210_reg_defaults[] = {
+static const struct reg_default da7210_reg_defaults[] = {
 	{ 0x00, 0x00 },
 	{ 0x01, 0x11 },
 	{ 0x03, 0x00 },
@@ -1182,7 +1182,7 @@ static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
 
 #if IS_ENABLED(CONFIG_I2C)
 
-static struct reg_default da7210_regmap_i2c_patch[] = {
+static const struct reg_default da7210_regmap_i2c_patch[] = {
 
 	/* System controller master disable */
 	{ DA7210_STARTUP1, 0x00 },
@@ -1269,7 +1269,7 @@ static struct i2c_driver da7210_i2c_driver = {
 
 #if defined(CONFIG_SPI_MASTER)
 
-static struct reg_default da7210_regmap_spi_patch[] = {
+static const struct reg_default da7210_regmap_spi_patch[] = {
 	/* Dummy read to give two pulses over nCS for SPI */
 	{ DA7210_AUX2, 0x00 },
 	{ DA7210_AUX2, 0x00 },
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 238e48a..baa36f6 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -954,7 +954,7 @@ static const struct snd_soc_dapm_route da7213_audio_map[] = {
 	{"LINE", NULL, "Lineout PGA"},
 };
 
-static struct reg_default da7213_reg_defaults[] = {
+static const struct reg_default da7213_reg_defaults[] = {
 	{ DA7213_DIG_ROUTING_DAI, 0x10 },
 	{ DA7213_SR, 0x0A },
 	{ DA7213_REFERENCES, 0x80 },
diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 2075236..b1cb465 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -43,7 +43,7 @@ struct da732x_priv {
 /*
  * da732x register cache - default settings
  */
-static struct reg_default da732x_reg_cache[] = {
+static const struct reg_default da732x_reg_cache[] = {
 	{ DA732X_REG_REF1		, 0x02 },
 	{ DA732X_REG_BIAS_EN		, 0x80 },
 	{ DA732X_REG_BIAS1		, 0x00 },
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 66bb446..925d822 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -948,7 +948,7 @@ struct da9055_priv {
 	struct da9055_platform_data *pdata;
 };
 
-static struct reg_default da9055_reg_defaults[] = {
+static const struct reg_default da9055_reg_defaults[] = {
 	{ 0x21, 0x10 },
 	{ 0x22, 0x0A },
 	{ 0x23, 0x00 },
diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index ebd9028..ac7dfe7 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -33,7 +33,7 @@
 
 
 /* Register default values for ISABELLE driver. */
-static struct reg_default isabelle_reg_defs[] = {
+static const struct reg_default isabelle_reg_defs[] = {
 	{ 0, 0x00 },
 	{ 1, 0x00 },
 	{ 2, 0x00 },
diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 6600aa0..bf77462 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -30,7 +30,7 @@
 #include <asm/div64.h>
 #include "lm49453.h"
 
-static struct reg_default lm49453_reg_defs[] = {
+static const struct reg_default lm49453_reg_defs[] = {
 	{ 0, 0x00 },
 	{ 1, 0x00 },
 	{ 2, 0x00 },
diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index e1c196a..e3ccea2 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -35,7 +35,7 @@ struct max9768 {
 	u32 flags;
 };
 
-static struct reg_default max9768_default_regs[] = {
+static const struct reg_default max9768_default_regs[] = {
 	{ 0, 0 },
 	{ 3,  MAX9768_CTRL_FILTERLESS},
 };
diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index 29549cd..8df99fb 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -22,7 +22,7 @@
 
 static struct regmap *regmap;
 
-static struct reg_default max9877_regs[] = {
+static const struct reg_default max9877_regs[] = {
 	{ 0, 0x40 },
 	{ 1, 0x00 },
 	{ 2, 0x00 },
diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index b74118e..1e8ede8 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -199,7 +199,7 @@ static const struct clk_coeff coeff_div[] = {
 	{12288000, 48000, 0xc, 0x0, 0x30, 0x0, 0x4},
 };
 
-static struct reg_default ml26124_reg[] = {
+static const struct reg_default ml26124_reg[] = {
 	/* CLOCK control Register */
 	{0x00, 0x00 },	/* Sampling Rate */
 	{0x02, 0x00},	/* PLL NL */
diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 5c43e26..7069fe8 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -38,7 +38,7 @@
 #define RT288_VENDOR_ID 0x10ec0288
 
 struct rt286_priv {
-	struct reg_default *index_cache;
+	const struct reg_default *index_cache;
 	int index_cache_size;
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
@@ -50,7 +50,7 @@ struct rt286_priv {
 	int clk_id;
 };
 
-static struct reg_default rt286_index_def[] = {
+static const struct reg_default rt286_index_def[] = {
 	{ 0x01, 0xaaaa },
 	{ 0x02, 0x8aaa },
 	{ 0x03, 0x0002 },
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index a3506e1..3ee0574 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -46,7 +46,7 @@ static const struct regmap_range_cfg rt5651_ranges[] = {
 	  .window_len = 0x1, },
 };
 
-static struct reg_default init_list[] = {
+static const struct reg_default init_list[] = {
 	{RT5651_PR_BASE + 0x3d,	0x3e00},
 };
 
diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 4f25a7d0..71cfae0 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -38,7 +38,7 @@
 
 #include "tas2552.h"
 
-static struct reg_default tas2552_reg_defs[] = {
+static const struct reg_default tas2552_reg_defs[] = {
 	{TAS2552_CFG_1, 0x22},
 	{TAS2552_CFG_3, 0x80},
 	{TAS2552_DOUT, 0x00},
diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index aab0af6..bf7596b 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -160,7 +160,7 @@ static int tfa9879_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static struct reg_default tfa9879_regs[] = {
+static const struct reg_default tfa9879_regs[] = {
 	{ TFA9879_DEVICE_CONTROL,	0x0000 }, /* 0x00 */
 	{ TFA9879_SERIAL_INTERFACE_1,	0x0a18 }, /* 0x01 */
 	{ TFA9879_PCM_IOM2_FORMAT_1,	0x0007 }, /* 0x02 */
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index c830832..01aeb75 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -166,7 +166,7 @@ static const struct wm_adsp_region wm2200_dsp2_regions[] = {
 	{ .type = WMFW_ADSP1_ZM, .base = WM2200_DSP2_ZM_BASE },
 };
 
-static struct reg_default wm2200_reg_defaults[] = {
+static const struct reg_default wm2200_reg_defaults[] = {
 	{ 0x000B, 0x0000 },   /* R11    - Tone Generator 1 */
 	{ 0x0102, 0x0000 },   /* R258   - Clocking 3 */
 	{ 0x0103, 0x0011 },   /* R259   - Clocking 4 */
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index c5748fd..8edc6d2 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -113,7 +113,7 @@ WM8962_REGULATOR_EVENT(5)
 WM8962_REGULATOR_EVENT(6)
 WM8962_REGULATOR_EVENT(7)
 
-static struct reg_default wm8962_reg[] = {
+static const struct reg_default wm8962_reg[] = {
 	{ 0, 0x009F },   /* R0     - Left Input volume */
 	{ 1, 0x049F },   /* R1     - Right Input volume */
 	{ 2, 0x0000 },   /* R2     - HPOUTL volume */
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 8a8db86..f2d5211 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -41,7 +41,7 @@ static const char *wm8993_supply_names[WM8993_NUM_SUPPLIES] = {
 	"SPKVDD",
 };
 
-static struct reg_default wm8993_reg_defaults[] = {
+static const struct reg_default wm8993_reg_defaults[] = {
 	{ 1,   0x0000 },     /* R1   - Power Management (1) */
 	{ 2,   0x6000 },     /* R2   - Power Management (2) */
 	{ 3,   0x0000 },     /* R3   - Power Management (3) */
@@ -1595,7 +1595,7 @@ static int wm8993_resume(struct snd_soc_codec *codec)
 #endif
 
 /* Tune DC servo configuration */
-static struct reg_default wm8993_regmap_patch[] = {
+static const struct reg_default wm8993_regmap_patch[] = {
 	{ 0x44, 3 },
 	{ 0x56, 3 },
 	{ 0x44, 0 },
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 3dd063f..66f32be 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -117,7 +117,7 @@ WM8996_REGULATOR_EVENT(0)
 WM8996_REGULATOR_EVENT(1)
 WM8996_REGULATOR_EVENT(2)
 
-static struct reg_default wm8996_reg[] = {
+static const struct reg_default wm8996_reg[] = {
 	{ WM8996_POWER_MANAGEMENT_1, 0x0 },
 	{ WM8996_POWER_MANAGEMENT_2, 0x0 },
 	{ WM8996_POWER_MANAGEMENT_3, 0x0 },
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 8a8b1c0..ec91ce8 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -30,7 +30,7 @@
 #include <sound/wm9081.h>
 #include "wm9081.h"
 
-static struct reg_default wm9081_reg[] = {
+static const struct reg_default wm9081_reg[] = {
 	{  2, 0x00B9 },     /* R2  - Analogue Lineout */
 	{  3, 0x00B9 },     /* R3  - Analogue Speaker PGA */
 	{  4, 0x0001 },     /* R4  - VMID Control */
-- 
2.1.4
