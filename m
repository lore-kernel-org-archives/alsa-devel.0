From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l51: add reset management" to the asoc tree
Date: Thu,  4 Apr 2019 20:58:26 +0700 (+07)
Message-ID: <20190404135826.22337441D3C@finisterre.ee.mobilebroadband>
References: <1554297817-14154-4-git-send-email-olivier.moysan@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554297817-14154-4-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com, apatard@mandriva.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l51: add reset management

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 11b9cd748e3107df5c5e040a4daa986a3c6d8b75 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:33 +0200
Subject: [PATCH] ASoC: cs42l51: add reset management

Manage cs42l51 audio codec reset pin.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index f43eb51d2d8d..9b3ffa16b204 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -30,6 +30,7 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/pcm.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -54,6 +55,7 @@ struct cs42l51_private {
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(cs42l51_supply_names)];
+	struct gpio_desc *reset_gpio;
 };
 
 #define CS42L51_FORMATS ( \
@@ -595,6 +597,17 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 		return ret;
 	}
 
+	cs42l51->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(cs42l51->reset_gpio))
+		return PTR_ERR(cs42l51->reset_gpio);
+
+	if (cs42l51->reset_gpio) {
+		dev_dbg(dev, "Release reset gpio\n");
+		gpiod_set_value_cansleep(cs42l51->reset_gpio, 0);
+		mdelay(2);
+	}
+
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
@@ -629,6 +642,8 @@ int cs42l51_remove(struct device *dev)
 {
 	struct cs42l51_private *cs42l51 = dev_get_drvdata(dev);
 
+	gpiod_set_value_cansleep(cs42l51->reset_gpio, 1);
+
 	return regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
 				      cs42l51->supplies);
 }
-- 
2.20.1
