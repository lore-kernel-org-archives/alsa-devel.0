From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Add the manual offset field to
	compensate the DC offset" to the asoc tree
Date: Mon, 10 Jul 2017 19:42:04 +0100
Message-ID: <E1dUddE-0000BV-FW@debutante>
References: <1499656497-3986-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D750266D49
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 20:42:13 +0200 (CEST)
In-Reply-To: <1499656497-3986-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Add the manual offset field to compensate the DC offset

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

>From 13700da6aea1d568ec68c7f2a90baf99a06851bf Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Mon, 10 Jul 2017 11:14:56 +0800
Subject: [PATCH] ASoC: rt5663: Add the manual offset field to compensate the
 DC offset

The patch adds the manual offset field in the devicetree to compensate the
DC offset that will be different between the PCB layout. It only can be
measured by the real production.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5663.txt |  5 ++
 include/sound/rt5663.h                             | 20 ++++++++
 sound/soc/codecs/rt5663.c                          | 55 ++++++++++++++++++++--
 sound/soc/codecs/rt5663.h                          |  2 +
 4 files changed, 77 insertions(+), 5 deletions(-)
 create mode 100644 include/sound/rt5663.h

diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
index 70eaeaed2b18..f7c7cc513ee8 100644
--- a/Documentation/devicetree/bindings/sound/rt5663.txt
+++ b/Documentation/devicetree/bindings/sound/rt5663.txt
@@ -12,6 +12,11 @@ Required properties:
 
 Optional properties:
 
+- "realtek,dc_offset_l_manual"
+- "realtek,dc_offset_r_manual"
+  Based on the different PCB layout, add the manual offset value to
+  compensate the DC offset for each L and R channel.
+
 Pins on the device (for linking into audio routes) for RT5663:
 
   * IN1P
diff --git a/include/sound/rt5663.h b/include/sound/rt5663.h
new file mode 100644
index 000000000000..be6f1b2d8fbd
--- /dev/null
+++ b/include/sound/rt5663.h
@@ -0,0 +1,20 @@
+/*
+ * linux/sound/rt5663.h -- Platform data for RT5663
+ *
+ * Copyright 2017 Realtek Semiconductor Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_RT5663_H
+#define __LINUX_SND_RT5663_H
+
+struct rt5663_platform_data {
+	unsigned int dc_offset_l_manual;
+	unsigned int dc_offset_r_manual;
+};
+
+#endif
+
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 5b3c50c641d8..963cda9c995a 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -40,6 +40,7 @@ enum {
 
 struct rt5663_priv {
 	struct snd_soc_codec *codec;
+	struct rt5663_platform_data pdata;
 	struct regmap *regmap;
 	struct delayed_work jack_detect_work;
 	struct snd_soc_jack *hs_jack;
@@ -57,6 +58,10 @@ struct rt5663_priv {
 	int jack_type;
 };
 
+static const struct reg_sequence rt5663_patch_list[] = {
+	{ 0x002a, 0x8080 },
+};
+
 static const struct reg_default rt5663_v2_reg[] = {
 	{ 0x0000, 0x0000 },
 	{ 0x0001, 0xc8c8 },
@@ -476,7 +481,7 @@ static const struct reg_default rt5663_reg[] = {
 	{ 0x0023, 0x0039 },
 	{ 0x0026, 0xc0c0 },
 	{ 0x0029, 0x8080 },
-	{ 0x002a, 0xa0a0 },
+	{ 0x002a, 0x8080 },
 	{ 0x002c, 0x000c },
 	{ 0x002d, 0x0000 },
 	{ 0x0040, 0x0808 },
@@ -1958,15 +1963,11 @@ static const struct snd_kcontrol_new rt5663_adda_r_mix[] = {
 static const struct snd_kcontrol_new rt5663_sto1_dac_l_mix[] = {
 	SOC_DAPM_SINGLE("DAC L Switch", RT5663_STO_DAC_MIXER,
 			RT5663_M_DAC_L1_STO_L_SHIFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC R Switch", RT5663_STO_DAC_MIXER,
-			RT5663_M_DAC_R1_STO_L_SHIFT, 1, 1),
 };
 
 static const struct snd_kcontrol_new rt5663_sto1_dac_r_mix[] = {
 	SOC_DAPM_SINGLE("DAC L Switch", RT5663_STO_DAC_MIXER,
 			RT5663_M_DAC_L1_STO_R_SHIFT, 1, 1),
-	SOC_DAPM_SINGLE("DAC R Switch", RT5663_STO_DAC_MIXER,
-			RT5663_M_DAC_R1_STO_R_SHIFT, 1, 1),
 };
 
 /* Out Switch */
@@ -3126,9 +3127,20 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 	usleep_range(10000, 10005);
 }
 
+static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
+{
+	device_property_read_u32(dev, "realtek,dc_offset_l_manual",
+		&rt5663->pdata.dc_offset_l_manual);
+	device_property_read_u32(dev, "realtek,dc_offset_r_manual",
+		&rt5663->pdata.dc_offset_r_manual);
+
+	return 0;
+}
+
 static int rt5663_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
+	struct rt5663_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5663_priv *rt5663;
 	int ret;
 	unsigned int val;
@@ -3142,6 +3154,11 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5663);
 
+	if (pdata)
+		rt5663->pdata = *pdata;
+	else
+		rt5663_parse_dp(rt5663, &i2c->dev);
+
 	regmap = devm_regmap_init_i2c(i2c, &temp_regmap);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
@@ -3190,6 +3207,34 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 	regmap_write(rt5663->regmap, RT5663_RESET, 0);
 	dev_dbg(&i2c->dev, "calibrate done\n");
 
+	switch (rt5663->codec_ver) {
+	case CODEC_VER_1:
+		break;
+	case CODEC_VER_0:
+		ret = regmap_register_patch(rt5663->regmap, rt5663_patch_list,
+					    ARRAY_SIZE(rt5663_patch_list));
+		if (ret != 0)
+			dev_warn(&i2c->dev,
+				"Failed to apply regmap patch: %d\n", ret);
+		break;
+	default:
+		dev_err(&i2c->dev, "%s:Unknown codec type\n", __func__);
+	}
+
+	if (rt5663->pdata.dc_offset_l_manual) {
+		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_2,
+			rt5663->pdata.dc_offset_l_manual >> 16);
+		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_3,
+			rt5663->pdata.dc_offset_l_manual & 0xffff);
+	}
+
+	if (rt5663->pdata.dc_offset_r_manual) {
+		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_5,
+			rt5663->pdata.dc_offset_r_manual >> 16);
+		regmap_write(rt5663->regmap, RT5663_MIC_DECRO_6,
+			rt5663->pdata.dc_offset_r_manual & 0xffff);
+	}
+
 	/* GPIO1 as IRQ */
 	regmap_update_bits(rt5663->regmap, RT5663_GPIO_1, RT5663_GP1_PIN_MASK,
 		RT5663_GP1_PIN_IRQ);
diff --git a/sound/soc/codecs/rt5663.h b/sound/soc/codecs/rt5663.h
index 4621812c94d8..c5a9b69579ad 100644
--- a/sound/soc/codecs/rt5663.h
+++ b/sound/soc/codecs/rt5663.h
@@ -12,6 +12,8 @@
 #ifndef __RT5663_H__
 #define __RT5663_H__
 
+#include <sound/rt5663.h>
+
 /* Info */
 #define RT5663_RESET				0x0000
 #define RT5663_VENDOR_ID			0x00fd
-- 
2.13.2
