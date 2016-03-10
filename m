From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH 4/5] Sound: SOC: TAS571x: added support for
	TAS5721
Date: Thu, 10 Mar 2016 12:22:40 +0100
Message-ID: <1457608960-16913-4-git-send-email-petr@barix.com>
References: <1457608960-16913-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 00210261492
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 12:24:02 +0100 (CET)
Received: by mail-wm0-f51.google.com with SMTP id l68so24153208wml.1
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 03:24:02 -0800 (PST)
In-Reply-To: <1457608960-16913-1-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: cernekee@chromium.org, lgirdwood@gmail.com
Cc: petr@barix.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This adds support for TAS5721.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Tested-by: Petr Kulhavy <petr@barix.com>
---
 sound/soc/codecs/Kconfig   |  2 +-
 sound/soc/codecs/tas571x.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 50693c8..562b66f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -705,7 +705,7 @@ config SND_SOC_TAS5086
 	depends on I2C
 
 config SND_SOC_TAS571X
-	tristate "Texas Instruments TAS5711/TAS5717/TAS5719 power amplifiers"
+	tristate "Texas Instruments TAS5711/TAS5717/TAS5719/TAS5721 power amplifiers"
 	depends on I2C
 
 config SND_SOC_TFA9879
diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 431dffa..187f85b 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -4,6 +4,9 @@
  * Copyright (C) 2015 Google, Inc.
  * Copyright (c) 2013 Daniel Mack <zonque@gmail.com>
  *
+ * TAS5721 support:
+ * Copyright (C) 2016 Petr Kulhavy, Barix AG <petr@barix.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -348,6 +351,75 @@ static const struct tas571x_chip tas5717_chip = {
 	.vol_reg_size			= 2,
 };
 
+static const char *const tas5721_supply_names[] = {
+	"AVDD",
+	"DVDD",
+	"DRVDD",
+	"PVDD",
+};
+
+static const struct snd_kcontrol_new tas5721_controls[] = {
+	SOC_SINGLE_TLV("Master Volume",
+		       TAS571X_MVOL_REG,
+		       0, 0xff, 1, tas5711_volume_tlv),
+	SOC_DOUBLE_R_TLV("Speaker Volume",
+			 TAS571X_CH1_VOL_REG,
+			 TAS571X_CH2_VOL_REG,
+			 0, 0xff, 1, tas5711_volume_tlv),
+	SOC_DOUBLE("Speaker Switch",
+		   TAS571X_SOFT_MUTE_REG,
+		   TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
+		   1, 1),
+};
+
+static const struct reg_default tas5721_reg_defaults[] = {
+	{TAS571X_CLK_CTRL_REG,		0x6c},
+	{TAS571X_DEV_ID_REG,		0x00},
+	{TAS571X_ERR_STATUS_REG,	0x00},
+	{TAS571X_SYS_CTRL_1_REG,	0xa0},
+	{TAS571X_SDI_REG,		0x05},
+	{TAS571X_SYS_CTRL_2_REG,	0x40},
+	{TAS571X_SOFT_MUTE_REG,		0x00},
+	{TAS571X_MVOL_REG,		0xff},
+	{TAS571X_CH1_VOL_REG,		0x30},
+	{TAS571X_CH2_VOL_REG,		0x30},
+	{TAS571X_CH3_VOL_REG,		0x30},
+	{TAS571X_VOL_CFG_REG,		0x91},
+	{TAS571X_MODULATION_LIMIT_REG,	0x02},
+	{TAS571X_IC_DELAY_CH1_REG,	0xac},
+	{TAS571X_IC_DELAY_CH2_REG,	0x54},
+	{TAS571X_IC_DELAY_CH3_REG,	0xac},
+	{TAS571X_IC_DELAY_CH4_REG,	0x54},
+	{TAS571X_PWM_CH_SDN_GROUP_REG,	0x30},
+	{TAS571X_START_STOP_PERIOD_REG,	0x0f},
+	{TAS571X_OSC_TRIM_REG,		0x82},
+	{TAS571X_BKND_ERR_REG,		0x02},
+	{TAS571X_INPUT_MUX_REG,		0x17772},
+	{TAS571X_CH4_SRC_SELECT_REG,	0x4303},
+	{TAS571X_PWM_MUX_REG,		0x1021345},
+};
+
+static const struct regmap_config tas5721_regmap_config = {
+	.reg_bits			= 8,
+	.val_bits			= 32,
+	.max_register			= 0xff,
+	.reg_read			= tas571x_reg_read,
+	.reg_write			= tas571x_reg_write,
+	.reg_defaults			= tas5721_reg_defaults,
+	.num_reg_defaults		= ARRAY_SIZE(tas5721_reg_defaults),
+	.cache_type			= REGCACHE_RBTREE,
+};
+
+
+static const struct tas571x_chip tas5721_chip = {
+	.supply_names			= tas5721_supply_names,
+	.num_supply_names		= ARRAY_SIZE(tas5721_supply_names),
+	.controls			= tas5711_controls,
+	.num_controls			= ARRAY_SIZE(tas5711_controls),
+	.regmap_config			= &tas5721_regmap_config,
+	.vol_reg_size			= 1,
+};
+
 static const struct snd_soc_dapm_widget tas571x_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DACL", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DACR", NULL, SND_SOC_NOPM, 0, 0),
@@ -503,6 +575,7 @@ static const struct of_device_id tas571x_of_match[] = {
 	{ .compatible = "ti,tas5711", .data = &tas5711_chip, },
 	{ .compatible = "ti,tas5717", .data = &tas5717_chip, },
 	{ .compatible = "ti,tas5719", .data = &tas5717_chip, },
+	{ .compatible = "ti,tas5721", .data = &tas5721_chip, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tas571x_of_match);
@@ -511,6 +584,7 @@ static const struct i2c_device_id tas571x_i2c_id[] = {
 	{ "tas5711", (kernel_ulong_t) &tas5711_chip },
 	{ "tas5717", (kernel_ulong_t) &tas5717_chip },
 	{ "tas5719", (kernel_ulong_t) &tas5717_chip },
+	{ "tas5721", (kernel_ulong_t) &tas5721_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tas571x_i2c_id);
-- 
1.9.1
