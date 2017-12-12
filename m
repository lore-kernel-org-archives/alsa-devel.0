From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas5720: add TAS5722 register support"
	to the asoc tree
Date: Tue, 12 Dec 2017 12:05:42 +0000
Message-ID: <E1eOjJe-0002B0-0U@debutante>
References: <20171211190157.12371-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C2C09266E6C
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 13:05:46 +0100 (CET)
In-Reply-To: <20171211190157.12371-2-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Andrew F . Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas5720: add TAS5722 register support

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

>From d5eb436acc8104b5c789359aa8c923ff5fafcd62 Mon Sep 17 00:00:00 2001
From: Andreas Dannenberg <dannenberg@ti.com>
Date: Mon, 11 Dec 2017 13:01:55 -0600
Subject: [PATCH] ASoC: tas5720: add TAS5722 register support

Introduce a custom super-set register map and associated bit definitions
to allow driver access to all TAS5722 device functionality.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas5720.c | 23 ++++++++++++++++++++++-
 sound/soc/codecs/tas5720.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index 5def54d1336d..f3006f301fe8 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -466,6 +466,15 @@ static const struct regmap_config tas5720_regmap_config = {
 	.volatile_reg = tas5720_is_volatile_reg,
 };
 
+static const struct regmap_config tas5722_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = TAS5722_MAX_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = tas5720_is_volatile_reg,
+};
+
 /*
  * DAC analog gain. There are four discrete values to select from, ranging
  * from 19.2 dB to 26.3dB.
@@ -564,6 +573,7 @@ static int tas5720_probe(struct i2c_client *client,
 {
 	struct device *dev = &client->dev;
 	struct tas5720_data *data;
+	const struct regmap_config *regmap_config;
 	int ret;
 	int i;
 
@@ -574,7 +584,18 @@ static int tas5720_probe(struct i2c_client *client,
 	data->tas5720_client = client;
 	data->devtype = id->driver_data;
 
-	data->regmap = devm_regmap_init_i2c(client, &tas5720_regmap_config);
+	switch (id->driver_data) {
+	case TAS5720:
+		regmap_config = &tas5720_regmap_config;
+		break;
+	case TAS5722:
+		regmap_config = &tas5722_regmap_config;
+		break;
+	default:
+		dev_err(dev, "unexpected private driver data\n");
+		return -EINVAL;
+	}
+	data->regmap = devm_regmap_init_i2c(client, regmap_config);
 	if (IS_ERR(data->regmap)) {
 		ret = PTR_ERR(data->regmap);
 		dev_err(dev, "failed to allocate register map: %d\n", ret);
diff --git a/sound/soc/codecs/tas5720.h b/sound/soc/codecs/tas5720.h
index bef802afcc69..1dda3095961d 100644
--- a/sound/soc/codecs/tas5720.h
+++ b/sound/soc/codecs/tas5720.h
@@ -30,6 +30,11 @@
 #define TAS5720_DIGITAL_CLIP1_REG	0x11
 #define TAS5720_MAX_REG			TAS5720_DIGITAL_CLIP1_REG
 
+/* Additional TAS5722-specific Registers */
+#define TAS5722_DIGITAL_CTRL2_REG	0x13
+#define TAS5722_ANALOG_CTRL2_REG	0x14
+#define TAS5722_MAX_REG			TAS5722_ANALOG_CTRL2_REG
+
 /* TAS5720_DEVICE_ID_REG */
 #define TAS5720_DEVICE_ID		0x01
 #define TAS5722_DEVICE_ID		0x12
@@ -52,6 +57,7 @@
 #define TAS5720_SAIF_FORMAT_MASK	GENMASK(2, 0)
 
 /* TAS5720_DIGITAL_CTRL2_REG */
+#define TAS5722_VOL_RAMP_RATE		BIT(6)
 #define TAS5720_MUTE			BIT(4)
 #define TAS5720_TDM_SLOT_SEL_MASK	GENMASK(2, 0)
 
@@ -88,4 +94,28 @@
 #define TAS5720_CLIP1_MASK		GENMASK(7, 2)
 #define TAS5720_CLIP1_SHIFT		(0x2)
 
+/* TAS5722_DIGITAL_CTRL2_REG */
+#define TAS5722_HPF_3_7HZ		(0x0 << 5)
+#define TAS5722_HPF_7_4HZ		(0x1 << 5)
+#define TAS5722_HPF_14_9HZ		(0x2 << 5)
+#define TAS5722_HPF_29_7HZ		(0x3 << 5)
+#define TAS5722_HPF_59_4HZ		(0x4 << 5)
+#define TAS5722_HPF_118_4HZ		(0x5 << 5)
+#define TAS5722_HPF_235_0HZ		(0x6 << 5)
+#define TAS5722_HPF_463_2HZ		(0x7 << 5)
+#define TAS5722_HPF_MASK		GENMASK(7, 5)
+#define TAS5722_AUTO_SLEEP_OFF		(0x0 << 3)
+#define TAS5722_AUTO_SLEEP_1024LR	(0x1 << 3)
+#define TAS5722_AUTO_SLEEP_65536LR	(0x2 << 3)
+#define TAS5722_AUTO_SLEEP_262144LR	(0x3 << 3)
+#define TAS5722_AUTO_SLEEP_MASK		GENMASK(4, 3)
+#define TAS5722_TDM_SLOT_16B		BIT(2)
+#define TAS5722_MCLK_PIN_CFG		BIT(1)
+#define TAS5722_VOL_CONTROL_LSB		BIT(0)
+
+/* TAS5722_ANALOG_CTRL2_REG */
+#define TAS5722_FAULTZ_PU		BIT(3)
+#define TAS5722_VREG_LVL		BIT(2)
+#define TAS5722_PWR_TUNE		BIT(0)
+
 #endif /* __TAS5720_H__ */
-- 
2.15.1
