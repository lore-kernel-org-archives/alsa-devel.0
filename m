From: "Reddy, MR Swami" <MR.Swami.Reddy@ti.com>
Subject: [PATCH] ASoC: Add support for TI LM49453 Audio codec
Date: Tue, 31 Jan 2012 03:59:57 -0800
Message-ID: <290463D19D2E064191F1F96ECA480A89434AAB43C3@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sc-mailgw05.nsc.com (mail2.nsc.com [12.238.8.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 42F8D246A9
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 13:00:53 +0100 (CET)
Received: from SCNTRDCSS6.nsc.com (scntrdcss6.nsc.com [10.188.130.177])
	by sc-mailgw05.nsc.com (Tumbleweed MailGate 3.7.1) with ESMTP id
	2DB7E17A892F
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 04:00:45 -0800 (PST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

ASoC: Add support for TI LM49453 Audio codec

Signed-off-by: MR Swami Reddy <MR.Swami.Reddy@ti.com>
---
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/lm49453.c | 1508 ++++++++
 sound/soc/codecs/lm49453.h |  384 ++
 4 files changed, 1898 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6943e24..ed5f66c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -32,6 +32,7 @@ config SND_SOC_ALL_CODECS
        select SND_SOC_DFBMCS320
        select SND_SOC_JZ4740_CODEC if SOC_JZ4740
        select SND_SOC_LM4857 if I2C
+       select SND_SOC_LM49453 if I2C
        select SND_SOC_MAX98088 if I2C
        select SND_SOC_MAX9850 if I2C
        select SND_SOC_MAX9877 if I2C
@@ -184,6 +185,9 @@ config SND_SOC_DFBMCS320
 config SND_SOC_DMIC
        tristate

+config SND_SOC_LM49453
+       tristate
+
 config SND_SOC_MAX98088
        tristate

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 379bc55..7bbfdb2 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -18,6 +18,7 @@ snd-soc-da7210-objs := da7210.o
 snd-soc-dfbmcs320-objs := dfbmcs320.o
 snd-soc-dmic-objs := dmic.o
 snd-soc-l3-objs := l3.o
+snd-soc-lm49453-objs := lm49453.o
 snd-soc-max98088-objs := max98088.o
 snd-soc-max9850-objs := max9850.o
 snd-soc-pcm3008-objs := pcm3008.o
@@ -106,6 +107,7 @@ obj-$(CONFIG_SND_SOC_DA7210)        += snd-soc-da7210.o
 obj-$(CONFIG_SND_SOC_DFBMCS320)        += snd-soc-dfbmcs320.o
 obj-$(CONFIG_SND_SOC_DMIC)     += snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_L3)       += snd-soc-l3.o
+obj-$(CONFIG_SND_SOC_LM49453)   += snd-soc-lm49453.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)     += snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_MAX98088) += snd-soc-max98088.o
 obj-$(CONFIG_SND_SOC_MAX9850)  += snd-soc-max9850.o
diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
new file mode 100644
index 0000000..f77647d
--- /dev/null
+++ b/sound/soc/codecs/lm49453.c
@@ -0,0 +1,1508 @@
+/*
+ * lm49453.c  -  LM49453 ALSA Soc Audio driver
+ *
+ * Copyright (c) 2012 Texas Instruments, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * Initially based on sound/soc/codecs/wm8350.c
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+#include <sound/jack.h>
+#include <sound/initval.h>
+#include <asm/div64.h>
+#include "lm49453.h"
+
+static struct reg_default lm49453_reg_defs[] = {
+       { 0, 0x00}, { 1, 0x00}, { 2, 0x00}, { 3, 0x00}, /*R3*/
+       { 4, 0x00}, { 5, 0x00}, { 6, 0x00}, { 7, 0x00}, /*R7*/
+       { 8, 0x00}, { 9, 0x00}, { 10, 0x00}, { 11, 0x00}, /*R11*/
+       { 12, 0x00}, { 13, 0x00}, { 14, 0x00}, { 15, 0x00}, /*R15*/
+       { 16, 0x00}, { 17, 0x00}, { 18, 0x00}, { 19, 0x00}, /*R19*/
+       { 20, 0x00}, { 21, 0x00}, { 22, 0x00}, { 23, 0x00}, /*R23*/
+       { 24, 0x00}, { 25, 0x00}, { 26, 0x00}, { 27, 0x00}, /*R27*/
+       { 28, 0x00}, { 29, 0x00}, { 30, 0x00}, { 31, 0x00}, /*R31*/
+       { 32, 0x00}, { 33, 0x00}, { 34, 0x00}, { 35, 0x00}, /*R35*/
+       { 36, 0x00}, { 37, 0x00}, { 38, 0x00}, { 39, 0x00}, /*R39*/
+       { 40, 0x00}, { 41, 0x00}, { 42, 0x00}, { 43, 0x00}, /*R43*/
+       { 44, 0x00}, { 45, 0x00}, { 46, 0x00}, { 47, 0x00}, /*R47*/
+       { 48, 0x00}, { 49, 0x00}, { 50, 0x00}, { 51, 0x00}, /*R51*/
+       { 52, 0x00}, { 53, 0x00}, { 54, 0x00}, { 55, 0x00}, /*R55*/
+       { 57, 0x00}, { 58, 0x00}, { 59, 0x00}, { 59, 0x00}, /*R59*/
+       { 60, 0x00}, { 61, 0x00}, { 62, 0x00}, { 63, 0x00}, /*R63*/
+       { 64, 0x00}, { 65, 0x00}, { 66, 0x00}, { 67, 0x00}, /*R67*/
+       { 68, 0x00}, { 69, 0x00}, { 70, 0x00}, { 71, 0x00}, /*R71*/
+       { 72, 0x00}, { 73, 0x00}, { 74, 0x00}, { 75, 0x00}, /*R75*/
+       { 76, 0x00}, { 77, 0x00}, { 78, 0x00}, { 79, 0x00}, /*R79*/
+       { 80, 0x00}, { 81, 0x00}, { 82, 0x00}, { 83, 0x00}, /*R83*/
+       { 85, 0x00}, { 85, 0x00}, { 86, 0x00}, { 87, 0x00}, /*R87*/
+       { 88, 0x00}, { 89, 0x00}, { 90, 0x00}, { 91, 0x00}, /*R91*/
+       { 92, 0x00}, { 93, 0x00}, { 94, 0x00}, { 95, 0x00}, /*R95*/
+       { 96, 0x01}, { 97, 0x00}, { 98, 0x00}, { 99, 0x00}, /*R99*/
+       { 100, 0x00}, { 101, 0x00}, { 102, 0x00}, { 103, 0x01}, /*R103*/
+       { 105, 0x01}, { 106, 0x00}, { 107, 0x01}, { 107, 0x00}, /*R107*/
+       { 108, 0x00}, { 109, 0x00}, { 110, 0x00}, { 111, 0x02}, /*R111*/
+       { 112, 0x02}, { 113, 0x00}, { 114, 0x00}, { 115, 0x00}, /*R115*/
+       { 116, 0x00}, { 117, 0x00}, { 118, 0x00}, { 119, 0x00}, /*R119*/
+       { 120, 0x00}, { 121, 0x80}, { 122, 0xBB}, { 123, 0x80}, /*R123*/
+       { 124, 0xBB}, { 125, 0x00}, { 126, 0x00}, { 127, 0x00}, /*R127*/
+       { 128, 0x00}, { 129, 0x00}, { 130, 0x00}, { 131, 0x00}, /*R131*/
+       { 132, 0x00}, { 133, 0x0A}, { 134, 0x0A}, { 135, 0x0A}, /*R135*/
+       { 136, 0x0F}, { 137, 0x00}, { 138, 0x73}, { 139, 0x33}, /*R139*/
+       { 140, 0x73}, { 141, 0x33}, { 142, 0x73}, { 143, 0x33}, /*R143*/
+       { 144, 0x73}, { 145, 0x33}, { 146, 0x73}, { 147, 0x33}, /*R147*/
+       { 148, 0x73}, { 149, 0x33}, { 150, 0x73}, { 151, 0x33}, /*R151*/
+       { 152, 0x00}, { 153, 0x00}, { 154, 0x00}, { 155, 0x00}, /*R155*/
+       { 156, 0x00}, { 157, 0x00}, { 158, 0x00}, { 159, 0x00}, /*R159*/
+       { 160, 0x00}, { 161, 0x00}, { 162, 0x00}, { 163, 0x00}, /*R163*/
+       { 164, 0x00}, { 165, 0x00}, { 166, 0x00}, { 167, 0x00}, /*R167*/
+       { 168, 0x00}, { 169, 0x00}, { 170, 0x00}, { 171, 0x00}, /*R171*/
+       { 172, 0x00}, { 173, 0x00}, { 174, 0x00}, { 175, 0x00}, /*R175*/
+       { 176, 0x00}, { 177, 0x00}, { 178, 0x00}, { 179, 0x00}, /*R179*/
+       { 180, 0x00}, { 181, 0x00}, { 182, 0x00}, { 183, 0x00}, /*R183*/
+       { 184, 0x00}, { 185, 0x00}, { 186, 0x00}, { 189, 0x00}, /*R187*/
+       { 188, 0x00}, { 189, 0x00}, { 190, 0x00}, { 191, 0x00}, /*R191*/
+       { 192, 0x00}, { 193, 0x00}, { 194, 0x00}, { 195, 0x00}, /*R195*/
+       { 196, 0x00}, { 197, 0x00}, { 198, 0x00}, { 199, 0x00}, /*R199*/
+       { 200, 0x00}, { 201, 0x00}, { 202, 0x00}, { 203, 0x00}, /*R203*/
+       { 204, 0x00}, { 205, 0x00}, { 206, 0x00}, { 207, 0x00}, /*R207*/
+       { 208, 0x00}, { 209, 0x00}, { 210, 0x00}, { 211, 0x00}, /*R211*/
+       { 212, 0x00}, { 213, 0x00}, { 214, 0x00}, { 215, 0x00}, /*R215*/
+       { 216, 0x00}, { 217, 0x00}, { 218, 0x00}, { 219, 0x00}, /*R219*/
+       { 221, 0x00}, { 222, 0x00}, { 223, 0x00}, { 224, 0x00}, /*R223*/
+       { 224, 0x00}, { 225, 0x00}, { 226, 0x00}, { 227, 0x00}, /*R227*/
+       { 228, 0x00}, { 229, 0x00}, { 230, 0x13}, { 231, 0x00}, /*R231*/
+       { 232, 0x80}, { 233, 0x0C}, { 234, 0xDD}, { 235, 0x00}, /*R235*/
+       { 236, 0x04}, { 237, 0x00}, { 238, 0x00}, { 239, 0x00}, /*R239*/
+       { 240, 0x00}, { 241, 0x00}, { 242, 0x00}, { 243, 0x00}, /*R243*/
+       { 244, 0x00}, { 245, 0x00}, { 246, 0x00}, { 247, 0x00}, /*R247*/
+       { 248, 0x00}, { 249, 0x00}, { 250, 0x00}, { 251, 0x00}, /*R251*/
+       { 252, 0x00}, { 253, 0x00}, { 254, 0x00}, { 255, 0x00}, /*R255*/
+};
+
+struct pll_state {
+       unsigned int in;
+       unsigned int out;
+};
+
+/* codec private data */
+struct lm49453_priv {
+       struct regmap *regmap;
+       struct pll_state pll1, pll2;
+       int fs_rate;
+       int sysclk;
+};
+
+/* capture path controls */
+
+static const char *lm49453_mic2mode_text[] = {"Single Ended", "Differential"};
+
+static const SOC_ENUM_SINGLE_DECL(lm49453_mic2mode_enum, LM49453_P0_MICR_REG,
+                                  5, lm49453_mic2mode_text);
+
+static const char *lm49453_dmic_cfg_text[] = {"DMIC1", "DMIC2"};
+
+static const SOC_ENUM_SINGLE_DECL(lm49453_dmic12_cfg_enum,
+                                 LM49453_P0_DIGITAL_MIC1_CONFIG_REG,
+                                 7, lm49453_dmic_cfg_text);
+
+static const SOC_ENUM_SINGLE_DECL(lm49453_dmic34_cfg_enum,
+                                 LM49453_P0_DIGITAL_MIC2_CONFIG_REG,
+                                 7, lm49453_dmic_cfg_text);
+
+/* MUX Controls */
+static const char *lm49453_adcl_mux_text[] = { "MIC1", "Aux_L" };
+
+static const char *lm49453_adcr_mux_text[] = { "MIC2", "Aux_R" };
+
+static const struct soc_enum lm49453_adcl_enum =
+       SOC_ENUM_SINGLE(LM49453_P0_ANALOG_MIXER_ADC_REG, 0,
+                       ARRAY_SIZE(lm49453_adcl_mux_text),
+                       lm49453_adcl_mux_text);
+
+static const struct soc_enum lm49453_adcr_enum =
+       SOC_ENUM_SINGLE(LM49453_P0_ANALOG_MIXER_ADC_REG, 1,
+                       ARRAY_SIZE(lm49453_adcr_mux_text),
+                       lm49453_adcr_mux_text);
+
+static const struct snd_kcontrol_new lm49453_headset_left_mixer[] = {
+SOC_DAPM_SINGLE("Port1_1 Switch", LM49453_P0_DACHPL1_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("Port1_2 Switch", LM49453_P0_DACHPL1_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("Port1_3 Switch", LM49453_P0_DACHPL1_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("Port1_4 Switch", LM49453_P0_DACHPL1_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("Port1_5 Switch", LM49453_P0_DACHPL1_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("Port1_6 Switch", LM49453_P0_DACHPL1_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_7 Switch", LM49453_P0_DACHPL1_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port1_8 Switch", LM49453_P0_DACHPL1_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_DACHPL2_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_DACHPL2_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_DACHPL2_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_DACHPL2_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_DACHPL2_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_DACHPL2_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port2_1 Switch", LM49453_P0_DACHPL2_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_DACHPL2_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("Sidetone Switch", LM49453_P0_STN_SEL_REG, 0, 0, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_headset_right_mixer[] = {
+SOC_DAPM_SINGLE("Port1_1 Switch", LM49453_P0_DACHPR1_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("Port1_2 Switch", LM49453_P0_DACHPR1_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("Port1_3 Switch", LM49453_P0_DACHPR1_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("Port1_4 Switch", LM49453_P0_DACHPR1_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("Port1_5 Switch", LM49453_P0_DACHPR1_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("Port1_6 Switch", LM49453_P0_DACHPR1_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_7 Switch", LM49453_P0_DACHPR1_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port1_8 Switch", LM49453_P0_DACHPR1_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_DACHPR2_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_DACHPR2_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_DACHPR2_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_DACHPR2_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_DACHPR2_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_DACHPR2_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port2_1 Switch", LM49453_P0_DACHPR2_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_DACHPR2_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("Sidetone Switch", LM49453_P0_STN_SEL_REG, 1, 0, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_speaker_left_mixer[] = {
+SOC_DAPM_SINGLE("Port1_1 Switch", LM49453_P0_DACLSL1_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("Port1_2 Switch", LM49453_P0_DACLSL1_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("Port1_3 Switch", LM49453_P0_DACLSL1_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("Port1_4 Switch", LM49453_P0_DACLSL1_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("Port1_5 Switch", LM49453_P0_DACLSL1_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("Port1_6 Switch", LM49453_P0_DACLSL1_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_7 Switch", LM49453_P0_DACLSL1_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port1_8 Switch", LM49453_P0_DACLSL1_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_DACLSL2_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_DACLSL2_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_DACLSL2_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_DACLSL2_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_DACLSL2_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_DACLSL2_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port2_1 Switch", LM49453_P0_DACLSL2_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_DACLSL2_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("Sidetone Switch", LM49453_P0_STN_SEL_REG, 2, 0, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_speaker_right_mixer[] = {
+SOC_DAPM_SINGLE("Port1_1 Switch", LM49453_P0_DACLSR1_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("Port1_2 Switch", LM49453_P0_DACLSR1_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("Port1_3 Switch", LM49453_P0_DACLSR1_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("Port1_4 Switch", LM49453_P0_DACLSR1_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("Port1_5 Switch", LM49453_P0_DACLSR1_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("Port1_6 Switch", LM49453_P0_DACLSR1_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_7 Switch", LM49453_P0_DACLSR1_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port1_8 Switch", LM49453_P0_DACLSR1_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_DACLSR2_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_DACLSR2_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_DACLSR2_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_DACLSR2_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_DACLSR2_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_DACLSR2_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port2_1 Switch", LM49453_P0_DACLSR2_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_DACLSR2_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("Sidetone Switch", LM49453_P0_STN_SEL_REG, 3, 0, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_haptic_left_mixer[] = {
+SOC_DAPM_SINGLE("Port1_1 Switch", LM49453_P0_DACHAL1_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("Port1_2 Switch", LM49453_P0_DACHAL1_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("Port1_3 Switch", LM49453_P0_DACHAL1_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("Port1_4 Switch", LM49453_P0_DACHAL1_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("Port1_5 Switch", LM49453_P0_DACHAL1_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("Port1_6 Switch", LM49453_P0_DACHAL1_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_7 Switch", LM49453_P0_DACHAL1_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port1_8 Switch", LM49453_P0_DACHAL1_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_DACHAL2_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_DACHAL2_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_DACHAL2_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_DACHAL2_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_DACHAL2_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_DACHAL2_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port2_1 Switch", LM49453_P0_DACHAL2_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_DACHAL2_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("Sidetone Switch", LM49453_P0_STN_SEL_REG, 4, 0, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_haptic_right_mixer[] = {
+SOC_DAPM_SINGLE("Port1_1 Switch", LM49453_P0_DACHAR1_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("Port1_2 Switch", LM49453_P0_DACHAR1_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("Port1_3 Switch", LM49453_P0_DACHAR1_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("Port1_4 Switch", LM49453_P0_DACHAR1_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("Port1_5 Switch", LM49453_P0_DACHAR1_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("Port1_6 Switch", LM49453_P0_DACHAR1_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_7 Switch", LM49453_P0_DACHAR1_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port1_8 Switch", LM49453_P0_DACHAR1_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_DACHAR2_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_DACHAR2_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_DACHAR2_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_DACHAR2_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_DACHAR2_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_DACHAR2_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port2_1 Switch", LM49453_P0_DACHAR2_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_DACHAR2_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("Sidetone Switch", LM49453_P0_STN_SEL_REG, 5, 0, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_lineout_left_mixer[] = {
+SOC_DAPM_SINGLE("Port1_1 Switch", LM49453_P0_DACLOL1_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("Port1_2 Switch", LM49453_P0_DACLOL1_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("Port1_3 Switch", LM49453_P0_DACLOL1_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("Port1_4 Switch", LM49453_P0_DACLOL1_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("Port1_5 Switch", LM49453_P0_DACLOL1_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("Port1_6 Switch", LM49453_P0_DACLOL1_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_7 Switch", LM49453_P0_DACLOL1_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port1_8 Switch", LM49453_P0_DACLOL1_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_DACLOL2_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_DACLOL2_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_DACLOL2_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_DACLOL2_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_DACLOL2_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_DACLOL2_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port2_1 Switch", LM49453_P0_DACLOL2_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_DACLOL2_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("Sidetone Switch", LM49453_P0_STN_SEL_REG, 6, 0, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_lineout_right_mixer[] = {
+SOC_DAPM_SINGLE("Port1_1 Switch", LM49453_P0_DACLOR1_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("Port1_2 Switch", LM49453_P0_DACLOR1_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("Port1_3 Switch", LM49453_P0_DACLOR1_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("Port1_4 Switch", LM49453_P0_DACLOR1_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("Port1_5 Switch", LM49453_P0_DACLOR1_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("Port1_6 Switch", LM49453_P0_DACLOR1_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_7 Switch", LM49453_P0_DACLOR1_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port1_8 Switch", LM49453_P0_DACLOR1_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_DACLOR2_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_DACLOR2_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_DACLOR2_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_DACLOR2_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_DACLOR2_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_DACLOR2_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port2_1 Switch", LM49453_P0_DACLOR2_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_DACLOR2_REG, 7, 1, 0),
+SOC_DAPM_SINGLE("Sidetone Switch", LM49453_P0_STN_SEL_REG, 7, 0, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_port1_tx1_mixer[] = {
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_PORT1_TX1_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_PORT1_TX1_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_PORT1_TX1_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_PORT1_TX1_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_PORT1_TX1_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_PORT1_TX1_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_1 Switch", LM49453_P0_PORT1_TX1_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_1 Switch", LM49453_P0_PORT1_TX1_REG, 7, 1, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_port1_tx2_mixer[] = {
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_PORT1_TX2_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_PORT1_TX2_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_PORT1_TX2_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_PORT1_TX2_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_PORT1_TX2_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_PORT1_TX2_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_2 Switch", LM49453_P0_PORT1_TX2_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_PORT1_TX2_REG, 7, 1, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_port1_tx3_mixer[] = {
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_PORT1_TX3_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_PORT1_TX3_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_PORT1_TX3_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_PORT1_TX3_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_PORT1_TX3_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_PORT1_TX3_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_3 Switch", LM49453_P0_PORT1_TX3_REG, 6, 1, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_port1_tx4_mixer[] = {
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_PORT1_TX4_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_PORT1_TX4_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_PORT1_TX4_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_PORT1_TX4_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_PORT1_TX4_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_PORT1_TX4_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_4 Switch", LM49453_P0_PORT1_TX4_REG, 6, 1, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_port1_tx5_mixer[] = {
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_PORT1_TX5_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_PORT1_TX5_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_PORT1_TX5_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_PORT1_TX5_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_PORT1_TX5_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_PORT1_TX5_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_5 Switch", LM49453_P0_PORT1_TX5_REG, 6, 1, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_port1_tx6_mixer[] = {
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_PORT1_TX6_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_PORT1_TX6_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_PORT1_TX6_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_PORT1_TX6_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_PORT1_TX6_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_PORT1_TX6_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_6 Switch", LM49453_P0_PORT1_TX6_REG, 6, 1, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_port1_tx7_mixer[] = {
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_PORT1_TX7_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_PORT1_TX7_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_PORT1_TX7_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_PORT1_TX7_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_PORT1_TX7_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_PORT1_TX7_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_7 Switch", LM49453_P0_PORT1_TX7_REG, 6, 1, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_port1_tx8_mixer[] = {
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_PORT1_TX8_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_PORT1_TX8_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_PORT1_TX8_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_PORT1_TX8_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_PORT1_TX8_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_PORT1_TX8_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_8 Switch", LM49453_P0_PORT1_TX8_REG, 6, 1, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_port2_tx1_mixer[] = {
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_PORT2_TX1_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_PORT2_TX1_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_PORT2_TX1_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_PORT2_TX1_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_PORT2_TX1_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_PORT2_TX1_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_1 Switch", LM49453_P0_PORT2_TX1_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_1 Switch", LM49453_P0_PORT2_TX1_REG, 7, 1, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_port2_tx2_mixer[] = {
+SOC_DAPM_SINGLE("DMIC1L Switch", LM49453_P0_PORT2_TX2_REG, 0, 1, 0),
+SOC_DAPM_SINGLE("DMIC1R Switch", LM49453_P0_PORT2_TX2_REG, 1, 1, 0),
+SOC_DAPM_SINGLE("DMIC2L Switch", LM49453_P0_PORT2_TX2_REG, 2, 1, 0),
+SOC_DAPM_SINGLE("DMIC2R Switch", LM49453_P0_PORT2_TX2_REG, 3, 1, 0),
+SOC_DAPM_SINGLE("ADCL Switch", LM49453_P0_PORT2_TX2_REG, 4, 1, 0),
+SOC_DAPM_SINGLE("ADCR Switch", LM49453_P0_PORT2_TX2_REG, 5, 1, 0),
+SOC_DAPM_SINGLE("Port1_2 Switch", LM49453_P0_PORT2_TX2_REG, 6, 1, 0),
+SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_PORT2_TX2_REG, 7, 1, 0),
+};
+
+/* TLV Declarations */
+static const DECLARE_TLV_DB_SCALE(digital_tlv, -7650, 150, 1);
+static const DECLARE_TLV_DB_SCALE(port_tlv, 0, 600, 0);
+
+static const struct snd_kcontrol_new lm49453_sidetone_mixer_controls[] = {
+/* Sidetone supports mono only */
+SOC_SINGLE_TLV("Sidetone ADCL Volume", LM49453_P0_STN_VOL_ADCL_REG,
+               0, 0x3F, 0, digital_tlv),
+SOC_SINGLE_TLV("Sidetone ADCR Volume", LM49453_P0_STN_VOL_ADCR_REG,
+               0, 0x3F, 0, digital_tlv),
+SOC_SINGLE_TLV("Sidetone DMIC1L Volume", LM49453_P0_STN_VOL_DMIC1L_REG,
+               0, 0x3F, 0, digital_tlv),
+SOC_SINGLE_TLV("Sidetone DMIC1R Volume", LM49453_P0_STN_VOL_DMIC1R_REG,
+               0, 0x3F, 0, digital_tlv),
+SOC_SINGLE_TLV("Sidetone DMIC2L Volume", LM49453_P0_STN_VOL_DMIC2L_REG,
+               0, 0x3F, 0, digital_tlv),
+SOC_SINGLE_TLV("Sidetone DMIC2R Volume", LM49453_P0_STN_VOL_DMIC2R_REG,
+               0, 0x3F, 0, digital_tlv),
+SOC_DAPM_SINGLE("Sidetone Enable Switch", LM49453_P0_DMIX_CLK_SEL_REG, 2, 1, 0),
+};
+
+static const struct snd_kcontrol_new lm49453_snd_controls[] = {
+       /* mic1 and mic2 supports mono only */
+       SOC_SINGLE_TLV("Mic1 Volume", LM49453_P0_ADC_LEVELL_REG, 0, 6,
+                       0, digital_tlv),
+       SOC_SINGLE_TLV("Mic2 Volume", LM49453_P0_ADC_LEVELR_REG, 0, 6,
+                       0, digital_tlv),
+
+       SOC_DOUBLE_R_TLV("DMIC1 Volume", LM49453_P0_DMIC1_LEVELL_REG,
+                         LM49453_P0_DMIC1_LEVELR_REG, 0, 6, 0, digital_tlv),
+       SOC_DOUBLE_R_TLV("DMIC2 Volume", LM49453_P0_DMIC2_LEVELL_REG,
+                         LM49453_P0_DMIC2_LEVELR_REG, 0, 6, 0, digital_tlv),
+
+       SOC_DAPM_ENUM("Mic2Mode", lm49453_mic2mode_enum),
+       SOC_DAPM_ENUM("DMIC12 SRC", lm49453_dmic12_cfg_enum),
+       SOC_DAPM_ENUM("DMIC34 SRC", lm49453_dmic34_cfg_enum),
+
+       /* Capture path filter enable */
+       SOC_DAPM_SINGLE("DMIC1 HPFilter Switch",
+                       LM49453_P0_ADC_FX_ENABLES_REG, 0, 1, 0),
+       SOC_DAPM_SINGLE("DMIC2 HPFilter Switch",
+                       LM49453_P0_ADC_FX_ENABLES_REG, 1, 1, 0),
+       SOC_DAPM_SINGLE("ADC HPFilter Switch",
+                       LM49453_P0_ADC_FX_ENABLES_REG, 2, 1, 0),
+
+       SOC_DOUBLE_R_TLV("DAC HP Volume", LM49453_P0_DAC_HP_LEVELL_REG,
+                         LM49453_P0_DAC_HP_LEVELR_REG, 0, 6, 0, digital_tlv),
+       SOC_DOUBLE_R_TLV("DAC LO Volume", LM49453_P0_DAC_LO_LEVELL_REG,
+                         LM49453_P0_DAC_LO_LEVELR_REG, 0, 6, 0, digital_tlv),
+       SOC_DOUBLE_R_TLV("DAC LS Volume", LM49453_P0_DAC_LS_LEVELL_REG,
+                         LM49453_P0_DAC_LS_LEVELR_REG, 0, 6, 0, digital_tlv),
+       SOC_DOUBLE_R_TLV("DAC HA Volume", LM49453_P0_DAC_HA_LEVELL_REG,
+                         LM49453_P0_DAC_HA_LEVELR_REG, 0, 6, 0, digital_tlv),
+
+       SOC_SINGLE_TLV("EP Volume", LM49453_P0_DAC_LS_LEVELL_REG,
+                       0, 6, 0, digital_tlv),
+
+       SOC_SINGLE_TLV("PORT1_1_RX_LVL Volume", LM49453_P0_PORT1_RX_LVL1_REG,
+                       0, 3, 0, port_tlv),
+       SOC_SINGLE_TLV("PORT1_2_RX_LVL Volume", LM49453_P0_PORT1_RX_LVL1_REG,
+                       2, 3, 0, port_tlv),
+       SOC_SINGLE_TLV("PORT1_3_RX_LVL Volume", LM49453_P0_PORT1_RX_LVL1_REG,
+                       4, 3, 0, port_tlv),
+       SOC_SINGLE_TLV("PORT1_4_RX_LVL Volume", LM49453_P0_PORT1_RX_LVL1_REG,
+                       6, 3, 0, port_tlv),
+       SOC_SINGLE_TLV("PORT1_5_RX_LVL Volume", LM49453_P0_PORT1_RX_LVL2_REG,
+                       0, 3, 0, port_tlv),
+       SOC_SINGLE_TLV("PORT1_6_RX_LVL Volume", LM49453_P0_PORT1_RX_LVL2_REG,
+                       2, 3, 0, port_tlv),
+       SOC_SINGLE_TLV("PORT1_7_RX_LVL Volume", LM49453_P0_PORT1_RX_LVL2_REG,
+                       4, 3, 0, port_tlv),
+       SOC_SINGLE_TLV("PORT1_8_RX_LVL Volume", LM49453_P0_PORT1_RX_LVL2_REG,
+                       6, 3, 0, port_tlv),
+
+       SOC_SINGLE_TLV("PORT2_1_RX_LVL Volume", LM49453_P0_PORT2_RX_LVL_REG,
+                       0, 3, 0, port_tlv),
+       SOC_SINGLE_TLV("PORT2_2_RX_LVL Volume", LM49453_P0_PORT2_RX_LVL_REG,
+                       2, 3, 0, port_tlv),
+};
+
+/* DAPM widgets */
+static const struct snd_soc_dapm_widget lm49453_dapm_widgets[] = {
+
+       /* All end points HP,EP, LS, Lineout and Haptic */
+       SND_SOC_DAPM_OUTPUT("HPOUTL"),
+       SND_SOC_DAPM_OUTPUT("HPOUTR"),
+       SND_SOC_DAPM_OUTPUT("EPOUT"),
+       SND_SOC_DAPM_OUTPUT("LSOUTL"),
+       SND_SOC_DAPM_OUTPUT("LSOUTR"),
+       SND_SOC_DAPM_OUTPUT("LOOUTR"),
+       SND_SOC_DAPM_OUTPUT("LOOUTL"),
+       SND_SOC_DAPM_OUTPUT("HAOUTL"),
+       SND_SOC_DAPM_OUTPUT("HAOUTR"),
+
+       SND_SOC_DAPM_INPUT("AMIC1"),
+       SND_SOC_DAPM_INPUT("AMIC2"),
+       SND_SOC_DAPM_INPUT("DMIC1"),
+       SND_SOC_DAPM_INPUT("DMIC2"),
+       SND_SOC_DAPM_INPUT("AUXL"),
+       SND_SOC_DAPM_INPUT("AUXR"),
+
+       SND_SOC_DAPM_PGA("PORT1_1_RX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_PGA("PORT1_2_RX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_PGA("PORT1_3_RX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_PGA("PORT1_4_RX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_PGA("PORT1_5_RX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_PGA("PORT1_6_RX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_PGA("PORT1_7_RX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_PGA("PORT1_8_RX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_PGA("PORT2_1_RX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_PGA("PORT2_2_RX", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+       SND_SOC_DAPM_SUPPLY("AMIC1Bias", LM49453_P0_MICL_REG, 6, 0, NULL, 0),
+       SND_SOC_DAPM_SUPPLY("AMIC2Bias", LM49453_P0_MICR_REG, 6, 0, NULL, 0),
+
+       /* playback path driver enables */
+       SND_SOC_DAPM_OUT_DRV("Headset Enable",
+                       LM49453_P0_PMC_SETUP_REG, 0, 0, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("Earpiece Enable",
+                       LM49453_P0_EP_REG, 0, 0, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("Speaker Left Enable",
+                       LM49453_P0_DIS_PKVL_FB_REG, 0, 1, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("Speaker Right Enable",
+                       LM49453_P0_DIS_PKVL_FB_REG, 1, 1, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("Haptic Left Enable",
+                       LM49453_P0_DIS_PKVL_FB_REG, 2, 1, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("Haptic Right Enable",
+                       LM49453_P0_DIS_PKVL_FB_REG, 3, 1, NULL, 0),
+
+       /* DAC */
+       SND_SOC_DAPM_DAC("HPL DAC", "Headset", SND_SOC_NOPM, 0, 0),
+       SND_SOC_DAPM_DAC("HPR DAC", "Headset", SND_SOC_NOPM, 0, 0),
+       SND_SOC_DAPM_DAC("LSL DAC", "Speaker", SND_SOC_NOPM, 0, 0),
+       SND_SOC_DAPM_DAC("LSR DAC", "Speaker", SND_SOC_NOPM, 0, 0),
+       SND_SOC_DAPM_DAC("HAL DAC", "Haptic", SND_SOC_NOPM, 0, 0),
+       SND_SOC_DAPM_DAC("HAR DAC", "Haptic", SND_SOC_NOPM, 0, 0),
+       SND_SOC_DAPM_DAC("LOL DAC", "Lineout", SND_SOC_NOPM, 0, 0),
+       SND_SOC_DAPM_DAC("LOR DAC", "Lineout", SND_SOC_NOPM, 0, 0),
+
+
+       SND_SOC_DAPM_PGA("AUXL Input",
+                       LM49453_P0_ANALOG_MIXER_ADC_REG, 2, 0, NULL, 0),
+       SND_SOC_DAPM_PGA("AUXR Input",
+                       LM49453_P0_ANALOG_MIXER_ADC_REG, 3, 0, NULL, 0),
+
+       SND_SOC_DAPM_PGA("Sidetone", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+       /* ADC */
+       SND_SOC_DAPM_ADC("ADC Left", "Capture", SND_SOC_NOPM, 1, 0),
+       SND_SOC_DAPM_ADC("ADC Right", "Capture", SND_SOC_NOPM, 0, 0),
+
+       SND_SOC_DAPM_MUX("ADCL Mux", SND_SOC_NOPM, 0, 0,
+                         &lm49453_adcl_mux_control),
+       SND_SOC_DAPM_MUX("ADCR Mux", SND_SOC_NOPM, 0, 0,
+                         &lm49453_adcr_mux_control),
+
+       SND_SOC_DAPM_MUX("Mic1 Input",
+                       SND_SOC_NOPM, 0, 0, &lm49453_adcl_mux_control),
+
+       SND_SOC_DAPM_MUX("Mic2 Input",
+                       SND_SOC_NOPM, 0, 0, &lm49453_adcr_mux_control),
+
+       /* AIF */
+       SND_SOC_DAPM_AIF_IN("PORT1_SDI", NULL, 0,
+                           LM49453_P0_PULL_CONFIG1_REG, 2, 0),
+       SND_SOC_DAPM_AIF_IN("PORT2_SDI", NULL, 0,
+                           LM49453_P0_PULL_CONFIG1_REG, 6, 0),
+
+       SND_SOC_DAPM_AIF_OUT("PORT1_SDO", NULL, 0,
+                            LM49453_P0_PULL_CONFIG1_REG, 3, 0),
+       SND_SOC_DAPM_AIF_OUT("PORT2_SDO", NULL, 0,
+                             LM49453_P0_PULL_CONFIG1_REG, 7, 0),
+
+       /* Port1 TX controls */
+       SND_SOC_DAPM_OUT_DRV("P1_1_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("P1_2_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("P1_3_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("P1_4_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("P1_5_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("P1_6_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("P1_7_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("P1_8_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+       /* Port2 TX controls */
+       SND_SOC_DAPM_OUT_DRV("P2_1_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
+       SND_SOC_DAPM_OUT_DRV("P2_2_TX", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+       SND_SOC_DAPM_MIXER("Port1 Playback", LM49453_P0_AUDIO_PORT1_BASIC_REG,
+                           1, 0, NULL, 0),
+       SND_SOC_DAPM_MIXER("Port2 Playback", LM49453_P0_AUDIO_PORT2_BASIC_REG,
+                           1, 0, NULL, 0),
+
+       SND_SOC_DAPM_MIXER("Port1 Capture", LM49453_P0_AUDIO_PORT1_BASIC_REG,
+                           2, 0, NULL, 0),
+       SND_SOC_DAPM_MIXER("Port2 Capture", LM49453_P0_AUDIO_PORT2_BASIC_REG,
+                           2, 0, NULL, 0),
+
+       /* Sidetone Mixer */
+       SND_SOC_DAPM_MIXER("Sidetone Mixer", SND_SOC_NOPM, 0, 0,
+                           &lm49453_sidetone_mixer_controls,
+                           ARRAY_SIZE(lm49453_sidetone_mixer_controls)),
+
+       /* DAC MIXERS */
+       SND_SOC_DAPM_MIXER("HPL Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_headset_left_mixer,
+                           ARRAY_SIZE(lm49453_headset_left_mixer)),
+       SND_SOC_DAPM_MIXER("HPR Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_headset_right_mixer,
+                           ARRAY_SIZE(lm49453_headset_right_mixer)),
+       SND_SOC_DAPM_MIXER("LOL Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_lineout_left_mixer,
+                           ARRAY_SIZE(lm49453_lineout_left_mixer)),
+       SND_SOC_DAPM_MIXER("LOR Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_lineout_right_mixer,
+                           ARRAY_SIZE(lm49453_lineout_right_mixer)),
+       SND_SOC_DAPM_MIXER("LSL Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_speaker_left_mixer,
+                           ARRAY_SIZE(lm49453_speaker_left_mixer)),
+       SND_SOC_DAPM_MIXER("LSR Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_speaker_right_mixer,
+                           ARRAY_SIZE(lm49453_speaker_right_mixer)),
+       SND_SOC_DAPM_MIXER("HAL Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_haptic_left_mixer,
+                           ARRAY_SIZE(lm49453_haptic_left_mixer)),
+       SND_SOC_DAPM_MIXER("HAR Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_haptic_right_mixer,
+                           ARRAY_SIZE(lm49453_haptic_right_mixer)),
+
+       /* Capture Mixer */
+       SND_SOC_DAPM_MIXER("Port1_1 Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_port1_tx1_mixer,
+                           ARRAY_SIZE(lm49453_port1_tx1_mixer)),
+       SND_SOC_DAPM_MIXER("Port1_2 Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_port1_tx2_mixer,
+                           ARRAY_SIZE(lm49453_port1_tx2_mixer)),
+       SND_SOC_DAPM_MIXER("Port1_3 Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_port1_tx3_mixer,
+                           ARRAY_SIZE(lm49453_port1_tx3_mixer)),
+       SND_SOC_DAPM_MIXER("Port1_4 Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_port1_tx4_mixer,
+                           ARRAY_SIZE(lm49453_port1_tx4_mixer)),
+       SND_SOC_DAPM_MIXER("Port1_5 Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_port1_tx5_mixer,
+                           ARRAY_SIZE(lm49453_port1_tx5_mixer)),
+       SND_SOC_DAPM_MIXER("Port1_6 Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_port1_tx6_mixer,
+                           ARRAY_SIZE(lm49453_port1_tx6_mixer)),
+       SND_SOC_DAPM_MIXER("Port1_7 Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_port1_tx7_mixer,
+                           ARRAY_SIZE(lm49453_port1_tx7_mixer)),
+       SND_SOC_DAPM_MIXER("Port1_8 Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_port1_tx8_mixer,
+                           ARRAY_SIZE(lm49453_port1_tx8_mixer)),
+
+       SND_SOC_DAPM_MIXER("Port2_1 Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_port2_tx1_mixer,
+                           ARRAY_SIZE(lm49453_port2_tx1_mixer)),
+       SND_SOC_DAPM_MIXER("Port2_2 Mixer", SND_SOC_NOPM, 0, 0,
+                           lm49453_port2_tx2_mixer,
+                           ARRAY_SIZE(lm49453_port2_tx2_mixer)),
+};
+
+static const struct snd_soc_dapm_route lm49453_audio_map[] = {
+       /* Port SDI mapping */
+       { "PORT1_1_RX", NULL, "PORT1_SDI" },
+       { "PORT1_2_RX", NULL, "PORT1_SDI" },
+       { "PORT1_3_RX", NULL, "PORT1_SDI" },
+       { "PORT1_4_RX", NULL, "PORT1_SDI" },
+       { "PORT1_5_RX", NULL, "PORT1_SDI" },
+       { "PORT1_6_RX", NULL, "PORT1_SDI" },
+       { "PORT1_7_RX", NULL, "PORT1_SDI" },
+       { "PORT1_8_RX", NULL, "PORT1_SDI" },
+
+       { "PORT2_1_RX", NULL, "PORT2_SDI" },
+       { "PORT2_2_RX", NULL, "PORT2_SDI" },
+
+       /* HP mapping */
+       { "HPL Mixer", "Port1_1 Switch", "PORT1_1_RX" },
+       { "HPL Mixer", "Port1_2 Switch", "PORT1_2_RX" },
+       { "HPL Mixer", "Port1_3 Switch", "PORT1_3_RX" },
+       { "HPL Mixer", "Port1_4 Switch", "PORT1_4_RX" },
+       { "HPL Mixer", "Port1_5 Switch", "PORT1_5_RX" },
+       { "HPL Mixer", "Port1_6 Switch", "PORT1_6_RX" },
+       { "HPL Mixer", "Port1_7 Switch", "PORT1_7_RX" },
+       { "HPL Mixer", "Port1_8 Switch", "PORT1_8_RX" },
+
+       { "HPL Mixer", "Port2_1 Switch", "PORT2_1_RX" },
+       { "HPL Mixer", "Port2_2 Switch", "PORT2_2_RX" },
+
+       { "HPL Mixer", "ADCL Switch", "ADC Left" },
+       { "HPL Mixer", "ADCR Switch", "ADC Right" },
+       { "HPL Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "HPL Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "HPL Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "HPL Mixer", "DMIC2R Switch", "DMIC2 Right" },
+       { "HPL Mixer", "Sidetone Switch", "Sidetone" },
+
+       { "HPL DAC", NULL, "HPL Mixer" },
+
+       { "HPR Mixer", "Port1_1 Switch", "PORT1_1_RX" },
+       { "HPR Mixer", "Port1_2 Switch", "PORT1_2_RX" },
+       { "HPR Mixer", "Port1_3 Switch", "PORT1_3_RX" },
+       { "HPR Mixer", "Port1_4 Switch", "PORT1_4_RX" },
+       { "HPR Mixer", "Port1_5 Switch", "PORT1_5_RX" },
+       { "HPR Mixer", "Port1_6 Switch", "PORT1_6_RX" },
+       { "HPR Mixer", "Port1_7 Switch", "PORT1_7_RX" },
+       { "HPR Mixer", "Port1_8 Switch", "PORT1_8_RX" },
+
+       /* Port 2 */
+       { "HPR Mixer", "Port2_1 Switch", "PORT2_1_RX" },
+       { "HPR Mixer", "Port2_2 Switch", "PORT2_2_RX" },
+
+       { "HPR Mixer", "ADCL Switch", "ADC Left" },
+       { "HPR Mixer", "ADCR Switch", "ADC Right" },
+       { "HPR Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "HPR Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "HPR Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "HPR Mixer", "DMIC2L Switch", "DMIC2 Right" },
+       { "HPR Mixer", "Sidetone Switch", "Sidetone" },
+
+       { "HPR DAC", NULL, "HPR Mixer" },
+
+       { "HPOUTL", "Headset Enable", "HPL DAC"},
+       { "HPOUTR", "Headset Enable", "HPR DAC"},
+
+       /* EP map */
+       { "EPOUT", "Earpiece Enable", "HPL DAC" },
+
+       /* Speaker map */
+       { "LSL Mixer", "Port1_1 Switch", "PORT1_1_RX" },
+       { "LSL Mixer", "Port1_2 Switch", "PORT1_2_RX" },
+       { "LSL Mixer", "Port1_3 Switch", "PORT1_3_RX" },
+       { "LSL Mixer", "Port1_4 Switch", "PORT1_4_RX" },
+       { "LSL Mixer", "Port1_5 Switch", "PORT1_5_RX" },
+       { "LSL Mixer", "Port1_6 Switch", "PORT1_6_RX" },
+       { "LSL Mixer", "Port1_7 Switch", "PORT1_7_RX" },
+       { "LSL Mixer", "Port1_8 Switch", "PORT1_8_RX" },
+
+       /* Port 2 */
+       { "LSL Mixer", "Port2_1 Switch", "PORT2_1_RX" },
+       { "LSL Mixer", "Port2_2 Switch", "PORT2_2_RX" },
+
+       { "LSL Mixer", "ADCL Switch", "ADC Left" },
+       { "LSL Mixer", "ADCR Switch", "ADC Right" },
+       { "LSL Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "LSL Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "LSL Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "LSL Mixer", "DMIC2R Switch", "DMIC2 Right" },
+       { "LSL Mixer", "Sidetone Switch", "Sidetone" },
+
+       { "LSL DAC", NULL, "LSL Mixer" },
+
+       { "LSR Mixer", "Port1_1 Switch", "PORT1_1_RX" },
+       { "LSR Mixer", "Port1_2 Switch", "PORT1_2_RX" },
+       { "LSR Mixer", "Port1_3 Switch", "PORT1_3_RX" },
+       { "LSR Mixer", "Port1_4 Switch", "PORT1_4_RX" },
+       { "LSR Mixer", "Port1_5 Switch", "PORT1_5_RX" },
+       { "LSR Mixer", "Port1_6 Switch", "PORT1_6_RX" },
+       { "LSR Mixer", "Port1_7 Switch", "PORT1_7_RX" },
+       { "LSR Mixer", "Port1_8 Switch", "PORT1_8_RX" },
+
+       /* Port 2 */
+       { "LSR Mixer", "Port2_1 Switch", "PORT2_1_RX" },
+       { "LSR Mixer", "Port2_2 Switch", "PORT2_2_RX" },
+
+       { "LSR Mixer", "ADCL Switch", "ADC Left" },
+       { "LSR Mixer", "ADCR Switch", "ADC Right" },
+       { "LSR Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "LSR Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "LSR Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "LSR Mixer", "DMIC2R Switch", "DMIC2 Right" },
+       { "LSR Mixer", "Sidetone Switch", "Sidetone" },
+
+       { "LSR DAC", NULL, "LSR Mixer" },
+
+       { "LSOUTL", "Speaker Left Enable", "LSL DAC"},
+       { "LSOUTR", "Speaker Left Enable", "LSR DAC"},
+
+       /* Haptic map */
+       { "HAL Mixer", "Port1_1 Switch", "PORT1_1_RX" },
+       { "HAL Mixer", "Port1_2 Switch", "PORT1_2_RX" },
+       { "HAL Mixer", "Port1_3 Switch", "PORT1_3_RX" },
+       { "HAL Mixer", "Port1_4 Switch", "PORT1_4_RX" },
+       { "HAL Mixer", "Port1_5 Switch", "PORT1_5_RX" },
+       { "HAL Mixer", "Port1_6 Switch", "PORT1_6_RX" },
+       { "HAL Mixer", "Port1_7 Switch", "PORT1_7_RX" },
+       { "HAL Mixer", "Port1_8 Switch", "PORT1_8_RX" },
+
+       /* Port 2 */
+       { "HAL Mixer", "Port2_1 Switch", "PORT2_1_RX" },
+       { "HAL Mixer", "Port2_2 Switch", "PORT2_2_RX" },
+
+       { "HAL Mixer", "ADCL Switch", "ADC Left" },
+       { "HAL Mixer", "ADCR Switch", "ADC Right" },
+       { "HAL Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "HAL Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "HAL Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "HAL Mixer", "DMIC2R Switch", "DMIC2 Right" },
+       { "HAL Mixer", "Sidetone Switch", "Sidetone" },
+
+       { "HAL DAC", NULL, "HAL Mixer" },
+
+       { "HAR Mixer", "Port1_1 Switch", "PORT1_1_RX" },
+       { "HAR Mixer", "Port1_2 Switch", "PORT1_2_RX" },
+       { "HAR Mixer", "Port1_3 Switch", "PORT1_3_RX" },
+       { "HAR Mixer", "Port1_4 Switch", "PORT1_4_RX" },
+       { "HAR Mixer", "Port1_5 Switch", "PORT1_5_RX" },
+       { "HAR Mixer", "Port1_6 Switch", "PORT1_6_RX" },
+       { "HAR Mixer", "Port1_7 Switch", "PORT1_7_RX" },
+       { "HAR Mixer", "Port1_8 Switch", "PORT1_8_RX" },
+
+       /* Port 2 */
+       { "HAR Mixer", "Port2_1 Switch", "PORT2_1_RX" },
+       { "HAR Mixer", "Port2_2 Switch", "PORT2_2_RX" },
+
+       { "HAR Mixer", "ADCL Switch", "ADC Left" },
+       { "HAR Mixer", "ADCR Switch", "ADC Right" },
+       { "HAR Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "HAR Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "HAR Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "HAR Mixer", "DMIC2R Switch", "DMIC2 Right" },
+       { "HAR Mixer", "Sideton Switch", "Sidetone" },
+
+       { "HAR DAC", NULL, "HAR Mixer" },
+
+       { "HAOUTL", "Haptic Left Enable", "HAL DAC" },
+       { "HAOUTR", "Haptic Right Enable", "HAR DAC" },
+
+       /* Lineout map */
+       { "LOL Mixer", "Port1_1 Switch", "PORT1_1_RX" },
+       { "LOL Mixer", "Port1_2 Switch", "PORT1_2_RX" },
+       { "LOL Mixer", "Port1_3 Switch", "PORT1_3_RX" },
+       { "LOL Mixer", "Port1_4 Switch", "PORT1_4_RX" },
+       { "LOL Mixer", "Port1_5 Switch", "PORT1_5_RX" },
+       { "LOL Mixer", "Port1_6 Switch", "PORT1_6_RX" },
+       { "LOL Mixer", "Port1_7 Switch", "PORT1_7_RX" },
+       { "LOL Mixer", "Port1_8 Switch", "PORT1_8_RX" },
+
+       /* Port 2 */
+       { "LOL Mixer", "Port2_1 Switch", "PORT2_1_RX" },
+       { "LOL Mixer", "Port2_2 Switch", "PORT2_2_RX" },
+
+       { "LOL Mixer", "ADCL Switch", "ADC Left" },
+       { "LOL Mixer", "ADCR Switch", "ADC Right" },
+       { "LOL Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "LOL Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "LOL Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "LOL Mixer", "DMIC2R Switch", "DMIC2 Right" },
+       { "LOL Mixer", "Sidetone Switch", "Sidetone" },
+
+       { "LOL DAC", NULL, "LOL Mixer" },
+
+       { "LOR Mixer", "Port1_1 Switch", "PORT1_1_RX" },
+       { "LOR Mixer", "Port1_2 Switch", "PORT1_2_RX" },
+       { "LOR Mixer", "Port1_3 Switch", "PORT1_3_RX" },
+       { "LOR Mixer", "Port1_4 Switch", "PORT1_4_RX" },
+       { "LOR Mixer", "Port1_5 Switch", "PORT1_5_RX" },
+       { "LOR Mixer", "Port1_6 Switch", "PORT1_6_RX" },
+       { "LOR Mixer", "Port1_7 Switch", "PORT1_7_RX" },
+       { "LOR Mixer", "Port1_8 Switch", "PORT1_8_RX" },
+
+       /* Port 2 */
+       { "LOR Mixer", "Port2_1 Switch", "PORT2_1_RX" },
+       { "LOR Mixer", "Port2_2 Switch", "PORT2_2_RX" },
+
+       { "LOR Mixer", "ADCL Switch", "ADC Left" },
+       { "LOR Mixer", "ADCR Switch", "ADC Right" },
+       { "LOR Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "LOR Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "LOR Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "LOR Mixer", "DMIC2R Switch", "DMIC2 Right" },
+       { "LOR Mixer", "Sidetone Switch", "Sidetone" },
+
+       { "LOR DAC", NULL, "LOR Mixer" },
+
+       { "LOOUTL", NULL, "LOL DAC" },
+       { "LOOUTR", NULL, "LOR DAC" },
+
+       /* TX map */
+       /* Port1 mappings */
+       { "Port1_1 Mixer", "ADCL Switch", "ADC Left" },
+       { "Port1_1 Mixer", "ADCR Switch", "ADC Right" },
+       { "Port1_1 Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "Port1_1 Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "Port1_1 Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "Port1_1 Mixer", "DMIC2R Switch", "DMIC2 Right" },
+
+       { "Port1_2 Mixer", "ADCL Switch", "ADC Left" },
+       { "Port1_2 Mixer", "ADCR Switch", "ADC Right" },
+       { "Port1_2 Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "Port1_2 Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "Port1_2 Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "Port1_2 Mixer", "DMIC2R Switch", "DMIC2 Right" },
+
+       { "Port1_3 Mixer", "ADCL Switch", "ADC Left" },
+       { "Port1_3 Mixer", "ADCR Switch", "ADC Right" },
+       { "Port1_3 Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "Port1_3 Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "Port1_3 Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "Port1_3 Mixer", "DMIC2R Switch", "DMIC2 Right" },
+
+       { "Port1_4 Mixer", "ADCL Switch", "ADC Left" },
+       { "Port1_4 Mixer", "ADCR Switch", "ADC Right" },
+       { "Port1_4 Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "Port1_4 Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "Port1_4 Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "Port1_4 Mixer", "DMIC2R Switch", "DMIC2 Right" },
+
+       { "Port1_5 Mixer", "ADCL Switch", "ADC Left" },
+       { "Port1_5 Mixer", "ADCR Switch", "ADC Right" },
+       { "Port1_5 Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "Port1_5 Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "Port1_5 Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "Port1_5 Mixer", "DMIC2R Switch", "DMIC2 Right" },
+
+       { "Port1_6 Mixer", "ADCL Switch", "ADC Left" },
+       { "Port1_6 Mixer", "ADCR Switch", "ADC Right" },
+       { "Port1_6 Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "Port1_6 Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "Port1_6 Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "Port1_6 Mixer", "DMIC2R Switch", "DMIC2 Right" },
+
+       { "Port1_7 Mixer", "ADCL Switch", "ADC Left" },
+       { "Port1_7 Mixer", "ADCR Switch", "ADC Right" },
+       { "Port1_7 Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "Port1_7 Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "Port1_7 Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "Port1_7 Mixer", "DMIC2R Switch", "DMIC2 Right" },
+
+       { "Port1_8 Mixer", "ADCL Switch", "ADC Left" },
+       { "Port1_8 Mixer", "ADCR Switch", "ADC Right" },
+       { "Port1_8 Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "Port1_8 Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "Port1_8 Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "Port1_8 Mixer", "DMIC2R Switch", "DMIC2 Right" },
+
+       { "Port2_1 Mixer", "ADCL Switch", "ADC Left" },
+       { "Port2_1 Mixer", "ADCR Switch", "ADC Right" },
+       { "Port2_1 Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "Port2_1 Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "Port2_1 Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "Port2_1 Mixer", "DMIC2R Switch", "DMIC2 Right" },
+
+       { "Port2_2 Mixer", "ADCL Switch", "ADC Left" },
+       { "Port2_2 Mixer", "ADCR Switch", "ADC Right" },
+       { "Port2_2 Mixer", "DMIC1L Switch", "DMIC1 Left" },
+       { "Port2_2 Mixer", "DMIC1R Switch", "DMIC1 Right" },
+       { "Port2_2 Mixer", "DMIC2L Switch", "DMIC2 Left" },
+       { "Port2_2 Mixer", "DMIC2R Switch", "DMIC2 Right" },
+
+       { "P1_1_TX", NULL, "Port1_1 Mixer" },
+       { "P1_2_TX", NULL, "Port1_2 Mixer" },
+       { "P1_3_TX", NULL, "Port1_3 Mixer" },
+       { "P1_4_TX", NULL, "Port1_4 Mixer" },
+       { "P1_5_TX", NULL, "Port1_5 Mixer" },
+       { "P1_6_TX", NULL, "Port1_6 Mixer" },
+       { "P1_7_TX", NULL, "Port1_7 Mixer" },
+       { "P1_8_TX", NULL, "Port1_8 Mixer" },
+
+       { "P2_1_TX", NULL, "Port2_1 Mixer" },
+       { "P2_2_TX", NULL, "Port2_2 Mixer" },
+
+       { "PORT1_SDO", NULL, "P1_1_TX"},
+       { "PORT1_SDO", NULL, "P1_2_TX"},
+       { "PORT1_SDO", NULL, "P1_3_TX"},
+       { "PORT1_SDO", NULL, "P1_4_TX"},
+       { "PORT1_SDO", NULL, "P1_5_TX"},
+       { "PORT1_SDO", NULL, "P1_6_TX"},
+       { "PORT1_SDO", NULL, "P1_7_TX"},
+       { "PORT1_SDO", NULL, "P1_8_TX"},
+
+       { "PORT2_SDO", NULL, "P2_1_TX"},
+       { "PORT2_SDO", NULL, "P2_2_TX"},
+
+       { "Mic1 Input", NULL, "AMIC1" },
+       { "Mic2 Input", NULL, "AMIC2" },
+
+       { "AUXL Input", NULL, "AUXL" },
+       { "AUXR Input", NULL, "AUXR" },
+
+       /* AUX connections */
+       { "ADCL Mux", "Aux_L", "AUXL Input" },
+       { "ADCL Mux", "MIC1", "Mic1 Input" },
+
+       { "ADCR Mux", "Aux_R", "AUXR Input" },
+       { "ADCR Mux", "MIC2", "Mic2 Input" },
+
+       /* ADC connection */
+       { "ADC Left", NULL, "ADCL Mux"},
+       { "ADC Right", NULL, "ADCR Mux"},
+
+       /* TX Paths */
+       { "Port1 Capture", NULL, "P1_1_TX" },
+       { "Port1 Capture", NULL, "P1_2_TX" },
+       { "Port1 Capture", NULL, "P1_3_TX" },
+       { "Port1 Capture", NULL, "P1_4_TX" },
+       { "Port1 Capture", NULL, "P1_5_TX" },
+       { "Port1 Capture", NULL, "P1_6_TX" },
+       { "Port1 Capture", NULL, "P1_7_TX" },
+       { "Port1 Capture", NULL, "P1_8_TX" },
+
+       { "Port2 Capture", NULL, "P2_1_TX" },
+       { "Port2 Capture", NULL, "P2_2_TX" },
+
+       /* RX Paths */
+       { "Port1 Playback", NULL, "P1_1_RX" },
+       { "Port1 Playback", NULL, "P1_2_RX" },
+       { "Port1 Playback", NULL, "P1_3_RX" },
+       { "Port1 Playback", NULL, "P1_4_RX" },
+       { "Port1 Playback", NULL, "P1_5_RX" },
+       { "Port1 Playback", NULL, "P1_6_RX" },
+       { "Port1 Playback", NULL, "P1_7_RX" },
+       { "Port1 Playback", NULL, "P1_8_RX" },
+
+       { "Port2 Playback", NULL, "P2_1_RX" },
+       { "Port2 Playback", NULL, "P2_2_RX" },
+
+       /* Sidetone map */
+       { "Sidetone Mixer", "Sidetone Enable Switch", "ADC Left" },
+       { "Sidetone Mixer", "Sidetone Enable Switch", "ADC Right" },
+       { "Sidetone Mixer", "Sidetone Enable Switch", "DMIC1 Left" },
+       { "Sidetone Mixer", "Sidetone Enable Switch", "DMIC1 Right" },
+       { "Sidetone Mixer", "Sidetone Enable Switch", "DMIC2 Left" },
+       { "Sidetone Mixer", "Sidetone Enable Switch", "DMIC2 Right" },
+
+       { "Sidetone", NULL, "Sidetone Mixer" },
+};
+
+static int lm49453_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
+                              int source, unsigned int freq_in,
+                              unsigned int freq_out)
+{
+       struct snd_soc_codec *codec = codec_dai->codec;
+       struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
+       struct pll_state *state;
+       unsigned int pwr_mask;
+
+       switch (pll_id) {
+       case LM49453_PLL_1:
+               state = &lm49453->pll1;
+               pwr_mask = LM49453_PMC_SETUP_PLL_EN;
+               break;
+       case LM49453_PLL_2:
+               state = &lm49453->pll2;
+               pwr_mask = LM49453_PMC_SETUP_PLL_P2_EN;
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       state->in = freq_in;
+       state->out = freq_out;
+
+       /* Always disable the PLL - it is not safe to leave it running
+        * while reprogramming it.
+        */
+       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
+                           LM49453_PMC_SETUP_PLL_EN, 0);
+
+       if (!freq_in || !freq_out)
+               return 0;
+
+       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQL_REG, (state->in & 0xff));
+       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQH_REG,
+                            ((state->in >> 8) & 0xff));
+
+       snd_soc_write(codec, LM49453_P0_VCO_TARGETLL_REG,
+                            state->out & 0xff);
+       snd_soc_write(codec, LM49453_P0_VCO_TARGETLH_REG,
+                            (state->out >> 8) & 0xff);
+       snd_soc_write(codec, LM49453_P0_VCO_TARGETHL_REG,
+                            (state->out >> 16) & 0xff);
+       snd_soc_write(codec, LM49453_P0_VCO_TARGETHH_REG,
+                            (state->out >> 24) & 0xff);
+
+       /* All done, turn it on */
+       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG, pwr_mask,
+                           pwr_mask);
+
+       return 0;
+}
+
+static int lm49453_hw_params(struct snd_pcm_substream *substream,
+                            struct snd_pcm_hw_params *params,
+                            struct snd_soc_dai *dai)
+{
+       struct snd_soc_pcm_runtime *rtd = substream->private_data;
+       struct snd_soc_codec *codec = rtd->codec;
+       struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
+       u16 clk_div = 0;
+       u16 pll_clk = 0;
+
+       dev_dbg(codec->dev, "\n in lm49453_hw_params\n");
+
+       lm49453->fs_rate = params_rate(params);
+
+       /* Setting DAC clock dividers based on substream sample rate. */
+       switch (lm49453->fs_rate) {
+       case 8000:
+       case 16000:
+       case 32000:
+       case 24000:
+       case 48000:
+               clk_div = 256;
+               break;
+       case 11025:
+       case 22050:
+       case 44100:
+               clk_div = 216;
+               break;
+       case 96000:
+               clk_div = 127;
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       snd_soc_write(codec, LM49453_P0_ADC_CLK_DIV_REG, clk_div);
+       snd_soc_write(codec, LM49453_P0_DAC_OT_CLK_DIV_REG, clk_div);
+       snd_soc_write(codec, LM49453_P0_DAC_HP_CLK_DIV_REG, clk_div);
+
+       switch (lm49453->sysclk) {
+       case 12288000:
+       case 26000000:
+       case 19000000:
+               pll_clk = ~BIT(4);
+               break;
+       case 48000:
+       case 32576:
+               pll_clk = BIT(4);
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG, BIT(4), pll_clk);
+
+       return 0;
+}
+
+static int lm49453_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+       struct snd_soc_codec *codec = codec_dai->codec;
+
+       int aif_val;
+
+       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+       case SND_SOC_DAIFMT_CBS_CFS:
+               aif_val = ~LM49453_AUDIO_PORT1_BASIC_CLK_MS |
+                       ~LM49453_AUDIO_PORT1_BASIC_SYNC_MS;
+               break;
+       case SND_SOC_DAIFMT_CBS_CFM:
+               aif_val = ~LM49453_AUDIO_PORT1_BASIC_CLK_MS |
+                       LM49453_AUDIO_PORT1_BASIC_SYNC_MS;
+               break;
+       case SND_SOC_DAIFMT_CBM_CFS:
+               aif_val = LM49453_AUDIO_PORT1_BASIC_CLK_MS |
+                       ~LM49453_AUDIO_PORT1_BASIC_SYNC_MS;
+               break;
+       case SND_SOC_DAIFMT_CBM_CFM:
+               aif_val = LM49453_AUDIO_PORT1_BASIC_CLK_MS |
+                       LM49453_AUDIO_PORT1_BASIC_SYNC_MS;
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       snd_soc_update_bits(codec, LM49453_P0_AUDIO_PORT1_BASIC_REG,
+                           LM49453_AUDIO_PORT1_BASIC_FMT_MASK, aif_val);
+
+       return 0;
+}
+
+static int lm49453_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+                                 unsigned int freq, int dir)
+{
+       struct snd_soc_codec *codec = dai->codec;
+       struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
+
+       switch (freq) {
+       case 12288000:
+       case 26000000:
+       case 19200000:
+       case 48000:
+       case 32576:
+               lm49453->sysclk = freq;
+               return 0;
+       default:
+               return -EINVAL;
+       }
+}
+
+static int lm49453_hp_mute(struct snd_soc_dai *dai, int mute)
+{
+       if (mute)
+               snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG,
+                                   BIT(1)|BIT(0), BIT(1)|BIT(0));
+       return 0;
+}
+
+static int lm49453_lo_mute(struct snd_soc_dai *dai, int mute)
+{
+       if (mute)
+               snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG,
+                                   BIT(3)|BIT(2), BIT(3)|BIT(2));
+       return 0;
+}
+
+static int lm49453_ls_mute(struct snd_soc_dai *dai, int mute)
+{
+       if (mute)
+               snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG,
+                                   BIT(5)|BIT(4), BIT(5)|BIT(4));
+       return 0;
+}
+
+static int lm49453_ep_mute(struct snd_soc_dai *dai, int mute)
+{
+       if (mute)
+               snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG,
+                                   BIT(4), BIT(4));
+       return 0;
+}
+
+static int lm49453_ha_mute(struct snd_soc_dai *dai, int mute)
+{
+       if (mute)
+               snd_soc_update_bits(dai->codec, LM49453_P0_DAC_DSP_REG,
+                                   BIT(7)|BIT(6), BIT(7)|BIT(6));
+       return 0;
+}
+
+static int lm49453_set_bias_level(struct snd_soc_codec *codec,
+                                 enum snd_soc_bias_level level)
+{
+       struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
+       u16 reg;
+
+       switch (level) {
+       case SND_SOC_BIAS_ON:
+       case SND_SOC_BIAS_PREPARE:
+               break;
+
+       case SND_SOC_BIAS_STANDBY:
+               if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+                       regcache_sync(lm49453->regmap);
+               break;
+
+       case SND_SOC_BIAS_OFF:
+               reg = LM49453_PMC_SETUP_CHIP_EN;
+               snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
+                                   LM49453_PMC_SETUP_CHIP_EN, reg);
+               break;
+       }
+
+       codec->dapm.bias_level = level;
+
+       return 0;
+}
+
+/* Formates supported by LM49453 driver. */
+#define LM49453_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+                        SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_ops lm49453_headset_dai_ops = {
+       .hw_params      = lm49453_hw_params,
+       .set_sysclk     = lm49453_set_dai_sysclk,
+       .set_pll        = lm49453_set_dai_pll,
+       .set_fmt        = lm49453_set_dai_fmt,
+       .digital_mute   = lm49453_hp_mute,
+};
+
+static struct snd_soc_dai_ops lm49453_speaker_dai_ops = {
+       .digital_mute = lm49453_ls_mute,
+       .hw_params = lm49453_hw_params,
+};
+
+static struct snd_soc_dai_ops lm49453_haptic_dai_ops = {
+       .digital_mute = lm49453_ha_mute,
+       .hw_params = lm49453_hw_params,
+};
+
+static struct snd_soc_dai_ops lm49453_ep_dai_ops = {
+       .digital_mute = lm49453_ep_mute,
+       .hw_params = lm49453_hw_params,
+};
+
+static struct snd_soc_dai_ops lm49453_lineout_dai_ops = {
+       .digital_mute = lm49453_lo_mute,
+       .hw_params = lm49453_hw_params,
+};
+
+/* LM49453 dai structure. */
+struct snd_soc_dai_driver lm49453_dai[] = {
+       {
+               .name = "LM49453 Headset",
+               .playback = {
+                       .stream_name = "Headset",
+                       .channels_min = 2,
+                       .channels_max = 2,
+                       .rates = SNDRV_PCM_RATE_8000_192000,
+                       .formats = LM49453_FORMATS,
+               },
+               .capture = {
+                       .stream_name = "Capture",
+                       .channels_min = 1,
+                       .channels_max = 5,
+                       .rates = SNDRV_PCM_RATE_8000_192000,
+                       .formats = LM49453_FORMATS,
+               },
+               .ops = &lm49453_headset_dai_ops,
+               .symmetric_rates = 1,
+       },
+       {
+               .name = "LM49453 Speaker",
+               .playback = {
+                       .stream_name = "Speaker",
+                       .channels_min = 2,
+                       .channels_max = 2,
+                       .rates = SNDRV_PCM_RATE_8000_192000,
+                       .formats = LM49453_FORMATS,
+               },
+               .ops = &lm49453_speaker_dai_ops,
+       },
+       {
+               .name = "LM49453 Haptic",
+               .playback = {
+                       .stream_name = "Haptic",
+                       .channels_min = 2,
+                       .channels_max = 2,
+                       .rates = SNDRV_PCM_RATE_8000_192000,
+                       .formats = LM49453_FORMATS,
+               },
+               .ops = &lm49453_haptic_dai_ops,
+       },
+       {
+               .name = "LM49453 Earpiece",
+               .playback = {
+                       .stream_name = "Earpiece",
+                       .channels_min = 1,
+                       .channels_max = 1,
+                       .rates = SNDRV_PCM_RATE_8000_192000,
+                       .formats = LM49453_FORMATS,
+               },
+               .ops = &lm49453_ep_dai_ops,
+       },
+       {
+               .name = "LM49453 line out",
+               .playback = {
+                       .stream_name = "Lineout",
+                       .channels_min = 2,
+                       .channels_max = 2,
+                       .rates = SNDRV_PCM_RATE_8000_192000,
+                       .formats = LM49453_FORMATS,
+               },
+               .ops = &lm49453_lineout_dai_ops,
+       },
+};
+
+static int lm49453_suspend(struct snd_soc_codec *codec, pm_message_t state)
+{
+       lm49453_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+       return 0;
+}
+
+static int lm49453_resume(struct snd_soc_codec *codec)
+{
+       struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
+
+       regcache_sync(lm49453->regmap);
+
+       lm49453_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+       lm49453_set_bias_level(codec, codec->dapm.suspend_bias_level);
+
+       return 0;
+}
+
+static int lm49453_probe(struct snd_soc_codec *codec)
+{
+       struct lm49453_priv *lm49453 = snd_soc_codec_get_drvdata(codec);
+       int ret = 0;
+       int reg;
+
+       codec->control_data = lm49453->regmap;
+
+       ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
+       if (ret < 0) {
+               dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+               return ret;
+       }
+
+       /* Get the codec into a known state */
+       reg = LM49453_RESET_REG_RST;
+       snd_soc_update_bits(codec, LM49453_P0_RESET_REG, BIT(0), reg);
+       if (ret != 0) {
+               dev_err(codec->dev, "Failed to reset codec: %d\n", ret);
+               return ret;
+       }
+
+       return 0;
+}
+
+/* power down chip */
+static int lm49453_remove(struct snd_soc_codec *codec)
+{
+       lm49453_set_bias_level(codec, SND_SOC_BIAS_OFF);
+       return 0;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_lm49453 = {
+       .probe = lm49453_probe,
+       .remove = lm49453_remove,
+       .suspend = lm49453_suspend,
+       .resume = lm49453_resume,
+       .set_bias_level = lm49453_set_bias_level,
+       .controls = lm49453_snd_controls,
+       .num_controls = ARRAY_SIZE(lm49453_snd_controls),
+       .dapm_widgets = lm49453_dapm_widgets,
+       .num_dapm_widgets = ARRAY_SIZE(lm49453_dapm_widgets),
+       .dapm_routes = lm49453_audio_map,
+       .num_dapm_routes = ARRAY_SIZE(lm49453_audio_map),
+       .idle_bias_off = true,
+};
+
+static const struct regmap_config lm49453_regmap_config = {
+       .reg_bits = 8,
+       .val_bits = 8,
+
+       .max_register = LM49453_MAX_REGISTER,
+       .reg_defaults = lm49453_reg_defs,
+       .num_reg_defaults = ARRAY_SIZE(lm49453_reg_defs),
+       .cache_type = REGCACHE_RBTREE,
+};
+
+static __devinit int lm49453_i2c_probe(struct i2c_client *i2c,
+                                      const struct i2c_device_id *id)
+{
+       struct lm49453_priv *lm49453;
+       int ret = 0;
+
+       lm49453 = devm_kzalloc(&i2c->dev, sizeof(struct lm49453_priv),
+                               GFP_KERNEL);
+
+       if (lm49453 == NULL)
+               return -ENOMEM;
+
+       i2c_set_clientdata(i2c, lm49453);
+
+       lm49453->regmap = regmap_init_i2c(i2c, &lm49453_regmap_config);
+       if (IS_ERR(lm49453->regmap)) {
+               ret = PTR_ERR(lm49453->regmap);
+               dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
+                       ret);
+               return ret;
+       }
+
+       ret =  snd_soc_register_codec(&i2c->dev,
+                                     &soc_codec_dev_lm49453,
+                                     lm49453_dai, ARRAY_SIZE(lm49453_dai));
+       if (ret < 0) {
+               dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+               regmap_exit(lm49453->regmap);
+               return ret;
+       }
+
+       return ret;
+}
+
+static int __devexit lm49453_i2c_remove(struct i2c_client *client)
+{
+       struct lm49453_priv *lm49453 = i2c_get_clientdata(client);
+
+       snd_soc_unregister_codec(&client->dev);
+       regmap_exit(lm49453->regmap);
+       return 0;
+}
+
+static const struct i2c_device_id lm49453_i2c_id[] = {
+       { "lm49453", 0 },
+       { }
+};
+MODULE_DEVICE_TABLE(i2c, lm49453_i2c_id);
+
+static struct i2c_driver lm49453_i2c_driver = {
+       .driver = {
+               .name = "lm49453",
+               .owner = THIS_MODULE,
+       },
+       .probe = lm49453_i2c_probe,
+       .remove = __devexit_p(lm49453_i2c_remove),
+       .id_table = lm49453_i2c_id,
+};
+
+module_i2c_driver(lm49453_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC LM49453 driver");
+MODULE_AUTHOR("M R Swami Reddy <MR.Swami.Reddy@ti.com");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/lm49453.h b/sound/soc/codecs/lm49453.h
new file mode 100644
index 0000000..093f626
--- /dev/null
+++ b/sound/soc/codecs/lm49453.h
@@ -0,0 +1,384 @@
+/*
+ * lm49453.h  -  LM49453 ALSA Soc Audio drive
+ *
+ * Copyright (c) 2012  Texas Instruments, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ */
+
+#ifndef _LM49453_H
+#define _LM49453_H
+
+#include <linux/bitops.h>
+
+#define LM49453_PLL_1                                  1
+#define LM49453_PLL_2                                  2
+
+/* Page0 REGISTERS */
+
+/* LM49453_P0 register space for page0 */
+#define LM49453_P0_PMC_SETUP_REG                       0x00
+#define LM49453_P0_PLL_CLK_SEL1_REG                    0x01
+#define LM49453_P0_PLL_CLK_SEL2_REG                    0x02
+#define LM49453_P0_PMC_CLK_DIV_REG                     0x03
+#define LM49453_P0_HSDET_CLK_DIV_REG                   0x04
+#define LM49453_P0_DMIC_CLK_DIV_REG                    0x05
+#define LM49453_P0_ADC_CLK_DIV_REG                     0x06
+#define LM49453_P0_DAC_OT_CLK_DIV_REG                  0x07
+#define LM49453_P0_PLL_HF_M_REG                                0x08
+#define LM49453_P0_PLL_LF_M_REG                                0x09
+#define LM49453_P0_PLL_NL_REG                          0x0A
+#define LM49453_P0_PLL_N_MODL_REG                      0x0B
+#define LM49453_P0_PLL_N_MODH_REG                      0x0C
+#define LM49453_P0_PLL_P1_REG                          0x0D
+#define LM49453_P0_PLL_P2_REG                          0x0E
+#define LM49453_P0_FLL_REF_FREQL_REG                   0x0F
+#define LM49453_P0_FLL_REF_FREQH_REG                   0x10
+#define LM49453_P0_VCO_TARGETLL_REG                    0x11
+#define LM49453_P0_VCO_TARGETLH_REG                    0x12
+#define LM49453_P0_VCO_TARGETHL_REG                    0x13
+#define LM49453_P0_VCO_TARGETHH_REG                    0x14
+#define LM49453_P0_PLL_CONFIG_REG                      0x15
+#define LM49453_P0_DAC_CLK_SEL_REG                     0x16
+#define LM49453_P0_DAC_HP_CLK_DIV_REG                  0x17
+
+/* Analog Mixer Input Stages */
+#define LM49453_P0_MICL_REG                            0x20
+#define LM49453_P0_MICR_REG                            0x21
+#define LM49453_P0_EP_REG                              0x24
+#define LM49453_P0_DIS_PKVL_FB_REG                     0x25
+
+/* Analog Mixer Output Stages */
+#define LM49453_P0_ANALOG_MIXER_ADC_REG                        0x2E
+
+/*ADC or DAC */
+#define LM49453_P0_ADC_DSP_REG                         0x30
+#define LM49453_P0_DAC_DSP_REG                         0x31
+
+/* EFFECTS ENABLES */
+#define LM49453_P0_ADC_FX_ENABLES_REG                  0x33
+
+/* GPIO */
+#define LM49453_P0_GPIO1_REG                           0x38
+#define LM49453_P0_GPIO2_REG                           0x39
+#define LM49453_P0_GPIO3_REG                           0x3A
+#define LM49453_P0_HAP_CTL_REG                         0x3B
+#define LM49453_P0_HAP_FREQ_PROG_LEFTL_REG             0x3C
+#define LM49453_P0_HAP_FREQ_PROG_LEFTH_REG             0x3D
+#define LM49453_P0_HAP_FREQ_PROG_RIGHTL_REG            0x3E
+#define LM49453_P0_HAP_FREQ_PROG_RIGHTH_REG            0x3F
+
+/* DIGITAL MIXER */
+#define LM49453_P0_DMIX_CLK_SEL_REG                    0x40
+#define LM49453_P0_PORT1_RX_LVL1_REG                   0x41
+#define LM49453_P0_PORT1_RX_LVL2_REG                   0x42
+#define LM49453_P0_PORT2_RX_LVL_REG                    0x43
+#define LM49453_P0_PORT1_TX1_REG                       0x44
+#define LM49453_P0_PORT1_TX2_REG                       0x45
+#define LM49453_P0_PORT1_TX3_REG                       0x46
+#define LM49453_P0_PORT1_TX4_REG                       0x47
+#define LM49453_P0_PORT1_TX5_REG                       0x48
+#define LM49453_P0_PORT1_TX6_REG                       0x49
+#define LM49453_P0_PORT1_TX7_REG                       0x4A
+#define LM49453_P0_PORT1_TX8_REG                       0x4B
+#define LM49453_P0_PORT2_TX1_REG                       0x4C
+#define LM49453_P0_PORT2_TX2_REG                       0x4D
+#define LM49453_P0_STN_SEL_REG                         0x4F
+#define LM49453_P0_DACHPL1_REG                         0x50
+#define LM49453_P0_DACHPL2_REG                         0x51
+#define LM49453_P0_DACHPR1_REG                         0x52
+#define LM49453_P0_DACHPR2_REG                         0x53
+#define LM49453_P0_DACLOL1_REG                         0x54
+#define LM49453_P0_DACLOL2_REG                         0x55
+#define LM49453_P0_DACLOR1_REG                         0x56
+#define LM49453_P0_DACLOR2_REG                         0x57
+#define LM49453_P0_DACLSL1_REG                         0x58
+#define LM49453_P0_DACLSL2_REG                         0x59
+#define LM49453_P0_DACLSR1_REG                         0x5A
+#define LM49453_P0_DACLSR2_REG                         0x5B
+#define LM49453_P0_DACHAL1_REG                         0x5C
+#define LM49453_P0_DACHAL2_REG                         0x5D
+#define LM49453_P0_DACHAR1_REG                         0x5E
+#define LM49453_P0_DACHAR2_REG                         0x5F
+
+/* AUDIO PORT 1 (TDM) */
+#define LM49453_P0_AUDIO_PORT1_BASIC_REG               0x60
+#define LM49453_P0_AUDIO_PORT1_CLK_GEN1_REG            0x61
+#define LM49453_P0_AUDIO_PORT1_CLK_GEN2_REG            0x62
+#define LM49453_P0_AUDIO_PORT1_CLK_GEN3_REG            0x63
+#define LM49453_P0_AUDIO_PORT1_SYNC_RATE_REG           0x64
+#define LM49453_P0_AUDIO_PORT1_SYNC_SDO_SETUP_REG      0x65
+#define LM49453_P0_AUDIO_PORT1_DATA_WIDTH_REG          0x66
+#define LM49453_P0_AUDIO_PORT1_RX_MSB_REG              0x67
+#define LM49453_P0_AUDIO_PORT1_TX_MSB_REG              0x68
+#define LM49453_P0_AUDIO_PORT1_TDM_CHANNELS_REG                0x69
+
+/* AUDIO PORT 2 */
+#define LM49453_P0_AUDIO_PORT2_BASIC_REG               0x6A
+#define LM49453_P0_AUDIO_PORT2_CLK_GEN1_REG            0x6B
+#define LM49453_P0_AUDIO_PORT2_CLK_GEN2_REG            0x6C
+#define LM49453_P0_AUDIO_PORT2_SYNC_GEN_REG            0x6D
+#define LM49453_P0_AUDIO_PORT2_DATA_WIDTH_REG          0x6E
+#define LM49453_P0_AUDIO_PORT2_RX_MODE_REG             0x6F
+#define LM49453_P0_AUDIO_PORT2_TX_MODE_REG             0x70
+
+/* SAMPLE RATE */
+#define LM49453_P0_PORT1_SR_LSB_REG                    0x79
+#define LM49453_P0_PORT1_SR_MSB_REG                    0x7A
+#define LM49453_P0_PORT2_SR_LSB_REG                    0x7B
+#define LM49453_P0_PORT2_SR_MSB_REG                    0x7C
+
+/* EFFECTS - HPFs */
+#define LM49453_P0_HPF_REG                             0x80
+
+/* EFFECTS ADC ALC */
+#define LM49453_P0_ADC_ALC1_REG                                0x82
+#define LM49453_P0_ADC_ALC2_REG                                0x83
+#define LM49453_P0_ADC_ALC3_REG                                0x84
+#define LM49453_P0_ADC_ALC4_REG                                0x85
+#define LM49453_P0_ADC_ALC5_REG                                0x86
+#define LM49453_P0_ADC_ALC6_REG                                0x87
+#define LM49453_P0_ADC_ALC7_REG                                0x88
+#define LM49453_P0_ADC_ALC8_REG                                0x89
+#define LM49453_P0_DMIC1_LEVELL_REG                    0x8A
+#define LM49453_P0_DMIC1_LEVELR_REG                    0x8B
+#define LM49453_P0_DMIC2_LEVELL_REG                    0x8C
+#define LM49453_P0_DMIC2_LEVELR_REG                    0x8D
+#define LM49453_P0_ADC_LEVELL_REG                      0x8E
+#define LM49453_P0_ADC_LEVELR_REG                      0x8F
+#define LM49453_P0_DAC_HP_LEVELL_REG                   0x90
+#define LM49453_P0_DAC_HP_LEVELR_REG                   0x91
+#define LM49453_P0_DAC_LO_LEVELL_REG                   0x92
+#define LM49453_P0_DAC_LO_LEVELR_REG                   0x93
+#define LM49453_P0_DAC_LS_LEVELL_REG                   0x94
+#define LM49453_P0_DAC_LS_LEVELR_REG                   0x95
+#define LM49453_P0_DAC_HA_LEVELL_REG                   0x96
+#define LM49453_P0_DAC_HA_LEVELR_REG                   0x97
+#define LM49453_P0_SOFT_MUTE_REG                       0x98
+#define LM49453_P0_DMIC_MUTE_CFG_REG                   0x99
+#define LM49453_P0_ADC_MUTE_CFG_REG                    0x9A
+#define LM49453_P0_DAC_MUTE_CFG_REG                    0x9B
+
+/*DIGITAL MIC1 */
+#define LM49453_P0_DIGITAL_MIC1_CONFIG_REG             0xB0
+#define LM49453_P0_DIGITAL_MIC1_DATA_DELAYL_REG                0xB1
+#define LM49453_P0_DIGITAL_MIC1_DATA_DELAYR_REG                0xB2
+
+/*DIGITAL MIC2 */
+#define LM49453_P0_DIGITAL_MIC2_CONFIG_REG             0xB3
+#define LM49453_P0_DIGITAL_MIC2_DATA_DELAYL_REG                0xB4
+#define LM49453_P0_DIGITAL_MIC2_DATA_DELAYR_REG                0xB5
+
+/* ADC DECIMATOR */
+#define LM49453_P0_ADC_DECIMATOR_REG                   0xB6
+
+/* DAC CONFIGURE */
+#define LM49453_P0_DAC_CONFIG_REG                      0xB7
+
+/* SIDETONE */
+#define LM49453_P0_STN_VOL_ADCL_REG                    0xB8
+#define LM49453_P0_STN_VOL_ADCR_REG                    0xB9
+#define LM49453_P0_STN_VOL_DMIC1L_REG                  0xBA
+#define LM49453_P0_STN_VOL_DMIC1R_REG                  0xBB
+#define LM49453_P0_STN_VOL_DMIC2L_REG                  0xBC
+#define LM49453_P0_STN_VOL_DMIC2R_REG                  0xBD
+
+/* ADC/DAC CLIPPING MONITORS (Read Only/Write to Clear) */
+#define LM49453_P0_ADC_DEC_CLIP_REG                    0xC2
+#define LM49453_P0_ADC_HPF_CLIP_REG                    0xC3
+#define LM49453_P0_ADC_LVL_CLIP_REG                    0xC4
+#define LM49453_P0_DAC_LVL_CLIP_REG                    0xC5
+
+/* ADC ALC EFFECT MONITORS (Read Only) */
+#define LM49453_P0_ADC_LVLMONL_REG                     0xC8
+#define LM49453_P0_ADC_LVLMONR_REG                     0xC9
+#define LM49453_P0_ADC_ALCMONL_REG                     0xCA
+#define LM49453_P0_ADC_ALCMONR_REG                     0xCB
+#define LM49453_P0_ADC_MUTED_REG                       0xCC
+#define LM49453_P0_DAC_MUTED_REG                       0xCD
+
+/* HEADSET DETECT */
+#define LM49453_P0_HSD_PPB_LONG_CNT_LIMITL_REG         0xD0
+#define LM49453_P0_HSD_PPB_LONG_CNT_LIMITR_REG         0xD1
+#define LM49453_P0_HSD_PIN3_4_EX_LOOP_CNT_LIMITL_REG   0xD2
+#define LM49453_P0_HSD_PIN3_4_EX_LOOP_CNT_LIMITH_REG   0xD3
+#define LM49453_P0_HSD_TIMEOUT1_REG                    0xD4
+#define LM49453_P0_HSD_TIMEOUT2_REG                    0xD5
+#define LM49453_P0_HSD_TIMEOUT3_REG                    0xD6
+#define LM49453_P0_HSD_PIN3_4_CFG_REG                  0xD7
+#define LM49453_P0_HSD_IRQ1_REG                                0xD8
+#define LM49453_P0_HSD_IRQ2_REG                                0xD9
+#define LM49453_P0_HSD_IRQ3_REG                                0xDA
+#define LM49453_P0_HSD_IRQ4_REG                                0xDB
+#define LM49453_P0_HSD_IRQ_MASK1_REG                   0xDC
+#define LM49453_P0_HSD_IRQ_MASK2_REG                   0xDD
+#define LM49453_P0_HSD_IRQ_MASK3_REG                   0xDE
+#define LM49453_P0_HSD_R_HPLL_REG                      0xE0
+#define LM49453_P0_HSD_R_HPLH_REG                      0xE1
+#define LM49453_P0_HSD_R_HPLU_REG                      0xE2
+#define LM49453_P0_HSD_R_HPRL_REG                      0xE3
+#define LM49453_P0_HSD_R_HPRH_REG                      0xE4
+#define LM49453_P0_HSD_R_HPRU_REG                      0xE5
+#define LM49453_P0_HSD_VEL_L_FINALL_REG                        0xE6
+#define LM49453_P0_HSD_VEL_L_FINALH_REG                        0xE7
+#define LM49453_P0_HSD_VEL_L_FINALU_REG                        0xE8
+#define LM49453_P0_HSD_RO_FINALL_REG                   0xE9
+#define LM49453_P0_HSD_RO_FINALH_REG                   0xEA
+#define LM49453_P0_HSD_RO_FINALU_REG                   0xEB
+#define LM49453_P0_HSD_VMIC_BIAS_FINALL_REG            0xEC
+#define LM49453_P0_HSD_VMIC_BIAS_FINALH_REG            0xED
+#define LM49453_P0_HSD_VMIC_BIAS_FINALU_REG            0xEE
+#define LM49453_P0_HSD_PIN_CONFIG_REG                  0xEF
+#define LM49453_P0_HSD_PLUG_DETECT_BB_IRQ_STATUS1_REG  0xF1
+#define LM49453_P0_HSD_PLUG_DETECT_BB_IRQ_STATUS2_REG  0xF2
+#define LM49453_P0_HSD_PLUG_DETECT_BB_IRQ_STATUS3_REG  0xF3
+#define LM49453_P0_HSD_PLUG_DETECT_BB_IRQ_STATEL_REG   0xF4
+#define LM49453_P0_HSD_PLUG_DETECT_BB_IRQ_STATEH_REG   0xF5
+
+/* I/O PULLDOWN CONFIG */
+#define LM49453_P0_PULL_CONFIG1_REG                    0xF8
+#define LM49453_P0_PULL_CONFIG2_REG                    0xF9
+#define LM49453_P0_PULL_CONFIG3_REG                    0xFA
+
+/* RESET */
+#define LM49453_P0_RESET_REG                           0xFE
+
+/* PAGE */
+#define LM49453_PAGE_REG                               0xFF
+
+#define LM49453_MAX_REGISTER                           0xFF
+
+/* LM49453_P0_PMC_SETUP_REG (0x00h) */
+#define LM49453_PMC_SETUP_CHIP_EN                      (BIT(1)|BIT(0))
+#define LM49453_PMC_SETUP_PLL_EN                       BIT(2)
+#define LM49453_PMC_SETUP_PLL_P2_EN                    BIT(3)
+#define LM49453_PMC_SETUP_PLL_FLL                      BIT(4)
+#define LM49453_PMC_SETUP_MCLK_OVER                    BIT(5)
+#define LM49453_PMC_SETUP_RTC_CLK_OVER                 BIT(6)
+#define LM49453_PMC_SETUP_CHIP_ACTIVE                  BIT(7)
+
+/* Chip Enable bits */
+#define LM49453_CHIP_EN_SHUTDOWN                       0x00
+#define LM49453_CHIP_EN_NO_HSD_DETECT                  0x01
+#define LM49453_CHIP_EN_HSD_DETECT                     0x02
+#define LM49453_CHIP_EN_INVALID_HSD                    0x03
+
+/* LM49453_P0_PLL_CLK_SEL1_REG (0x01h) */
+#define LM49453_CLK_SEL1_MCLK_SEL                      0x11
+#define LM49453_CLK_SEL1_RTC_SEL                       0x11
+#define LM49453_CLK_SEL1_PORT1_SEL                     0x10
+#define LM49453_CLK_SEL1_PORT2_SEL                     0x11
+
+/* LM49453_P0_PLL_CLK_SEL2_REG (0x02h) */
+#define LM49453_CLK_SEL2_ADC_CLK_SEL                   0x38
+
+/* LM49453_P0_FLL_REF_FREQL_REG (0x0F) */
+#define LM49453_FLL_REF_FREQ_VAL                       0x8ca0001
+
+/* LM49453_P0_VCO_TARGETLL_REG (0x11) */
+#define LM49453_VCO_TARGET_VAL                         0x8ca0001
+
+/* LM49453_P0_ADC_DSP_REG (0x30h) */
+#define LM49453_ADC_DSP_ADC_MUTEL                      BIT(0)
+#define LM49453_ADC_DSP_ADC_MUTER                      BIT(1)
+#define LM49453_ADC_DSP_DMIC1_MUTEL                    BIT(2)
+#define LM49453_ADC_DSP_DMIC1_MUTER                    BIT(3)
+#define LM49453_ADC_DSP_DMIC2_MUTEL                    BIT(4)
+#define LM49453_ADC_DSP_DMIC2_MUTER                    BIT(5)
+#define LM49453_ADC_DSP_MUTE_ALL                       0x3F
+
+/* LM49453_P0_DAC_DSP_REG (0x31h) */
+#define LM49453_DAC_DSP_MUTE_ALL                       0xFF
+
+/* LM49453_P0_AUDIO_PORT1_BASIC_REG (0x60h) */
+#define LM49453_AUDIO_PORT1_BASIC_FMT_MASK             (BIT(4)|BIT(3))
+#define LM49453_AUDIO_PORT1_BASIC_CLK_MS               BIT(3)
+#define LM49453_AUDIO_PORT1_BASIC_SYNC_MS              BIT(4)
+
+/* LM49453_P0_RESET_REG (0xFEh) */
+#define LM49453_RESET_REG_RST                          BIT(0)
+
+/* Page select register bits (0xFF) */
+#define LM49453_PAGE0_SELECT                           0x0
+#define LM49453_PAGE1_SELECT                           0x1
+
+/* LM49453_P0_HSD_PIN3_4_CFG_REG (Jack Pin config - 0xD7) */
+#define LM49453_JACK_DISABLE                           0x00
+#define LM49453_JACK_CONFIG1                           0x01
+#define LM49453_JACK_CONFIG2                           0x02
+#define LM49453_JACK_CONFIG3                           0x03
+#define LM49453_JACK_CONFIG4                           0x04
+#define LM49453_JACK_CONFIG5                           0x05
+
+/* Page 1 REGISTERS */
+
+/* SIDETONE */
+#define LM49453_P1_SIDETONE_SA0L_REG                   0x80
+#define LM49453_P1_SIDETONE_SA0H_REG                   0x81
+#define LM49453_P1_SIDETONE_SAB0U_REG                  0x82
+#define LM49453_P1_SIDETONE_SB0L_REG                   0x83
+#define LM49453_P1_SIDETONE_SB0H_REG                   0x84
+#define LM49453_P1_SIDETONE_SH0L_REG                   0x85
+#define LM49453_P1_SIDETONE_SH0H_REG                   0x86
+#define LM49453_P1_SIDETONE_SH0U_REG                   0x87
+#define LM49453_P1_SIDETONE_SA1L_REG                   0x88
+#define LM49453_P1_SIDETONE_SA1H_REG                   0x89
+#define LM49453_P1_SIDETONE_SAB1U_REG                  0x8A
+#define LM49453_P1_SIDETONE_SB1L_REG                   0x8B
+#define LM49453_P1_SIDETONE_SB1H_REG                   0x8C
+#define LM49453_P1_SIDETONE_SH1L_REG                   0x8D
+#define LM49453_P1_SIDETONE_SH1H_REG                   0x8E
+#define LM49453_P1_SIDETONE_SH1U_REG                   0x8F
+#define LM49453_P1_SIDETONE_SA2L_REG                   0x90
+#define LM49453_P1_SIDETONE_SA2H_REG                   0x91
+#define LM49453_P1_SIDETONE_SAB2U_REG                  0x92
+#define LM49453_P1_SIDETONE_SB2L_REG                   0x93
+#define LM49453_P1_SIDETONE_SB2H_REG                   0x94
+#define LM49453_P1_SIDETONE_SH2L_REG                   0x95
+#define LM49453_P1_SIDETONE_SH2H_REG                   0x96
+#define LM49453_P1_SIDETONE_SH2U_REG                   0x97
+#define LM49453_P1_SIDETONE_SA3L_REG                   0x98
+#define LM49453_P1_SIDETONE_SA3H_REG                   0x99
+#define LM49453_P1_SIDETONE_SAB3U_REG                  0x9A
+#define LM49453_P1_SIDETONE_SB3L_REG                   0x9B
+#define LM49453_P1_SIDETONE_SB3H_REG                   0x9C
+#define LM49453_P1_SIDETONE_SH3L_REG                   0x9D
+#define LM49453_P1_SIDETONE_SH3H_REG                   0x9E
+#define LM49453_P1_SIDETONE_SH3U_REG                   0x9F
+#define LM49453_P1_SIDETONE_SA4L_REG                   0xA0
+#define LM49453_P1_SIDETONE_SA4H_REG                   0xA1
+#define LM49453_P1_SIDETONE_SAB4U_REG                  0xA2
+#define LM49453_P1_SIDETONE_SB4L_REG                   0xA3
+#define LM49453_P1_SIDETONE_SB4H_REG                   0xA4
+#define LM49453_P1_SIDETONE_SH4L_REG                   0xA5
+#define LM49453_P1_SIDETONE_SH4H_REG                   0xA6
+#define LM49453_P1_SIDETONE_SH4U_REG                   0xA7
+#define LM49453_P1_SIDETONE_SA5L_REG                   0xA8
+#define LM49453_P1_SIDETONE_SA5H_REG                   0xA9
+#define LM49453_P1_SIDETONE_SAB5U_REG                  0xAA
+#define LM49453_P1_SIDETONE_SB5L_REG                   0xAB
+#define LM49453_P1_SIDETONE_SB5H_REG                   0xAC
+#define LM49453_P1_SIDETONE_SH5L_REG                   0xAD
+#define LM49453_P1_SIDETONE_SH5H_REG                   0xAE
+#define LM49453_P1_SIDETONE_SH5U_REG                   0xAF
+
+/* CHARGE PUMP CONFIG */
+#define LM49453_P1_CP_CONFIG1_REG                      0xB0
+#define LM49453_P1_CP_CONFIG2_REG                      0xB1
+#define LM49453_P1_CP_CONFIG3_REG                      0xB2
+#define LM49453_P1_CP_CONFIG4_REG                      0xB3
+#define LM49453_P1_CP_LA_VTH1L_REG                     0xB4
+#define LM49453_P1_CP_LA_VTH1M_REG                     0xB5
+#define LM49453_P1_CP_LA_VTH2L_REG                     0xB6
+#define LM49453_P1_CP_LA_VTH2M_REG                     0xB7
+#define LM49453_P1_CP_LA_VTH3L_REG                     0xB8
+#define LM49453_P1_CP_LA_VTH3H_REG                     0xB9
+#define LM49453_P1_CP_CLK_DIV_REG                      0xBA
+
+/* DAC */
+#define LM49453_P1_DAC_CHOP_REG                                0xC0
+
+#endif
