From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ASoC: sta350: Add codec driver
Date: Thu, 27 Mar 2014 17:18:02 +0100
Message-ID: <1395937082-28202-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id F2DA226545C
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 17:18:15 +0100 (CET)
Received: by mail-bk0-f50.google.com with SMTP id w10so811566bkz.37
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 09:18:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, neumann@teufel.de, brandau@gmx.de
List-Id: alsa-devel@alsa-project.org

From: Sven Brandau <brandau@gmx.de>

The TI STA350 is an integrated 2.1-channel power amplifier that is
controllable over I2C. This patch adds an ASoC driver for it.

At a glance, this chip is very similar to the STA320 for which a driver
already exists. In details, however, the register maps contain subtle
differences which made a whole new driver easier to write and maintain.

[daniel@zonque.org: cleanups, DT property rework, rebased on asoc-next]
Signed-off-by: Sven Brandau <brandau@gmx.de>
---
I'm sending this patch on behalf of Sven Brandau, who wrote the driver,
based on earlier bits for the STA320.

In case of any pending issue, I will amend and resubmit.


Thanks,
Daniel

 .../devicetree/bindings/sound/st,sta350.txt        |  103 ++
 include/sound/sta350.h                             |   52 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/sta350.c                          | 1277 ++++++++++++++++++++
 sound/soc/codecs/sta350.h                          |  228 ++++
 6 files changed, 1666 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,sta350.txt
 create mode 100644 include/sound/sta350.h
 create mode 100644 sound/soc/codecs/sta350.c
 create mode 100644 sound/soc/codecs/sta350.h

