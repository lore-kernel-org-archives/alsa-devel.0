From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98383: fix i2c probe failure" to the asoc tree
Date: Mon, 22 Jul 2019 13:22:06 +0100 (BST)
Message-ID: <20190722122206.EEFF22742C38@ypsilon.sirena.org.uk>
References: <20190715095556.1614-1-chunguo.feng@amlogic.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715095556.1614-1-chunguo.feng@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: alsa-devel@alsa-project.org, bleung@chromium.org, broonie@kernel.org, chunguo.feng@amlogic.com, grundler@chromium.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, pierre-louis.bossart@linux.intel.com, RyanS.Lee@maximintegrated.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98383: fix i2c probe failure

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 1eac7bb88ae5a4c45283de1dc1f93e9da9278a7f Mon Sep 17 00:00:00 2001
From: fengchunguo <chunguo.feng@amlogic.com>
Date: Mon, 15 Jul 2019 17:55:56 +0800
Subject: [PATCH] ASoC: max98383: fix i2c probe failure

Added reset_gpio configuration for i2c probe successfully.
If not,i2c address can't be found rightly.

Error information:
max98373 3-0031: Failed to read: 0x21FF

Fixed:
[3.761299@3] max98373 3-0031: MAX98373 revisionID: 0x43
[3.828911@3] asoc-aml-card auge_sound: max98373-aif1 <-> TDM-B mapping ok

Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
Link: https://lore.kernel.org/r/20190715095556.1614-1-chunguo.feng@amlogic.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 34 ++++++++++++++++++++++++++++++----
 sound/soc/codecs/max98373.h |  1 +
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 528695cd6a1c..9a1eb7222357 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -12,6 +12,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <sound/tlv.h>
 #include "max98373.h"
@@ -895,6 +896,17 @@ static void max98373_slot_config(struct i2c_client *i2c,
 	else
 		max98373->i_slot = 1;
 
+	max98373->reset_gpio = of_get_named_gpio(dev->of_node,
+						"maxim,reset-gpio", 0);
+	if (!gpio_is_valid(max98373->reset_gpio)) {
+		dev_err(dev, "Looking up %s property in node %s failed %d\n",
+			"maxim,reset-gpio", dev->of_node->full_name,
+			max98373->reset_gpio);
+	} else {
+		dev_dbg(dev, "maxim,reset-gpio=%d",
+			max98373->reset_gpio);
+	}
+
 	if (!device_property_read_u32(dev, "maxim,spkfb-slot-no", &value))
 		max98373->spkfb_slot = value & 0xF;
 	else
@@ -923,7 +935,6 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 	else
 		max98373->interleave_mode = false;
 
-
 	/* regmap initialization */
 	max98373->regmap
 		= devm_regmap_init_i2c(i2c, &max98373_regmap);
@@ -934,6 +945,24 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/* voltage/current slot & gpio configuration */
+	max98373_slot_config(i2c, max98373);
+
+	/* Power on device */
+	if (gpio_is_valid(max98373->reset_gpio)) {
+		ret = gpio_request(max98373->reset_gpio, "MAX98373_RESET");
+		if (ret) {
+			dev_err(&i2c->dev, "%s: Failed to request gpio %d\n",
+				__func__, max98373->reset_gpio);
+			gpio_free(max98373->reset_gpio);
+			return -EINVAL;
+		}
+		gpio_direction_output(max98373->reset_gpio, 0);
+		msleep(50);
+		gpio_direction_output(max98373->reset_gpio, 1);
+		msleep(20);
+	}
+
 	/* Check Revision ID */
 	ret = regmap_read(max98373->regmap,
 		MAX98373_R21FF_REV_ID, &reg);
@@ -944,9 +973,6 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 	}
 	dev_info(&i2c->dev, "MAX98373 revisionID: 0x%02X\n", reg);
 
-	/* voltage/current slot configuration */
-	max98373_slot_config(i2c, max98373);
-
 	/* codec registeration */
 	ret = devm_snd_soc_register_component(&i2c->dev, &soc_codec_dev_max98373,
 		max98373_dai, ARRAY_SIZE(max98373_dai));
diff --git a/sound/soc/codecs/max98373.h b/sound/soc/codecs/max98373.h
index f6a37aa02f26..533d2053f608 100644
--- a/sound/soc/codecs/max98373.h
+++ b/sound/soc/codecs/max98373.h
@@ -203,6 +203,7 @@
 
 struct max98373_priv {
 	struct regmap *regmap;
+	int reset_gpio;
 	unsigned int v_slot;
 	unsigned int i_slot;
 	unsigned int spkfb_slot;
-- 
2.20.1
