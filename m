From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 1/3] ASoC: tas571x: added missing register literals
Date: Thu, 31 Mar 2016 18:41:25 +0200
Message-ID: <1459442487-32284-1-git-send-email-petr@barix.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The list of TAS571x registers was incomplete.
Added the missing register definitions up to the register 0x25.
Added volatile and read-only register tables into tas5711_regmap_config
and tas5717_regmap_config.

The chip has 256 registers in total. But from address 0x29 on
(0x26 to 0x28 are reserved) the register width varies between
20, 12 and 8 bytes, which the register map cannot represent.

Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
---
v1: <initial>

v2: <no change>

v3: added volatile and read-only register tables into regmap configs

v4: no change, the set v3 resubmitted without the already accepted patches

 sound/soc/codecs/tas571x.c | 28 ++++++++++++++++++++++++++++
 sound/soc/codecs/tas571x.h | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index aafee9bbe01a..ef6c8d9b251a 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -57,6 +57,10 @@ static int tas571x_register_size(struct tas571x_private *priv, unsigned int reg)
 	case TAS571X_CH1_VOL_REG:
 	case TAS571X_CH2_VOL_REG:
 		return priv->chip->vol_reg_size;
+	case TAS571X_INPUT_MUX_REG:
+	case TAS571X_CH4_SRC_SELECT_REG:
+	case TAS571X_PWM_MUX_REG:
+		return 4;
 	default:
 		return 1;
 	}
@@ -259,6 +263,26 @@ static const struct snd_kcontrol_new tas5711_controls[] = {
 		   1, 1),
 };
 
+static const struct regmap_range tas571x_readonly_regs_range[] = {
+	regmap_reg_range(TAS571X_CLK_CTRL_REG,  TAS571X_DEV_ID_REG),
+};
+
+static const struct regmap_range tas571x_volatile_regs_range[] = {
+	regmap_reg_range(TAS571X_CLK_CTRL_REG,  TAS571X_ERR_STATUS_REG),
+	regmap_reg_range(TAS571X_OSC_TRIM_REG,  TAS571X_OSC_TRIM_REG),
+};
+
+static const struct regmap_access_table tas571x_write_regs = {
+	.no_ranges =	tas571x_readonly_regs_range,
+	.n_no_ranges =	ARRAY_SIZE(tas571x_readonly_regs_range),
+};
+
+static const struct regmap_access_table tas571x_volatile_regs = {
+	.yes_ranges =	tas571x_volatile_regs_range,
+	.n_yes_ranges =	ARRAY_SIZE(tas571x_volatile_regs_range),
+
+};
+
 static const struct reg_default tas5711_reg_defaults[] = {
 	{ 0x04, 0x05 },
 	{ 0x05, 0x40 },
@@ -278,6 +302,8 @@ static const struct regmap_config tas5711_regmap_config = {
 	.reg_defaults			= tas5711_reg_defaults,
 	.num_reg_defaults		= ARRAY_SIZE(tas5711_reg_defaults),
 	.cache_type			= REGCACHE_RBTREE,
+	.wr_table			= &tas571x_write_regs,
+	.volatile_table			= &tas571x_volatile_regs,
 };
 
 static const struct tas571x_chip tas5711_chip = {
@@ -332,6 +358,8 @@ static const struct regmap_config tas5717_regmap_config = {
 	.reg_defaults			= tas5717_reg_defaults,
 	.num_reg_defaults		= ARRAY_SIZE(tas5717_reg_defaults),
 	.cache_type			= REGCACHE_RBTREE,
+	.wr_table			= &tas571x_write_regs,
+	.volatile_table			= &tas571x_volatile_regs,
 };
 
 /* This entry is reused for tas5719 as the software interface is identical. */
diff --git a/sound/soc/codecs/tas571x.h b/sound/soc/codecs/tas571x.h
index 0aee471232cd..cf800c364f0f 100644
--- a/sound/soc/codecs/tas571x.h
+++ b/sound/soc/codecs/tas571x.h
@@ -13,6 +13,10 @@
 #define _TAS571X_H
 
 /* device registers */
+#define TAS571X_CLK_CTRL_REG		0x00
+#define TAS571X_DEV_ID_REG		0x01
+#define TAS571X_ERR_STATUS_REG		0x02
+#define TAS571X_SYS_CTRL_1_REG		0x03
 #define TAS571X_SDI_REG			0x04
 #define TAS571X_SDI_FMT_MASK		0x0f
 
@@ -27,7 +31,25 @@
 #define TAS571X_MVOL_REG		0x07
 #define TAS571X_CH1_VOL_REG		0x08
 #define TAS571X_CH2_VOL_REG		0x09
+#define TAS571X_CH3_VOL_REG		0x0a
+#define TAS571X_VOL_CFG_REG		0x0e
+#define TAS571X_MODULATION_LIMIT_REG	0x10
+#define TAS571X_IC_DELAY_CH1_REG	0x11
+#define TAS571X_IC_DELAY_CH2_REG	0x12
+#define TAS571X_IC_DELAY_CH3_REG	0x13
+#define TAS571X_IC_DELAY_CH4_REG	0x14
 
+#define TAS571X_PWM_CH_SDN_GROUP_REG	0x19	/* N/A on TAS5717, TAS5719 */
+#define TAS571X_PWM_CH1_SDN_MASK	(1<<0)
+#define TAS571X_PWM_CH2_SDN_SHIFT	(1<<1)
+#define TAS571X_PWM_CH3_SDN_SHIFT	(1<<2)
+#define TAS571X_PWM_CH4_SDN_SHIFT	(1<<3)
+
+#define TAS571X_START_STOP_PERIOD_REG	0x1a
 #define TAS571X_OSC_TRIM_REG		0x1b
+#define TAS571X_BKND_ERR_REG		0x1c
+#define TAS571X_INPUT_MUX_REG		0x20
+#define TAS571X_CH4_SRC_SELECT_REG	0x21
+#define TAS571X_PWM_MUX_REG		0x25
 
 #endif /* _TAS571X_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