diff --git a/Documentation/devicetree/bindings/sound/st,sta350.txt b/Documentation/devicetree/bindings/sound/st,sta350.txt
new file mode 100644
index 0000000..ae0630b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,sta350.txt
@@ -0,0 +1,103 @@
+STA350 audio CODEC
+
+The driver for this device only supports I2C.
+
+Required properties:
+
+  - compatible: "st,sta350"
+  - reg: the I2C address of the device for I2C
+  - reset-gpio: a GPIO spec for the reset pin. If specified, it will be
+		deasserted before communication to the codec starts.
+
+  - power-down-gpio: a GPIO spec for the power down pin. If specified,
+		     it will be deasserted before communication to the codec
+		     starts.
+
+Optional properties:
+
+  -  st,output-conf: number, Selects the output configuration:
+	0: 2-channel (full-bridge) power, 2-channel data-out
+	1: 2 (half-bridge). 1 (full-bridge) on-board power
+	2: 2 Channel (Full-Bridge) Power, 1 Channel FFX
+	3: 1 Channel Mono-Parallel
+	If parameter is missing, mode 0 will be enabled.
+
+  -  st,ch1-output-mapping: Channel 1 output mapping
+  -  st,ch2-output-mapping: Channel 2 output mapping
+  -  st,ch3-output-mapping: Channel 3 output mapping
+	0: Channel 1
+	1: Channel 2
+	2: Channel 3
+	If parameter is missing, channel 1 is choosen.
+
+  -  st,thermal-warning-recover:
+	If present, thermal warning recovery is enabled.
+
+  -  st,thermal-warning-adjustment:
+	If present, thermal warning adjustment is enabled.
+
+  -  st,fault-detect-recovery:
+	If present, then fault recovery will be enabled.
+
+  -  st,ffx-power-output-mode: string
+	The FFX power output mode selects how the FFX output timing is
+	configured. Must be one of these values:
+	  -  "drop-compensation"
+	  -  "tapered-compensation"
+	  -  "full-power-mode"
+	  -  "variable-drop-compensation" (default)
+
+  -  st,drop-compensation-ns: number
+	Only required for "st,ffx-power-output-mode" ==
+	"variable-drop-compensation".
+	Specifies the drop compensation in nanoseconds.
+	The value must be in the range of 0..300, and only
+	multiples of 20 are allowed. Default is 140ns.
+
+  -  st,overcurrent-warning-adjustment:
+	If present, overcurrent warning adjustment is enabled.
+
+  -  st,max-power-use-mpcc:
+	If present, then MPCC bits are used for MPC coefficients,
+	otherwise standard MPC coefficients are used.
+
+  -  st,max-power-corr:
+	If present, power bridge correction for THD reduction near maximum
+	power output is enabled.
+
+  -  st,am-reduction-mode:
+	If present, FFX mode runs in AM reduction mode, otherwise normal
+	FFX mode is used.
+
+  -  st,odd-pwm-speed-mode:
+	If present, PWM speed mode run on odd speed mode (341.3 kHz) on all
+	channels. If not present, normal PWM spped mode (384 kHz) will be used.
+
+  -  st,distortion-compensation:
+	If present, distortion compensation variable uses DCC coefficient.
+	If not present, preset DC coefficient is used.
+
+  -  st,invalid-input-detect-mute:
+	If not present, automatic invalid input detect mute is enabled.
+
+
+
+Example:
+
+codec: sta350@38 {
+	compatible = "st,sta350";
+	reg = <0x1c>;
+	reset-gpio = <&gpio1 19 0>;
+	power-down-gpio = <&gpio1 16 0>;
+	st,output-conf = <0x3>;			// set output to 2-channel
+						// (full-bridge) power,
+						// 2-channel data-out
+	st,ch1-output-mapping = <0>;		// set channel 1 output ch 1
+	st,ch2-output-mapping = <0>;		// set channel 2 output ch 1
+	st,ch3-output-mapping = <0>;		// set channel 3 output ch 1
+	st,max-power-correction;		// enables power bridge
+						// correction for THD reduction
+						// near maximum power output
+	st,invalid-input-detect-mute;		// mute if no valid digital
+						// audio signal is provided.
+};
diff --git a/include/sound/sta350.h b/include/sound/sta350.h
new file mode 100644
index 0000000..3a329810
--- /dev/null
+++ b/include/sound/sta350.h
@@ -0,0 +1,52 @@
+/*
+ * Platform data for ST STA350 ASoC codec driver.
+ *
+ * Copyright: 2014 Raumfeld GmbH
+ * Author: Sven Brandau <info@brandau.biz>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __LINUX_SND__STA350_H
+#define __LINUX_SND__STA350_H
+
+#define STA350_OCFG_2CH		0
+#define STA350_OCFG_2_1CH	1
+#define STA350_OCFG_1CH		3
+
+#define STA350_OM_CH1		0
+#define STA350_OM_CH2		1
+#define STA350_OM_CH3		2
+
+#define STA350_THERMAL_ADJUSTMENT_ENABLE	1
+#define STA350_THERMAL_RECOVERY_ENABLE		2
+#define STA350_FAULT_DETECT_RECOVERY_BYPASS	1
+
+#define STA350_FFX_PM_DROP_COMP			0
+#define STA350_FFX_PM_TAPERED_COMP		1
+#define STA350_FFX_PM_FULL_POWER		2
+#define STA350_FFX_PM_VARIABLE_DROP_COMP	3
+
+
+struct sta350_platform_data {
+	u8 output_conf;
+	u8 ch1_output_mapping;
+	u8 ch2_output_mapping;
+	u8 ch3_output_mapping;
+	u8 ffx_power_output_mode;
+	u8 drop_compensation_ns;
+	unsigned int thermal_warning_recovery:1;
+	unsigned int thermal_warning_adjustment:1;
+	unsigned int fault_detect_recovery:1;
+	unsigned int oc_warning_adjustment:1;
+	unsigned int max_power_use_mpcc:1;
+	unsigned int max_power_correction:1;
+	unsigned int am_reduction_mode:1;
+	unsigned int odd_pwm_speed_mode:1;
+	unsigned int distortion_compensation:1;
+	unsigned int invalid_input_detect_mute:1;
+};
+
+#endif /* __LINUX_SND__STA350_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f0e8401..6211889 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -80,6 +80,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_SSM2602_SPI if SPI_MASTER
 	select SND_SOC_SSM2602_I2C if I2C
 	select SND_SOC_STA32X if I2C
+	select SND_SOC_STA350 if I2C
 	select SND_SOC_STA529 if I2C
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
 	select SND_SOC_TAS5086 if I2C
@@ -435,6 +436,9 @@ config SND_SOC_SSM2602_I2C
 config SND_SOC_STA32X
 	tristate
 
+config SND_SOC_STA350
+	tristate
+
 config SND_SOC_STA529
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 3c4d275..efdb4d0 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -74,6 +74,7 @@ snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-ssm2602-spi-objs := ssm2602-spi.o
 snd-soc-ssm2602-i2c-objs := ssm2602-i2c.o
 snd-soc-sta32x-objs := sta32x.o
+snd-soc-sta350-objs := sta350.o
 snd-soc-sta529-objs := sta529.o
 snd-soc-stac9766-objs := stac9766.o
 snd-soc-tas5086-objs := tas5086.o
@@ -221,6 +222,7 @@ obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_SSM2602_SPI)	+= snd-soc-ssm2602-spi.o
 obj-$(CONFIG_SND_SOC_SSM2602_I2C)	+= snd-soc-ssm2602-i2c.o
 obj-$(CONFIG_SND_SOC_STA32X)   += snd-soc-sta32x.o
+obj-$(CONFIG_SND_SOC_STA350)   += snd-soc-sta350.o
 obj-$(CONFIG_SND_SOC_STA529)   += snd-soc-sta529.o
 obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
new file mode 100644
index 0000000..c78d1c5
--- /dev/null
+++ b/sound/soc/codecs/sta350.c
@@ -0,0 +1,1277 @@
+/*
+ * Codec driver for ST STA350 2.1-channel high-efficiency digital audio system
+ *
+ * Copyright: 2014 Raumfeld GmbH
+ * Author: Sven Brandau <info@brandau.biz>
+ *
+ * based on code from:
+ *	Raumfeld GmbH
+ *	  Johannes Stezenbach <js@sig21.net>
+ *	Wolfson Microelectronics PLC.
+ *	  Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *	Freescale Semiconductor, Inc.
+ *	  Timur Tabi <timur@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ":%s:%d: " fmt, __func__, __LINE__
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include <sound/sta350.h>
+#include "sta350.h"
+
+#define STA350_RATES (SNDRV_PCM_RATE_32000 | \
+		      SNDRV_PCM_RATE_44100 | \
+		      SNDRV_PCM_RATE_48000 | \
+		      SNDRV_PCM_RATE_88200 | \
+		      SNDRV_PCM_RATE_96000 | \
+		      SNDRV_PCM_RATE_176400 | \
+		      SNDRV_PCM_RATE_192000)
+
+#define STA350_FORMATS \
+	(SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE  | \
+	 SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S18_3BE | \
+	 SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S20_3BE | \
+	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE | \
+	 SNDRV_PCM_FMTBIT_S24_LE  | SNDRV_PCM_FMTBIT_S24_BE  | \
+	 SNDRV_PCM_FMTBIT_S32_LE  | SNDRV_PCM_FMTBIT_S32_BE)
+
+/* Power-up register defaults */
+static const struct reg_default sta350_regs[] = {
+	{  0x0, 0x63 },
+	{  0x1, 0x80 },
+	{  0x2, 0xdf },
+	{  0x3, 0x40 },
+	{  0x4, 0xc2 },
+	{  0x5, 0x5c },
+	{  0x6, 0x00 },
+	{  0x7, 0xff },
+	{  0x8, 0x60 },
+	{  0x9, 0x60 },
+	{  0xa, 0x60 },
+	{  0xb, 0x00 },
+	{  0xc, 0x00 },
+	{  0xd, 0x00 },
+	{  0xe, 0x00 },
+	{  0xf, 0x40 },
+	{ 0x10, 0x80 },
+	{ 0x11, 0x77 },
+	{ 0x12, 0x6a },
+	{ 0x13, 0x69 },
+	{ 0x14, 0x6a },
+	{ 0x15, 0x69 },
+	{ 0x16, 0x00 },
+	{ 0x17, 0x00 },
+	{ 0x18, 0x00 },
+	{ 0x19, 0x00 },
+	{ 0x1a, 0x00 },
+	{ 0x1b, 0x00 },
+	{ 0x1c, 0x00 },
+	{ 0x1d, 0x00 },
+	{ 0x1e, 0x00 },
+	{ 0x1f, 0x00 },
+	{ 0x20, 0x00 },
+	{ 0x21, 0x00 },
+	{ 0x22, 0x00 },
+	{ 0x23, 0x00 },
+	{ 0x24, 0x00 },
+	{ 0x25, 0x00 },
+	{ 0x26, 0x00 },
+	{ 0x27, 0x2a },
+	{ 0x28, 0xc0 },
+	{ 0x29, 0xf3 },
+	{ 0x2a, 0x33 },
+	{ 0x2b, 0x00 },
+	{ 0x2c, 0x0c },
+	{ 0x31, 0x00 },
+	{ 0x36, 0x00 },
+	{ 0x37, 0x00 },
+	{ 0x38, 0x00 },
+	{ 0x39, 0x01 },
+	{ 0x3a, 0xee },
+	{ 0x3b, 0xff },
+	{ 0x3c, 0x7e },
+	{ 0x3d, 0xc0 },
+	{ 0x3e, 0x26 },
+	{ 0x3f, 0x00 },
+	{ 0x48, 0x00 },
+	{ 0x49, 0x00 },
+	{ 0x4a, 0x00 },
+	{ 0x4b, 0x04 },
+	{ 0x4c, 0x00 },
+};
+
+static const struct regmap_range sta350_write_regs_range[] = {
+	regmap_reg_range(STA350_CONFA,  STA350_AUTO2),
+	regmap_reg_range(STA350_C1CFG,  STA350_FDRC2),
+	regmap_reg_range(STA350_EQCFG,  STA350_EVOLRES),
+	regmap_reg_range(STA350_NSHAPE, STA350_MISC2),
+};
+
+static const struct regmap_range sta350_read_regs_range[] = {
+	regmap_reg_range(STA350_CONFA,  STA350_AUTO2),
+	regmap_reg_range(STA350_C1CFG,  STA350_STATUS),
+	regmap_reg_range(STA350_EQCFG,  STA350_EVOLRES),
+	regmap_reg_range(STA350_NSHAPE, STA350_MISC2),
+};
+
+static const struct regmap_range sta350_volatile_regs_range[] = {
+	regmap_reg_range(STA350_CFADDR2, STA350_CFUD),
+	regmap_reg_range(STA350_STATUS,  STA350_STATUS),
+};
+
+static const struct regmap_access_table sta350_write_regs = {
+	.yes_ranges =	sta350_write_regs_range,
+	.n_yes_ranges =	ARRAY_SIZE(sta350_write_regs_range),
+};
+
+static const struct regmap_access_table sta350_read_regs = {
+	.yes_ranges =	sta350_read_regs_range,
+	.n_yes_ranges =	ARRAY_SIZE(sta350_read_regs_range),
+};
+
+static const struct regmap_access_table sta350_volatile_regs = {
+	.yes_ranges =	sta350_volatile_regs_range,
+	.n_yes_ranges =	ARRAY_SIZE(sta350_volatile_regs_range),
+};
+
+/* regulator power supply names */
+static const char const *sta350_supply_names[] = {
+	"vdd-dig",	/* digital supply, 3.3V */
+	"vdd-pll",	/* pll supply, 3.3V */
+	"vcc"		/* power amp supply, 5V - 26V */
+};
+
+/* codec private data */
+struct sta350_priv {
+	struct regmap *regmap;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(sta350_supply_names)];
+	struct sta350_platform_data *pdata;
+
+	unsigned int mclk;
+	unsigned int format;
+
+	u32 coef_shadow[STA350_COEF_COUNT];
+	int shutdown;
+	int gpio_nreset;
+	int gpio_power_down;
+};
+
+static const DECLARE_TLV_DB_SCALE(mvol_tlv, -12750, 50, 1);
+static const DECLARE_TLV_DB_SCALE(chvol_tlv, -7950, 50, 1);
+static const DECLARE_TLV_DB_SCALE(tone_tlv, -1200, 200, 0);
+
+static const char const *sta350_drc_ac[] = {
+	"Anti-Clipping", "Dynamic Range Compression"
+};
+static const char const *sta350_auto_gc_mode[] = {
+	"User", "AC no clipping", "AC limited clipping (10%)",
+	"DRC nighttime listening mode"
+};
+static const char const *sta350_auto_xo_mode[] = {
+	"User", "80Hz", "100Hz", "120Hz", "140Hz", "160Hz", "180Hz",
+	"200Hz", "220Hz", "240Hz", "260Hz", "280Hz", "300Hz", "320Hz",
+	"340Hz", "360Hz"
+};
+static const char const *sta350_binary_output[] = {
+	"FFX 3-state output - normal operation", "Binary output"
+};
+static const char const *sta350_limiter_select[] = {
+	"Limiter Disabled", "Limiter #1", "Limiter #2"
+};
+static const char const *sta350_limiter_attack_rate[] = {
+	"3.1584", "2.7072", "2.2560", "1.8048", "1.3536", "0.9024",
+	"0.4512", "0.2256", "0.1504", "0.1123", "0.0902", "0.0752",
+	"0.0645", "0.0564", "0.0501", "0.0451"
+};
+static const char const *sta350_limiter_release_rate[] = {
+	"0.5116", "0.1370", "0.0744", "0.0499", "0.0360", "0.0299",
+	"0.0264", "0.0208", "0.0198", "0.0172", "0.0147", "0.0137",
+	"0.0134", "0.0117", "0.0110", "0.0104"
+};
+static const char const *sta350_noise_shaper_type[] = {
+	"Third order", "Forth order"
+};
+
+static const unsigned int sta350_limiter_ac_attack_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0, 7, TLV_DB_SCALE_ITEM(-1200, 200, 0),
+	8, 16, TLV_DB_SCALE_ITEM(300, 100, 0),
+};
+
+static const unsigned int sta350_limiter_ac_release_tlv[] = {
+	TLV_DB_RANGE_HEAD(5),
+	0, 0, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 0),
+	1, 1, TLV_DB_SCALE_ITEM(-2900, 0, 0),
+	2, 2, TLV_DB_SCALE_ITEM(-2000, 0, 0),
+	3, 8, TLV_DB_SCALE_ITEM(-1400, 200, 0),
+	8, 16, TLV_DB_SCALE_ITEM(-700, 100, 0),
+};
+
+static const unsigned int sta350_limiter_drc_attack_tlv[] = {
+	TLV_DB_RANGE_HEAD(3),
+	0, 7, TLV_DB_SCALE_ITEM(-3100, 200, 0),
+	8, 13, TLV_DB_SCALE_ITEM(-1600, 100, 0),
+	14, 16, TLV_DB_SCALE_ITEM(-1000, 300, 0),
+};
+
+static const unsigned int sta350_limiter_drc_release_tlv[] = {
+	TLV_DB_RANGE_HEAD(5),
+	0, 0, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 0),
+	1, 2, TLV_DB_SCALE_ITEM(-3800, 200, 0),
+	3, 4, TLV_DB_SCALE_ITEM(-3300, 200, 0),
+	5, 12, TLV_DB_SCALE_ITEM(-3000, 200, 0),
+	13, 16, TLV_DB_SCALE_ITEM(-1500, 300, 0),
+};
+
+static const struct soc_enum sta350_drc_ac_enum =
+	SOC_ENUM_SINGLE(STA350_CONFD, STA350_CONFD_DRC_SHIFT,
+			2, sta350_drc_ac);
+static const struct soc_enum sta350_noise_shaper_enum =
+	SOC_ENUM_SINGLE(STA350_CONFE, STA350_CONFE_NSBW_SHIFT,
+			2, sta350_noise_shaper_type);
+static const struct soc_enum sta350_auto_gc_enum =
+	SOC_ENUM_SINGLE(STA350_AUTO1, STA350_AUTO1_AMGC_SHIFT,
+			4, sta350_auto_gc_mode);
+static const struct soc_enum sta350_auto_xo_enum =
+	SOC_ENUM_SINGLE(STA350_AUTO2, STA350_AUTO2_XO_SHIFT,
+			16, sta350_auto_xo_mode);
+static const struct soc_enum sta350_binary_output_ch1_enum =
+	SOC_ENUM_SINGLE(STA350_C1CFG, STA350_CxCFG_BO_SHIFT,
+			2, sta350_binary_output);
+static const struct soc_enum sta350_binary_output_ch2_enum =
+	SOC_ENUM_SINGLE(STA350_C2CFG, STA350_CxCFG_BO_SHIFT,
+			2, sta350_binary_output);
+static const struct soc_enum sta350_binary_output_ch3_enum =
+	SOC_ENUM_SINGLE(STA350_C3CFG, STA350_CxCFG_BO_SHIFT,
+			2, sta350_binary_output);
+static const struct soc_enum sta350_limiter_ch1_enum =
+	SOC_ENUM_SINGLE(STA350_C1CFG, STA350_CxCFG_LS_SHIFT,
+			3, sta350_limiter_select);
+static const struct soc_enum sta350_limiter_ch2_enum =
+	SOC_ENUM_SINGLE(STA350_C2CFG, STA350_CxCFG_LS_SHIFT,
+			3, sta350_limiter_select);
+static const struct soc_enum sta350_limiter_ch3_enum =
+	SOC_ENUM_SINGLE(STA350_C3CFG, STA350_CxCFG_LS_SHIFT,
+			3, sta350_limiter_select);
+static const struct soc_enum sta350_limiter1_attack_rate_enum =
+	SOC_ENUM_SINGLE(STA350_L1AR, STA350_LxA_SHIFT,
+			16, sta350_limiter_attack_rate);
+static const struct soc_enum sta350_limiter2_attack_rate_enum =
+	SOC_ENUM_SINGLE(STA350_L2AR, STA350_LxA_SHIFT,
+			16, sta350_limiter_attack_rate);
+static const struct soc_enum sta350_limiter1_release_rate_enum =
+	SOC_ENUM_SINGLE(STA350_L1AR, STA350_LxR_SHIFT,
+			16, sta350_limiter_release_rate);
+static const struct soc_enum sta350_limiter2_release_rate_enum =
+	SOC_ENUM_SINGLE(STA350_L2AR, STA350_LxR_SHIFT,
+			16, sta350_limiter_release_rate);
+
+/*
+ * byte array controls for setting biquad, mixer, scaling coefficients;
+ * for biquads all five coefficients need to be set in one go,
+ * mixer and pre/postscale coefs can be set individually;
+ * each coef is 24bit, the bytes are ordered in the same way
+ * as given in the STA350 data sheet (big endian; b1, b2, a1, a2, b0)
+ */
+
+static int sta350_coefficient_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	int numcoef = kcontrol->private_value >> 16;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = 3 * numcoef;
+	return 0;
+}
+
+static int sta350_coefficient_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	int numcoef = kcontrol->private_value >> 16;
+	int index = kcontrol->private_value & 0xffff;
+	unsigned int cfud, val;
+	int i;
+
+	/* preserve reserved bits in STA350_CFUD */
+	regmap_read(sta350->regmap, STA350_CFUD, &cfud);
+	cfud &= 0xf0;
+	/*
+	 * chip documentation does not say if the bits are self clearing,
+	 * so do it explicitly
+	 */
+	regmap_write(sta350->regmap, STA350_CFUD, cfud);
+
+	regmap_write(sta350->regmap, STA350_CFADDR2, index);
+	if (numcoef == 1)
+		regmap_write(sta350->regmap, STA350_CFUD, cfud | 0x04);
+	else if (numcoef == 5)
+		regmap_write(sta350->regmap, STA350_CFUD, cfud | 0x08);
+	else
+		return -EINVAL;
+
+	for (i = 0; i < 3 * numcoef; i++) {
+		regmap_read(sta350->regmap, STA350_B1CF1 + i, &val);
+		ucontrol->value.bytes.data[i] = val;
+	}
+
+	return 0;
+}
+
+static int sta350_coefficient_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	int numcoef = kcontrol->private_value >> 16;
+	int index = kcontrol->private_value & 0xffff;
+	unsigned int cfud;
+	int i;
+
+	/* preserve reserved bits in STA350_CFUD */
+	regmap_read(sta350->regmap, STA350_CFUD, &cfud);
+	cfud &= 0xf0;
+	/*
+	 * chip documentation does not say if the bits are self clearing,
+	 * so do it explicitly
+	 */
+	regmap_write(sta350->regmap, STA350_CFUD, cfud);
+
+	regmap_write(sta350->regmap, STA350_CFADDR2, index);
+	for (i = 0; i < numcoef && (index + i < STA350_COEF_COUNT); i++)
+		sta350->coef_shadow[index + i] =
+			  (ucontrol->value.bytes.data[3 * i] << 16)
+			| (ucontrol->value.bytes.data[3 * i + 1] << 8)
+			| (ucontrol->value.bytes.data[3 * i + 2]);
+	for (i = 0; i < 3 * numcoef; i++)
+		regmap_write(sta350->regmap, STA350_B1CF1 + i,
+			     ucontrol->value.bytes.data[i]);
+	if (numcoef == 1)
+		regmap_write(sta350->regmap, STA350_CFUD, cfud | 0x01);
+	else if (numcoef == 5)
+		regmap_write(sta350->regmap, STA350_CFUD, cfud | 0x02);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sta350_sync_coef_shadow(struct snd_soc_codec *codec)
+{
+	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	unsigned int cfud;
+	int i;
+
+	/* preserve reserved bits in STA350_CFUD */
+	regmap_read(sta350->regmap, STA350_CFUD, &cfud);
+	cfud &= 0xf0;
+
+	for (i = 0; i < STA350_COEF_COUNT; i++) {
+		regmap_write(sta350->regmap, STA350_CFADDR2, i);
+		regmap_write(sta350->regmap, STA350_B1CF1,
+			     (sta350->coef_shadow[i] >> 16) & 0xff);
+		regmap_write(sta350->regmap, STA350_B1CF2,
+			     (sta350->coef_shadow[i] >> 8) & 0xff);
+		regmap_write(sta350->regmap, STA350_B1CF3,
+			     (sta350->coef_shadow[i]) & 0xff);
+		/*
+		 * chip documentation does not say if the bits are
+		 * self-clearing, so do it explicitly
+		 */
+		regmap_write(sta350->regmap, STA350_CFUD, cfud);
+		regmap_write(sta350->regmap, STA350_CFUD, cfud | 0x01);
+	}
+	return 0;
+}
+
+static int sta350_cache_sync(struct snd_soc_codec *codec)
+{
+	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	unsigned int mute;
+	int rc;
+
+	/* mute during register sync */
+	regmap_read(sta350->regmap, STA350_CFUD, &mute);
+	regmap_write(sta350->regmap, STA350_MMUTE, mute | STA350_MMUTE_MMUTE);
+	sta350_sync_coef_shadow(codec);
+	rc = regcache_sync(sta350->regmap);
+	regmap_write(sta350->regmap, STA350_MMUTE, mute);
+	return rc;
+}
+
+#define SINGLE_COEF(xname, index) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = sta350_coefficient_info, \
+	.get = sta350_coefficient_get,\
+	.put = sta350_coefficient_put, \
+	.private_value = index | (1 << 16) }
+
+#define BIQUAD_COEFS(xname, index) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = sta350_coefficient_info, \
+	.get = sta350_coefficient_get,\
+	.put = sta350_coefficient_put, \
+	.private_value = index | (5 << 16) }
+
+static const struct snd_kcontrol_new sta350_snd_controls[] = {
+SOC_SINGLE_TLV("Master Volume", STA350_MVOL, 0, 0xff, 1, mvol_tlv),
+/* VOL */
+SOC_SINGLE_TLV("Ch1 Volume", STA350_C1VOL, 0, 0xff, 1, chvol_tlv),
+SOC_SINGLE_TLV("Ch2 Volume", STA350_C2VOL, 0, 0xff, 1, chvol_tlv),
+SOC_SINGLE_TLV("Ch3 Volume", STA350_C3VOL, 0, 0xff, 1, chvol_tlv),
+/* CONFD */
+SOC_SINGLE("High Pass Filter Bypass Switch",
+	   STA350_CONFD, STA350_CONFD_HPB_SHIFT, 1, 1),
+SOC_SINGLE("De-emphasis Filter Switch",
+	   STA350_CONFD, STA350_CONFD_DEMP_SHIFT, 1, 0),
+SOC_SINGLE("DSP Bypass Switch",
+	   STA350_CONFD, STA350_CONFD_DSPB_SHIFT, 1, 0),
+SOC_SINGLE("Post-scale Link Switch",
+	   STA350_CONFD, STA350_CONFD_PSL_SHIFT, 1, 0),
+SOC_SINGLE("Biquad Coefficient Link Switch",
+	   STA350_CONFD, STA350_CONFD_BQL_SHIFT, 1, 0),
+SOC_ENUM("Compressor/Limiter Switch", sta350_drc_ac_enum),
+SOC_ENUM("Noise Shaper Bandwidth", sta350_noise_shaper_enum),
+SOC_SINGLE("Zero-detect Mute Enable Switch",
+	   STA350_CONFD, STA350_CONFD_ZDE_SHIFT, 1, 0),
+SOC_SINGLE("Submix Mode Switch",
+	   STA350_CONFD, STA350_CONFD_SME_SHIFT, 1, 0),
+/* CONFE */
+SOC_SINGLE("Zero Cross Switch", STA350_CONFE, STA350_CONFE_ZCE_SHIFT, 1, 0),
+SOC_SINGLE("Soft Ramp Switch", STA350_CONFE, STA350_CONFE_SVE_SHIFT, 1, 0),
+/* MUTE */
+SOC_SINGLE("Master Switch", STA350_MMUTE, STA350_MMUTE_MMUTE_SHIFT, 1, 1),
+SOC_SINGLE("Ch1 Switch", STA350_MMUTE, STA350_MMUTE_C1M_SHIFT, 1, 1),
+SOC_SINGLE("Ch2 Switch", STA350_MMUTE, STA350_MMUTE_C2M_SHIFT, 1, 1),
+SOC_SINGLE("Ch3 Switch", STA350_MMUTE, STA350_MMUTE_C3M_SHIFT, 1, 1),
+/* AUTOx */
+SOC_ENUM("Automode GC", sta350_auto_gc_enum),
+SOC_ENUM("Automode XO", sta350_auto_xo_enum),
+/* CxCFG */
+SOC_SINGLE("Ch1 Tone Control Bypass Switch",
+	   STA350_C1CFG, STA350_CxCFG_TCB_SHIFT, 1, 0),
+SOC_SINGLE("Ch2 Tone Control Bypass Switch",
+	   STA350_C2CFG, STA350_CxCFG_TCB_SHIFT, 1, 0),
+SOC_SINGLE("Ch1 EQ Bypass Switch",
+	   STA350_C1CFG, STA350_CxCFG_EQBP_SHIFT, 1, 0),
+SOC_SINGLE("Ch2 EQ Bypass Switch",
+	   STA350_C2CFG, STA350_CxCFG_EQBP_SHIFT, 1, 0),
+SOC_SINGLE("Ch1 Master Volume Bypass Switch",
+	   STA350_C1CFG, STA350_CxCFG_VBP_SHIFT, 1, 0),
+SOC_SINGLE("Ch2 Master Volume Bypass Switch",
+	   STA350_C1CFG, STA350_CxCFG_VBP_SHIFT, 1, 0),
+SOC_SINGLE("Ch3 Master Volume Bypass Switch",
+	   STA350_C1CFG, STA350_CxCFG_VBP_SHIFT, 1, 0),
+SOC_ENUM("Ch1 Binary Output Select", sta350_binary_output_ch1_enum),
+SOC_ENUM("Ch2 Binary Output Select", sta350_binary_output_ch2_enum),
+SOC_ENUM("Ch3 Binary Output Select", sta350_binary_output_ch3_enum),
+SOC_ENUM("Ch1 Limiter Select", sta350_limiter_ch1_enum),
+SOC_ENUM("Ch2 Limiter Select", sta350_limiter_ch2_enum),
+SOC_ENUM("Ch3 Limiter Select", sta350_limiter_ch3_enum),
+/* TONE */
+SOC_SINGLE_RANGE_TLV("Bass Tone Control Volume",
+		     STA350_TONE, STA350_TONE_BTC_SHIFT, 1, 13, 0, tone_tlv),
+SOC_SINGLE_RANGE_TLV("Treble Tone Control Volume",
+		     STA350_TONE, STA350_TONE_TTC_SHIFT, 1, 13, 0, tone_tlv),
+SOC_ENUM("Limiter1 Attack Rate (dB/ms)", sta350_limiter1_attack_rate_enum),
+SOC_ENUM("Limiter2 Attack Rate (dB/ms)", sta350_limiter2_attack_rate_enum),
+SOC_ENUM("Limiter1 Release Rate (dB/ms)", sta350_limiter1_release_rate_enum),
+SOC_ENUM("Limiter2 Release Rate (dB/ms)", sta350_limiter2_release_rate_enum),
+
+/*
+ * depending on mode, the attack/release thresholds have
+ * two different enum definitions; provide both
+ */
+SOC_SINGLE_TLV("Limiter1 Attack Threshold (AC Mode)",
+	       STA350_L1ATRT, STA350_LxA_SHIFT,
+	       16, 0, sta350_limiter_ac_attack_tlv),
+SOC_SINGLE_TLV("Limiter2 Attack Threshold (AC Mode)",
+	       STA350_L2ATRT, STA350_LxA_SHIFT,
+	       16, 0, sta350_limiter_ac_attack_tlv),
+SOC_SINGLE_TLV("Limiter1 Release Threshold (AC Mode)",
+	       STA350_L1ATRT, STA350_LxR_SHIFT,
+	       16, 0, sta350_limiter_ac_release_tlv),
+SOC_SINGLE_TLV("Limiter2 Release Threshold (AC Mode)",
+	       STA350_L2ATRT, STA350_LxR_SHIFT,
+	       16, 0, sta350_limiter_ac_release_tlv),
+SOC_SINGLE_TLV("Limiter1 Attack Threshold (DRC Mode)",
+	       STA350_L1ATRT, STA350_LxA_SHIFT,
+	       16, 0, sta350_limiter_drc_attack_tlv),
+SOC_SINGLE_TLV("Limiter2 Attack Threshold (DRC Mode)",
+	       STA350_L2ATRT, STA350_LxA_SHIFT,
+	       16, 0, sta350_limiter_drc_attack_tlv),
+SOC_SINGLE_TLV("Limiter1 Release Threshold (DRC Mode)",
+	       STA350_L1ATRT, STA350_LxR_SHIFT,
+	       16, 0, sta350_limiter_drc_release_tlv),
+SOC_SINGLE_TLV("Limiter2 Release Threshold (DRC Mode)",
+	       STA350_L2ATRT, STA350_LxR_SHIFT,
+	       16, 0, sta350_limiter_drc_release_tlv),
+
+BIQUAD_COEFS("Ch1 - Biquad 1", 0),
+BIQUAD_COEFS("Ch1 - Biquad 2", 5),
+BIQUAD_COEFS("Ch1 - Biquad 3", 10),
+BIQUAD_COEFS("Ch1 - Biquad 4", 15),
+BIQUAD_COEFS("Ch2 - Biquad 1", 20),
+BIQUAD_COEFS("Ch2 - Biquad 2", 25),
+BIQUAD_COEFS("Ch2 - Biquad 3", 30),
+BIQUAD_COEFS("Ch2 - Biquad 4", 35),
+BIQUAD_COEFS("High-pass", 40),
+BIQUAD_COEFS("Low-pass", 45),
+SINGLE_COEF("Ch1 - Prescale", 50),
+SINGLE_COEF("Ch2 - Prescale", 51),
+SINGLE_COEF("Ch1 - Postscale", 52),
+SINGLE_COEF("Ch2 - Postscale", 53),
+SINGLE_COEF("Ch3 - Postscale", 54),
+SINGLE_COEF("Thermal warning - Postscale", 55),
+SINGLE_COEF("Ch1 - Mix 1", 56),
+SINGLE_COEF("Ch1 - Mix 2", 57),
+SINGLE_COEF("Ch2 - Mix 1", 58),
+SINGLE_COEF("Ch2 - Mix 2", 59),
+SINGLE_COEF("Ch3 - Mix 1", 60),
+SINGLE_COEF("Ch3 - Mix 2", 61),
+};
+
+static const struct snd_soc_dapm_widget sta350_dapm_widgets[] = {
+SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_OUTPUT("LEFT"),
+SND_SOC_DAPM_OUTPUT("RIGHT"),
+SND_SOC_DAPM_OUTPUT("SUB"),
+};
+
+static const struct snd_soc_dapm_route sta350_dapm_routes[] = {
+	{ "LEFT", NULL, "DAC" },
+	{ "RIGHT", NULL, "DAC" },
+	{ "SUB", NULL, "DAC" },
+};
+
+/* MCLK interpolation ratio per fs */
+static struct {
+	int fs;
+	int ir;
+} interpolation_ratios[] = {
+	{ 32000, 0 },
+	{ 44100, 0 },
+	{ 48000, 0 },
+	{ 88200, 1 },
+	{ 96000, 1 },
+	{ 176400, 2 },
+	{ 192000, 2 },
+};
+
+/* MCLK to fs clock ratios */
+static int mcs_ratio_table[3][6] = {
+	{ 768, 512, 384, 256, 128, 576 },
+	{ 384, 256, 192, 128,  64,   0 },
+	{ 192, 128,  96,  64,  32,   0 },
+};
+
+/**
+ * sta350_set_dai_sysclk - configure MCLK
+ * @codec_dai: the codec DAI
+ * @clk_id: the clock ID (ignored)
+ * @freq: the MCLK input frequency
+ * @dir: the clock direction (ignored)
+ *
+ * The value of MCLK is used to determine which sample rates are supported
+ * by the STA350, based on the mcs_ratio_table.
+ *
+ * This function must be called by the machine driver's 'startup' function,
+ * otherwise the list of supported sample rates will not be available in
+ * time for ALSA.
+ */
+static int sta350_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+
+	pr_debug("mclk=%u\n", freq);
+	sta350->mclk = freq;
+
+	return 0;
+}
+
+/**
+ * sta350_set_dai_fmt - configure the codec for the selected audio format
+ * @codec_dai: the codec DAI
+ * @fmt: a SND_SOC_DAIFMT_x value indicating the data format
+ *
+ * This function takes a bitmask of SND_SOC_DAIFMT_x bits and programs the
+ * codec accordingly.
+ */
+static int sta350_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			      unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	unsigned int confb;
+
+	regmap_read(sta350->regmap, STA350_CONFB, &confb);
+
+	pr_debug("\n");
+	confb &= ~(STA350_CONFB_C1IM | STA350_CONFB_C2IM);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_RIGHT_J:
+	case SND_SOC_DAIFMT_LEFT_J:
+		sta350->format = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		confb |= STA350_CONFB_C2IM;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		confb |= STA350_CONFB_C1IM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_write(sta350->regmap, STA350_CONFB, confb);
+	return 0;
+}
+
+/**
+ * sta350_hw_params - program the STA350 with the given hardware parameters.
+ * @substream: the audio stream
+ * @params: the hardware parameters to set
+ * @dai: the SOC DAI (ignored)
+ *
+ * This function programs the hardware with the values provided.
+ * Specifically, the sample rate and the data format.
+ */
+static int sta350_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	int i, mcs = -EINVAL, ir = -EINVAL;
+	unsigned int confa, confb;
+	unsigned int rate, ratio;
+
+	if (!sta350->mclk) {
+		dev_err(codec->dev,
+			"sta350->mclk is unset. Unable to determine ratio\n");
+		return -EIO;
+	}
+
+	rate = params_rate(params);
+	ratio = sta350->mclk / rate;
+	pr_debug("rate: %u, ratio: %u\n", rate, ratio);
+
+	for (i = 0; i < ARRAY_SIZE(interpolation_ratios); i++)
+		if (interpolation_ratios[i].fs == rate) {
+			ir = interpolation_ratios[i].ir;
+			break;
+		}
+	if (ir < 0) {
+		dev_err(codec->dev, "Unsupported samplerate: %u\n", rate);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < 6; i++)
+		if (mcs_ratio_table[ir][i] == ratio) {
+			mcs = i;
+			break;
+		}
+	if (mcs < 0) {
+		dev_err(codec->dev, "Unresolvable ratio: %u\n", ratio);
+		return -EINVAL;
+	}
+
+	regmap_read(sta350->regmap, STA350_CONFA, &confa);
+	confa &= ~(STA350_CONFA_MCS_MASK | STA350_CONFA_IR_MASK);
+	confa |= (ir << STA350_CONFA_IR_SHIFT) |
+		 (mcs << STA350_CONFA_MCS_SHIFT);
+
+	regmap_read(sta350->regmap, STA350_CONFB, &confb);
+	confb &= ~(STA350_CONFB_SAI_MASK | STA350_CONFB_SAIFB);
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S24_BE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3BE:
+		pr_debug("24bit\n");
+		/* fall through */
+	case SNDRV_PCM_FORMAT_S32_LE:
+	case SNDRV_PCM_FORMAT_S32_BE:
+		pr_debug("24bit or 32bit\n");
+		switch (sta350->format) {
+		case SND_SOC_DAIFMT_I2S:
+			confb |= 0x0;
+			break;
+		case SND_SOC_DAIFMT_LEFT_J:
+			confb |= 0x1;
+			break;
+		case SND_SOC_DAIFMT_RIGHT_J:
+			confb |= 0x2;
+			break;
+		}
+
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S20_3BE:
+		pr_debug("20bit\n");
+		switch (sta350->format) {
+		case SND_SOC_DAIFMT_I2S:
+			confb |= 0x4;
+			break;
+		case SND_SOC_DAIFMT_LEFT_J:
+			confb |= 0x5;
+			break;
+		case SND_SOC_DAIFMT_RIGHT_J:
+			confb |= 0x6;
+			break;
+		}
+
+		break;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+	case SNDRV_PCM_FORMAT_S18_3BE:
+		pr_debug("18bit\n");
+		switch (sta350->format) {
+		case SND_SOC_DAIFMT_I2S:
+			confb |= 0x8;
+			break;
+		case SND_SOC_DAIFMT_LEFT_J:
+			confb |= 0x9;
+			break;
+		case SND_SOC_DAIFMT_RIGHT_J:
+			confb |= 0xa;
+			break;
+		}
+
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+	case SNDRV_PCM_FORMAT_S16_BE:
+		pr_debug("16bit\n");
+		switch (sta350->format) {
+		case SND_SOC_DAIFMT_I2S:
+			confb |= 0x0;
+			break;
+		case SND_SOC_DAIFMT_LEFT_J:
+			confb |= 0xd;
+			break;
+		case SND_SOC_DAIFMT_RIGHT_J:
+			confb |= 0xe;
+			break;
+		}
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_write(sta350->regmap, STA350_CONFA, confa);
+	regmap_write(sta350->regmap, STA350_CONFB, confb);
+	return 0;
+}
+
+static int sta350_startup_sequence(struct sta350_priv *sta350)
+{
+	if (gpio_is_valid(sta350->gpio_power_down))
+		gpio_set_value(sta350->gpio_power_down, 1);
+
+	if (gpio_is_valid(sta350->gpio_nreset)) {
+		gpio_set_value(sta350->gpio_nreset, 1);
+		mdelay(1);
+		gpio_set_value(sta350->gpio_nreset, 0);
+		mdelay(1);
+		gpio_set_value(sta350->gpio_nreset, 1);
+		mdelay(1);
+	}
+
+	return 0;
+}
+
+/**
+ * sta350_set_bias_level - DAPM callback
+ * @codec: the codec device
+ * @level: DAPM power level
+ *
+ * This is called by ALSA to put the codec into low power mode
+ * or to wake it up.  If the codec is powered off completely
+ * all registers must be restored after power on.
+ */
+static int sta350_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	pr_debug("level = %d\n", level);
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		/* Full power on */
+		regmap_update_bits(sta350->regmap, STA350_CONFF,
+				   STA350_CONFF_PWDN | STA350_CONFF_EAPD,
+				   STA350_CONFF_PWDN | STA350_CONFF_EAPD);
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			ret = regulator_bulk_enable(
+				ARRAY_SIZE(sta350->supplies),
+				sta350->supplies);
+			if (ret < 0) {
+				dev_err(codec->dev,
+					"Failed to enable supplies: %d\n",
+					ret);
+				return ret;
+			}
+			sta350_startup_sequence(sta350);
+			sta350_cache_sync(codec);
+		}
+
+		/* Power down */
+		regmap_update_bits(sta350->regmap, STA350_CONFF,
+				   STA350_CONFF_PWDN | STA350_CONFF_EAPD,
+				   0);
+
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		/* The chip runs through the power down sequence for us. */
+		regmap_update_bits(sta350->regmap, STA350_CONFF,
+				   STA350_CONFF_PWDN | STA350_CONFF_EAPD, 0);
+		/* power down: low */
+		if (gpio_is_valid(sta350->gpio_power_down))
+			gpio_set_value(sta350->gpio_power_down, 0);
+
+		regulator_bulk_disable(ARRAY_SIZE(sta350->supplies),
+				       sta350->supplies);
+		break;
+	}
+	codec->dapm.bias_level = level;
+	return 0;
+}
+
+static const struct snd_soc_dai_ops sta350_dai_ops = {
+	.hw_params	= sta350_hw_params,
+	.set_sysclk	= sta350_set_dai_sysclk,
+	.set_fmt	= sta350_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver sta350_dai = {
+	.name = "sta350-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = STA350_RATES,
+		.formats = STA350_FORMATS,
+	},
+	.ops = &sta350_dai_ops,
+};
+
+#ifdef CONFIG_PM
+static int sta350_suspend(struct snd_soc_codec *codec)
+{
+	sta350_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static int sta350_resume(struct snd_soc_codec *codec)
+{
+	sta350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	return 0;
+}
+#else
+#define sta350_suspend NULL
+#define sta350_resume NULL
+#endif
+
+static int sta350_probe(struct snd_soc_codec *codec)
+{
+	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+	struct sta350_platform_data *pdata = sta350->pdata;
+	int i, ret = 0, thermal = 0;
+
+	if (gpio_is_valid(sta350->gpio_nreset))
+		if (devm_gpio_request_one(codec->dev, sta350->gpio_nreset,
+					  GPIOF_OUT_INIT_HIGH,
+					  "ST350 Reset"))
+			sta350->gpio_nreset = -EINVAL;
+
+	if (gpio_is_valid(sta350->gpio_power_down))
+		if (devm_gpio_request_one(codec->dev, sta350->gpio_power_down,
+					  GPIOF_OUT_INIT_HIGH,
+					  "ST350 Power-Down"))
+			sta350->gpio_power_down = -EINVAL;
+
+	ret = sta350_startup_sequence(sta350);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to startup device\n");
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(sta350->supplies),
+				    sta350->supplies);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Tell ASoC what kind of I/O to use to read the registers.  ASoC will
+	 * then do the I2C transactions itself.
+	 */
+	codec->control_data = sta350->regmap;
+
+	/*
+	 * Chip documentation explicitly requires that the reset values
+	 * of reserved register bits are left untouched.
+	 * Write the register default value to cache for reserved registers,
+	 * so the write to the these registers are suppressed by the cache
+	 * restore code when it skips writes of default registers.
+	 */
+	regcache_cache_only(sta350->regmap, true);
+	regmap_write(sta350->regmap, STA350_CONFC, 0xc2);
+	regmap_write(sta350->regmap, STA350_CONFE, 0xc2);
+	regmap_write(sta350->regmap, STA350_CONFF, 0x5c);
+	regmap_write(sta350->regmap, STA350_MMUTE, 0x10);
+	regmap_write(sta350->regmap, STA350_AUTO1, 0x60);
+	regmap_write(sta350->regmap, STA350_AUTO3, 0x00);
+	regmap_write(sta350->regmap, STA350_C3CFG, 0x40);
+	regcache_cache_only(sta350->regmap, false);
+
+	/* CONFA */
+	if (!pdata->thermal_warning_recovery)
+		thermal |= STA350_CONFA_TWAB;
+	if (!pdata->thermal_warning_adjustment)
+		thermal |= STA350_CONFA_TWRB;
+	if (!pdata->fault_detect_recovery)
+		thermal |= STA350_CONFA_FDRB;
+	regmap_update_bits(sta350->regmap, STA350_CONFA,
+			   STA350_CONFA_TWAB | STA350_CONFA_TWRB |
+			   STA350_CONFA_FDRB,
+			   thermal);
+
+	/* CONFC */
+	regmap_update_bits(sta350->regmap, STA350_CONFC,
+			   STA350_CONFC_OM_MASK,
+			   pdata->ffx_power_output_mode
+				<< STA350_CONFC_OM_SHIFT);
+	regmap_update_bits(sta350->regmap, STA350_CONFC,
+			   STA350_CONFC_CSZ_MASK,
+			   pdata->drop_compensation_ns
+				<< STA350_CONFC_CSZ_SHIFT);
+	regmap_update_bits(sta350->regmap,
+			   STA350_CONFC,
+			   STA350_CONFC_OCRB,
+			   pdata->oc_warning_adjustment ?
+				STA350_CONFC_OCRB : 0);
+
+	/* CONFE */
+	regmap_update_bits(sta350->regmap, STA350_CONFE,
+			   STA350_CONFE_MPCV,
+			   pdata->max_power_use_mpcc ?
+				STA350_CONFE_MPCV : 0);
+	regmap_update_bits(sta350->regmap, STA350_CONFE,
+			   STA350_CONFE_MPC,
+			   pdata->max_power_correction ?
+				STA350_CONFE_MPC : 0);
+	regmap_update_bits(sta350->regmap, STA350_CONFE,
+			   STA350_CONFE_AME,
+			   pdata->am_reduction_mode ?
+				STA350_CONFE_AME : 0);
+	regmap_update_bits(sta350->regmap, STA350_CONFE,
+			   STA350_CONFE_PWMS,
+			   pdata->odd_pwm_speed_mode ?
+				STA350_CONFE_PWMS : 0);
+	regmap_update_bits(sta350->regmap, STA350_CONFE,
+			   STA350_CONFE_DCCV,
+			   pdata->distortion_compensation ?
+				STA350_CONFE_DCCV : 0);
+	/*  CONFF */
+	regmap_update_bits(sta350->regmap, STA350_CONFF,
+			   STA350_CONFF_IDE,
+			   pdata->invalid_input_detect_mute ?
+				STA350_CONFF_IDE : 0);
+	regmap_update_bits(sta350->regmap, STA350_CONFF,
+			   STA350_CONFF_OCFG_MASK,
+			   pdata->output_conf
+				<< STA350_CONFF_OCFG_SHIFT);
+
+	/* channel to output mapping */
+	regmap_update_bits(sta350->regmap, STA350_C1CFG,
+			   STA350_CxCFG_OM_MASK,
+			   pdata->ch1_output_mapping
+				<< STA350_CxCFG_OM_SHIFT);
+	regmap_update_bits(sta350->regmap, STA350_C2CFG,
+			   STA350_CxCFG_OM_MASK,
+			   pdata->ch2_output_mapping
+				<< STA350_CxCFG_OM_SHIFT);
+	regmap_update_bits(sta350->regmap, STA350_C3CFG,
+			   STA350_CxCFG_OM_MASK,
+			   pdata->ch3_output_mapping
+				<< STA350_CxCFG_OM_SHIFT);
+
+	/* initialize coefficient shadow RAM with reset values */
+	for (i = 4; i <= 49; i += 5)
+		sta350->coef_shadow[i] = 0x400000;
+	for (i = 50; i <= 54; i++)
+		sta350->coef_shadow[i] = 0x7fffff;
+	sta350->coef_shadow[55] = 0x5a9df7;
+	sta350->coef_shadow[56] = 0x7fffff;
+	sta350->coef_shadow[59] = 0x7fffff;
+	sta350->coef_shadow[60] = 0x400000;
+	sta350->coef_shadow[61] = 0x400000;
+
+	sta350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	/* Bias level configuration will have done an extra enable */
+	regulator_bulk_disable(ARRAY_SIZE(sta350->supplies), sta350->supplies);
+
+	return 0;
+}
+
+static int sta350_remove(struct snd_soc_codec *codec)
+{
+	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
+
+	if (gpio_is_valid(sta350->gpio_nreset))
+		gpio_set_value(sta350->gpio_nreset, 0);
+
+	if (gpio_is_valid(sta350->gpio_power_down))
+		gpio_set_value(sta350->gpio_power_down, 0);
+
+	sta350_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	regulator_bulk_disable(ARRAY_SIZE(sta350->supplies), sta350->supplies);
+
+	return 0;
+}
+
+static const struct snd_soc_codec_driver sta350_codec = {
+	.probe =		sta350_probe,
+	.remove =		sta350_remove,
+	.suspend =		sta350_suspend,
+	.resume =		sta350_resume,
+	.set_bias_level =	sta350_set_bias_level,
+	.controls =		sta350_snd_controls,
+	.num_controls =		ARRAY_SIZE(sta350_snd_controls),
+	.dapm_widgets =		sta350_dapm_widgets,
+	.num_dapm_widgets =	ARRAY_SIZE(sta350_dapm_widgets),
+	.dapm_routes =		sta350_dapm_routes,
+	.num_dapm_routes =	ARRAY_SIZE(sta350_dapm_routes),
+};
+
+static const struct regmap_config sta350_regmap = {
+	.reg_bits =		8,
+	.val_bits =		8,
+	.max_register =		STA350_MISC2,
+	.reg_defaults =		sta350_regs,
+	.num_reg_defaults =	ARRAY_SIZE(sta350_regs),
+	.cache_type =		REGCACHE_RBTREE,
+	.wr_table =		&sta350_write_regs,
+	.rd_table =		&sta350_read_regs,
+	.volatile_table =	&sta350_volatile_regs,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id st350_dt_ids[] = {
+	{ .compatible = "st,sta350", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, st350_dt_ids);
+
+static const char const *sta350_ffx_modes[] = {
+	[STA350_FFX_PM_DROP_COMP]		= "drop-compensation",
+	[STA350_FFX_PM_TAPERED_COMP]		= "tapered-compensation",
+	[STA350_FFX_PM_FULL_POWER]		= "full-power-mode",
+	[STA350_FFX_PM_VARIABLE_DROP_COMP]	= "variable-drop-compensation",
+};
+
+static int sta350_probe_dt(struct device *dev, struct sta350_priv *sta350)
+{
+	struct device_node *np = dev->of_node;
+	struct sta350_platform_data *pdata;
+	const char *ffx_power_mode;
+	u16 tmp;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	sta350->gpio_nreset = of_get_named_gpio(np, "reset-gpio", 0);
+	sta350->gpio_power_down = of_get_named_gpio(np, "power-down-gpio", 0);
+
+	of_property_read_u8(np, "st,output-conf",
+			    &pdata->output_conf);
+	of_property_read_u8(np, "st,ch1-output-mapping",
+			    &pdata->ch1_output_mapping);
+	of_property_read_u8(np, "st,ch2-output-mapping",
+			    &pdata->ch2_output_mapping);
+	of_property_read_u8(np, "st,ch3-output-mapping",
+			    &pdata->ch3_output_mapping);
+
+	if (of_get_property(np, "st,thermal-warning-recovery", NULL))
+		pdata->thermal_warning_recovery = 1;
+	if (of_get_property(np, "st,thermal-warning-adjustment", NULL))
+		pdata->thermal_warning_adjustment = 1;
+	if (of_get_property(np, "st,fault-detect-recovery", NULL))
+		pdata->fault_detect_recovery = 1;
+
+	pdata->ffx_power_output_mode = STA350_FFX_PM_VARIABLE_DROP_COMP;
+	if (!of_property_read_string(np, "st,ffx-power-output-mode",
+				     &ffx_power_mode)) {
+		int i, mode = -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(sta350_ffx_modes); i++)
+			if (!strcasecmp(ffx_power_mode, sta350_ffx_modes[i]))
+				mode = i;
+
+		if (mode < 0)
+			dev_warn(dev, "Unsupported ffx output mode: %s\n",
+				 ffx_power_mode);
+		else
+			pdata->ffx_power_output_mode = mode;
+	}
+
+	tmp = 140;
+	of_property_read_u16(np, "st,drop-compensation-ns", &tmp);
+	pdata->drop_compensation_ns = clamp_t(u16, tmp, 0, 300) / 20;
+
+	if (of_get_property(np, "st,overcurrent-warning-adjustment", NULL))
+		pdata->oc_warning_adjustment = 1;
+
+	/* CONFE */
+	if (of_get_property(np, "st,max-power-use-mpcc", NULL))
+		pdata->max_power_use_mpcc = 1;
+
+	if (of_get_property(np, "st,max-power-correction", NULL))
+		pdata->max_power_correction = 1;
+
+	if (of_get_property(np, "st,am-reduction-mode", NULL))
+		pdata->am_reduction_mode = 1;
+
+	if (of_get_property(np, "st,odd-pwm-speed-mode", NULL))
+		pdata->odd_pwm_speed_mode = 1;
+
+	if (of_get_property(np, "st,distortion-compensation", NULL))
+		pdata->distortion_compensation = 1;
+
+	/* CONFF */
+	if (of_get_property(np, "st,invalid-input-detect-mute", NULL))
+		pdata->invalid_input_detect_mute = 1;
+
+	sta350->pdata = pdata;
+
+	return 0;
+}
+#endif
+
+static int sta350_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct sta350_priv *sta350;
+	int ret, i;
+
+	sta350 = devm_kzalloc(&i2c->dev, sizeof(struct sta350_priv),
+			      GFP_KERNEL);
+	if (!sta350)
+		return -ENOMEM;
+
+	sta350->pdata = dev_get_platdata(&i2c->dev);
+	sta350->gpio_nreset = -EINVAL;
+
+#ifdef CONFIG_OF
+	if (of_match_device(st350_dt_ids, &i2c->dev)) {
+		ret = sta350_probe_dt(&i2c->dev, sta350);
+		if (ret < 0)
+			return ret;
+	}
+#endif
+
+	/* regulators */
+	for (i = 0; i < ARRAY_SIZE(sta350->supplies); i++)
+		sta350->supplies[i].supply = sta350_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&i2c->dev, ARRAY_SIZE(sta350->supplies),
+				      sta350->supplies);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	sta350->regmap = devm_regmap_init_i2c(i2c, &sta350_regmap);
+	if (IS_ERR(sta350->regmap)) {
+		ret = PTR_ERR(sta350->regmap);
+		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(i2c, sta350);
+
+	ret = snd_soc_register_codec(&i2c->dev, &sta350_codec, &sta350_dai, 1);
+	if (ret < 0)
+		dev_err(&i2c->dev, "Failed to register codec (%d)\n", ret);
+
+	return ret;
+}
+
+static int sta350_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id sta350_i2c_id[] = {
+	{ "sta350", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sta350_i2c_id);
+
+static struct i2c_driver sta350_i2c_driver = {
+	.driver = {
+		.name = "sta350",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(st350_dt_ids),
+	},
+	.probe =    sta350_i2c_probe,
+	.remove =   sta350_i2c_remove,
+	.id_table = sta350_i2c_id,
+};
+
+module_i2c_driver(sta350_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC STA350 driver");
+MODULE_AUTHOR("Sven Brandau <info@brandau.biz>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/sta350.h b/sound/soc/codecs/sta350.h
new file mode 100644
index 0000000..c3248f0
--- /dev/null
+++ b/sound/soc/codecs/sta350.h
@@ -0,0 +1,228 @@
+/*
+ * Codec driver for ST STA350 2.1-channel high-efficiency digital audio system
+ *
+ * Copyright: 2011 Raumfeld GmbH
+ * Author: Sven Brandau <info@brandau.biz>
+ *
+ * based on code from:
+ *      Raumfeld GmbH
+ *        Johannes Stezenbach <js@sig21.net>
+ *	Wolfson Microelectronics PLC.
+ *	  Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef _ASOC_STA_350_H
+#define _ASOC_STA_350_H
+
+/* STA50 register addresses */
+
+#define STA350_REGISTER_COUNT	0x4D
+#define STA350_COEF_COUNT 62
+
+#define STA350_CONFA	0x00
+#define STA350_CONFB    0x01
+#define STA350_CONFC    0x02
+#define STA350_CONFD    0x03
+#define STA350_CONFE    0x04
+#define STA350_CONFF    0x05
+#define STA350_MMUTE    0x06
+#define STA350_MVOL     0x07
+#define STA350_C1VOL    0x08
+#define STA350_C2VOL    0x09
+#define STA350_C3VOL    0x0a
+#define STA350_AUTO1    0x0b
+#define STA350_AUTO2    0x0c
+#define STA350_AUTO3    0x0d
+#define STA350_C1CFG    0x0e
+#define STA350_C2CFG    0x0f
+#define STA350_C3CFG    0x10
+#define STA350_TONE     0x11
+#define STA350_L1AR     0x12
+#define STA350_L1ATRT   0x13
+#define STA350_L2AR     0x14
+#define STA350_L2ATRT   0x15
+#define STA350_CFADDR2  0x16
+#define STA350_B1CF1    0x17
+#define STA350_B1CF2    0x18
+#define STA350_B1CF3    0x19
+#define STA350_B2CF1    0x1a
+#define STA350_B2CF2    0x1b
+#define STA350_B2CF3    0x1c
+#define STA350_A1CF1    0x1d
+#define STA350_A1CF2    0x1e
+#define STA350_A1CF3    0x1f
+#define STA350_A2CF1    0x20
+#define STA350_A2CF2    0x21
+#define STA350_A2CF3    0x22
+#define STA350_B0CF1    0x23
+#define STA350_B0CF2    0x24
+#define STA350_B0CF3    0x25
+#define STA350_CFUD     0x26
+#define STA350_MPCC1    0x27
+#define STA350_MPCC2    0x28
+#define STA350_DCC1     0x29
+#define STA350_DCC2     0x2a
+#define STA350_FDRC1    0x2b
+#define STA350_FDRC2    0x2c
+#define STA350_STATUS   0x2d
+/* reserved: 0x2d - 0x30 */
+#define STA350_EQCFG    0x31
+#define STA350_EATH1    0x32
+#define STA350_ERTH1    0x33
+#define STA350_EATH2    0x34
+#define STA350_ERTH2    0x35
+#define STA350_CONFX    0x36
+#define STA350_SVCA     0x37
+#define STA350_SVCB     0x38
+#define STA350_RMS0A    0x39
+#define STA350_RMS0B    0x3a
+#define STA350_RMS0C    0x3b
+#define STA350_RMS1A    0x3c
+#define STA350_RMS1B    0x3d
+#define STA350_RMS1C    0x3e
+#define STA350_EVOLRES  0x3f
+/* reserved: 0x40 - 0x47 */
+#define STA350_NSHAPE   0x48
+#define STA350_CTXB4B1  0x49
+#define STA350_CTXB7B5  0x4a
+#define STA350_MISC1    0x4b
+#define STA350_MISC2    0x4c
+
+/* 0x00 CONFA */
+#define STA350_CONFA_MCS_MASK	0x03
+#define STA350_CONFA_MCS_SHIFT	0
+#define STA350_CONFA_IR_MASK	0x18
+#define STA350_CONFA_IR_SHIFT	3
+#define STA350_CONFA_TWRB	BIT(5)
+#define STA350_CONFA_TWAB	BIT(6)
+#define STA350_CONFA_FDRB	BIT(7)
+
+/* 0x01 CONFB */
+#define STA350_CONFB_SAI_MASK	0x0f
+#define STA350_CONFB_SAI_SHIFT	0
+#define STA350_CONFB_SAIFB	BIT(4)
+#define STA350_CONFB_DSCKE	BIT(5)
+#define STA350_CONFB_C1IM	BIT(6)
+#define STA350_CONFB_C2IM	BIT(7)
+
+/* 0x02 CONFC */
+#define STA350_CONFC_OM_MASK	0x03
+#define STA350_CONFC_OM_SHIFT	0
+#define STA350_CONFC_CSZ_MASK	0x3c
+#define STA350_CONFC_CSZ_SHIFT	2
+#define STA350_CONFC_OCRB	BIT(7)
+
+/* 0x03 CONFD */
+#define STA350_CONFD_HPB_SHIFT	0
+#define STA350_CONFD_DEMP_SHIFT	1
+#define STA350_CONFD_DSPB_SHIFT	2
+#define STA350_CONFD_PSL_SHIFT	3
+#define STA350_CONFD_BQL_SHIFT	4
+#define STA350_CONFD_DRC_SHIFT	5
+#define STA350_CONFD_ZDE_SHIFT	6
+#define STA350_CONFD_SME_SHIFT	7
+
+/* 0x04 CONFE */
+#define STA350_CONFE_MPCV	BIT(0)
+#define STA350_CONFE_MPCV_SHIFT	0
+#define STA350_CONFE_MPC	BIT(1)
+#define STA350_CONFE_MPC_SHIFT	1
+#define STA350_CONFE_NSBW	BIT(2)
+#define STA350_CONFE_NSBW_SHIFT	2
+#define STA350_CONFE_AME	BIT(3)
+#define STA350_CONFE_AME_SHIFT	3
+#define STA350_CONFE_PWMS	BIT(4)
+#define STA350_CONFE_PWMS_SHIFT	4
+#define STA350_CONFE_DCCV	BIT(5)
+#define STA350_CONFE_DCCV_SHIFT	5
+#define STA350_CONFE_ZCE	BIT(6)
+#define STA350_CONFE_ZCE_SHIFT	6
+#define STA350_CONFE_SVE	BIT(7)
+#define STA350_CONFE_SVE_SHIFT	7
+
+/* 0x05 CONFF */
+#define STA350_CONFF_OCFG_MASK	0x03
+#define STA350_CONFF_OCFG_SHIFT	0
+#define STA350_CONFF_IDE	BIT(2)
+#define STA350_CONFF_BCLE	BIT(3)
+#define STA350_CONFF_LDTE	BIT(4)
+#define STA350_CONFF_ECLE	BIT(5)
+#define STA350_CONFF_PWDN	BIT(6)
+#define STA350_CONFF_EAPD	BIT(7)
+
+/* 0x06 MMUTE */
+#define STA350_MMUTE_MMUTE		0x01
+#define STA350_MMUTE_MMUTE_SHIFT	0
+#define STA350_MMUTE_C1M		0x02
+#define STA350_MMUTE_C1M_SHIFT		1
+#define STA350_MMUTE_C2M		0x04
+#define STA350_MMUTE_C2M_SHIFT		2
+#define STA350_MMUTE_C3M		0x08
+#define STA350_MMUTE_C3M_SHIFT		3
+#define STA350_MMUTE_LOC_MASK		0xC0
+#define STA350_MMUTE_LOC_SHIFT		6
+
+/* 0x0b AUTO1 */
+#define STA350_AUTO1_AMGC_MASK	0x30
+#define STA350_AUTO1_AMGC_SHIFT	4
+
+/* 0x0c AUTO2 */
+#define STA350_AUTO2_AMAME	0x01
+#define STA350_AUTO2_AMAM_MASK	0x0e
+#define STA350_AUTO2_AMAM_SHIFT	1
+#define STA350_AUTO2_XO_MASK	0xf0
+#define STA350_AUTO2_XO_SHIFT	4
+
+/* 0x0d AUTO3 */
+#define STA350_AUTO3_PEQ_MASK	0x1f
+#define STA350_AUTO3_PEQ_SHIFT	0
+
+/* 0x0e 0x0f 0x10 CxCFG */
+#define STA350_CxCFG_TCB_SHIFT	0
+#define STA350_CxCFG_EQBP_SHIFT	1
+#define STA350_CxCFG_VBP_SHIFT	2
+#define STA350_CxCFG_BO_SHIFT	3
+#define STA350_CxCFG_LS_SHIFT	4
+#define STA350_CxCFG_OM_MASK	0xc0
+#define STA350_CxCFG_OM_SHIFT	6
+
+/* 0x11 TONE */
+#define STA350_TONE_BTC_SHIFT	0
+#define STA350_TONE_TTC_SHIFT	4
+
+/* 0x12 0x13 0x14 0x15 limiter attack/release */
+#define STA350_LxA_SHIFT	0
+#define STA350_LxR_SHIFT	4
+
+/* 0x26 CFUD */
+#define STA350_CFUD_W1		0x01
+#define STA350_CFUD_WA		0x02
+#define STA350_CFUD_R1		0x04
+#define STA350_CFUD_RA		0x08
+
+
+/* biquad filter coefficient table offsets */
+#define STA350_C1_BQ_BASE	0
+#define STA350_C2_BQ_BASE	20
+#define STA350_CH_BQ_NUM	4
+#define STA350_BQ_NUM_COEF	5
+#define STA350_XO_HP_BQ_BASE	40
+#define STA350_XO_LP_BQ_BASE	45
+#define STA350_C1_PRESCALE	50
+#define STA350_C2_PRESCALE	51
+#define STA350_C1_POSTSCALE	52
+#define STA350_C2_POSTSCALE	53
+#define STA350_C3_POSTSCALE	54
+#define STA350_TW_POSTSCALE	55
+#define STA350_C1_MIX1		56
+#define STA350_C1_MIX2		57
+#define STA350_C2_MIX1		58
+#define STA350_C2_MIX2		59
+#define STA350_C3_MIX1		60
+#define STA350_C3_MIX2		61
+
+#endif /* _ASOC_STA_350_H */
-- 
1.8.5.3
