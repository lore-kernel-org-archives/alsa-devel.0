From: Daniel Drake <drake@endlessm.com>
Subject: New platform CherryTrail/ES8316 audio output is silent
Date: Wed, 11 Jan 2017 13:07:28 -0600
Message-ID: <20170111190728.1824-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2348371153226950344=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id DD54426719D
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 20:07:40 +0100 (CET)
Received: by mail-oi0-f51.google.com with SMTP id u143so189805921oif.3
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 11:07:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com, vinod.koul@intel.com, alsa-devel@alsa-project.org
Cc: linux@endlessm.com, yangxiaohua@everest-semi.com
List-Id: alsa-devel@alsa-project.org

--===============2348371153226950344==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I'm trying to get audio working on the Weibu F3C miniPC which has a 3.5mm
headphone jack and 3.5mm mic jack. The SoC is Intel Cherry Trail x5-Z8300.

The ES8316 codec included is not supported by Linux at the moment. I'd like
to fix that and upstream the driver but so far am I stuck with no audio
output, only silence. I do have a working Windows setup that I can poke at
for more info.

I would appreciate any suggestions or ideas. Here is a description of my
efforts so far, followed by the work in progress code:

I started with the Cherry Trail ES8316 platform driver + ES8316 codec driver
which I found in
https://github.com/JideTechnology/remixos-kernel/tree/jide_chuwi_vi10_plus_r51

First I did the required updates to get it building on Linux 4.9 including
adding the driver for the codec's MCLK input which is done with some patches
currently under review:

    clk: x86: Add Atom PMC platform clocks
    arch/x86/platform/atom: Move pmc_atom to drivers/platform/x86
    platform/x86: Enable Atom PMC platform clocks

I confirmed that I am manipulating the right clock by disabling it under
Windows and observing that audio output suddenly stops.

I created an audio loop within the codec itself, by enabling MIC1 as an input
to the Left HP Mux, enabling the LLIN Switch, and enabling Left HP Mux as an
input to Left Hp Mixer. Now when I make noise in the microphone, I can hear
it on the headphone. This verifies that most of the audio path through the
codec is working fine, and also that it is clocked.

I used asoc debugfs to trace the path through the DAI, platform and
codec DAPM graphs. Everything is On and active as expected. I confirmed that
it is basically the same as another Cherry Trail platform I have here
(except for the codec which is rt5645 on the other platform), including mixer
levels.

I also dumped the codec registers over I2C from Windows and set them to
the exact same values on Linux. Still not working.

At this point I am suspecting that this is likely a problem with the audio
interface and its linkage to the codec (SSP/I2S).

I modified the platform driver to use ssp1 instead of ssp2, because the
device schematics say that I2S_1 is being used. Then I ran into
send_ssp_cmd() complaining that ssp1 is not supported, and found a point
of curiosity here. This code is basically to set the value of
sst_cmd_sba_hw_set_ssp.selection which is documented as:
	/* 0:SSP0(def), 1:SSP1, 2:SSP2 */
But other platforms like cht_bsw_rt5645 use ssp2, for which send_ssp_cmd()
will use SSP_CODEC, which has value 3. So it looks like the above comment
is wrong? Either way, I tried selection values 0, 1, 2, and 3, and still no
audio output.

Here's the code, apologies that it is a bit unclean, I'll continue
improving it once I get something working. Any suggestions, or do I need to
get a hardware scope to diganose further?
---
 drivers/base/regmap/regmap-debugfs.c     |    2 +-
 sound/soc/codecs/Kconfig                 |    4 +
 sound/soc/codecs/Makefile                |    2 +
 sound/soc/codecs/es8316.c                | 1386 ++++++++++++++++++++++++++++
 sound/soc/codecs/es8316.h                |  124 +++
 sound/soc/intel/Kconfig                  |   12 +
 sound/soc/intel/atom/sst-atom-controls.c |    5 +-
 sound/soc/intel/atom/sst/sst_acpi.c      |    2 +
 sound/soc/intel/boards/Makefile          |    2 +
 sound/soc/intel/boards/cht_es8316.c      | 1462 ++++++++++++++++++++++++++++++
 10 files changed, 2999 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/es8316.c
 create mode 100644 sound/soc/codecs/es8316.h
 create mode 100644 sound/soc/intel/boards/cht_es8316.c

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 36ce351..6d3dc14 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -269,7 +269,7 @@ static ssize_t regmap_map_read_file(struct file *file, char __user *user_buf,
 				   count, ppos);
 }
 
-#undef REGMAP_ALLOW_WRITE_DEBUGFS
+#define REGMAP_ALLOW_WRITE_DEBUGFS
 #ifdef REGMAP_ALLOW_WRITE_DEBUGFS
 /*
  * This can be dangerous especially when we have clients such as
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c67667b..c74846c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -68,6 +68,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
 	select SND_SOC_DMIC
+	select SND_SOC_ES8316 if I2C
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_GTM601
@@ -512,6 +513,9 @@ config SND_SOC_HDMI_CODEC
 	select SND_PCM_IEC958
 	select HDMI
 
+config SND_SOC_ES8316
+	tristate "Everest Semi ES8316 CODEC"
+
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 958cd49..63a9329 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -61,6 +61,7 @@ snd-soc-da7219-objs := da7219.o da7219-aad.o
 snd-soc-da732x-objs := da732x.o
 snd-soc-da9055-objs := da9055.o
 snd-soc-dmic-objs := dmic.o
+snd-soc-es8316-objs := es8316.o
 snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
@@ -286,6 +287,7 @@ obj-$(CONFIG_SND_SOC_DA7219)	+= snd-soc-da7219.o
 obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
+obj-$(CONFIG_SND_SOC_ES8316)	+= snd-soc-es8316.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
new file mode 100644
index 0000000..6566895
--- /dev/null
+++ b/sound/soc/codecs/es8316.c
@@ -0,0 +1,1386 @@
+/*
+ * es8316.c -- es8316 ALSA SoC audio driver
+ * Copyright Everest Semiconductor Co.,Ltd
+ *
+ * Author: David Yang <yangxiaohua@everest-semi.com>
+ *
+ * Based on es8316.c
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#define DEBUG
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/of_gpio.h>
+#include <linux/acpi.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/tlv.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <linux/proc_fs.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/regmap.h>
+#include "es8316.h"
+
+#if 1
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...) do { } while (0)
+#endif
+#define alsa_dbg DBG
+
+#define dmic_used  1
+#define amic_used  0
+
+#define INVALID_GPIO -1
+int es8316_spk_con_gpio = INVALID_GPIO;
+int es8316_hp_con_gpio = INVALID_GPIO;
+int es8316_hp_det_gpio = INVALID_GPIO;
+//static int HP_IRQ=0;
+//static int mutex_status=0;
+//static int hp_irq_flag = 0;
+int es8316_init_reg = 0;
+
+#define GPIO_LOW  0
+#define GPIO_HIGH 1
+#ifndef es8316_DEF_VOL
+#define es8316_DEF_VOL			0x1e
+#endif
+
+struct snd_soc_codec *es8316_codec;
+static int es8316_init_regs(struct snd_soc_codec *codec);
+static int es8316_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level);
+
+static const struct reg_default es8316_reg_defaults[] = {
+       {0x00, 0x03}, {0x01 ,0x03}, {0x02, 0x00}, {0x03, 0x20}, 
+       {0x04, 0x11}, {0x05, 0x00}, {0x06, 0x11}, {0x07, 0x00},  
+       {0x08, 0x00}, {0x09, 0x01}, {0x0a, 0x00}, {0x0b, 0x00}, 
+       {0x0c, 0xf8}, {0x0d, 0x3f}, {0x0e, 0x00}, {0x0f, 0x00},  
+       {0x10, 0x01}, {0x11, 0xfc}, {0x12, 0x28}, {0x13, 0x00},
+       {0x14, 0x00}, {0x15, 0x33}, {0x16, 0x00}, {0x17, 0x00},  
+       {0x18, 0x88}, {0x19, 0x07}, {0x1a, 0x22}, {0x1b, 0x03},
+       {0x1c, 0x0f}, {0x1d, 0x00}, {0x1e, 0x80}, {0x1f, 0x80},  
+       {0x20, 0x00}, {0x21, 0x00}, {0x22, 0xc0}, {0x23, 0x00},
+       {0x24, 0x01}, {0x25, 0x08}, {0x26, 0x10}, {0x27, 0xc0},  
+       {0x28, 0x00}, {0x29, 0x1c}, {0x2a, 0x00}, {0x2b, 0xb0}, 
+       {0x2c, 0x32}, {0x2d, 0x03}, {0x2e, 0x00}, {0x2f, 0x11},  
+       {0x30, 0x10}, {0x31, 0x00}, {0x32, 0x00}, {0x33, 0xc0}, 
+       {0x34, 0xc0}, {0x35, 0x1f}, {0x36, 0xf7}, {0x37, 0xfd},  
+       {0x38, 0xff}, {0x39, 0x1f}, {0x3a, 0xf7}, {0x3b, 0xfd}, 
+       {0x3c, 0xff}, {0x3d, 0x1f}, {0x3e, 0xf7}, {0x3f, 0xfd},  
+       {0x40, 0xff}, {0x41, 0x1f}, {0x42, 0xf7}, {0x43, 0xfd}, 
+       {0x44, 0xff}, {0x45, 0x1f}, {0x46, 0xf7}, {0x47, 0xfd},  
+       {0x48, 0xff}, {0x49, 0x1f}, {0x4a, 0xf7}, {0x4b, 0xfd}, 
+       {0x4c, 0xff}, {0x4d, 0x00}, {0x4e, 0x00}, {0x4f, 0xff},  
+       {0x50, 0x00}, {0x51, 0x00}, {0x52, 0x00}, {0x53, 0x00},                           
+	};
+
+static bool es8316_writeable(struct device *dev, unsigned int reg)
+{
+	if (reg <= 90)
+		return true;
+	else
+		return false;
+}
+static bool es8316_readable(struct device *dev, unsigned int reg)
+{
+	if (reg <= 90)
+		return true;
+	else
+		return false;
+}
+static bool es8316_volatile(struct device *dev, unsigned int reg)
+{
+	if (reg <= 90)
+		return true;
+	else
+		return false;
+}
+/* codec private data */
+struct es8316_priv {
+	struct regmap *regmap;
+	unsigned int dmic_amic;
+	unsigned int sysclk;
+	struct snd_pcm_hw_constraint_list *sysclk_constraints;
+	struct delayed_work pcm_pop_work;
+};
+struct snd_soc_codec *tron_codec;
+/*
+* es8316_reset
+* write value 0xff to reg0x00, the chip will be in reset mode
+* then, writer 0x00 to reg0x00, unreset the chip
+*/
+static int es8316_reset(struct snd_soc_codec *codec)
+{
+	/* snd_soc_write(codec, ES8316_RESET_REG00, 0x3F); */
+	msleep(5);
+	/* return snd_soc_write(codec, ES8316_RESET_REG00, 0x03); */
+	return 0;
+}
+/*
+* es8316_hp_state_query
+* Check the register 0x4F, return the register value 
+* User should update this code according the headphone jack configuratio
+*/
+ static int es8316_hp_state_query(struct snd_soc_codec *codec)
+ {
+    unsigned int retv,tmp;
+	
+	retv = snd_soc_read(codec, 
+	0);
+    tmp  = retv & 0x06;
+
+    return(tmp);
+ }
+/*
+ * es8316S Controls
+ */
+//#define DECLARE_TLV_DB_SCALE(name, min, step, mute) 
+//static const DECLARE_TLV_DB_SCALE(hpout_vol_tlv, -4800, 1200, 0);
+static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -9600, 50, 1);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -9600, 50, 1);
+static const DECLARE_TLV_DB_SCALE(hpmixer_gain_tlv, -1200, 150, 0);
+static const DECLARE_TLV_DB_SCALE(mic_bst_tlv, 0, 1200, 0);
+//static const DECLARE_TLV_DB_SCALE(linin_pga_tlv, 0, 300, 0);
+/* {0, +3, +6, +9, +12, +15, +18, +21, +24,+27,+30,+33} dB */
+static unsigned int linin_pga_tlv[] = {
+	TLV_DB_RANGE_HEAD(12),
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 1, TLV_DB_SCALE_ITEM(300, 0, 0),
+	2, 2, TLV_DB_SCALE_ITEM(600, 0, 0),
+	3, 3, TLV_DB_SCALE_ITEM(900, 0, 0),
+	4, 4, TLV_DB_SCALE_ITEM(1200, 0, 0),
+	5, 5, TLV_DB_SCALE_ITEM(1500, 0, 0),
+	6, 6, TLV_DB_SCALE_ITEM(1800, 0, 0),
+	7, 7, TLV_DB_SCALE_ITEM(2100, 0, 0),
+	8, 8, TLV_DB_SCALE_ITEM(2400, 0, 0),
+};
+static unsigned int hpout_vol_tlv[] = {
+	TLV_DB_RANGE_HEAD(1),
+	0, 3, TLV_DB_SCALE_ITEM(-4800, 1200, 0),
+	
+};
+static const char *alc_func_txt[] = {"Off", "On"};
+static const struct soc_enum alc_func =
+	SOC_ENUM_SINGLE(ES8316_ADC_ALC1_REG29, 6, 2, alc_func_txt);
+
+static const char *ng_type_txt[] = {"Constant PGA Gain",
+				    "Mute ADC Output"};
+static const struct soc_enum ng_type =
+	SOC_ENUM_SINGLE(ES8316_ADC_ALC6_REG2E, 6, 2, ng_type_txt);
+
+static const char *adcpol_txt[] = {"Normal", "Invert"};
+static const struct soc_enum adcpol =
+	SOC_ENUM_SINGLE(ES8316_ADC_MUTE_REG26, 1, 2, adcpol_txt);
+static const char *dacpol_txt[] = {"Normal", "R Invert", "L Invert",
+				   "L + R Invert"};
+static const struct soc_enum dacpol =
+	SOC_ENUM_SINGLE(ES8316_DAC_SET1_REG30, 0, 4, dacpol_txt);
+
+static const struct snd_kcontrol_new es8316_snd_controls[] = {
+	/* HP OUT VOLUME */
+	SOC_DOUBLE_TLV("HP Playback Volume", ES8316_CPHP_ICAL_VOL_REG18,
+		4, 0, 0, 1, hpout_vol_tlv),
+	/* HPMIXER VOLUME Control */
+	SOC_DOUBLE_TLV("HPMixer Gain", ES8316_HPMIX_VOL_REG16, 
+	  0, 4, 7, 0, hpmixer_gain_tlv),
+			    
+	/* DAC Digital controls */
+	SOC_DOUBLE_R_TLV("DAC Playback Volume", ES8316_DAC_VOLL_REG33,
+			ES8316_DAC_VOLR_REG34, 0, 0xC0, 1, dac_vol_tlv),
+			
+  	SOC_SINGLE("Enable DAC Soft Ramp", ES8316_DAC_SET1_REG30, 4, 1, 1),		
+  	SOC_SINGLE("DAC Soft Ramp Rate", ES8316_DAC_SET1_REG30, 2, 4, 0),
+    
+  	SOC_ENUM("Playback Polarity", dacpol),		
+  	SOC_SINGLE("DAC Notch Filter", ES8316_DAC_SET2_REG31, 6, 1, 0),	
+  	SOC_SINGLE("DAC Double Fs Mode", ES8316_DAC_SET2_REG31, 7, 1, 0),	  
+  	SOC_SINGLE("DAC Volume Control-LeR", ES8316_DAC_SET2_REG31, 2, 1, 0),	   
+  	SOC_SINGLE("DAC Stereo Enhancement", ES8316_DAC_SET3_REG32, 0, 7, 0),
+  
+	/* +20dB D2SE PGA Control */
+	SOC_SINGLE_TLV("MIC Boost", ES8316_ADC_D2SEPGA_REG24,
+		0, 1, 0, mic_bst_tlv),
+	/* 0-+24dB Lineinput PGA Control */	
+	SOC_SINGLE_TLV("Input PGA", ES8316_ADC_PGAGAIN_REG23,
+		4, 8, 0, linin_pga_tlv),
+
+	/* ADC Digital  Control */
+	SOC_SINGLE_TLV("ADC Capture Volume", ES8316_ADC_VOLUME_REG27, 
+	  0, 0xC0, 1, adc_vol_tlv),
+	SOC_SINGLE("ADC Soft Ramp", ES8316_ADC_MUTE_REG26, 4, 1, 0),
+  	SOC_ENUM("Capture Polarity", adcpol),	
+	SOC_SINGLE("ADC Double FS Mode", ES8316_ADC_DMIC_REG25, 4, 1, 0),
+		/* ADC ALC  Control */	
+  	SOC_SINGLE("ALC Capture Target Volume", ES8316_ADC_ALC3_REG2B, 4, 10, 0),
+  	SOC_SINGLE("ALC Capture Max PGA", ES8316_ADC_ALC1_REG29, 0, 28, 0), 
+  	SOC_SINGLE("ALC Capture Min PGA", ES8316_ADC_ALC2_REG2A, 0, 28, 0),
+  	SOC_ENUM("ALC Capture Function", alc_func),
+  	SOC_SINGLE("ALC Capture Hold Time", ES8316_ADC_ALC3_REG2B, 0, 10, 0),
+  	SOC_SINGLE("ALC Capture Decay Time", ES8316_ADC_ALC4_REG2C, 4, 10, 0),
+  	SOC_SINGLE("ALC Capture Attack Time", ES8316_ADC_ALC4_REG2C, 0, 10, 0),
+  	SOC_SINGLE("ALC Capture NG Threshold", ES8316_ADC_ALC6_REG2E, 0, 31, 0),
+  	SOC_ENUM("ALC Capture NG Type", ng_type),
+  	SOC_SINGLE("ALC Capture NG Switch", ES8316_ADC_ALC6_REG2E, 5, 1, 0),
+};
+
+/* Analog Input MUX */
+static const char * const es8316_analog_in_txt[] = {
+		"lin1-rin1",
+		"lin2-rin2",
+		"lin1-rin1 with 20db Boost",
+		"lin2-rin2 with 20db Boost"
+		};
+static const unsigned int es8316_analog_in_values[] = {
+		0,/*1,*/
+		1,
+		2,
+		3
+		};		
+static const struct soc_enum es8316_analog_input_enum =
+        SOC_VALUE_ENUM_SINGLE(ES8316_ADC_PDN_LINSEL_REG22, 4, 3,
+                              ARRAY_SIZE(es8316_analog_in_txt),
+                               es8316_analog_in_txt,
+                               es8316_analog_in_values);
+static const struct snd_kcontrol_new es8316_analog_in_mux_controls =
+         SOC_DAPM_ENUM("Route", es8316_analog_input_enum);
+
+/* Dmic MUX */
+static const char * const es8316_dmic_txt[] = {
+		"dmic disable",
+		"dmic data at high level",
+		"dmic data at low level",
+		};
+static const unsigned int es8316_dmic_values[] = {
+		0,/*1,*/
+		1,
+		2
+		};		
+static const struct soc_enum es8316_dmic_src_enum =
+        SOC_VALUE_ENUM_SINGLE(ES8316_ADC_DMIC_REG25, 0, 3,
+                              ARRAY_SIZE(es8316_dmic_txt),
+                               es8316_dmic_txt,
+                               es8316_dmic_values);
+static const struct snd_kcontrol_new es8316_dmic_src_controls =
+         SOC_DAPM_ENUM("Route", es8316_dmic_src_enum);
+         
+/* hp mixer mux */
+static const char *es8316_hpmux_texts[] = {
+	"lin1-rin1",
+	"lin2-rin2",
+	"lin-rin with Boost",
+	"lin-rin with Boost and PGA"
+	};
+
+static const unsigned int es8316_hpmux_values[] = {
+	0, 1, 2, 3};
+
+static const struct soc_enum es8316_left_hpmux_enum =
+	SOC_VALUE_ENUM_SINGLE(ES8316_HPMIX_SEL_REG13, 4, 7,
+			      ARRAY_SIZE(es8316_hpmux_texts),
+			      es8316_hpmux_texts,
+			      es8316_hpmux_values);
+static const struct snd_kcontrol_new es8316_left_hpmux_controls =
+	SOC_DAPM_ENUM("Route", es8316_left_hpmux_enum);
+
+static const struct soc_enum es8316_right_hpmux_enum =
+	SOC_VALUE_ENUM_SINGLE(ES8316_HPMIX_SEL_REG13, 0, 7,
+			      ARRAY_SIZE(es8316_hpmux_texts),
+			      es8316_hpmux_texts,
+			      es8316_hpmux_values);
+static const struct snd_kcontrol_new es8316_right_hpmux_controls =
+	SOC_DAPM_ENUM("Route", es8316_right_hpmux_enum);
+
+/* headphone Output Mixer */
+static const struct snd_kcontrol_new es8316_out_left_mix[] = {
+	SOC_DAPM_SINGLE("LLIN Switch", ES8316_HPMIX_SWITCH_REG14,
+			6, 1, 0),
+	SOC_DAPM_SINGLE("Left DAC Switch", 0x30,
+			5, 1, 0),
+};
+static const struct snd_kcontrol_new es8316_out_right_mix[] = {
+	SOC_DAPM_SINGLE("RLIN Switch", ES8316_HPMIX_SWITCH_REG14,
+			2, 1, 0),
+	SOC_DAPM_SINGLE("Right DAC Switch", 0x30,
+			5, 1, 0),
+};
+
+/* DAC data source mux */
+static const char *es8316_dacsrc_texts[] = {
+	"LDATA TO LDAC, RDATA TO RDAC", 
+	"LDATA TO LDAC, LDATA TO RDAC", 
+	"RDATA TO LDAC, RDATA TO RDAC", 
+	"RDATA TO LDAC, LDATA TO RDAC", 
+  };
+
+static const unsigned int es8316_dacsrc_values[] = {
+	0, 1, 2, 3};
+
+static const struct soc_enum es8316_dacsrc_mux_enum =
+	SOC_VALUE_ENUM_SINGLE(ES8316_DAC_SET1_REG30, 6, 4,
+			      ARRAY_SIZE(es8316_dacsrc_texts),
+			      es8316_dacsrc_texts,
+			      es8316_dacsrc_values);
+static const struct snd_kcontrol_new es8316_dacsrc_mux_controls =
+	SOC_DAPM_ENUM("Route", es8316_dacsrc_mux_enum);
+
+
+static const struct snd_soc_dapm_widget es8316_dapm_widgets[] = {
+	/* Input Lines */
+	SND_SOC_DAPM_INPUT("DMIC"),
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("MIC2"),	
+//	SND_SOC_DAPM_MICBIAS("micbias", ES8316_SYS_PDN_REG0D,
+//			5, 1),
+			
+	SND_SOC_DAPM_MICBIAS("micbias", SND_SOC_NOPM,
+			0, 0),
+  	/* Input MUX */
+	SND_SOC_DAPM_MUX("Differential Mux", SND_SOC_NOPM, 0, 0,
+		&es8316_analog_in_mux_controls),
+	SND_SOC_DAPM_PGA("Line input PGA", SND_SOC_NOPM,
+		0, 0, NULL, 0),
+
+	/* ADCs */
+	//SND_SOC_DAPM_ADC("Mono ADC", NULL, ES8316_ADC_PDN_LINSEL_REG22, 6, 0),
+	SND_SOC_DAPM_ADC("Mono ADC", NULL, SND_SOC_NOPM, 0, 0),
+
+ 	 /* Dmic MUX */
+	SND_SOC_DAPM_MUX("Digital Mic Mux", SND_SOC_NOPM, 0, 0,
+		&es8316_dmic_src_controls),
+
+	/* Digital Interface */
+	SND_SOC_DAPM_AIF_OUT("I2S OUT", "Capture",  1,
+			SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("I2S IN", "Playback", 0,
+			SND_SOC_NOPM, 0, 0),
+
+	 /*  DACs DATA SRC MUX */
+	SND_SOC_DAPM_MUX("DAC SRC Mux", SND_SOC_NOPM, 0, 0,
+		&es8316_dacsrc_mux_controls),	
+ 	/*  DACs  */
+        SND_SOC_DAPM_DAC("Right DAC", NULL, SND_SOC_NOPM, 0, 0),
+
+	//SND_SOC_DAPM_DAC("Left DAC", NULL, ES8316_DAC_PDN_REG2F, 4, 0),
+        SND_SOC_DAPM_DAC("Left DAC", NULL, SND_SOC_NOPM, 0, 0),
+
+	/* Headphone Output Side */
+	/* hpmux for hp mixer */	
+	SND_SOC_DAPM_MUX("Left Hp mux", SND_SOC_NOPM, 0, 0, 
+	   &es8316_left_hpmux_controls),
+	SND_SOC_DAPM_MUX("Right Hp mux", SND_SOC_NOPM, 0, 0,
+	   &es8316_right_hpmux_controls),
+	/* Output mixer  */
+/*	SND_SOC_DAPM_MIXER("Left Hp mixer", ES8316_HPMIX_PDN_REG15, 
+	   4, 1, &es8316_out_left_mix[0], ARRAY_SIZE(es8316_out_left_mix)),
+	SND_SOC_DAPM_MIXER("Right Hp mixer", ES8316_HPMIX_PDN_REG15, 
+	   0, 1, &es8316_out_right_mix[0], ARRAY_SIZE(es8316_out_right_mix)),	   */
+	SND_SOC_DAPM_MIXER("Left Hp mixer", SND_SOC_NOPM, 
+	   4, 1, &es8316_out_left_mix[0], ARRAY_SIZE(es8316_out_left_mix)),
+	SND_SOC_DAPM_MIXER("Right Hp mixer", SND_SOC_NOPM, 
+	   0, 1, &es8316_out_right_mix[0], ARRAY_SIZE(es8316_out_right_mix)),
+
+  //SND_SOC_DAPM_MIXER("Left Hp mixer", 0x32,
+   //       5, 1, &es8316_out_left_mix[0], ARRAY_SIZE(es8316_out_left_mix)),
+  //SND_SOC_DAPM_MIXER("Right Hp mixer", 0x32,
+ //         4, 1, &es8316_out_right_mix[0], ARRAY_SIZE(es8316_out_right_mix)),
+
+	/* Ouput charge pump */
+/*
+        SND_SOC_DAPM_PGA("HPCP L", 0x17,
+                 6, 0, NULL, 0),
+         SND_SOC_DAPM_PGA("HPCP R", 0x17,
+                 2, 0, NULL, 0),
+*/
+         /* Ouput Driver */
+         SND_SOC_DAPM_PGA("HPVOL L", SND_SOC_NOPM,
+                 7, 1, NULL, 0),
+         SND_SOC_DAPM_PGA("HPVOL R", SND_SOC_NOPM,
+                 7, 1, NULL, 0),
+ 	/* Ouput Driver */
+         SND_SOC_DAPM_PGA("SPKVOL L", SND_SOC_NOPM,
+                 7, 1, NULL, 0),
+         SND_SOC_DAPM_PGA("SPKVOL R", SND_SOC_NOPM,
+                 7, 1, NULL, 0),
+
+		
+	/* Output Lines */
+	SND_SOC_DAPM_OUTPUT("HPOL"),
+	SND_SOC_DAPM_OUTPUT("HPOR"),
+	SND_SOC_DAPM_OUTPUT("SPKOL"),
+	SND_SOC_DAPM_OUTPUT("SPKOR"),
+};
+
+static const struct snd_soc_dapm_route es8316_dapm_routes[] = {
+  	 /*
+  	 * record route map
+  	 */
+	{"MIC1", NULL, "micbias"},
+	{"MIC2", NULL, "micbias"},
+	{"DMIC", NULL, "micbias"},
+
+	{"Differential Mux", "lin1-rin1", "MIC1"},
+	{"Differential Mux", "lin2-rin2", "MIC2"},
+	{"Line input PGA", NULL, "Differential Mux"},
+
+	{"Mono ADC", NULL, "Line input PGA"},
+	
+	{"Digital Mic Mux", "dmic disable", "Mono ADC"},
+	{"Digital Mic Mux", "dmic data at high level", "DMIC"},
+  	{"Digital Mic Mux", "dmic data at low level", "DMIC"},
+  
+ 	{"I2S OUT", NULL, "Digital Mic Mux"},
+	 /*
+  	 * playback route map
+   	*/
+ 	{"DAC SRC Mux", "LDATA TO LDAC, RDATA TO RDAC", "I2S IN"},
+  	{"DAC SRC Mux", "LDATA TO LDAC, LDATA TO RDAC", "I2S IN"},
+ 	{"DAC SRC Mux", "RDATA TO LDAC, RDATA TO RDAC", "I2S IN"},
+ 	{"DAC SRC Mux", "RDATA TO LDAC, LDATA TO RDAC", "I2S IN"},
+
+	{"Left DAC", NULL, "DAC SRC Mux"},
+	{"Right DAC", NULL, "DAC SRC Mux"},
+   
+  
+  	{"Left Hp mux", "lin1-rin1", "MIC1"},
+  	{"Left Hp mux", "lin2-rin2", "MIC2"},
+  	{"Left Hp mux", "lin-rin with Boost", "Differential Mux"},
+  	{"Left Hp mux", "lin-rin with Boost and PGA", "Line input PGA"},
+  
+  	{"Right Hp mux", "lin1-rin1", "MIC1"},
+  	{"Right Hp mux", "lin2-rin2", "MIC2"},
+  	{"Right Hp mux", "lin-rin with Boost", "Differential Mux"},
+  	{"Right Hp mux", "lin-rin with Boost and PGA", "Line input PGA"},
+
+	{"Left Hp mixer", "LLIN Switch", "Left Hp mux"},
+	{"Left Hp mixer", "Left DAC Switch", "Left DAC"},
+	
+	{"Right Hp mixer", "RLIN Switch", "Right Hp mux"},
+	{"Right Hp mixer", "Right DAC Switch", "Right DAC"},
+
+	{"HPVOL L", NULL, "Left Hp mixer"},
+	{"HPVOL R", NULL, "Right Hp mixer"},
+/*
+	{"HPVOL L", NULL, "HPCP L"},
+	{"HPVOL R", NULL, "HPCP R"},
+*/	
+	{"HPOL", NULL, "HPVOL L"},
+	{"HPOR", NULL, "HPVOL R"},
+	
+	{"SPKOL", NULL, "SPKVOL L"},
+	{"SPKOR", NULL, "SPKVOL R"},
+	
+	{"SPKVOL L", NULL, "Left Hp mixer"},
+	{"SPKVOL R", NULL, "Right Hp mixer"},
+};
+
+struct _coeff_div {
+	u32 mclk;       //mclk frequency
+	u32 rate;       //sample rate
+	u8 div;         //adcclk and dacclk divider
+	u8 lrck_h;      //adclrck divider and daclrck divider
+	u8 lrck_l;
+	u8 sr;          //sclk divider
+	u8 osr;         //adc osr
+};
+
+
+/* codec hifi mclk clock divider coefficients */
+static const struct _coeff_div coeff_div[] = {
+	/* 8k */
+	{12288000, 8000 , 6 , 0x06, 0x00, 21, 32},
+	{11289600, 8000 , 6 , 0x05, 0x83, 20, 29},
+	{18432000, 8000 , 9 , 0x09, 0x00, 27, 32},
+	{16934400, 8000 , 8 , 0x08, 0x44, 25, 33},
+	{12000000, 8000 , 7 , 0x05, 0xdc, 21, 25},
+	{19200000, 8000 , 12, 0x09, 0x60, 27, 25},
+
+	/* 11.025k */
+	{11289600, 11025, 4 , 0x04, 0x00, 16, 32},
+	{16934400, 11025, 6 , 0x06, 0x00, 21, 32},
+	{12000000, 11025, 4 , 0x04, 0x40, 17, 34},
+
+	/* 16k */
+	{12288000, 16000, 3 , 0x03, 0x00, 12, 32},
+	{18432000, 16000, 5 , 0x04, 0x80, 18, 25},
+	{12000000, 16000, 3 , 0x02, 0xee, 12, 31},
+	{19200000, 16000, 6 , 0x04, 0xb0, 18, 25},
+
+	/* 22.05k */
+	{11289600, 22050, 2 , 0x02, 0x00, 8 , 32},
+	{16934400, 22050, 3 , 0x03, 0x00, 12, 32},
+	{12000000, 22050, 2 , 0x02, 0x20, 8 , 34},
+
+	/* 32k */
+	{12288000, 32000, 1 , 0x01, 0x80, 6 , 48},
+	{18432000, 32000, 2 , 0x02, 0x40, 9 , 32},
+	{12000000, 32000, 1 , 0x01, 0x77, 6 , 31},
+	{19200000, 32000, 3 , 0x02, 0x58, 10, 25},
+
+	/* 44.1k */
+	{11289600, 44100, 1 , 0x01, 0x00, 4 , 32},
+	{16934400, 44100, 1 , 0x01, 0x80, 6 , 32},
+	{12000000, 44100, 1 , 0x01, 0x10, 4 , 34},
+
+	/* 48k */
+	{12288000, 48000, 1 , 0x01, 0x00, 4 , 32},
+	{18432000, 48000, 1 , 0x01, 0x80, 6 , 32},
+	{12000000, 48000, 1 , 0x00, 0xfa, 4 , 31},
+	{19200000, 48000, 2 , 0x01, 0x90, 6, 25},
+
+	/* 88.2k */
+	{11289600, 88200, 1 , 0x00, 0x80, 2 , 32},
+	{16934400, 88200, 1 , 0x00, 0xc0, 3 , 48},
+	{12000000, 88200, 1 , 0x00, 0x88, 2 , 34},
+
+	/* 96k */
+	{12288000, 96000, 1 , 0x00, 0x80, 2 , 32},
+	{18432000, 96000, 1 , 0x00, 0xc0, 3 , 48},
+	{12000000, 96000, 1 , 0x00, 0x7d, 1 , 31},
+	{19200000, 96000, 1 , 0x00, 0xc8, 3 , 25},	
+};
+static inline int get_coeff(int mclk, int rate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(coeff_div); i++) {
+		if (coeff_div[i].rate == rate && coeff_div[i].mclk == mclk)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+/* The set of rates we can generate from the above for each SYSCLK */
+
+static unsigned int rates_12288[] = {
+	8000, 12000, 16000, 24000, 24000, 32000, 48000, 96000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_12288 = {
+	.count	= ARRAY_SIZE(rates_12288),
+	.list	= rates_12288,
+};
+
+static unsigned int rates_112896[] = {
+	8000, 11025, 22050, 44100,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_112896 = {
+	.count	= ARRAY_SIZE(rates_112896),
+	.list	= rates_112896,
+};
+
+static unsigned int rates_12[] = {
+	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
+	48000, 88235, 96000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_12 = {
+	.count	= ARRAY_SIZE(rates_12),
+	.list	= rates_12,
+};
+
+/*
+ * Note that this should be called from init rather than from hw_params.
+ */
+static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct es8316_priv *es8316 = snd_soc_codec_get_drvdata(codec);
+
+	DBG("Enter::%s----%d, freq:%d\n",__FUNCTION__,__LINE__, freq);
+		
+	switch (freq) {
+	case 11289600:
+	case 18432000:
+	case 22579200:
+	case 36864000:
+		es8316->sysclk_constraints = &constraints_112896;
+		es8316->sysclk = freq;
+		return 0;
+
+	case 12288000:
+	case 19200000:
+	case 16934400:
+	case 24576000:
+	case 33868800:
+		es8316->sysclk_constraints = &constraints_12288;
+		es8316->sysclk = freq;
+		return 0;
+
+	case 12000000:
+	case 24000000:
+		es8316->sysclk_constraints = &constraints_12;
+		es8316->sysclk = freq;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int es8316_set_dai_fmt(struct snd_soc_dai *codec_dai,
+		unsigned int fmt)
+{
+  struct snd_soc_codec *codec = codec_dai->codec;
+    u8 iface = 0;
+    u8 adciface = 0;
+    u8 daciface = 0;
+
+    printk("%s----%d, fmt[%02x]\n",__FUNCTION__,__LINE__,fmt);
+
+    iface    = snd_soc_read(codec, ES8316_IFACE);
+    adciface = snd_soc_read(codec, ES8316_ADC_IFACE);
+    daciface = snd_soc_read(codec, ES8316_DAC_IFACE);
+
+    /* set master/slave audio interface */
+    switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+        case SND_SOC_DAIFMT_CBM_CFM:    // MASTER MODE
+        	  alsa_dbg("es8316 in master mode");
+            iface |= 0x80;
+            break;
+        case SND_SOC_DAIFMT_CBS_CFS:    // SLAVE MODE
+        	  alsa_dbg("es8316 in slave mode");
+            iface &= 0x7F;
+            break;
+        default:
+            return -EINVAL;
+    }
+
+    /* interface format */
+
+    switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+        case SND_SOC_DAIFMT_I2S:
+            adciface &= 0xFC;                   
+            daciface &= 0xFC;
+            break;
+        case SND_SOC_DAIFMT_RIGHT_J:
+            return -EINVAL;
+        case SND_SOC_DAIFMT_LEFT_J:
+            adciface &= 0xFC;                   
+            daciface &= 0xFC;        
+            adciface |= 0x01;                   
+            daciface |= 0x01;             
+            break;
+        case SND_SOC_DAIFMT_DSP_A:
+            adciface &= 0xDC;                   
+            daciface &= 0xDC;        
+            adciface |= 0x03;                   
+            daciface |= 0x03;         
+            break;
+        case SND_SOC_DAIFMT_DSP_B:
+            adciface &= 0xDC;                   
+            daciface &= 0xDC;        
+            adciface |= 0x23;                   
+            daciface |= 0x23;        
+            break;
+        default:
+            return -EINVAL;
+    }
+
+
+    /* clock inversion */
+    switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+        case SND_SOC_DAIFMT_NB_NF:  
+            iface    &= 0xDF;
+            adciface &= 0xDF;                  
+            daciface &= 0xDF;			
+            break;
+        case SND_SOC_DAIFMT_IB_IF:
+            iface    |= 0x20;            
+            adciface |= 0x20;            
+            daciface |= 0x20;
+            break;
+        case SND_SOC_DAIFMT_IB_NF:
+            iface    |= 0x20;           
+            adciface &= 0xDF;           
+            daciface &= 0xDF;
+            break;
+        case SND_SOC_DAIFMT_NB_IF:
+            iface    &= 0xDF;
+            adciface |= 0x20;            
+            daciface |= 0x20;
+            break;
+        default:
+            return -EINVAL;
+    }
+    snd_soc_write(codec, ES8316_IFACE, iface);
+    snd_soc_write(codec, ES8316_ADC_IFACE, adciface);
+    snd_soc_write(codec, ES8316_DAC_IFACE, daciface);
+    return 0;
+}
+
+static void pcm_pop_work_events(struct work_struct *work)
+{
+	int ret;
+	//printk("es8316--------pcm_pop_work_events\n");
+	snd_soc_write(tron_codec,ES8316_CPHP_OUTEN_REG17,0x66);
+	ret=snd_soc_read(tron_codec, ES8316_GPIO_FLAG);
+	if((ret & 0x04)==0x04) {			
+	 	gpio_set_value(368, 1);
+	 	//printk("2222 gpio_set_value 1\n"); 
+	}	
+	es8316_init_reg=1;
+}
+
+static int es8316_pcm_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct es8316_priv *es8316 = snd_soc_codec_get_drvdata(codec);
+	bool playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+  int ret;     
+	//printk("es8316_pcm_startup Enter::%s----%d  es8316->sysclk=%d\n",__FUNCTION__,__LINE__,es8316->sysclk);
+	if(playback)
+	{		
+		snd_soc_write(codec, 0x50, 0xAA);
+		 if(es8316_init_reg==0){
+         //printk("==================>>>>>>>>es8316_pcm_startup es8316_init_reg=0\n");
+         schedule_delayed_work(&es8316->pcm_pop_work,msecs_to_jiffies(100));
+        }
+        else{
+				ret = snd_soc_read(codec, ES8316_GPIO_FLAG);
+			if((ret & 0x04)==0x04)
+			{			
+				gpio_set_value(368, 1);
+				// printk("es8316_pcm_startup gpio_set_value 1\n");   
+				//msleep(250);                       	
+			}		
+ 		 }  
+	}		    	
+
+
+	/* The set of sample rates that can be supported depends on the
+	 * MCLK supplied to the CODEC - enforce this.
+	 */
+	if (!es8316->sysclk) {
+		dev_err(codec->dev,
+			"No MCLK configured, call set_sysclk() on init\n");
+		//return -EINVAL;
+	} else {
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE, es8316->sysclk_constraints);
+}
+
+ 	return 0;
+}
+
+static void es8316_pcm_shutdown(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+		bool playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+		struct snd_soc_codec *codec = dai->codec;
+		if(playback)
+	{		
+			snd_soc_write(codec, ES8316_DAC_SET1_REG30, 0x30);//close 功放 
+			gpio_set_value(368, 0);
+			snd_soc_write(codec, 0x50, 0xA0);
+ 			//printk("es8316_pcm_shutdown----gpio_set_value 0\n");   
+			//printk("%s playback\n",__FUNCTION__);
+	}   	
+}
+
+
+static int es8316_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{ 
+	struct snd_soc_codec *codec = dai->codec;
+	struct es8316_priv *es8316 = snd_soc_codec_get_drvdata(codec);
+	int retv;
+	int coeff;
+	u16 osrate  =  snd_soc_read(codec, ES8316_CLKMGR_ADCOSR_REG03) & 0xc0; 
+	u16 mclkdiv = snd_soc_read(codec, ES8316_CLKMGR_CLKSW_REG01) & 0x7f;
+	u16 srate = snd_soc_read(codec, ES8316_SDP_MS_BCKDIV_REG09) & 0xE0;
+	u16 adciface = snd_soc_read(codec, ES8316_SDP_ADCFMT_REG0A) & 0xE3;
+	u16 daciface = snd_soc_read(codec, ES8316_SDP_DACFMT_REG0B) & 0xE3;
+	u16 adcdiv   = snd_soc_read(codec, ES8316_CLKMGR_ADCDIV1_REG04); 
+	u16 adclrckdiv_l = snd_soc_read(codec, ES8316_CLKMGR_ADCDIV2_REG05) & 0x00; 
+	u16 dacdiv   = snd_soc_read(codec, ES8316_CLKMGR_DACDIV1_REG06);
+ 	u16 daclrckdiv_l = snd_soc_read(codec, ES8316_CLKMGR_DACDIV2_REG07) & 0x00;
+	u16 adclrckdiv_h = adcdiv & 0xf0;
+	u16 daclrckdiv_h = dacdiv & 0xf0;	
+	int ret;
+ 	adcdiv &= 0x0f;
+ 	dacdiv &= 0x0f;
+
+ 	u16 tmp = snd_soc_read(codec, ES8316_CLKMGR_DACDIV2_REG07);
+
+	coeff = get_coeff(es8316->sysclk, params_rate(params));
+	if (coeff < 0) {
+		coeff = get_coeff(es8316->sysclk / 2, params_rate(params));
+		mclkdiv |= 0x80;
+	}
+	if (coeff < 0) {
+		dev_err(codec->dev,
+			"Unable to configure sample rate %dHz with %dHz MCLK\n",
+			params_rate(params), es8316->sysclk);
+		return coeff;
+	}
+
+	/* bit size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		adciface |= 0x000C;
+		daciface |= 0x000C;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		adciface |= 0x0004;
+		daciface |= 0x0004;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		adciface |= 0x0010;
+		daciface |= 0x0010;
+		break;
+	}
+
+	/* set iface & srate*/
+	snd_soc_update_bits(codec,ES8316_SDP_DACFMT_REG0B, 0xe3, daciface);
+	snd_soc_update_bits(codec, ES8316_SDP_ADCFMT_REG0A, 0xe3, adciface);
+	if (coeff >= 0) {
+		osrate = coeff_div[coeff].osr;
+		osrate &= 0x3f;
+		
+		srate |= coeff_div[coeff].sr;
+		srate &= 0x1f;
+	
+		adcdiv |= (coeff_div[coeff].div << 4);
+		adclrckdiv_h |= coeff_div[coeff].lrck_h;
+		adcdiv &= 0xf0;
+		adclrckdiv_h &= 0x0f;
+		adcdiv |= adclrckdiv_h;
+		adclrckdiv_l = coeff_div[coeff].lrck_l;
+
+		dacdiv |= (coeff_div[coeff].div << 4);
+		daclrckdiv_h |= coeff_div[coeff].lrck_h;
+		dacdiv &= 0xf0;
+		daclrckdiv_h &= 0x0f;
+		dacdiv |= daclrckdiv_h;
+		daclrckdiv_l = coeff_div[coeff].lrck_l;
+    /* 
+      * must do codec power on initialization at here becauses MCLK and I2S CLK always startup at here
+     */
+		retv = snd_soc_read(codec, 0x14) ; 
+		//pr_err("%s:%d,   retv=%x \n", __func__, __LINE__, retv);
+		if(es8316_init_reg>0){ 		
+			//printk("===%s es8316_init_reg>0\n", __func__);	
+			snd_soc_write(codec, 0X17, 0x66);
+			snd_soc_write(codec, ES8316_DAC_SET1_REG30, 0x10);
+			ret = snd_soc_read(codec, ES8316_GPIO_FLAG);
+			if((ret & 0x04)==0x04) {
+			if(es8316_init_reg>0){
+ 			    gpio_set_value(368, 1);
+ 			   // printk("gpio_set_value 1\n");   
+ 			    //msleep(250);
+                        } 	
+			}	
+			
+		}else{
+			//printk("===%s es8316_init_reg=0\n", __func__);
+			snd_soc_write(codec, 0x01, 	0x7F);
+			snd_soc_write(codec, 0x2F,	0x00);
+			snd_soc_write(codec, 0X18, 	0x00);
+			snd_soc_write(codec, 0X1b, 	0x30);
+			snd_soc_write(codec, 0X1a, 	0x10);
+			snd_soc_write(codec, 0X19, 	0x03);
+			//msleep(10);
+			snd_soc_write(codec, 0X14,	0x88);
+			snd_soc_write(codec, 0X15, 	0x00);
+			snd_soc_write(codec, 0X16, 	0xbb);      
+			snd_soc_write(codec, 0x00,	0xC0);  //CHARGE PUMP DIVIDER
+			msleep(50);
+			snd_soc_write(codec, 0X17, 0x66);
+			snd_soc_write(codec, ES8316_DAC_SET1_REG30, 0x00);		
+			snd_soc_write(codec, ES8316_GPIO_SEL_REG4D, 0x00);	//set gpio2 to GM SHORT
+			snd_soc_write(codec, ES8316_GPIO_DEBUNCE_INT_REG4E, 0xf3);  //maximum debance time, enable interrupt, low active
+			es8316_set_bias_level(codec, SND_SOC_BIAS_ON);			
+			//es8316_init_reg = 1;
+		}
+		//pr_err("%s:%d,   retv=%x \n", __func__, __LINE__, retv);
+	}
+
+	//snd_soc_write(codec,ES8316_DAC_SET2_REG31, 0x20); 
+	retv = snd_soc_read(codec, ES8316_GPIO_FLAG);
+	//pr_err("%s:%d,   retv=%x \n", __func__, __LINE__, retv);
+	return 0;
+}
+
+static int es8316_mute(struct snd_soc_dai *dai, int mute)
+{
+	//printk("===enter %s\n", __func__);	
+	#if 0
+	struct snd_soc_codec *codec = dai->codec;
+	int ret;
+	dev_dbg(codec->dev, "%s %d\n", __func__, mute);
+	if (mute){ 	
+		//snd_soc_write(codec, ES8316_DAC_SET1_REG30, 0x20);//close 功放 
+		gpio_set_value(368, 0);
+	}else{
+		//snd_soc_write(codec, ES8316_DAC_SET1_REG30, 0x00);
+		ret = snd_soc_read(codec, ES8316_GPIO_FLAG);
+		if((ret & 0x04)==0x04)	{ //remove
+		gpio_set_value(368, 1);    	
+		}
+	}
+	#endif
+	return 0;
+}
+
+static int es8316_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{        
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		dev_dbg(codec->dev, "%s on\n", __func__);
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		dev_dbg(codec->dev, "%s prepare\n", __func__);
+		if(es8316_init_reg>0)
+			{
+				snd_soc_write(codec, ES8316_CLKMGR_CLKSW_REG01, 0x7F);
+				snd_soc_write(codec, ES8316_SYS_PDN_REG0D, 0x00);
+				snd_soc_write(codec, ES8316_DAC_PDN_REG2F, 0x00);
+				snd_soc_write(codec, ES8316_HPMIX_SWITCH_REG14, 0x88);
+				snd_soc_write(codec, ES8316_HPMIX_PDN_REG15, 0x00);		
+				snd_soc_write(codec, ES8316_HPMIX_VOL_REG16, 0xBB);
+				snd_soc_write(codec, ES8316_CPHP_PDN2_REG1A, 0x10);		
+				snd_soc_write(codec, ES8316_CPHP_LDOCTL_REG1B, 0x30);
+				snd_soc_write(codec, ES8316_CPHP_PDN1_REG19, 0x03);
+				snd_soc_write(codec, ES8316_CPHP_ICAL_VOL_REG18, 0x00);
+				snd_soc_write(codec, ES8316_RESET_REG00, 0xC0);	
+				//snd_soc_write(codec, ES8316_CPHP_OUTEN_REG17, 0x66);
+			}
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		dev_dbg(codec->dev, "%s standby\n", __func__);
+		if(es8316_init_reg>0)   // if codec intialized, 
+			{
+				snd_soc_write(codec, ES8316_CLKMGR_CLKSW_REG01, 0x7F);
+				snd_soc_write(codec, ES8316_SYS_PDN_REG0D, 0x00);
+				snd_soc_write(codec, ES8316_DAC_PDN_REG2F, 0x00);
+				snd_soc_write(codec, ES8316_HPMIX_SWITCH_REG14, 0x88);
+				snd_soc_write(codec, ES8316_HPMIX_PDN_REG15, 0x00);		
+				snd_soc_write(codec, ES8316_HPMIX_VOL_REG16, 0xBB);
+				snd_soc_write(codec, ES8316_CPHP_PDN2_REG1A, 0x10);		
+				snd_soc_write(codec, ES8316_CPHP_LDOCTL_REG1B, 0x30);
+				snd_soc_write(codec, ES8316_CPHP_PDN1_REG19, 0x03);
+				snd_soc_write(codec, ES8316_CPHP_ICAL_VOL_REG18, 0x00);
+				snd_soc_write(codec, ES8316_RESET_REG00, 0xC0);	
+				//snd_soc_write(codec, ES8316_CPHP_OUTEN_REG17, 0x66);	
+			}
+		break;
+	case SND_SOC_BIAS_OFF:
+		dev_dbg(codec->dev, "%s off\n", __func__);
+		/*if(es8316_init_reg>0){
+	//	snd_soc_write(codec, ES8316_CPHP_ICAL_VOL_REG18, 0x33);
+		snd_soc_write(codec, ES8316_CPHP_OUTEN_REG17, 0x00);
+		snd_soc_write(codec, ES8316_CPHP_LDOCTL_REG1B, 0x03);
+		snd_soc_write(codec, ES8316_CPHP_PDN2_REG1A, 0x22);
+		snd_soc_write(codec, ES8316_CPHP_PDN1_REG19, 0x07);
+		snd_soc_write(codec, ES8316_HPMIX_SWITCH_REG14, 0x00);
+		snd_soc_write(codec, ES8316_HPMIX_PDN_REG15, 0x33);
+		snd_soc_write(codec, ES8316_HPMIX_VOL_REG16, 0x00);
+		snd_soc_write(codec, ES8316_ADC_PDN_LINSEL_REG22, 0xC0);
+		snd_soc_write(codec, ES8316_DAC_PDN_REG2F, 0x11);
+		snd_soc_write(codec, ES8316_SYS_PDN_REG0D, 0x3F);
+		snd_soc_write(codec, ES8316_CLKMGR_CLKSW_REG01, 0x03);
+		snd_soc_write(codec, ES8316_RESET_REG00, 0x7F);		
+	}*/
+		break;
+	}
+	
+	return 0;
+}
+
+#define es8316_RATES SNDRV_PCM_RATE_8000_96000
+
+#define es8316_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
+	SNDRV_PCM_FMTBIT_S24_LE)
+
+static struct snd_soc_dai_ops es8316_ops = {
+	.startup = es8316_pcm_startup,
+	.hw_params = es8316_pcm_hw_params,
+	.set_fmt = es8316_set_dai_fmt,
+	.set_sysclk = es8316_set_dai_sysclk,
+	.digital_mute = es8316_mute,
+	.shutdown = es8316_pcm_shutdown,
+};
+
+static struct snd_soc_dai_driver es8316_dai = {
+	.name = "ES8316 HiFi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = es8316_RATES,
+		.formats = es8316_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = es8316_RATES,
+		.formats = es8316_FORMATS,
+	 },
+	.ops = &es8316_ops,
+	.symmetric_rates = 1,
+};
+
+
+static int es8316_init_regs(struct snd_soc_codec *codec)
+{
+	dev_dbg(codec->dev, "%s\n", __func__);
+	snd_soc_write(codec,0x01, 0x7f); //setup adc volume
+	snd_soc_write(codec,0x02, 0x00);   //disable DAC ds and notch mode
+	snd_soc_write(codec, 0x03,0x19);  //CHARGE PUMP DIVIDER
+	snd_soc_write(codec, 0x04,0x21);
+	snd_soc_write(codec, 0x05,0x90);
+	snd_soc_write(codec, 0x06,0x11);
+	snd_soc_write(codec, 0x07,0x90);
+	snd_soc_write(codec, 0x08,0x00);
+	snd_soc_write(codec, 0x09,0x01);
+
+	snd_soc_write(codec, 0x0A, 0x0C);//ADC FORMAT , i2s-16bit, 
+	snd_soc_write(codec, 0x0B, 0x0C);//DAC FORMAT, i2s-16bit
+	snd_soc_write(codec, 0x0D,0x00);  //CLK CASE
+	snd_soc_write(codec, 0x22,0x20);  //CHARGE PUMP DIVIDER
+	snd_soc_write(codec, 0x2F,0x00);
+	snd_soc_write(codec, 0x10,0x11);
+	snd_soc_write(codec, 0x12,0x28);
+	snd_soc_write(codec, 0x1C,0x0F);
+	snd_soc_write(codec, 0x1D,0x0C);
+	snd_soc_write(codec, 0x00,0xC0);  //CHARGE PUMP DIVIDER
+	msleep(50);
+
+	snd_soc_write(codec, 0x23,0x10);  //CLK ON
+	snd_soc_write(codec, 0x24,0x01);  //VMID SEQUENCE
+	snd_soc_write(codec, 0x26,0x00);      //ADC,DAC VREF SET, micbias pup
+	snd_soc_write(codec, 0x27,0x00);  //CSM POWER UP
+	snd_soc_write(codec, 0x30, 0x10); //INPUT SELECT INPUT1:0X20,INPUT2:0X30, ain and adc power down
+	snd_soc_write(codec, 0x33, 0x00); //POWER UP DACPOWER
+	snd_soc_write(codec, 0x34, 0x00); //L,R MIXER SET
+	snd_soc_write(codec, 0x14,0x88);  //MIXER
+	snd_soc_write(codec, 0x15,0x00);  //MIXER
+	snd_soc_write(codec, 0x16,0xAA);  //MIXER
+	snd_soc_write(codec, 0X18,0x00);  //CHARGE PUMP 
+	snd_soc_write(codec, 0X31, 0x00); //CHARGE PUMP 	
+	snd_soc_write(codec, 0X29, 0xd2); //CHARGE PUMP 
+	snd_soc_write(codec, 0X2A, 0x08); //vmidlow = 10'b
+	snd_soc_write(codec, 0X2B,0xA0);  //HPOUT SET
+
+	snd_soc_write(codec, 0X2C, 0x05);
+	snd_soc_write(codec, 0X2D, 0x06);
+	snd_soc_write(codec, 0X2E, 0x61);
+	/*alc set*/
+	snd_soc_write(codec, 0X4D, 0x00); 
+	snd_soc_write(codec, 0X4E, 0xF3); 
+	snd_soc_write(codec, 0X50, 0xA0); //adc ds mode, HPF enable
+	snd_soc_write(codec, 0X51, 0x00); //ALC ON,
+	snd_soc_write(codec, 0X52, 0x00);
+	//msleep(50);
+
+	snd_soc_write(codec, 0X18, 0x00);
+	snd_soc_write(codec, 0X1b, 0x30);
+	snd_soc_write(codec, 0X1a, 0x10);
+	snd_soc_write(codec, 0X19, 0x03);
+	snd_soc_write(codec, 0X14, 0x88);
+	snd_soc_write(codec, 0X15, 0x00);
+	snd_soc_write(codec, 0X16, 0xbb);
+	snd_soc_write(codec, 0X17, 0x66);
+	return 0;
+}
+
+//static int es8316_suspend(struct snd_soc_codec *codec, pm_message_t state)
+static int es8316_suspend(struct device *dev)
+{
+	//printk("%s suspend\n", __func__);
+	gpio_set_value(368, 0);
+	// snd_soc_write(codec, ES8316_CPHP_ICAL_VOL_REG18, 0x33);
+	if(es8316_init_reg>0){ 
+		/*if Codec has been initialized before, then enter into suspend directly */
+		//printk("===%s es8316_init_reg > 0\n", __func__);
+		snd_soc_write(tron_codec, ES8316_CPHP_ICAL_VOL_REG18, 0x11);
+		mdelay(5);
+		snd_soc_write(tron_codec, ES8316_CPHP_OUTEN_REG17, 0x00);
+		snd_soc_write(tron_codec, 0x2f, 0x11);
+		snd_soc_write(tron_codec, ES8316_CPHP_LDOCTL_REG1B, 0x03);
+		snd_soc_write(tron_codec, ES8316_CPHP_PDN2_REG1A, 0x22);
+		snd_soc_write(tron_codec, ES8316_CPHP_PDN1_REG19, 0x06);
+		snd_soc_write(tron_codec, ES8316_HPMIX_SWITCH_REG14, 0x00);
+		snd_soc_write(tron_codec, ES8316_HPMIX_PDN_REG15, 0x33);
+		snd_soc_write(tron_codec, ES8316_HPMIX_VOL_REG16, 0x00);
+		snd_soc_update_bits(tron_codec, ES8316_ADC_PDN_LINSEL_REG22, 0xC0, 0xc0);		
+		snd_soc_write(tron_codec, ES8316_CLKMGR_CLKSW_REG01, 0x03);	
+		//snd_soc_write(tron_codec, 0x00,0x7f);  //CHARGE PUMP DIVIDER		
+	} else {
+	#if 0
+		/*if Codec  has not been initialized before,  enter into normal mode firstly, then enter into suspend at last */
+		//snd_soc_update_bits(codec, ES8316_ADC_PDN_LINSEL_REG22, 0xC0, 0x00);	
+		//printk("===%s es8316_init_reg = 0\n", __func__);	
+		snd_soc_write(tron_codec, 0x2F,	0x00);
+		snd_soc_write(tron_codec, 0X18, 0x11);
+		snd_soc_write(tron_codec, 0X1b, 0x30);
+		snd_soc_write(tron_codec, 0X1a, 0x10);
+		snd_soc_write(tron_codec, 0X19, 0x03);
+		snd_soc_write(tron_codec, 0X14, 0x88);
+		snd_soc_write(tron_codec, 0X15, 0x00);
+		snd_soc_write(tron_codec, 0X16, 0xbb); 	 
+		snd_soc_write(tron_codec, 0x00,0xC0);  //CHARGE PUMP DIVIDER
+		//msleep(50);
+		//snd_soc_write(tron_codec, 0X17, 0x66);
+		msleep(200);			
+		snd_soc_write(tron_codec, ES8316_CPHP_OUTEN_REG17, 0x00);
+		snd_soc_write(tron_codec, 0x2f, 0x11);
+		snd_soc_write(tron_codec, ES8316_CPHP_LDOCTL_REG1B, 0x03);
+		snd_soc_write(tron_codec, ES8316_CPHP_PDN2_REG1A, 0x22);
+		snd_soc_write(tron_codec, ES8316_CPHP_PDN1_REG19, 0x06);
+		snd_soc_write(tron_codec, ES8316_HPMIX_SWITCH_REG14, 0x00);
+		snd_soc_write(tron_codec, ES8316_HPMIX_PDN_REG15, 0x33);
+		snd_soc_write(tron_codec, ES8316_HPMIX_VOL_REG16, 0x00);
+		snd_soc_update_bits(tron_codec, ES8316_ADC_PDN_LINSEL_REG22, 0xC0, 0xc0);		
+		snd_soc_write(tron_codec, ES8316_CLKMGR_CLKSW_REG01, 0x03);		
+		//es8316_init_reg = 1;
+		#endif
+	}
+	//snd_soc_write(tron_codec, 0X4E, 0xF0); 
+	return 0;
+}
+
+//static int es8316_resume(struct snd_soc_codec *codec)
+static int es8316_resume(struct device *dev)
+{
+	//printk("===%s resume\n", __func__);
+	if(es8316_init_reg>0){
+		//printk("es8316 resume\n");
+		snd_soc_write(tron_codec, ES8316_CLKMGR_CLKSW_REG01, 0x7f);
+		snd_soc_write(tron_codec, ES8316_CPHP_ICAL_VOL_REG18, 0x11);
+		snd_soc_write(tron_codec, ES8316_CPHP_LDOCTL_REG1B, 0x30);		
+		snd_soc_write(tron_codec, ES8316_CPHP_PDN2_REG1A, 0x10);
+		snd_soc_write(tron_codec, ES8316_CPHP_PDN1_REG19, 0x02);
+		snd_soc_write(tron_codec, ES8316_HPMIX_SWITCH_REG14, 0x88);
+		snd_soc_write(tron_codec, ES8316_HPMIX_PDN_REG15, 0x00);
+		snd_soc_write(tron_codec, ES8316_HPMIX_VOL_REG16, 0xbb);		
+		snd_soc_update_bits(tron_codec, ES8316_ADC_PDN_LINSEL_REG22, 0xc0, 0x00);
+		snd_soc_write(tron_codec, 0x2f, 0x00);
+		snd_soc_write(tron_codec, ES8316_CPHP_OUTEN_REG17, 0x66);
+	} 
+	//snd_soc_write(tron_codec, 0X4E, 0xF3); 
+	return 0;
+}
+
+static int es8316_probe(struct snd_soc_codec *codec)
+{
+	int ret = 0;
+//	int ReadBuffer,ReadBuffer1,ReadBuffer2;
+	struct es8316_priv *es8316 = snd_soc_codec_get_drvdata(codec);
+	pr_debug("---%s--start--\n",__FUNCTION__);
+  	tron_codec = codec;
+	es8316_init_reg = 0;
+	//gpio_set_value(139, 0);
+	snd_soc_write(codec, 0x00, 0xc2); 
+	//msleep(100);
+	//retv = snd_soc_read(codec, ES8316_CLKMGR_ADCDIV2_REG05) ; 
+	snd_soc_write(codec, 0x01, 0x7f); //setup adc volume
+	snd_soc_write(codec, 0x02, 0x00);   //disable DAC ds and notch mode
+	snd_soc_write(codec, 0x03,0x19);  //CHARGE PUMP DIVIDER
+	snd_soc_write(codec, 0x04,0x21);
+	snd_soc_write(codec, 0x05,0x90);
+	snd_soc_write(codec, 0x06,0x11);
+	snd_soc_write(codec, 0x07,0x90);
+	snd_soc_write(codec, 0x08,0x00);
+	snd_soc_write(codec, 0x09,0x01);
+
+	snd_soc_write(codec, 0x0A, 0x0C);//ADC FORMAT , i2s-16bit, 
+	snd_soc_write(codec, 0x0B, 0x0C);//DAC FORMAT, i2s-16bit
+	snd_soc_write(codec, 0x0D,0x00);  //CLK CASE
+
+	snd_soc_write(codec, 0x10, 0x11);
+	snd_soc_write(codec, 0x12, 0x28);
+	snd_soc_write(codec, 0x1C, 0x0F);
+	snd_soc_write(codec, 0x1D, 0x0C);
+	msleep(50);
+
+	snd_soc_write(codec, 0x23, 0x50);  //CLK ON
+	snd_soc_write(codec, 0x24, 0x00);  //VMID SEQUENCE
+        if(es8316->dmic_amic == dmic_used){
+	snd_soc_write(codec, 0x25, 0x0A);  //dmic channel
+        }else {
+ 	snd_soc_write(codec, 0x25, 0x08);  //amic channel
+        }
+	snd_soc_write(codec, 0x26, 0x00);      //ADC,DAC VREF SET, micbias pup
+	snd_soc_write(codec, 0x27, 0x00);  //CSM POWER UP
+	snd_soc_write(codec, 0x30, 0x10); //INPUT SELECT INPUT1:0X20,INPUT2:0X30, ain and adc power down
+	snd_soc_write(codec, 0x33, 0x00); //POWER UP DACPOWER
+	snd_soc_write(codec, 0x34, 0x00); //L,R MIXER SET
+	snd_soc_write(codec, 0X31, 0x00); //CHARGE PUMP 	
+        if(es8316->dmic_amic == dmic_used){
+	snd_soc_write(codec, 0X29, 0xDC); //CHARGE PUMP 
+	snd_soc_write(codec, 0X2A, 0x1C); //vmidlow = 10'b
+	}else {
+	snd_soc_write(codec, 0X29, 0xD0); //CHARGE PUMP 
+	snd_soc_write(codec, 0X2A, 0x08); //vmidlow = 10'b
+	}
+	snd_soc_write(codec, 0X2B, 0xA0);  //HPOUT SET
+
+	snd_soc_write(codec, 0X2C, 0x05);
+	snd_soc_write(codec, 0X2D, 0x06);
+	snd_soc_write(codec, 0X2E, 0x21);
+	/*alc set*/
+	snd_soc_write(codec, 0X4D, 0x00); 
+	snd_soc_write(codec, 0X4E, 0xF0);
+	snd_soc_write(codec, 0X50, 0xA0); //adc ds mode, HPF enable
+	snd_soc_write(codec, 0X51, 0x00); //ALC ON,
+	snd_soc_write(codec, 0X52, 0x00);
+#if defined(HS_IRQ)
+	det_initalize();
+#elif defined(HS_TIMER)
+	hsdet_init();
+#endif
+	INIT_DELAYED_WORK(&es8316->pcm_pop_work, pcm_pop_work_events);	
+	return ret;
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_es8316 = {
+	.probe =	es8316_probe,
+	//.suspend =	es8316_suspend,
+	//.resume =	es8316_resume,
+	.set_bias_level = es8316_set_bias_level,	
+	//.idle_bias_off = true,
+
+	.component_driver = {
+		.controls = es8316_snd_controls,
+		.num_controls = ARRAY_SIZE(es8316_snd_controls),
+		.dapm_widgets = es8316_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(es8316_dapm_widgets),
+		.dapm_routes = es8316_dapm_routes,
+		.num_dapm_routes = ARRAY_SIZE(es8316_dapm_routes),
+	},
+};
+
+static const struct regmap_config es8316_regmap = {
+	.reg_bits			= 8,
+	.val_bits			= 8,
+	.volatile_reg		= es8316_volatile,
+	.readable_reg		= es8316_readable,
+	.max_register		= ARRAY_SIZE(es8316_reg_defaults) + 1,
+	.reg_defaults		= es8316_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(es8316_reg_defaults),
+	.cache_type			= REGCACHE_RBTREE,
+};
+
+static void es8316_i2c_shutdown(struct i2c_client *i2c)
+{
+	struct snd_soc_codec *codec;
+
+	if (!tron_codec)
+		goto err;
+	codec = tron_codec;
+	if(es8316_init_reg>0){
+		snd_soc_write(codec, ES8316_CPHP_ICAL_VOL_REG18, 0x00);
+		snd_soc_write(codec, ES8316_CPHP_OUTEN_REG17, 0x00);
+		snd_soc_write(codec, ES8316_CPHP_LDOCTL_REG1B, 0x03);
+		snd_soc_write(codec, ES8316_CPHP_PDN2_REG1A, 0x22);
+		snd_soc_write(codec, ES8316_CPHP_PDN1_REG19, 0x06);
+		snd_soc_write(codec, ES8316_HPMIX_SWITCH_REG14, 0x00);
+		snd_soc_write(codec, ES8316_HPMIX_PDN_REG15, 0x33);
+		snd_soc_write(codec, ES8316_HPMIX_VOL_REG16, 0x00);
+		snd_soc_write(codec, ES8316_ADC_PDN_LINSEL_REG22, 0xC0);
+		snd_soc_write(codec, ES8316_DAC_PDN_REG2F, 0x11);
+		snd_soc_write(codec, ES8316_SYS_PDN_REG0D, 0x3F);
+		snd_soc_write(codec, ES8316_CLKMGR_CLKSW_REG01, 0x03);
+		snd_soc_write(codec, ES8316_RESET_REG00, 0x7F);		
+	}
+err:
+	return;
+}
+
+static int es8316_i2c_probe(struct i2c_client *i2c_client,
+				      const struct i2c_device_id *id)
+{
+	struct es8316_priv *es8316;
+	struct regmap *regmap;
+	int ret = -1;
+
+	es8316 = kzalloc(sizeof(*es8316), GFP_KERNEL);
+	if (es8316 == NULL){
+		return -ENOMEM;
+		}
+	es8316->dmic_amic = dmic_used;     //if internal mic is amic
+
+	regmap = devm_regmap_init_i2c(i2c_client, &es8316_regmap);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	i2c_set_clientdata(i2c_client, es8316);
+	ret =  snd_soc_register_codec(&i2c_client->dev, &soc_codec_dev_es8316,
+	     &es8316_dai, 1);
+	if (ret < 0) {
+		kfree(es8316);
+		return ret;
+	}
+    
+	gpio_request(368,"SPK_OUT_SHUTDOWN");
+	gpio_direction_output(368, 0);
+	return ret;
+}
+
+static  int es8316_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static const unsigned short normal_i2c[] = {0x11, I2C_CLIENT_END};
+static const struct i2c_device_id es8316_i2c_id[] = {
+	{"es8316", 0},	
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, es8316_i2c_id);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id es8316_acpi_match[] = {
+	{ "ESSX8316", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
+#endif
+
+static struct dev_pm_ops es8316_pm_ops = {
+	.suspend = es8316_suspend,
+	.resume  = es8316_resume,
+};
+
+
+static struct i2c_driver es8316_i2c_driver = {
+	.driver = {
+		.name = "es8316",
+		.pm = &es8316_pm_ops,
+		.acpi_match_table = ACPI_PTR(es8316_acpi_match),
+	},
+	.shutdown = es8316_i2c_shutdown,
+	.probe = es8316_i2c_probe,
+	.remove = es8316_i2c_remove,
+	.id_table = es8316_i2c_id,
+};
+module_i2c_driver(es8316_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC es8316 driver");
+MODULE_AUTHOR("Will <will@everset-semi.com>");
+MODULE_LICENSE("GPL");
+
diff --git a/sound/soc/codecs/es8316.h b/sound/soc/codecs/es8316.h
new file mode 100644
index 0000000..cb5d035
--- /dev/null
+++ b/sound/soc/codecs/es8316.h
@@ -0,0 +1,124 @@
+/*
+ * Copyright Everest Semiconductor Co.,Ltd
+ *
+ * Author: David Yang <yangxiaohua@everest-semi.com>
+ *
+ * Based on ES8323.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef _ES8316_H
+#define _ES8316_H
+
+/* ES8316 register space */
+/*
+* RESET Control
+*/
+#define ES8316_RESET_REG00             0x00
+/*
+* Clock Managerment
+*/
+#define ES8316_CLKMGR_CLKSW_REG01      0x01
+#define ES8316_CLKMGR_CLKSEL_REG02     0x02
+#define ES8316_CLKMGR_ADCOSR_REG03     0x03
+#define ES8316_CLKMGR_ADCDIV1_REG04    0x04
+#define ES8316_CLKMGR_ADCDIV2_REG05    0x05
+#define ES8316_CLKMGR_DACDIV1_REG06    0x06
+#define ES8316_CLKMGR_DACDIV2_REG07    0x07
+#define ES8316_CLKMGR_CPDIV_REG08      0x08
+/*
+* SDP Control
+*/
+#define ES8316_SDP_MS_BCKDIV_REG09     0x09
+#define ES8316_SDP_ADCFMT_REG0A        0x0a
+#define ES8316_SDP_DACFMT_REG0B        0x0b
+/*
+* System Control
+*/
+#define ES8316_SYS_VMIDSEL_REG0C       0x0c
+#define ES8316_SYS_PDN_REG0D           0x0d
+#define ES8316_SYS_LP1_REG0E           0x0e
+#define ES8316_SYS_LP2_REG0F           0x0f
+#define ES8316_SYS_VMIDLOW_REG10       0x10
+#define ES8316_SYS_VSEL_REG11          0x11
+#define ES8316_SYS_REF_REG12           0x12
+/*
+* HP Mixer
+*/
+#define ES8316_HPMIX_SEL_REG13         0x13
+#define ES8316_HPMIX_SWITCH_REG14      0x14
+#define ES8316_HPMIX_PDN_REG15         0x15
+#define ES8316_HPMIX_VOL_REG16         0x16
+/*
+* Charge Pump Headphone driver
+*/
+#define ES8316_CPHP_OUTEN_REG17        0x17
+#define ES8316_CPHP_ICAL_VOL_REG18     0x18
+#define ES8316_CPHP_PDN1_REG19         0x19
+#define ES8316_CPHP_PDN2_REG1A         0x1a
+#define ES8316_CPHP_LDOCTL_REG1B       0x1b
+/*
+* Calibration
+*/
+#define ES8316_CAL_TYPE_REG1C         0x1c
+#define ES8316_CAL_SET_REG1D          0x1d
+#define ES8316_CAL_HPLIV_REG1E        0x1e
+#define ES8316_CAL_HPRIV_REG1F        0x1f
+#define ES8316_CAL_HPLMV_REG20        0x20
+#define ES8316_CAL_HPRMV_REG21        0x21
+/*
+* ADC Control
+*/
+#define ES8316_ADC_PDN_LINSEL_REG22   0x22
+#define ES8316_ADC_PGAGAIN_REG23      0x23
+#define ES8316_ADC_D2SEPGA_REG24      0x24
+#define ES8316_ADC_DMIC_REG25         0x25
+#define ES8316_ADC_MUTE_REG26         0x26
+#define ES8316_ADC_VOLUME_REG27       0x27
+#define ES8316_ADC_ALC1_REG29         0x29
+#define ES8316_ADC_ALC2_REG2A         0x2a
+#define ES8316_ADC_ALC3_REG2B         0x2b
+#define ES8316_ADC_ALC4_REG2C         0x2c
+#define ES8316_ADC_ALC5_REG2D         0x2d
+#define ES8316_ADC_ALC6_REG2E         0x2e
+/*
+* DAC Control
+*/
+#define ES8316_DAC_PDN_REG2F          0x2f
+#define ES8316_DAC_SET1_REG30         0x30
+#define ES8316_DAC_SET2_REG31         0x31
+#define ES8316_DAC_SET3_REG32         0x32
+#define ES8316_DAC_VOLL_REG33         0x33
+#define ES8316_DAC_VOLR_REG34         0x34
+/*
+* GPIO
+*/
+#define ES8316_GPIO_SEL_REG4D         0x4D
+#define ES8316_GPIO_DEBUNCE_INT_REG4E 0x4E
+#define ES8316_GPIO_FLAG              0x4F
+/*
+* TEST MODE
+*/
+#define ES8316_TESTMODE_REG50         0x50
+#define ES8316_TEST1_REG51            0x51
+#define ES8316_TEST2_REG52            0x52
+#define ES8316_TEST3_REG53            0x53
+/*
+* es8396 System clock derived from MCLK or BCLK
+*/
+#define ES8316_CLKID_MCLK     0
+#define ES8316_CLKID_BCLK     1
+#define ES8316_CLKID_PLLO     2
+
+
+#define ES8316_IFACE            ES8316_SDP_MS_BCKDIV_REG09
+#define ES8316_ADC_IFACE        ES8316_SDP_ADCFMT_REG0A
+#define ES8316_DAC_IFACE        ES8316_SDP_DACFMT_REG0B
+
+#define ES8316_REGNUM      84
+
+#endif
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index fd5d1e0..b3023db 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -210,6 +210,18 @@ config SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
 	  platforms with MAX98090 audio codec it also can support TI jack chip as aux device.
 	  If unsure select "N".
 
+config SND_SOC_INTEL_CHT_ES8316_MACH
+	tristate "ASoC Audio driver for Intel Cherrytrail with ES8316 codec"
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SOC_ES8316
+	select SND_SST_MFLD_PLATFORM
+	select SND_SST_IPC_ACPI
+	select SND_SOC_INTEL_SST_MATCH if ACPI
+	help
+	  This adds support for ASoC machine driver for Intel(R) Cherrytrail
+	  platforms with ES8316 audio codec.
+	  If unsure select "N".
+
 config SND_SOC_INTEL_SKYLAKE
 	tristate
 	select SND_HDA_EXT_CORE
diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 0838478..25ea25c 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -21,6 +21,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define DEBUG
 
 #include <linux/slab.h>
 #include <sound/soc.h>
@@ -894,7 +895,7 @@ int sst_fill_ssp_config(struct snd_soc_dai *dai, unsigned int fmt)
  * this can be overwritten by set_dai_xxx APIs
  */
 static const struct sst_ssp_config sst_ssp_configs = {
-	.ssp_id = SSP_CODEC,
+	.ssp_id = SSP_BT,
 	.bits_per_slot = 24,
 	.slots = 4,
 	.ssp_mode = SSP_MODE_MASTER,
@@ -943,6 +944,8 @@ int send_ssp_cmd(struct snd_soc_dai *dai, const char *id, bool enable)
 		ssp_id = SSP_MODEM;
 	else if (strcmp(id, "ssp2-port") == 0)
 		ssp_id = SSP_CODEC;
+	else if (strcmp(id, "ssp1-port") == 0)
+		ssp_id = SSP_BT; // FIXME what is the right ID?
 	else {
 		dev_dbg(dai->dev, "port %s is not supported\n", id);
 		return -1;
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 0a88537..75997e2 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -458,6 +458,8 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 						&chv_platform_data },
 	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
+	{"ESSX8316", "cht-es8316", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
+						&chv_platform_data },
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", cht_quirk,
 						&chv_platform_data },
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 5639f10..2124aaa 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -10,6 +10,7 @@ snd-soc-sst-bytcr-rt5651-objs := bytcr_rt5651.o
 snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
 snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
 snd-soc-sst-cht-bsw-max98090_ti-objs := cht_bsw_max98090_ti.o
+snd-soc-sst-cht-es8316-objs := cht_es8316.o
 snd-soc-skl_rt286-objs := skl_rt286.o
 snd-skl_nau88l25_max98357a-objs := skl_nau88l25_max98357a.o
 snd-soc-skl_nau88l25_ssm4567-objs := skl_nau88l25_ssm4567.o
@@ -25,6 +26,7 @@ obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH) += snd-soc-sst-bytcr-rt5651.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
+obj-$(CONFIG_SND_SOC_INTEL_CHT_ES8316_MACH) += snd-soc-sst-cht-es8316.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) += snd-soc-sst-cht-bsw-max98090_ti.o
 obj-$(CONFIG_SND_SOC_INTEL_SKL_RT286_MACH) += snd-soc-skl_rt286.o
 obj-$(CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH) += snd-skl_nau88l25_max98357a.o
diff --git a/sound/soc/intel/boards/cht_es8316.c b/sound/soc/intel/boards/cht_es8316.c
new file mode 100644
index 0000000..a6e105d
--- /dev/null
+++ b/sound/soc/intel/boards/cht_es8316.c
@@ -0,0 +1,1462 @@
+/*
+ *  cht_cr_es8316.c - ASoc DPCM Machine driver
+ *  for Intel CherryTrail MID platform
+ *
+ *  Copyright (C) 2014 Intel Corp
+ *  Author: Praveen Diwakar <praveen.diwakar@intel.com>
+ *          Bhakte, GurudattaX <gurudattax.bhakte@intel.com>
+ *  This file is modified from cht_bl_dpcm_rt5672.c for cherrytrail CR
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#define DEBUG
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/gpio.h>
+#include <linux/acpi.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <asm/intel-mid.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include "../../codecs/es8316.h"
+#include "../atom/sst-atom-controls.h"
+
+struct clk *mclk;
+
+#define CHT_PLAT_CLK_3_HZ	19200000
+
+#define CHT_INTR_DEBOUNCE               0    //0  /* updated by everest-david  15-3-4*/
+#define CHT_HS_DEBOUNCE_DELAY           500//500       /* added by everest-david */
+#define CHT_HS_INSERT_DET_DELAY         400//600
+#define CHT_HS_REMOVE_DET_DELAY         40     //100  /* updated by everest-david  15-3-4*/   
+#define CHT_BUTTON_PRESS_DELAY          50
+#define CHT_BUTTON_RELEASE_DELAY        50
+#define CHT_HS_DET_POLL_INTRVL          50
+#define CHT_BUTTON_EN_DELAY             0
+
+#define CHT_HS_DET_RETRY_COUNT        8 
+#define CHT_HS_DEBOUNCE_RETRY_COUNT    3        /* added by everest-david */
+#define CHT_HS_BUTTON_PRESS_CHK_COUNT  3        /* added by everest-david */
+#define CHT_HS_BUTTON_RELEASE_CHK_COUNT 3       /* added by everest-david */
+#define CHT_HS_REMOVE_RETRY_COUNT 1       /* added by everest-david  15-3-4*/
+
+#define VLV2_PLAT_CLK_AUDIO	3
+#define PLAT_CLK_FORCE_ON	1
+#define PLAT_CLK_FORCE_OFF	2
+
+#define MAINMIC_DMIC_USED   1
+//#define  MAINMIC_AMIC_USED 1
+
+
+struct cht_mc_private {
+	struct snd_soc_codec *codec;
+	struct snd_soc_jack jack;
+	struct delayed_work hs_insert_work;
+	struct delayed_work hs_remove_work;
+	struct delayed_work hs_button_press_work;
+	struct delayed_work hs_button_release_work;
+	struct delayed_work hs_debounce_work;          /* added by everest-david */
+	struct delayed_work	hs_poll_work;
+	struct mutex jack_mlock;
+	struct mutex poll_mlock;
+	/* To enable button press interrupts after a delay after HS detection.
+	 * This is to avoid spurious button press events during slow
+	 * HS insertion
+	 */
+	struct delayed_work hs_button_en_work;
+	int intr_debounce;
+	int hs_debounce_delay;        /* added by everest-david */
+	int hs_debounce_retry;        /* added by everest-david */
+	int hs_insert_det_delay;
+	int hs_remove_det_delay;
+	int hs_remove_retry;          /* added by everest-david     15-3-4*/
+	int button_press_delay;
+	int button_press_chk_count;  /* added by everest-david */
+	int button_release_delay;
+	int button_release_chk_count; /* added by everest-david */
+	int button_en_delay;
+	int hs_det_poll_intrvl;
+	int hs_det_retry;
+	
+	int same_reg_cnt;
+  int hs_reg_v;
+  int poll_cnt;
+  int poll_status;
+	int poll_same_cnt;
+	bool process_button_events;
+};
+
+static int cht_hs_detection(void *);
+
+static struct snd_soc_jack_gpio hs_gpio = {
+		.name			= "cht-codec-int",
+		.report			= SND_JACK_HEADSET |
+					  SND_JACK_HEADPHONE |
+					  SND_JACK_BTN_0,
+		.debounce_time		= CHT_INTR_DEBOUNCE,
+		.jack_status_check	= cht_hs_detection,
+};
+static inline void cht_force_enable_pin(struct snd_soc_codec *codec,
+			 const char *bias_widget, bool enable)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	pr_debug("%s %s\n", enable ? "enable" : "disable", bias_widget);
+	if (enable)
+		snd_soc_dapm_force_enable_pin(dapm, bias_widget);
+	else
+		snd_soc_dapm_disable_pin(dapm, bias_widget);
+}
+
+static inline void cht_set_mic_bias(struct snd_soc_codec *codec, bool enable)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	if (enable)
+		cht_force_enable_pin(codec, "micbias", true);
+	else
+		cht_force_enable_pin(codec, "micbias", false);
+	snd_soc_dapm_sync(dapm);
+}
+
+static inline void cht_set_codec_power(struct snd_soc_codec *codec,
+								int jack_type)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	switch (jack_type) {
+	case SND_JACK_HEADSET:
+		cht_force_enable_pin(codec, "micbias2", true);
+		cht_force_enable_pin(codec, "JD Power", true);
+		cht_force_enable_pin(codec, "Mic Det Power", true);
+		break;
+	case SND_JACK_HEADPHONE:
+		cht_force_enable_pin(codec, "JD Power", true);
+		cht_force_enable_pin(codec, "Mic Det Power", false);
+		cht_force_enable_pin(codec, "micbias2", false);
+		break;
+	case 0:
+		cht_force_enable_pin(codec, "JD Power", false);
+		cht_force_enable_pin(codec, "Mic Det Power", false);
+		cht_force_enable_pin(codec, "micbias2", false);
+	       break;
+	default:
+		return;
+	}
+	snd_soc_dapm_sync(dapm);
+}
+static int es8316_headset_detect(struct snd_soc_codec *codec)
+{
+ 
+	int value;
+	int status;
+
+	value = snd_soc_read(codec, ES8316_GPIO_FLAG);
+	//printk("=== es8316_headset_detect: 0x%x\n",value);
+	switch (value) {
+	//case 0x24:
+	case 0x20:
+		status = SND_JACK_HEADPHONE;
+		break;
+	case 0x22:
+		status = SND_JACK_HEADSET;
+		break;
+	default:
+		status = 0;
+		break;
+	}
+
+	return status;
+}
+
+/* Identify the jack type as Headset/Headphone/None */
+static int cht_check_jack_type(struct snd_soc_jack *jack,
+					struct snd_soc_codec *codec)
+{
+	int status, jack_type = 0;
+	struct cht_mc_private *ctx = container_of(jack,
+					struct cht_mc_private, jack);
+
+	status = es8316_headset_detect(codec);
+	/* jd status high indicates some accessory has been connected */
+	if (status) {
+		pr_debug("Jack insert intr");
+		snd_soc_write(codec,0x30,0x30); 
+		gpio_direction_output(368,0);
+				  
+		 pr_debug("Jack insert intr");
+		/* Do not process button events until accessory is
+		   detected as headset*/
+		ctx->process_button_events = false;
+		cht_set_mic_bias(codec, true);
+		jack_type = es8316_headset_detect(codec); //read flag register to check headphone / headset type / or none
+		pr_info("jack_type:%d\n", jack_type);
+		if (jack_type == SND_JACK_HEADSET) {
+			ctx->process_button_events = true;
+#ifdef MAINMIC_DMIC_USED 
+			snd_soc_write(codec, 0x22,0x20);   //switch record channel to lin2rin2
+			snd_soc_write(codec, 0x25,0x08);   //record path switch to headset mic
+#else
+#ifdef MAINMIC_AMIC_USED
+			snd_soc_write(codec, 0x22,0x20);	//switch record channel to lin1rin1		 
+#endif
+#endif			
+
+			/* If headset is detected, enable button
+			   interrupts after a delay */
+			schedule_delayed_work(&ctx->hs_button_en_work,
+					msecs_to_jiffies(ctx->button_en_delay));
+		}
+		if (jack_type != SND_JACK_HEADSET){
+			cht_set_mic_bias(codec, true);
+#ifdef MAINMIC_DMIC_USED 
+			snd_soc_write(codec, 0x22,0x30);   //Disable ADC
+			snd_soc_write(codec, 0x25,0x08);   //record path switch to dmic
+#else
+#ifdef MAINMIC_AMIC_USED
+			snd_soc_write(codec, 0x22,0x30);	//switch record channel to lin2rin2		 
+#endif
+#endif
+
+		}
+	} else {
+		jack_type = 0;
+	}
+	pr_info("Jack type detected:%d\n", jack_type);
+	return jack_type;
+}
+
+/* Work function invoked by the Jack Infrastructure.
+ * Other delayed works for jack detection/removal/button
+ * press are scheduled from this function
+ */
+static int cht_hs_detection(void *data)
+{
+	int status, jack_type = 0;
+	int ret,value;
+	struct snd_soc_jack_gpio *gpio = &hs_gpio;
+	struct snd_soc_jack *jack = gpio->jack;
+	struct cht_mc_private *ctx = container_of(jack,
+						struct cht_mc_private, jack);
+	struct snd_soc_codec *codec = ctx->codec;
+	
+	pr_info("Enter:%s", __func__);
+	/* Ack interrupt first */
+	mutex_lock(&ctx->jack_mlock);
+	
+	cancel_delayed_work_sync(&ctx->hs_insert_work);
+	cancel_delayed_work_sync(&ctx->hs_button_en_work);
+	cancel_delayed_work_sync(&ctx->hs_button_press_work);
+	cancel_delayed_work_sync(&ctx->hs_button_release_work);
+	cancel_delayed_work_sync(&ctx->hs_remove_work);
+	cancel_delayed_work_sync(&ctx->hs_debounce_work);
+	//cancel_delayed_work_sync(&ctx->hs_poll_work);
+
+	/* Initialize jack status with previous status.
+	   The delayed work will confirm the event and
+	   send updated status later */
+	   
+	jack_type = jack->status;
+	value = snd_soc_read(codec, ES8316_GPIO_FLAG);
+	//printk("=== cht_hs_detection gpio flag: 0x%x\n",value);
+	if (!jack->status) {
+			//printk("=== jack->status = 0\n");
+			snd_soc_write(codec,0x30,0x30);       //mute dac when hp inserted
+      		//snd_soc_write(codec,0x22,0x30);
+			ctx->hs_det_retry = CHT_HS_DET_RETRY_COUNT;        
+			ctx->hs_debounce_retry = CHT_HS_DEBOUNCE_RETRY_COUNT;
+			ctx->button_press_chk_count = CHT_HS_BUTTON_PRESS_CHK_COUNT;
+			ctx->button_release_chk_count = CHT_HS_BUTTON_RELEASE_CHK_COUNT;
+			ctx->hs_remove_retry = CHT_HS_REMOVE_RETRY_COUNT;                   //UPDATED BY DAVID,15-3-4
+		
+			ret = schedule_delayed_work(&ctx->hs_insert_work,
+				msecs_to_jiffies(ctx->hs_insert_det_delay));
+			if (!ret){
+			 pr_info("byt_check_hs_insert_status already queued");		  
+			} else {
+				pr_info("%s:Check hs insertion  after %d msec",
+					__func__, ctx->hs_insert_det_delay);
+			}
+		} else {
+		/* First check for accessory removal; If not removed,
+		   check for button events*/
+		status = es8316_headset_detect(codec);
+		/* jd status low indicates accessory has been disconnected.
+		   However, confirm the removal in the delayed work */
+		if (!status) {
+			printk("=== >status = 0\n");
+			/* Do not process button events while we make sure
+			   accessory is disconnected*/
+			ctx->process_button_events = false;
+			snd_soc_write(codec,0x30,0x20);
+			ret = schedule_delayed_work(&ctx->hs_remove_work,
+				msecs_to_jiffies(ctx->hs_remove_det_delay));
+			if (!ret) {
+				pr_info("byt_check_hs_remove_status already queued");		
+			}else
+{
+				pr_info("%s:Check hs removal after %d msec",	__func__,
+						ctx->hs_remove_det_delay);	
+				}
+		} else { /* Must be button event.
+			  * Confirm the event in delayed work */
+			  printk("=== >status = 1\n");
+			if (((jack->status & SND_JACK_HEADSET) == SND_JACK_HEADSET) &&
+					ctx->process_button_events) {
+				ret = schedule_delayed_work(&ctx->hs_button_press_work,
+					msecs_to_jiffies(ctx->button_press_delay));
+				if (!ret)
+					{
+					  pr_info("byt_check_hs_button_press_status already queued");
+				 }
+				else
+					pr_info("%s:check BP/BR after %d msec",
+						__func__,
+						ctx->button_press_delay);
+			}
+			else
+				{
+					ret = schedule_delayed_work(&ctx->hs_remove_work,
+								msecs_to_jiffies(ctx->hs_remove_det_delay));
+					if (!ret) {
+							pr_info("byt_check_hs_remove_status already queued");		
+					}else	{
+					pr_info("%s:Check hs removal after %d msec",	__func__,
+							ctx->hs_remove_det_delay);	
+				}					
+			}
+		}
+	}
+
+	pr_info("Exit:%s", __func__);
+	mutex_unlock(&ctx->jack_mlock);
+
+	return jack_type;
+}
+/* Checks jack insertion and identifies the jack type.
+ * Retries the detection if necessary
+ */
+static void cht_check_hs_insert_status(struct work_struct *work)
+{
+	struct snd_soc_jack_gpio *gpio = &hs_gpio;
+	struct snd_soc_jack *jack = gpio->jack;
+	struct cht_mc_private *ctx = container_of(work,
+			struct cht_mc_private, hs_insert_work.work);
+	int jack_type = 0,ret;
+	struct snd_soc_codec *codec = ctx->codec;
+	mutex_lock(&ctx->jack_mlock);
+	pr_debug("Enter:%s", __func__);
+
+	//jack_type = cht_check_jack_type(jack, codec);
+
+	/* Report jack immediately only if jack is headset.
+	 * If headphone or no jack was detected, dont report it
+	 * until the last HS det try.
+	 * This is to avoid reporting any temporary jack removal or
+	 * accessory change (eg, HP to HS) during the detection tries.
+	 * This provides additional debounce that will help in the case
+	 * of slow insertion.
+	 * This also avoids the pause in audio due to accessory change
+	 * from HP to HS
+	 */
+    ret = snd_soc_read(codec, ES8316_GPIO_FLAG);
+    if(ctx->hs_reg_v == ret) {
+        ctx->same_reg_cnt++;
+    }
+    else {
+        ctx->same_reg_cnt = 0;
+    }
+    ctx->hs_reg_v = ret;	 
+	//if (ctx->hs_det_retry <= 0) /* end of retries; report the status */{
+	if (ctx->same_reg_cnt == CHT_HS_DET_RETRY_COUNT) /* end of retries; report the status */{
+		jack_type = cht_check_jack_type(jack, codec);
+		pr_info("%d Jack type sent is %d\n", __LINE__, jack_type);
+		if(jack_type == 0) {  /* if no hp inserted */
+			cht_set_mic_bias(codec, true);
+			ctx->process_button_events = false;
+			snd_soc_jack_report(jack, jack_type, gpio->report);   //report Jack status to Frame-work
+#ifdef MAINMIC_DMIC_USED 
+			snd_soc_write(codec, 0x22,0x30);   //Disable ADC
+			snd_soc_write(codec, 0x25,0x08);   //record path switch to dmic
+#else
+#ifdef MAINMIC_AMIC_USED
+			snd_soc_write(codec, 0x22,0x30);	//switch record channel to lin2rin2		 
+#endif
+#endif
+			ctx->process_button_events = false;
+			cancel_delayed_work_sync(&ctx->hs_button_en_work);
+			cancel_delayed_work_sync(&ctx->hs_button_press_work);	
+			cancel_delayed_work_sync(&ctx->hs_button_release_work); 
+			cancel_delayed_work_sync(&ctx->hs_remove_work);
+			cancel_delayed_work_sync(&ctx->hs_debounce_work);
+			//cancel_delayed_work_sync(&ctx->hs_poll_work);			
+		} else {           /* if headset or headphone inserted*/
+			snd_soc_jack_report(jack, jack_type, gpio->report); //report Jack status to Frame-work   
+			ret = schedule_delayed_work(&ctx->hs_poll_work,
+									msecs_to_jiffies(500));
+			gpio_direction_output(368, 0);
+			
+		}
+		ctx->same_reg_cnt = 0;
+		pr_info("jack report:%s,%d\n", __func__, __LINE__);
+		/* now, schedule one debounce work-quene, to cancel the noise at remove or insert */
+		ret = schedule_delayed_work(&ctx->hs_debounce_work,
+				msecs_to_jiffies(ctx->hs_debounce_delay));
+	} else {
+		/* Schedule another detection try if headphone or
+		 * no jack is detected.
+		 * During slow insertion of headset, first a headphone
+		 * may be detected.
+		 * Hence retry until headset is detected
+		 */
+		//ctx->hs_det_retry--;
+		ret = snd_soc_read(codec, ES8316_GPIO_FLAG);
+		schedule_delayed_work(&ctx->hs_insert_work,
+				msecs_to_jiffies(ctx->hs_det_poll_intrvl));
+		pr_info("%s:re-try hs detection after %d msec",
+				__func__, ctx->hs_det_poll_intrvl);
+	}
+
+	mutex_unlock(&ctx->jack_mlock);
+}
+/* Checks jack removal. */
+static void cht_check_hs_remove_status(struct work_struct *work)
+{
+	struct snd_soc_jack_gpio *gpio = &hs_gpio;
+	struct snd_soc_jack *jack = gpio->jack;
+	struct cht_mc_private *ctx = container_of(work,
+			struct cht_mc_private, hs_remove_work.work);
+	struct snd_soc_codec *codec = ctx->codec;
+	int status = 0, jack_type = 0;
+
+	int ret; 
+	/* Cancel any pending insertion detection. There
+	   could be pending insertion detection in the
+	   case of very slow insertion or insertion and
+	   immediate removal.*/
+
+	cancel_delayed_work_sync(&ctx->hs_insert_work);	
+	mutex_lock(&ctx->jack_mlock);
+	pr_info("Enter:%s", __func__);
+    ret = snd_soc_read(codec, ES8316_GPIO_FLAG);
+    if(ctx->hs_reg_v == ret) {
+        ctx->same_reg_cnt++;
+    }
+    else {
+        ctx->same_reg_cnt = 0;
+    }
+    ctx->hs_reg_v = ret;	
+	//if(ctx->hs_remove_retry <= 0){                        //Updated by david, 15-3-4
+	if (ctx->same_reg_cnt == CHT_HS_REMOVE_RETRY_COUNT) /* end of retries; report the status */{
+
+		ctx->same_reg_cnt = 0;
+		/* Initialize jack_type with previous status.
+		   If the event was an invalid one, we return the preious state*/
+		jack_type = jack->status;
+		ret = snd_soc_read(codec, 0x50);
+		if(ret == 0xaa) {
+			gpio_direction_output(368, 1); //1
+		}
+		
+		msleep(100);  
+		if (jack->status) {
+			/* jack is in connected state; look for removal event */
+
+			status = es8316_headset_detect(codec);
+			if (!status) {
+				pr_info("Jack remove event");
+				snd_soc_write(codec, 0x30,0x30);
+				ctx->process_button_events = false;
+				cancel_delayed_work_sync(&ctx->hs_insert_work);
+				cancel_delayed_work_sync(&ctx->hs_button_en_work);
+				cancel_delayed_work_sync(&ctx->hs_button_press_work);
+				cancel_delayed_work_sync(&ctx->hs_button_release_work);
+				//cancel_delayed_work_sync(&ctx->hs_remove_work);
+				cancel_delayed_work_sync(&ctx->hs_debounce_work);
+				//cancel_delayed_work_sync(&ctx->hs_poll_work);
+				jack_type = 0;
+				cht_set_mic_bias(codec, true);
+#ifdef MAINMIC_DMIC_USED 
+				snd_soc_write(codec, 0x22,0x30);   //Disable ADC
+				snd_soc_write(codec, 0x25,0x08);   //record path switch to dmic
+#else
+#ifdef MAINMIC_AMIC_USED
+				snd_soc_write(codec, 0x22,0x30);	//switch record channel to lin2rin2 	 
+#endif
+#endif
+
+			} else if (((jack->status & SND_JACK_HEADSET) == SND_JACK_HEADSET) &&
+					!ctx->process_button_events) {
+				/* Jack is still connected. We may come here if
+				   there was a spurious jack removal event.
+				   No state change is done until removal is confirmed
+				   by the check_jd_status above.i.e. jack status
+				   remains Headset or headphone. But as soon as
+				   the interrupt thread(byt_hs_detection) detected a jack
+				   removal, button processing gets disabled.
+				   Hence re-enable button processing in the case of
+				   headset */
+				pr_info(" spurious Jack remove event for headset \
+						re-enable button events");
+				ctx->process_button_events = true;
+#ifdef MAINMIC_DMIC_USED 
+				snd_soc_write(codec, 0x22,0x20);   //switch record channel to lin2rin2
+				snd_soc_write(codec, 0x25,0x08);   //record path switch to headset mic
+#else
+#ifdef MAINMIC_AMIC_USED
+				snd_soc_write(codec, 0x22,0x20);	//switch record channel to lin1rin1 	 
+#endif
+#endif			
+			}
+		}
+		snd_soc_jack_report(jack, jack_type, gpio->report);
+
+		pr_info("%d Jack type sent is %d\n", __LINE__, jack_type);
+		if(jack_type == 0)
+		{
+			ctx->process_button_events = false;
+			cancel_delayed_work_sync(&ctx->hs_insert_work);
+			cancel_delayed_work_sync(&ctx->hs_button_en_work);
+			cancel_delayed_work_sync(&ctx->hs_button_press_work);
+			cancel_delayed_work_sync(&ctx->hs_button_release_work);
+			//cancel_delayed_work_sync(&ctx->hs_remove_work);
+			cancel_delayed_work_sync(&ctx->hs_debounce_work);
+			//cancel_delayed_work_sync(&ctx->hs_poll_work);
+			jack_type = 0;
+			snd_soc_jack_report(jack, jack_type, gpio->report);
+			cht_set_mic_bias(codec, true);	
+#ifdef MAINMIC_DMIC_USED 
+			snd_soc_write(codec, 0x22,0x30);   //Disable ADC
+			snd_soc_write(codec, 0x25,0x08);   //record path switch to dmic
+#else
+#ifdef MAINMIC_AMIC_USED
+			snd_soc_write(codec, 0x22,0x30);	//switch record channel to lin2rin2 	 
+#endif
+#endif
+			snd_soc_write(codec,0x30,0x30);
+			/*Now, to schedule a debounce work-quenue to cancel the noise at remove moment*/
+			ret = schedule_delayed_work(&ctx->hs_debounce_work,
+					msecs_to_jiffies(ctx->hs_debounce_delay));	
+		} else
+		{
+			snd_soc_jack_report(jack, jack_type, gpio->report);
+		}
+		ret = schedule_delayed_work(&ctx->hs_poll_work,
+					msecs_to_jiffies(500));	
+	}                  
+	else
+	{
+		//ctx->hs_remove_retry--;
+		ret = schedule_delayed_work(&ctx->hs_remove_work,
+				msecs_to_jiffies(ctx->hs_remove_det_delay));
+	}
+	pr_info("Exit:%s", __func__);
+	mutex_unlock(&ctx->jack_mlock);
+}
+static int es8316_query_btn_press(struct snd_soc_codec *codec)
+{
+	
+	int btnstate = -1;
+	u32 value;
+	//bool status;
+	value = snd_soc_read(codec, ES8316_GPIO_FLAG);
+
+		switch (value & 0x6) {
+		case 0x0:
+			btnstate = SND_JACK_BTN_0;
+			break;
+		case 0x2:
+			btnstate = 0;
+			break;
+		default:
+			btnstate = 0;
+			break;
+		}
+	return btnstate;
+}
+/* Check for button press/release */
+static void cht_check_hs_button_press_status(struct work_struct *work)
+{
+
+	struct snd_soc_jack_gpio *gpio = &hs_gpio;
+	struct snd_soc_jack *jack = gpio->jack;
+	struct cht_mc_private *ctx =
+		 container_of(work, struct cht_mc_private,
+		 hs_button_press_work.work);
+	struct snd_soc_codec *codec = ctx->codec;
+	int status = 0, jack_type = 0;
+	int ret;
+	mutex_lock(&ctx->jack_mlock);
+	pr_info("Enter:%s\n", __func__);
+	jack_type = jack->status;
+	
+	status = es8316_headset_detect(codec);
+	if (((jack->status & SND_JACK_HEADSET) == SND_JACK_HEADSET)
+			&& ctx->process_button_events) {
+
+		status = es8316_headset_detect(codec);
+		if (status) { /* confirm jack is connected */
+			status = es8316_query_btn_press(codec);
+			if (status & SND_JACK_BTN_0) {
+				jack_type = SND_JACK_HEADSET | SND_JACK_BTN_0;
+				pr_info("%d Jack type sent is %d\n",
+					 __LINE__, jack_type);
+				snd_soc_jack_report(jack, jack_type, gpio->report);
+				/* Since there is not button_relese interrupt
+				   schedule delayed work to poll for button
+				   release status
+				 */
+				ctx->button_press_chk_count = CHT_HS_BUTTON_PRESS_CHK_COUNT;
+				ret = schedule_delayed_work(&ctx->hs_button_release_work,
+					msecs_to_jiffies(ctx->button_release_delay));
+			} else {
+				if(ctx->button_press_chk_count >0){
+				     ctx->button_press_chk_count--;
+				     ret = schedule_delayed_work(&ctx->hs_button_press_work,
+					       msecs_to_jiffies(ctx->button_press_delay));
+					} else {
+           					ctx->button_press_chk_count  = CHT_HS_BUTTON_PRESS_CHK_COUNT;
+							}
+				}
+		}
+		else
+		{
+			 status = es8316_headset_detect(codec);
+			 if(!status){
+			     ctx->process_button_events = false;
+			     ret = schedule_delayed_work(&ctx->hs_remove_work,
+			 	        msecs_to_jiffies(ctx->hs_remove_det_delay));	
+
+			 	} else {
+          				ctx->button_press_chk_count  = CHT_HS_BUTTON_PRESS_CHK_COUNT;
+				  		ret = schedule_delayed_work(&ctx->hs_button_press_work,
+								msecs_to_jiffies(ctx->button_press_delay));
+         				}
+		}
+	}
+	if(!jack_type){
+			ctx->process_button_events = false;
+			cancel_delayed_work_sync(&ctx->hs_button_en_work);
+			cancel_delayed_work_sync(&ctx->hs_insert_work);	
+			cancel_delayed_work_sync(&ctx->hs_remove_work);	
+			cancel_delayed_work_sync(&ctx->hs_button_release_work); 
+			jack_type = 0;
+			cht_set_mic_bias(codec, true);	
+			#ifdef MAINMIC_DMIC_USED 
+			snd_soc_write(codec, 0x22,0x30);   //Disable ADC
+			snd_soc_write(codec, 0x25,0x08);   //record path switch to dmic
+			#else
+			#ifdef MAINMIC_AMIC_USED
+			snd_soc_write(codec, 0x22,0x30);	//switch record channel to lin2rin2 	 
+			#endif
+			#endif
+			ret = schedule_delayed_work(&ctx->hs_debounce_work,
+				msecs_to_jiffies(ctx->hs_debounce_delay));
+	}
+	pr_info("Exit:%s\n", __func__);
+	ret = snd_soc_read(codec, ES8316_GPIO_FLAG);
+	mutex_unlock(&ctx->jack_mlock);
+}
+
+
+/* Check for button release */
+static void cht_check_hs_button_release_status(struct work_struct *work)
+{
+
+	struct snd_soc_jack_gpio *gpio = &hs_gpio;
+	struct snd_soc_jack *jack = gpio->jack;
+	struct cht_mc_private *ctx = container_of(work, struct cht_mc_private,
+			hs_button_release_work.work);
+	struct snd_soc_codec *codec = ctx->codec;
+	int status = 0, jack_type = 0;
+	int ret;
+	mutex_lock(&ctx->jack_mlock);
+	pr_info("Enter:%s\n", __func__);
+	jack_type = jack->status;
+
+	if (((jack->status & SND_JACK_HEADSET) == SND_JACK_HEADSET)
+			&& ctx->process_button_events) {
+
+		status = es8316_headset_detect(codec);
+		if (status) { /* confirm jack is connected */
+
+			status = es8316_query_btn_press(codec);
+			if (!(status & SND_JACK_BTN_0)) {
+				jack_type = SND_JACK_HEADSET;
+				pr_info("%d Jack type sent is %d\n",
+						__LINE__, jack_type);
+				ctx->button_release_chk_count = CHT_HS_BUTTON_RELEASE_CHK_COUNT;
+				snd_soc_jack_report(jack, jack_type, gpio->report);
+			} else {
+				/* Schedule again */
+				if(ctx->button_release_chk_count > 0){
+					ctx->button_release_chk_count--;
+					ret = schedule_delayed_work(&ctx->hs_button_release_work,
+							msecs_to_jiffies(ctx->button_release_delay));
+				} else {
+					ctx->button_release_chk_count = CHT_HS_BUTTON_RELEASE_CHK_COUNT;
+				}
+			}
+
+		}else {
+			status = es8316_headset_detect(codec);
+			if(!status){
+				ctx->process_button_events = false;
+				ret = schedule_delayed_work(&ctx->hs_remove_work,
+						msecs_to_jiffies(ctx->hs_remove_det_delay));	
+			} else {
+				ctx->button_release_chk_count = CHT_HS_BUTTON_RELEASE_CHK_COUNT;
+				ret = schedule_delayed_work(&ctx->hs_button_release_work,
+						msecs_to_jiffies(ctx->button_release_delay));
+			}
+
+		}
+	}
+	if(!jack_type){
+		ctx->process_button_events = false;
+		cancel_delayed_work_sync(&ctx->hs_button_en_work);
+		cancel_delayed_work_sync(&ctx->hs_debounce_work);	
+		cancel_delayed_work_sync(&ctx->hs_insert_work);	
+		cancel_delayed_work_sync(&ctx->hs_remove_work);	
+		cancel_delayed_work_sync(&ctx->hs_button_press_work); 	
+		jack_type = 0;
+		cht_set_mic_bias(codec, true);	
+#ifdef MAINMIC_DMIC_USED 
+		snd_soc_write(codec, 0x22,0x30);   //Disable ADC
+		snd_soc_write(codec, 0x25,0x08);   //record path switch to dmic
+#else
+#ifdef MAINMIC_AMIC_USED
+		snd_soc_write(codec, 0x22,0x30);	//switch record channel to lin2rin2 	 
+#endif
+#endif
+		ret = schedule_delayed_work(&ctx->hs_debounce_work,
+				msecs_to_jiffies(ctx->hs_debounce_delay));
+	}
+
+	ret = snd_soc_read(codec, ES8316_GPIO_FLAG);
+	pr_info("Exit:%s\n", __func__);
+	mutex_unlock(&ctx->jack_mlock);
+}
+/*
+* added by everest-david
+*Used for remove/button debounce
+*/
+static void cht_hs_debounce_events(struct work_struct *work)
+{
+	 
+ 	int ret;
+	struct cht_mc_private *ctx = container_of(work, struct cht_mc_private,
+			hs_button_release_work.work);
+	struct snd_soc_codec *codec = ctx->codec;
+	pr_info("Enter:%s\n", __func__);
+
+	ret = snd_soc_read(codec, ES8316_GPIO_FLAG); 
+	if((ret & 0x06)==0x06){ //remove
+		ret = snd_soc_read(codec, 0x50); 
+		if(ret == 0xaa) {
+			gpio_direction_output(368, 1); //1 		
+		}
+		printk("byt_hs_debounce_remove\n");	
+	}
+	else {       //inserted
+		gpio_direction_output(368, 0);
+		printk("byt_hs_debounce_insert\n");
+	}	
+	snd_soc_write(codec,0x30,0x10);
+}
+
+static void cht_hs_poll_events(struct work_struct *work)
+{
+	 
+ 	int ret,status;
+	struct snd_soc_jack_gpio *gpio = &hs_gpio;
+	struct snd_soc_jack *jack = gpio->jack;
+	struct cht_mc_private *ctx = container_of(work, struct cht_mc_private,
+			hs_button_release_work.work);
+	struct snd_soc_codec *codec = ctx->codec;
+	//pr_info("Enter:%s\n", __func__);
+	
+	mutex_lock(&ctx->poll_mlock);
+	status = es8316_headset_detect(codec);
+	if(ctx->poll_status == status){
+		ctx->poll_same_cnt++;
+	} else {
+		ctx->poll_same_cnt = 0;
+	}
+	if(!status){
+		//ret = schedule_delayed_work(&ctx->hs_remove_work,
+		//				msecs_to_jiffies(0));
+		if(ctx->poll_same_cnt > 2) {
+			snd_soc_jack_report(jack, status, gpio->report);
+			ctx->poll_same_cnt = 0;
+		} else {
+			if(ctx->poll_cnt < 10){
+				ret = schedule_delayed_work(&ctx->hs_poll_work,
+							msecs_to_jiffies(500));										ctx->poll_cnt++;
+			} else {
+				ctx->poll_cnt = 0;
+			}						
+		}	
+	}else {
+					if(jack->status != status){
+						if(ctx->poll_same_cnt>2) {
+							snd_soc_jack_report(jack, status, gpio->report);
+						}
+						//ret = schedule_delayed_work(&ctx->hs_insert_work,
+						//			msecs_to_jiffies(0));	
+					} 
+					if(ctx->poll_cnt<10){
+						ret = schedule_delayed_work(&ctx->hs_poll_work,
+									msecs_to_jiffies(500));	
+									ctx->poll_cnt++;
+						} else {
+									ctx->poll_cnt = 0;
+								}				
+	}
+	mutex_unlock(&ctx->poll_mlock);
+	//ret = schedule_delayed_work(&ctx->hs_poll_work,
+	//			msecs_to_jiffies(1000));
+	
+}
+
+/* Delayed work for enabling the overcurrent detection circuit
+ * and interrupt for generating button events */
+static void cht_enable_hs_button_events(struct work_struct *work)
+{
+#if 0
+	struct snd_soc_jack_gpio *gpio = &hs_gpio;
+	struct snd_soc_jack *jack = gpio->jack;
+	struct snd_soc_codec *codec = jack->codec;
+	struct cht_mc_private *ctx = container_of(work, struct cht_mc_private,
+			 hs_button_en_work.work);
+
+	int status = aic31xx_query_jack_status(codec);
+	if (status == SND_JACK_HEADSET)
+		ctx->process_button_events = true;
+	else
+		ctx->process_button_events = false;
+	aic31xx_btn_press_intr_enable(codec, ctx->process_button_events);
+#endif
+}
+
+static inline struct snd_soc_codec *cht_get_codec(struct snd_soc_card *card)
+{
+	bool found = false;
+	struct snd_soc_codec *codec;
+
+	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
+		printk(KERN_ERR " codec->name = %s\n", codec->component.name);
+		if (!strstr(codec->component.name, "i2c-ESSX8316:00")) { // "i2c-10ES8316:00")) {
+			pr_debug("codec was %s", codec->component.name);
+			continue;
+		} else {
+			found = true;
+			break;
+		}
+	}
+	if (found == false) {
+		pr_err("%s: cant find codec", __func__);
+		return NULL;
+	}
+	return codec;
+}
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_codec *codec;
+	
+	codec = cht_get_codec(card);
+	if (!codec) {
+		pr_err("Codec not found; Unable to set platform clock\n");
+		return -EIO;
+	}
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		//vlv2_plat_configure_clock(VLV2_PLAT_CLK_AUDIO,
+		//		PLAT_CLK_FORCE_ON);
+clk_prepare_enable(mclk);
+		pr_info("Platform clk turned ON\n");
+	} else {
+		/* Set codec clock source to internal clock before
+		 * turning off the platform clock. Codec needs clock
+		 * for Jack detection and button press
+		 */
+		//vlv2_plat_configure_clock(VLV2_PLAT_CLK_AUDIO,
+		//		PLAT_CLK_FORCE_ON);
+		clk_disable_unprepare(mclk);
+		pr_info("Platform clk turned OFF\n");
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic", NULL),
+	SND_SOC_DAPM_MIC("D-MIC", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control, SND_SOC_DAPM_PRE_PMU|
+			SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route cht_audio_map[] = {
+#if 0
+		{"Headphone", NULL, "HPL"},
+		{"Headphone", NULL, "HPR"},
+		{"Ext Spk", NULL, "SPKOUTL"},
+		{"Ext Spk", NULL, "SPKOUTR"},
+		/* AMIC */
+	/*
+		Don't use RVP resource
+		for HP detection issue on RVP
+	*/
+		{"Headset AMIC", NULL, "MIC Bias"},
+		{"MONOINP", NULL, "Headset AMIC"},
+		{"MONOINN", NULL, "Headset AMIC"},
+
+		{"AMIC", NULL, "MIC Bias"},
+		{"MIC", NULL, "AMIC"},
+#else
+		{"Ext Spk", NULL, "SPKOL"},
+		{"Ext Spk", NULL, "SPKOR"},
+		
+		{"D-MIC", NULL, "micbias"},
+		{"Headset Mic", NULL, "micbias"},
+		{"Internal Mic", NULL, "micbias"},	
+		/* Headset Mic: Headset Mic with bias */
+		{"MIC1", NULL, "Headset Mic"},
+		{"MIC2", NULL, "Internal Mic"},
+		{"DMIC", NULL, "D-MIC"},
+		
+		/* Headset Stereophone(Headphone): HSOL, HSOR */
+		{"Headphone", NULL, "HPOL"},
+		{"Headphone", NULL, "HPOR"},
+		
+		{"Headphone", NULL, "Platform Clock"},
+		{"Headset Mic", NULL, "Platform Clock"},
+		{"D-MIC", NULL, "Platform Clock"},
+		{"Internal Mic", NULL, "Platform Clock"},
+		{"Ext Spk", NULL, "Platform Clock"},
+#endif
+		{"Playback", NULL, "ssp1 Tx"},
+		{"ssp1 Tx", NULL, "codec_out0"},
+		{"ssp1 Tx", NULL, "codec_out1"},
+		{"codec_in0", NULL, "ssp1 Rx"},
+		{"codec_in1", NULL, "ssp1 Rx"},
+		{"ssp1 Rx", NULL, "Capture"},
+		{"ssp0 Tx", NULL, "modem_out"},
+		{"Playback", NULL, "Platform Clock"},
+		{"Capture", NULL, "Platform Clock"},
+};
+
+static const struct snd_kcontrol_new cht_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Internal Mic"),
+	SOC_DAPM_PIN_SWITCH("D-MIC"),
+	SOC_DAPM_PIN_SWITCH("Ext Spk"),
+};
+
+
+static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	unsigned int fmt;
+	int ret;
+
+	pr_debug("Enter:%s", __func__);
+
+	//add for voip call no sound by zm 1211
+	if (strncmp(codec_dai->name, "ES8316 HiFi", 11))
+                return 0;
+
+	/* I2S Slave Mode*/
+	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		pr_err("can't set codec DAI configuration %d\n", ret);
+		return ret;
+	}
+
+#if 0
+	ret = snd_soc_dai_set_pll(codec_dai, 0, ES8316_PLL_SRC_FRM_MCLK,
+				CHT_PLAT_CLK_3_HZ, params_rate(params) * 256);
+	if (ret < 0) {
+		pr_err("can't set codec pll***********: %d\n", ret);
+		return ret;
+	}
+
+
+	if (codec_dai->driver && codec_dai->driver->ops->hw_params)
+		codec_dai->driver->ops->hw_params(substream, params, codec_dai);
+
+	snd_soc_dai_set_sysclk(codec_dai, ES8316_CLKID_PLLO, CHT_PLAT_CLK_3_HZ, 0);
+#endif
+#if 0
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
+			params_rate(params) * 512, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		pr_err("can't set codec sysclk: %d\n", ret);
+		return ret;
+	}
+#endif
+
+	snd_soc_dai_set_sysclk(codec_dai, ES8316_CLKID_PLLO, CHT_PLAT_CLK_3_HZ, 0);
+
+	return 0;
+}
+
+static int cht_compr_set_params(struct snd_compr_stream *cstream)
+{
+	return 0;
+}
+
+static const struct snd_soc_pcm_stream cht_dai_params = {
+	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+};
+
+static struct snd_soc_compr_ops cht_compr_ops = {
+	.set_params = cht_compr_set_params,
+};
+
+static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	pr_debug("Invoked %s for dailink %s\n", __func__, rtd->dai_link->name);
+
+	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 4;//2
+	/* set SSP2 to 24-bit */
+	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
+				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
+				    SNDRV_PCM_FORMAT_S24_LE);
+	return 0;
+}
+
+static int cht_set_bias_level(struct snd_soc_card *card,
+				struct snd_soc_dapm_context *dapm,
+				enum snd_soc_bias_level level)
+{
+	int ret = 0;
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+	case SND_SOC_BIAS_PREPARE:
+	case SND_SOC_BIAS_STANDBY:
+	case SND_SOC_BIAS_OFF:
+		card->dapm.bias_level = level;
+		pr_debug("card(%s)->bias_level %u\n", card->name,
+				card->dapm.bias_level);
+		break;
+	default:
+		pr_err("%s: Invalid bias level=%d\n", __func__, level);
+		ret =  -EINVAL;
+	}
+
+	return ret;
+}
+
+static int cht_audio_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+ 	int ReadBuffer,ReadBuffer1,ReadBuffer2;
+	struct snd_soc_codec *codec;
+	struct snd_soc_card *card = runtime->card;
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
+	struct gpio_desc *desc;
+	pr_debug("Enter:%s", __func__);
+
+	codec = cht_get_codec(card);
+	if (!codec) {
+		pr_err("Codec not found: %s:failed\n", __func__);
+		return -EIO;
+	}
+	ctx->codec = codec;
+	desc = devm_gpiod_get_index(codec->dev, NULL, 1, 0);
+	if (!IS_ERR(desc)) {
+		hs_gpio.gpio = 307;//desc_to_gpio(desc);
+		devm_gpiod_put(codec->dev, desc);
+		pr_info("cht-cr GPIOs - JD/BP-int: %d\n", hs_gpio.gpio);
+	} else {
+		hs_gpio.gpio = 307;
+		pr_err("Failed to get gpio desc for Jack det\n");
+	}
+	pr_err("hs codec gpio %d\n", hs_gpio.gpio);
+
+	/* Set codec bias level */
+	cht_set_bias_level(card, &card->dapm, SND_SOC_BIAS_OFF);
+	card->dapm.idle_bias_off = true;
+
+	/* Headset jack detection */
+	ret = snd_soc_card_jack_new(card, "Headset Jack",
+			SND_JACK_HEADSET | SND_JACK_HEADPHONE | SND_JACK_BTN_0,
+			 &ctx->jack, NULL, 0);
+	if (ret) {
+		pr_err("Jack creation failed\n");
+// todo		return ret;
+	}
+	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_0, KEY_MEDIA);
+
+	ret = snd_soc_jack_add_gpios(&ctx->jack, 1, &hs_gpio);
+	if (ret) {
+		pr_err("Adding jack GPIO failed with error %d\n", ret);
+//todo		return ret;
+	}
+
+
+	ret = snd_soc_add_card_controls(card, cht_mc_controls,
+					ARRAY_SIZE(cht_mc_controls));
+	if (ret) {
+		pr_err("unable to add card controls\n");
+		return ret;
+	}
+
+	ret = snd_soc_dapm_sync(&card->dapm);
+	if (ret) {
+		pr_err("unable to sync dapm\n");
+		return ret;
+	}
+
+	ReadBuffer = snd_soc_read(codec, ES8316_GPIO_DEBUNCE_INT_REG4E);
+       // printk("===probe ReadBuffer: 0x%x\n",ReadBuffer);
+        ReadBuffer1=ReadBuffer | 0xFE;
+        ReadBuffer2=ReadBuffer1 & 0x01;
+         if (ReadBuffer2 & 0x01)
+        {
+               // printk("===11111111 ReadBuffer2: 0x%x\n",ReadBuffer2);
+                snd_soc_write(codec, 0X4E, 0xF2);
+        }
+         else
+        {
+                //printk("===22222222 ReadBuffer2: 0x%x\n",ReadBuffer2);
+                snd_soc_write(codec, 0X4E, 0xF3);
+        }
+         mdelay(10);
+        snd_soc_write(codec, 0X4E, 0xF3);
+        ret = snd_soc_read(codec, 0x4F);
+        //printk("===read 0x4F reg: 0x%x\n", ret);
+
+
+	return ret;
+}
+
+static unsigned int rates_8000_16000[] = {
+	8000,
+	16000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_8000_16000 = {
+	.count = ARRAY_SIZE(rates_8000_16000),
+	.list  = rates_8000_16000,
+};
+
+static unsigned int rates_48000[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_48000 = {
+	.count = ARRAY_SIZE(rates_48000),
+	.list  = rates_48000,
+};
+
+static int cht_aif1_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_48000);
+}
+
+static struct snd_soc_ops cht_aif1_ops = {
+	.startup = cht_aif1_startup,
+};
+
+static int cht_8k_16k_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_8000_16000);
+}
+
+static struct snd_soc_ops cht_be_ssp2_ops = {
+	.hw_params = cht_aif1_hw_params,
+};
+
+
+static struct snd_soc_dai_link cht_dailink[] = {
+	[MERR_DPCM_AUDIO] = {
+		.name = "Audio Port",
+		.stream_name = "Audio",
+		.cpu_dai_name = "media-cpu-dai",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "sst-mfld-platform",
+		.nonatomic = true,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &cht_aif1_ops,
+		.init = cht_audio_init,
+		.ignore_suspend = 1,
+	},
+	[MERR_DPCM_DEEP_BUFFER] = {
+		.name = "Deep-Buffer Audio Port",
+		.stream_name = "Deep-Buffer Audio",
+		.cpu_dai_name = "deepbuffer-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.nonatomic = true,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &cht_aif1_ops,
+		.ignore_suspend = 1,
+	},
+	[MERR_DPCM_COMPR] = {
+		.name = "Compressed Port",
+		.stream_name = "Compress",
+		.cpu_dai_name = "compress-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.ignore_suspend = 1,
+		.compr_ops = &cht_compr_ops,
+	},
+	/* Back ends */
+	{
+		.name = "SSP2-Codec",
+		.id = 1,
+		.cpu_dai_name = "ssp1-port",
+		.platform_name = "sst-mfld-platform",
+		.no_pcm = 1,
+		.codec_dai_name = "ES8316 HiFi",
+		.codec_name = "i2c-ESSX8316:00",
+		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
+					| SND_SOC_DAIFMT_CBS_CFS,
+		.be_hw_params_fixup = cht_codec_fixup,
+		.nonatomic = true,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		.ops = &cht_be_ssp2_ops,
+	},
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int snd_cht_prepare(struct device *dev)
+{
+	pr_debug("In %s device name\n", __func__);
+	return snd_soc_suspend(dev);
+}
+
+static void snd_cht_complete(struct device *dev)
+{
+	pr_debug("In %s\n", __func__);
+	snd_soc_resume(dev);
+}
+
+static int snd_cht_poweroff(struct device *dev)
+{
+	pr_debug("In %s\n", __func__);
+	return snd_soc_poweroff(dev);
+}
+#else
+#define snd_cht_prepare NULL
+#define snd_cht_complete NULL
+#define snd_cht_poweroff NULL
+#endif
+
+/* SoC card */
+static struct snd_soc_card snd_soc_card_cht = {
+	.name = "cherrytrailaud",
+	.dai_link = cht_dailink,
+	.num_links = ARRAY_SIZE(cht_dailink),
+	.set_bias_level = cht_set_bias_level,
+	.dapm_widgets = cht_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(cht_dapm_widgets),
+	.dapm_routes = cht_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(cht_audio_map),
+	.controls = cht_mc_controls,
+	.num_controls = ARRAY_SIZE(cht_mc_controls),
+};
+
+static int snd_cht_mc_probe(struct platform_device *pdev)
+{
+	int ret_val = 0;
+	struct cht_mc_private *drv;
+
+	pr_debug("Entry %s\n", __func__);
+
+	/* Audio Platform clock is on by default. The machine driver requests
+	 * this clock to be turned ON and OFF on playing any stream. But
+	 * until any stream is played the clock remains ON. Hence request the
+	 * clock to be turned OFF initially.
+	*/
+	//vlv2_plat_configure_clock(VLV2_PLAT_CLK_AUDIO, PLAT_CLK_FORCE_ON);
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
+	if (!drv) {
+		pr_err("allocation failed\n");
+		return -ENOMEM;
+	}
+	//ret_val = gpio_request(341, "I2S_RESET_GPIO");
+	if (ret_val)
+	{
+		pr_debug("request gpio fail\n");
+	}
+
+	drv->intr_debounce = CHT_INTR_DEBOUNCE;
+	drv->hs_insert_det_delay = CHT_HS_INSERT_DET_DELAY;
+	drv->hs_remove_det_delay = CHT_HS_REMOVE_DET_DELAY;
+	drv->button_press_delay = CHT_BUTTON_PRESS_DELAY;
+	drv->button_release_delay = CHT_BUTTON_RELEASE_DELAY;
+	drv->hs_det_poll_intrvl = CHT_HS_DET_POLL_INTRVL;
+	drv->hs_det_retry = CHT_HS_DET_RETRY_COUNT;
+	drv->button_press_chk_count = CHT_HS_BUTTON_PRESS_CHK_COUNT;
+	drv->button_release_chk_count = CHT_HS_BUTTON_RELEASE_CHK_COUNT;
+	drv->button_en_delay = CHT_BUTTON_EN_DELAY;
+	drv->hs_debounce_delay = CHT_HS_DEBOUNCE_DELAY;     /*added by everest-david*/
+	drv->hs_debounce_retry = CHT_HS_DEBOUNCE_RETRY_COUNT;  /*added by everest-david*/
+	drv->process_button_events = false;
+	drv->poll_cnt = 0;
+	drv->poll_status = 0;
+	drv->poll_same_cnt = 0;
+	INIT_DELAYED_WORK(&drv->hs_insert_work, cht_check_hs_insert_status);
+	INIT_DELAYED_WORK(&drv->hs_remove_work, cht_check_hs_remove_status);
+	INIT_DELAYED_WORK(&drv->hs_button_press_work,
+			 cht_check_hs_button_press_status);
+	INIT_DELAYED_WORK(&drv->hs_button_release_work,
+			 cht_check_hs_button_release_status);
+	INIT_DELAYED_WORK(&drv->hs_button_en_work, cht_enable_hs_button_events);
+	INIT_DELAYED_WORK(&drv->hs_debounce_work, cht_hs_debounce_events);   /*added by everest-david*/
+	INIT_DELAYED_WORK(&drv->hs_poll_work, cht_hs_poll_events);   /*added by everest-david for hampoo, 16-3-3*/	
+	mutex_init(&drv->jack_mlock);
+	mutex_init(&drv->poll_mlock);
+	/* register the soc card */
+	snd_soc_card_cht.dev = &pdev->dev;
+	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
+	ret_val = snd_soc_register_card(&snd_soc_card_cht);
+	if (ret_val) {
+		pr_err("snd_soc_register_card failed %d\n", ret_val);
+		return ret_val;
+	}
+	platform_set_drvdata(pdev, &snd_soc_card_cht);
+	pr_info("%s successful\n", __func__);
+	mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	return ret_val;
+}
+
+static void snd_cht_unregister_jack(struct cht_mc_private *ctx)
+{
+	/* Set process button events to false so that the button
+	   delayed work will not be scheduled.*/
+	ctx->process_button_events = false;
+	cancel_delayed_work_sync(&ctx->hs_insert_work);
+	cancel_delayed_work_sync(&ctx->hs_button_en_work);
+	cancel_delayed_work_sync(&ctx->hs_button_press_work);
+	cancel_delayed_work_sync(&ctx->hs_button_release_work);
+	cancel_delayed_work_sync(&ctx->hs_remove_work);
+	cancel_delayed_work_sync(&ctx->hs_debounce_work);
+	cancel_delayed_work_sync(&ctx->hs_poll_work);
+	snd_soc_jack_free_gpios(&ctx->jack, 1, &hs_gpio);
+}
+
+static int snd_cht_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
+	struct cht_mc_private *drv = snd_soc_card_get_drvdata(soc_card);
+
+	pr_debug("In %s\n", __func__);
+	snd_cht_unregister_jack(drv);
+	snd_soc_card_set_drvdata(soc_card, NULL);
+	snd_soc_unregister_card(soc_card);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static void snd_cht_mc_shutdown(struct platform_device *pdev)
+{
+	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
+	struct cht_mc_private *drv = snd_soc_card_get_drvdata(soc_card);
+    	struct snd_soc_codec *codec = drv->codec;
+	snd_soc_write(codec, ES8316_CPHP_OUTEN_REG17, 0x00);
+
+	pr_debug("In %s\n", __func__);
+	snd_cht_unregister_jack(drv);
+}
+
+const struct dev_pm_ops snd_cht_cr_mc_pm_ops = {
+	.prepare = snd_cht_prepare,
+	.complete = snd_cht_complete,
+	.poweroff = snd_cht_poweroff,
+};
+
+static struct platform_driver snd_cht_mc_driver = {
+	.driver = {
+		.name = "cht-es8316",
+		.pm = &snd_cht_cr_mc_pm_ops,
+	},
+	.probe = snd_cht_mc_probe,
+	.remove = snd_cht_mc_remove,
+	.shutdown = snd_cht_mc_shutdown,
+};
+
+static int __init snd_cht_driver_init(void)
+{
+	int ret;
+	ret = platform_driver_register(&snd_cht_mc_driver);
+	if (ret)
+		pr_err("Fail to register Cherrytrail Machine driver cht_es8316\n");
+	else
+		pr_info("Cherrytrail Machine Driver cht_es8316 registerd\n");
+	return ret;
+}
+late_initcall(snd_cht_driver_init);
+
+static void __exit snd_cht_driver_exit(void)
+{
+	pr_debug("In %s\n", __func__);
+	platform_driver_unregister(&snd_cht_mc_driver);
+}
+module_exit(snd_cht_driver_exit);
+
+MODULE_DESCRIPTION("ASoC Intel(R) Cherrytrail CR Machine driver");
+MODULE_AUTHOR("Praveen Diwakar <praveen.diwakar@intel.com>");
+MODULE_AUTHOR("Bhakte, GurudattaX <gurudattax.bhakte@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:cht_es8316");
-- 
2.9.3


--===============2348371153226950344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2348371153226950344==--
