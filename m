From: "Reddy, MR Swami" <MR.Swami.Reddy@nsc.com>
Subject: [PATCH] ASoC: Add National Semiconductor LM49352 Codec
	Support
Date: Wed, 16 Mar 2011 00:38:57 -0700
Message-ID: <290463D19D2E064191F1F96ECA480A89432CDF2B49@EXMAIL02.scwf.nsc.com>
References: <290463D19D2E064191F1F96ECA480A89432CB6D84E@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sc-mailgw03.nsc.com (mail6.nsc.com [12.24.21.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ADFB1038DE
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 08:39:30 +0100 (CET)
Received: from SCNTRDCSS7.nsc.com (scntrdcss7.nsc.com [10.188.130.178])
	by sc-mailgw03.nsc.com (Tumbleweed MailGate 3.7.1) with ESMTP id
	27932AEC0E4
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 00:39:25 -0700 (PDT)
In-Reply-To: <290463D19D2E064191F1F96ECA480A89432CB6D84E@EXMAIL02.scwf.nsc.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: M R Swami Reddy <MR.Swami.Reddy@nsc.com>

Patch for adding National Semiconductor LM49352 codec support.

Signed-off-by: M R Swami Reddy <MR.Swami.Reddy@nsc.com>
---
Tested this patch on SMDK6410 platform with Kernel- 2.6.24 and ALSA version is - 1.0.15.

Please review and let me know the comments/suggestion on this patch.
And also let me know the forward-porting (to the latest ALSA version APIs) steps/process. Thanks in advance.

diff -upNr -X linux-2.6.24-lm49352/Documentation/dontdiff linux-2.6.24/sound/soc/codecs/Kconfig linux-2.6.24-lm49352/sound/soc/codecs/Kconfig
--- linux-2.6.24/sound/soc/codecs/Kconfig       2011-03-14 14:36:03.000000000 +0530
+++ linux-2.6.24-lm49352/sound/soc/codecs/Kconfig       2010-03-27 11:33:10.000000000 +0530
@@ -2,6 +2,10 @@ config SND_SOC_AC97_CODEC
        tristate
        depends on SND_SOC

+config SND_SOC_LM49352
+       tristate
+       depends on SND_SOC
+
 config SND_SOC_WM8731
        tristate
        depends on SND_SOC
diff -upNr -X linux-2.6.24-lm49352/Documentation/dontdiff linux-2.6.24/sound/soc/codecs/lm49352.c linux-2.6.24-lm49352/sound/soc/codecs/lm49352.c
--- linux-2.6.24/sound/soc/codecs/lm49352.c     1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.24-lm49352/sound/soc/codecs/lm49352.c     2011-03-14 13:03:00.000000000 +0530
@@ -0,0 +1,834 @@
+/*
+ * Copyright (c) <2011> National Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation.
+*/
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+#include <sound/initval.h>
+#include <asm/div64.h>
+
+#include "lm49352.h"
+
+#define AUDIO_NAME "lm49352"
+#define LM49352_VERSION "0.1"
+int lm49352_write1(struct snd_soc_codec *codec, unsigned int reg,
+                                               unsigned int value);
+/*******
+ * Debug
+ *******/
+
+static int attach_once;
+
+#ifdef LM49352_DEBUG
+#define dbg(format, arg...) \
+       printk(KERN_DEBUG AUDIO_NAME ": " format , ## arg)
+#else
+#define dbg(format, arg...) do {} while (0)
+#endif
+#define err(format, arg...) \
+       printk(KERN_ERR AUDIO_NAME ": " format , ## arg)
+#define info(format, arg...) \
+       printk(KERN_INFO AUDIO_NAME ": " format , ## arg)
+#define warn(format, arg...) \
+       printk(KERN_WARNING AUDIO_NAME ": " format , ## arg)
+
+/* Register cache for LM49352 driver. */
+static const u16 lm49352_reg[] = {
+       0x0121, 0x017e, 0x007d, 0x0014, /*R3*/
+       0x0121, 0x017e, 0x007d, 0x0194, /*R7*/
+       0x001c, 0x0002, 0x0002, 0x00c2, /*R11*/
+       0x0182, 0x0082, 0x000a, 0x0024, /*R15*/
+       0x0009, 0x0000, 0x00ff, 0x0000, /*R19*/
+       0x00ff, 0x00ff, 0x00ff, 0x00ff, /*R23*/
+       0x00ff, 0x00ff, 0x00ff, 0x00ff, /*R27*/
+       0x01f0, 0x0040, 0x0000, 0x0000, /*R31(0x1F)*/
+       0x0000, 0x0000, 0x0031, 0x000b, /*R35*/
+       0x0039, 0x0000, 0x0010, 0x0032, /*R39*/
+       0x0054, 0x0076, 0x0098, 0x0000, /*R43(0x2B)*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R47*/
+       0x0000, 0x0000, 0x005e, 0x003e, /*R51(0x33)*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R55*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R59*/
+       0x0000, 0x0000, 0x0000, 0x0000,  /*R63*/
+       0x0000, 0x0000, 0x0000, 0x0000,  /*R67*/
+       0x0000, 0x0000, 0x0000, 0x0000,  /*R71*/
+       0x0000, 0x0000, 0x0000, 0x0000,  /*R75*/
+       0x0000, 0x0000, 0x0000, 0x0000,  /*R79*/
+       0x0000, 0x0000, 0x0000, 0x0000,  /*R83*/
+       0x0000, 0x0000, 0x0000, 0x0000,  /*R87*/
+       0x0000, 0x0000, 0x0000, 0x0000,  /*R91*/
+       0x0000, 0x0000, 0x0000, 0x0000,  /*R95*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R99*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R103*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R107*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R111*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R115*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R119*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R123*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R127*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R131*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R135*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R139*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R143*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R147*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R151*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R155*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R159*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R163*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R167*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R171*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R175*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R179*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R183*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R187*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R191*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R193*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R197*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R201*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R205*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R209*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R213*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R217*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R221*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R225*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R229*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R233*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R237*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R241*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R245*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R249*/
+       0x0000, 0x0000, 0x0000, 0x0000, /*R253*/
+       0x0000, 0x0000,  /*R255*/
+};
+
+/***************************************************************************
+ * Name:
+ *    lm49352_read_reg_cache- Reads specific register from reg cache.
+ *
+ * Synopsis:
+ *     static inline unsigned int
+ *     lm49352_read_reg_cache(struct snd_soc_codec *codec,unsigned int reg)
+ *
+ * Arguments:
+ *    codec- Pointer to the struct snd_soc_codec
+ *    reg- Specific register address
+ *
+ * Decription:
+ *     In this function a specific register value is read from reg cache
+ *     and value is returned to the called function.
+ **************************************************************************/
+
+static inline unsigned int
+lm49352_read_reg_cache(struct snd_soc_codec *codec, unsigned int reg)
+{
+       dbg("in lm49352_read_reg_cache \n");
+       u16 *cache = codec->reg_cache;
+       BUG_ON(reg > ARRAY_SIZE(lm49352_reg));
+       dbg("in lm49352_read_reg_cache %x\n", cache[reg]);
+       return cache[reg];
+}
+/**************************************************************************
+ * Name
+ *     lm49352_write_reg_cache- Writes specific register value to reg
+ *                              cache.
+ * Synopsis
+ *     static inline void lm49352_write_reg_cache(struct
+ *             snd_soc_codec *codec,unsigned int reg, unsigned int value)
+ * Arguments
+ *     codec- Pointer to the struct snd_soc_codec
+ *      reg- Specific register address
+ *      value- The value that to be written to reg cache
+ * Decription
+ *     This function is called when a specific register is to be written
+ *     with the given value. This function writes the value to reg cache.
+ *************************************************************************/
+
+static inline void lm49352_write_reg_cache(struct snd_soc_codec *codec,
+                                          unsigned int reg,
+                                          unsigned int value)
+{
+       u16 *cache = codec->reg_cache;
+       dbg("in lm49352_write_reg_cache \n");
+       dbg("value to be written is %x\n", value);
+       cache[reg] = value;
+}
+
+/**************************************************************************
+ * Name
+ *     lm49352_write- Writes specific value to register and also to reg
+ *     cache.
+ * Synopsis
+ *     static int lm49352_write(struct snd_soc_codec *codec,
+ *                              unsigned int reg,unsigned int value)
+ * Arguments
+ *     codec- Pointer to the struct snd_soc_codec
+ *      reg- Specific register address
+ *      value- The value that to be written to cache and also to given
+ *     register
+ * Decription
+ *     This function is called when a specific register is to be written
+ *     with the given value. This function writes the value to the given
+ *     register and also to reg cache.
+ *************************************************************************/
+
+static int lm49352_write(struct snd_soc_codec *codec, unsigned int reg,
+                        unsigned int value)
+{
+       u8 data[2];
+       int wrreg;
+       int wrvalue, tmp;
+       wrreg = reg;
+       wrvalue = value;
+       dbg("wrvalue  %x\n", wrvalue);
+
+       /* For mute operation. */
+       if (wrreg == DAC_MUTE) {
+               /* Value read from register.*/
+               tmp = i2c_smbus_read_byte_data(codec->control_data, wrreg);
+
+               if (wrvalue) {
+                       dbg("wrvalue  %x\n", wrvalue);
+                       tmp |= LM49352_MUTE;
+               } else {
+                       dbg("wrvalue  %x\n", wrvalue);
+                       tmp &= ~LM49352_MUTE;
+               }
+               wrvalue = tmp;
+       }
+
+       /* New value written to LM49352 register.*/
+       i2c_smbus_write_byte_data(codec->control_data, wrreg, wrvalue);
+       dbg("%s,%d : reg : 0x%x, value : 0x%x\n", __FUNCTION__, __LINE__,
+                                                 reg, value);
+       dbg("reg=%x value=%x \n", reg, value);
+       BUG_ON(reg > ARRAY_SIZE(lm49352_reg));
+
+       value &= 0x1ff;
+       dbg("reg value is %x\n", value);
+
+       if (value == lm49352_read_reg_cache(codec, reg))
+               return 0;
+
+       data[0] = (reg << 1) | ((value >> 8) & 0x0001);
+       data[1] = value & 0x00ff;
+       dbg("data[0]=%x data[1]=%x \n", data[0], data[1]);
+       lm49352_write_reg_cache(codec, reg, value);
+
+       if (codec->hw_write(codec->control_data, data, 2) == 2) {
+               dbg("i2c write successful\n");
+               return 0;
+       } else {
+               dbg("i2c write failed\n");
+               return -EIO;
+       }
+
+
+}
+/**************************************************************************
+ * Name
+ *     lm49352_read- Reads specific register value from reg cache.
+ * Synopsis
+ *     static inline unsigned int lm49352_read(struct snd_soc_codec *codec,
+ * Arguments
+ *     codec- Pointer to the struct snd_soc_codec
+ *      reg- Specific register address
+ * Decription
+ *     This function is called when a specific register value is to be
+ *     read from reg cache.
+ *************************************************************************/
+
+static inline unsigned int lm49352_read(struct snd_soc_codec *codec,
+                                       unsigned int reg)
+{
+       return lm49352_read_reg_cache(codec, reg);
+}
+
+static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
+
+/**************************************************************************
+ * Name
+ *     lm49352_out_vu- Sets the value of a single mixer control.
+ * Synopsis
+ *     static int lm49352_out_vu(struct snd_kcontrol *kcontrol,
+ * Arguments
+ *     kcontrol- Pointer to the struct snd_kcontrol
+ *      ucontrol- Pointer to struct snd_ctl_elem_value
+ * Decription
+ *     This function is called when a single mixer control value is
+ *     to be set.
+ *************************************************************************/
+
+static int lm49352_out_vu(struct snd_kcontrol *kcontrol,
+                         struct snd_ctl_elem_value *ucontrol)
+{
+       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       int reg = kcontrol->private_value & 0xff;
+       int ret;
+       u16 val;
+
+       /* Resetting the reg cache value. */
+       lm49352_write_reg_cache(codec, reg, 0);
+
+       /* Callback to set the value of a single mixer control. */
+       ret = snd_soc_put_volsw(kcontrol, ucontrol);
+
+       if (ret < 0)
+               return ret;
+
+       /* Reading the written new value. */
+       val = lm49352_read_reg_cache(codec, reg);
+       /* Oring the value with 0x100 and writing back to reg cavhe. */
+       return lm49352_write(codec, reg, val | 0x0100);
+}
+
+/* Macro for defining and adding single mixer controls. */
+#define SOC_LM49352_OUT_SINGLE_R_TLV(xname, reg, shift, max, invert, tlv_array)\
+{      .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+       .access = SNDRV_CTL_ELEM_ACCESS_TLV_READ \
+                 | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+       .tlv.p = (tlv_array), \
+       .info = snd_soc_info_volsw, \
+       .get = snd_soc_get_volsw, .put = lm49352_out_vu, \
+       .private_value = SOC_SINGLE_VALUE(reg, shift, max, invert) }
+
+static const struct snd_kcontrol_new lm49352_snd_controls[] =
+{      /* Various controls of LM49352 Driver */
+       SOC_LM49352_OUT_SINGLE_R_TLV("Left DAC1 Playback Volume",
+               LM49352_DIGITAL_ATTENUATION_DACL1, 0, 0x3f, 0, dac_tlv),
+       SOC_LM49352_OUT_SINGLE_R_TLV("Right DAC1 Playback Volume",
+               LM49352_DIGITAL_ATTENUATION_DACR1, 0, 0x3f, 0, dac_tlv),
+       SOC_LM49352_OUT_SINGLE_R_TLV("Headphone Playback Volume",
+               ANALOG_MIXER_OUTPUT_OPTIONS, 1, 7, 1, dac_tlv),
+       SOC_LM49352_OUT_SINGLE_R_TLV("Aux Playback Volume",
+               ANALOG_MIXER_OUTPUT_OPTIONS, 4, 1, 0, dac_tlv),
+       SOC_LM49352_OUT_SINGLE_R_TLV("PC Speaker Playback Volume",
+               ANALOG_MIXER_OUTPUT_OPTIONS, 6, 3, 0, dac_tlv),
+       SOC_SINGLE("DAC1 Deemphasis Switch", LM49352_DAC_CONTROL3, 2, 1, 0),
+       SOC_SINGLE("DAC1 Left Invert Switch", LM49352_DAC_CONTROL4, 0, 1, 0),
+       SOC_SINGLE("DAC1 Right Invert Switch", LM49352_DAC_CONTROL4, 1, 1, 0),
+       SOC_SINGLE("DAC ZC Switch", DAC_BASIC, 5, 1, 0),
+       SOC_SINGLE("DAC Mute Switch", DAC_MUTE, 2, 1, 0),
+       SOC_SINGLE("ADCL Mute Switch", LM49352_ADC_CONTROL1, 2, 1, 0),
+       SOC_SINGLE("ADCR Mute Switch", LM49352_ADC_CONTROL1, 3, 1, 0),
+};
+
+/**************************************************************************
+ * Name
+ *     lm49352_add_controls- Adds the controls which are defined in
+ *     lm49352_snd_controls struct.
+ * Synopsis
+ *     static int lm49352_add_controls(struct snd_soc_codec *codec)
+ * Arguments
+ *     codec- Pointer to the struct snd_soc_codec
+ * Decription
+ *     This function is called when setting mixer controls and it adds
+ *     the controls defined in lm49352_snd_controls.
+ *************************************************************************/
+
+static int lm49352_add_controls(struct snd_soc_codec *codec)
+{
+       int err, i;
+
+       for (i = 0; i < ARRAY_SIZE(lm49352_snd_controls); i++) {
+               /* Adding the declared controls.*/
+               err = snd_ctl_add(codec->card,
+                                 snd_soc_cnew(&lm49352_snd_controls[i],
+                                              codec, NULL));
+               if (err < 0)
+                       return err;
+       }
+       return 0;
+}
+
+/**************************************************************************
+ * Name
+ *     lm49352_hw_params- Reads specific control information
+ * Synopsis
+ *     static int lm49352_hw_params(struct snd_pcm_substream *substream,
+ *                                  struct snd_pcm_hw_params *params)
+ * Arguments
+ *     substream- Pointer to the struct snd_pcm_substream
+ *      params- Pointer to struct snd_pcm_hw_params
+ * Decription
+ *     This function is called while playback or record is done and it
+ *     sets the DAC and ADC's clock divider value based on
+ *     substreams sample rates and also gives information about bit size.
+ *************************************************************************/
+
+static int lm49352_hw_params(struct snd_pcm_substream *substream,
+                            struct snd_pcm_hw_params *params)
+{
+       struct snd_soc_pcm_runtime *rtd = substream->private_data;
+       struct snd_soc_dai_link *dai = rtd->dai;
+       struct snd_soc_device *socdev = rtd->socdev;
+       struct snd_soc_codec *codec = socdev->codec;
+       dbg("\n in lm49352_hw_params \n");
+
+
+       /* Setting the DAC and ADC clock dividers based on substream
+          sample rate. */
+       switch (params_rate(params)) {
+       case 8000:
+               lm49352_write1(codec, DAC_CLOCK, 0x17);
+               lm49352_write1(codec, ADC_CLOCK, 0x17);
+               break;
+       case 11025:
+               lm49352_write1(codec, DAC_CLOCK, 0x10);
+               lm49352_write1(codec, ADC_CLOCK, 0x10);
+               break;
+       case 16000:
+               lm49352_write1(codec, DAC_CLOCK, 0x0b);
+               lm49352_write1(codec, ADC_CLOCK, 0x0b);
+               break;
+       case 22050:
+               lm49352_write1(codec, DAC_CLOCK, 0x08);
+               lm49352_write1(codec, ADC_CLOCK, 0x08);
+               break;
+       case 32000:
+               lm49352_write1(codec, DAC_CLOCK, 0x05);
+               lm49352_write1(codec, ADC_CLOCK, 0x05);
+               break;
+       case 44100:
+               lm49352_write1(codec, DAC_CLOCK, 0x03);
+               lm49352_write1(codec, ADC_CLOCK, 0x03);
+               break;
+       case 48000:
+               lm49352_write1(codec, DAC_CLOCK, 0x03);
+               lm49352_write1(codec, ADC_CLOCK, 0x03);
+               break;
+       case 96000:
+               lm49352_write1(codec, DAC_CLOCK, 0x01);
+               break;
+       default:
+               lm49352_write1(codec, DAC_CLOCK, 0x01);
+               lm49352_write1(codec, ADC_CLOCK, 0x03);
+               break;
+       }
+
+       /* bit size */
+       switch (params_format(params)) {
+       case SNDRV_PCM_FORMAT_S16_LE:
+               dbg(KERN_CRIT "16 bit\n");
+               break;
+       case SNDRV_PCM_FORMAT_S20_3LE:
+               dbg(KERN_CRIT "20 bit\n");
+               break;
+       case SNDRV_PCM_FORMAT_S24_LE:
+               dbg(KERN_CRIT "24 bit\n");
+               break;
+       case SNDRV_PCM_FORMAT_S32_LE:
+               dbg(KERN_CRIT "32 bit\n");
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
+/**************************************************************************
+ * Name
+ *     lm49352_write1- Reads specific control information
+ * Synopsis
+ *     int lm49352_write1(struct snd_soc_codec *codec, unsigned int reg,
+ *                        unsigned int value)
+ * Arguments
+ *     codec- Pointer to the struct snd_soc_codec
+ *     reg- Specific register address
+ *     value- The value that to be written to given register
+ * Decription
+ *     This function is called when a specific register is to be written
+ *     with the given value.
+ *************************************************************************/
+ int lm49352_write1(struct snd_soc_codec *codec, unsigned int reg,
+                   unsigned int value)
+{
+       dbg(" reg=%x value=%x \n", reg, value);
+       /* I2C write call for LM49352 registers.*/
+       i2c_smbus_write_byte_data(codec->control_data, reg, value);
+}
+
+/* Formates supported by LM49352 driver. */
+#define LM49352_FORMATS (SNDRV_PCM_FMTBIT_S16_LE   \
+                        | SNDRV_PCM_FMTBIT_S20_3LE \
+                        | SNDRV_PCM_FMTBIT_S24_LE  \
+                        | SNDRV_PCM_FMTBIT_S32_LE)
+
+/* LM49352 dai structure. */
+struct snd_soc_codec_dai lm49352_dai[] = {
+       {
+               .name = "LM49352",
+               .id = 0,
+               .playback = {
+                       .stream_name = "Playback",
+                       .channels_min = 2,
+                       .channels_max = 2,
+                       .rates = SNDRV_PCM_RATE_8000_192000,
+                       .formats = LM49352_FORMATS,
+               },
+               .capture = {
+                       .stream_name = "Capture",
+                       .channels_min = 2,
+                       .channels_max = 2,
+                       .rates = SNDRV_PCM_RATE_8000_192000,
+                       .formats = LM49352_FORMATS,
+               },
+               .ops = {
+                        .hw_params = lm49352_hw_params,
+                },
+       },
+};
+EXPORT_SYMBOL_GPL(lm49352_dai);
+
+/**************************************************************************
+ * Name
+ *     lm49352_init- Initializes LM49352 sound card.
+ * Synopsis
+ *     static int lm49352_init(struct snd_soc_device *socdev)
+ * Arguments
+ *     socdev- Pointer to the struct snd_soc_device
+ * Decription
+ *     This function initializes the LM49352 sound card and registers
+ *     new PCM for it and also registers it as a new card in ALSA.
+ *     This function also writes the default value to the Lm49352's
+ *     registers.
+ *************************************************************************/
+static int lm49352_init(struct snd_soc_device *socdev)
+{
+       struct snd_soc_codec *codec = socdev->codec;
+       int ret = 0;
+
+
+       codec->name = "LM49352";
+       codec->owner = THIS_MODULE;
+       codec->read = lm49352_read_reg_cache;
+       codec->write = lm49352_write;
+       codec->dai = lm49352_dai;
+       codec->num_dai = ARRAY_SIZE(lm49352_dai);
+       codec->reg_cache_size = ARRAY_SIZE(lm49352_reg);
+       codec->reg_cache = kmemdup(lm49352_reg, sizeof(lm49352_reg),
+                                  GFP_KERNEL);
+
+       if (codec->reg_cache == NULL)
+               return -ENOMEM;
+
+       /* register pcms */
+       /* Creating new PCM for LM49352. */
+       ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+       if (ret < 0) {
+               dbg(KERN_ERR "lm49352: failed to create pcms\n");
+               goto pcm_err;
+       }
+
+       /* Writing default values for LM49352 registers. */
+       lm49352_add_controls(codec);
+       lm49352_write1(codec, BASIC_SETUP_PMC_SETUP, 0x13);
+       lm49352_write1(codec, BASIC_SETUP_PMC_CLOCK, 0x02);
+       lm49352_write1(codec, PLL_CLK_SEL, 0x00);
+       lm49352_write1(codec, ANALOG_MIXER_HEADPHONESL, 0x02);
+       lm49352_write1(codec, ANALOG_MIXER_HEADPHONESR, 0x01);
+       lm49352_write1(codec, ANALOG_MIXER_HP_SENSE, 0x00);
+       lm49352_write1(codec, ADC_BASIC, 0x033);
+       lm49352_write1(codec, ADC_CLOCK, 0x0b);
+       lm49352_write1(codec, DAC_BASIC, 0x31);
+       lm49352_write1(codec, DAC_IP_SELECT, 0x09);
+       lm49352_write1(codec, AUDIO_PORT1_BASIC, 0x07);
+       lm49352_write1(codec, PLL_M, 0x00);
+       lm49352_write1(codec, PLL_N, 0xec);
+       lm49352_write1(codec, PLL_N_MOD, 0x14);
+       lm49352_write1(codec, PLL_P1, 0x0d);
+       lm49352_write1(codec, ANALOG_MIXER_CLASSD, 0x03);
+       lm49352_write1(codec, ANALOG_MIXER_AUX_OUT, 0x23);
+       lm49352_write1(codec, ANALOG_MIXER_AUXL_LVL, 0x2b);
+       lm49352_write1(codec, ADC_MIXER, 0x0f);
+       lm49352_write1(codec, AUDIO_PORT1_IP, 0x05);
+       lm49352_write1(codec, ADC_EFFECTS_HPF, 0x04);
+       lm49352_write1(codec, ADC_EFFECTS_ADC_ALC4, 0x0a);
+       lm49352_write1(codec, ADC_EFFECTS_ADC_ALC5, 0x0a);
+       lm49352_write1(codec, ADC_EFFECTS_ADC_ALC6, 0x0a);
+       lm49352_write1(codec, ADC_EFFECTS_ADC_ALC7, 0x1f);
+       lm49352_write1(codec, ADC_EFFECTS_ADC_L_LEVEL, 0x33);
+       lm49352_write1(codec, ADC_EFFECTS_ADC_R_LEVEL, 0x33);
+       lm49352_write1(codec, DAC_EFFECTS_DAC_ALC1, 0x02);
+       lm49352_write1(codec, DAC_EFFECTS_DAC_ALC4, 0x0a);
+       lm49352_write1(codec, DAC_EFFECTS_DAC_ALC5, 0x0a);
+       lm49352_write1(codec, DAC_EFFECTS_DAC_ALC6, 0x0a);
+       lm49352_write1(codec, DAC_EFFECTS_DAC_ALC7, 0x33);
+       lm49352_write1(codec, DAC_EFFECTS_DAC_L_LEVEL, 0x33);
+       lm49352_write1(codec, DAC_EFFECTS_DAC_R_LEVEL, 0x33);
+       lm49352_write1(codec, ANALOG_MIXER_MIC_LVL, 0x0f);
+       lm49352_write1(codec, ANALOG_MIXER_ADC, 0x0c);
+
+       /* Registering new card instance for LM49352 sound card. */
+       ret = snd_soc_register_card(socdev);
+       if (ret < 0) {
+               dbg(KERN_ERR "lm49352: failed to register card\n");
+               goto card_err;
+       }
+       return ret;
+card_err:
+       snd_soc_free_pcms(socdev);
+       snd_soc_dapm_free(socdev);
+pcm_err:
+       kfree(codec->reg_cache);
+       return ret;
+}
+
+
+static struct snd_soc_device *lm49352_socdev;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+
+
+/* Address range for Lm49352 I2C. */
+static unsigned short normal_i2c[] = { 0, I2C_CLIENT_END };
+
+/* Defines I2C client address data. */
+I2C_CLIENT_INSMOD;
+
+static struct i2c_driver lm49352_i2c_driver;
+static struct i2c_client client_template;
+/***************************************************************************
+ * Name
+ *     lm49352_codec_probe- Probes the I2C for given address.
+ * Synopsis
+ *     static int lm49352_codec_probe(struct i2c_adapter *adap, int addr,
+ *                                    int kind)
+ * Arguments
+ *     adap- Pointer to the struct i2c_adapter
+ *      addr- Default I2C address of LM49352(0x1a).
+ *      kind- Kind of I2C.
+ * Decription
+ *     This function is calles while doing I2C probe and it probes I2C
+ *     for given address and also allocates memory for I2C.
+ *     and also attaches the client to I2C.
+ *************************************************************************/
+static int lm49352_codec_probe(struct i2c_adapter *adap, int addr, int kind)
+{
+       struct snd_soc_device *socdev = lm49352_socdev;
+       struct lm49352_setup_data *setup = socdev->codec_data;
+       struct snd_soc_codec *codec = socdev->codec;
+       struct i2c_client *i2c;
+       int ret;
+       dbg("in lm49352_codec_probe start\n");
+
+       if (addr != setup->i2c_address)
+               return -ENODEV;
+
+       client_template.adapter = adap;
+       client_template.addr = addr;
+
+       /* Allocating memory for LM49352 I2C data. */
+       i2c =  kmemdup(&client_template, sizeof(client_template), GFP_KERNEL);
+
+       if (i2c == NULL) {
+               kfree(codec);
+               dbg("in lm49352_codec_probe  kmemdup failed\n");
+               return -ENOMEM;
+       }
+
+       i2c_set_clientdata(i2c, codec);
+       codec->control_data = i2c;
+
+       /* Attaching I2C client of LM49352. */
+       ret = i2c_attach_client(i2c);
+       if (ret < 0) {
+               err("failed to attach codec at addr %x\n", addr);
+               goto err;
+       }
+
+       /* Calling LM49352_ to initialise Lm49352. */
+       ret = lm49352_init(socdev);
+       if (ret < 0) {
+               err("failed to initialise LM49352\n");
+               goto err;
+       }
+       dbg("in lm49352_codec_probe  end\n");
+       return ret;
+
+err:
+       kfree(codec);
+       kfree(i2c);
+       return ret;
+}
+
+/**************************************************************************
+ * Name
+ *     lm49352_i2c_detach- Detaches or removes the created I2C instance.
+ * Synopsis
+ *     static int lm49352_i2c_detach(struct i2c_client *client)
+ * Arguments
+ *     client- Pointer to the struct i2c_client
+ * Decription
+ *     This function removes or detaches the I2C instance.
+ **************************************************************************/
+
+static int lm49352_i2c_detach(struct i2c_client *client)
+{
+       dbg("in lm49352_i2c_detach \n");
+       struct snd_soc_codec *codec = i2c_get_clientdata(client);
+
+       /* Detaching I2C client of LM49352. */
+       i2c_detach_client(client);
+       kfree(codec->reg_cache);
+       kfree(client);
+       return 0;
+}
+
+/**************************************************************************
+ * Name
+ *     lm49352_i2c_attach- Attaches or creates I2C instance.
+ * Synopsis
+ *     static int lm49352_i2c_attach(struct i2c_adapter *adap)
+ * Arguments
+ *     adap- Pointer to the struct i2c_adapter
+ * Decription
+ *     This function attaches a new client to I2C.
+ *************************************************************************/
+static int lm49352_i2c_attach(struct i2c_adapter *adap)
+{
+       if (attach_once == 0) {
+               attach_once++;
+               dbg("in lm49352_i2c_attach \n");
+               /* Probes I2C for given address values. */
+               return i2c_probe(adap, &addr_data, lm49352_codec_probe);
+       } else
+               return 0;
+}
+
+/* I2C driver structure for LM49352. */
+static struct i2c_driver lm49352_i2c_driver = {
+       .driver = {
+               .name = "LM49352 I2C Codec",
+               .owner = THIS_MODULE,
+       },
+       .attach_adapter = lm49352_i2c_attach,
+       .detach_client =  lm49352_i2c_detach,
+       .command =      NULL,
+};
+
+/* I2C client structure for LM49352. */
+static struct i2c_client client_template = {
+       .name =   "LM49352",
+       .driver = &lm49352_i2c_driver,
+};
+#endif
+
+/**************************************************************************
+ * Name
+ *     lm49352_probe- Probes LM49352 card.
+ * Synopsis
+ *     static int lm49352_probe(struct platform_device *pdev)
+ * Arguments
+ *     pdev- Pointer to the struct platform_device
+ * Decription
+ *     This function probes LM49352 and creates or allocates memory for
+ *     codec structure and also for codec private data (lm49352) and
+ *     adds I2C driver for LM49352.
+ *************************************************************************/
+
+static int lm49352_probe(struct platform_device *pdev)
+{
+       struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+       struct lm49352_setup_data *setup;
+       struct snd_soc_codec *codec;
+       int ret = 0;
+       dbg(" in lm49352_probe start \n");
+       info("LM49352 Audio Codec %s\n", LM49352_VERSION);
+
+       setup = socdev->codec_data;
+       /* Allocating memory for LM49352 codec data. */
+       codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+       if (codec == NULL)
+               return -ENOMEM;
+       dbg("in lm49352_probe lm49352 kzalloc success \n");
+       socdev->codec = codec;
+       mutex_init(&codec->mutex);
+       INIT_LIST_HEAD(&codec->dapm_widgets);
+       INIT_LIST_HEAD(&codec->dapm_paths);
+       lm49352_socdev = socdev;
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+       if (setup->i2c_address) {
+               normal_i2c[0] = setup->i2c_address;
+               dbg("i2c address is %x\n", setup->i2c_address);
+               codec->hw_write = (hw_write_t)i2c_master_send;
+               /* Adding I2C driver for LM49352. */
+               ret = i2c_add_driver(&lm49352_i2c_driver);
+               if (ret != 0)
+                       dbg(KERN_ERR "can't add i2c driver");
+       }
+#else
+
+#endif
+       return ret;
+}
+
+/**************************************************************************
+ * Name
+ *     lm49352_remove- Removes Lm49352 driver structures.
+ * Synopsis
+ *     static int lm49352_remove(struct platform_device *pdev)
+ * Arguments
+ *     pdev- Pointer to the struct platform_device
+ * Decription
+ *     This function removes all the structures created while
+ *     lm49352_probe.
+ *************************************************************************/
+
+static int lm49352_remove(struct platform_device *pdev)
+{
+       struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+       struct snd_soc_codec *codec = socdev->codec;
+
+       snd_soc_free_pcms(socdev);
+       snd_soc_dapm_free(socdev);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+       i2c_del_driver(&lm49352_i2c_driver);
+#endif
+       kfree(codec->private_data);
+       kfree(codec);
+
+       return 0;
+}
+
+/* Codec structure for LM49352. */
+struct snd_soc_codec_device soc_codec_dev_lm49352 = {
+       .probe  = lm49352_probe,
+       .remove = lm49352_remove,
+};
+
+/* Exporting soc_codec_dev_lm49352 symbol. */
+EXPORT_SYMBOL_GPL(soc_codec_dev_lm49352);
+
+MODULE_AUTHOR("M R Swami Reddy <MR.Swami.Reddy@nsc.com");
+MODULE_DESCRIPTION("ASoC LM49352 driver");
+MODULE_LICENSE("GPL");
diff -upNr -X linux-2.6.24-lm49352/Documentation/dontdiff linux-2.6.24/sound/soc/codecs/lm49352.h linux-2.6.24-lm49352/sound/soc/codecs/lm49352.h
--- linux-2.6.24/sound/soc/codecs/lm49352.h     1970-01-01 05:30:00.000000000 +0530
+++ linux-2.6.24-lm49352/sound/soc/codecs/lm49352.h     2011-03-14 13:03:17.000000000 +0530
@@ -0,0 +1,90 @@
+/*
+ * Copyright (c) <2011> National Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation.
+*/
+
+#ifndef _LM49352_H
+#define _LM49352_H
+
+
+/* LM49352 register space */
+#define BASIC_SETUP_PMC_SETUP                0x00
+#define BASIC_SETUP_PMC_CLOCK                0x01
+#define PLL_CLK_SEL                          0x03
+#define ANALOG_MIXER_HEADPHONESL             0x11
+#define ANALOG_MIXER_HEADPHONESR             0x12
+#define ANALOG_MIXER_OUTPUT_OPTIONS          0x14
+#define ANALOG_MIXER_ADC                     0x15
+#define ANALOG_MIXER_MIC_LVL                 0x16
+#define ANALOG_MIXER_HP_SENSE                0x1B
+#define ADC_BASIC                            0x20
+#define ADC_CLOCK                            0x21
+#define DAC_BASIC                            0x30
+#define DAC_MUTE                             0x30
+#define DAC_CLOCK                            0x31
+#define DAC_IP_SELECT                        0x44
+#define AUDIO_PORT1_BASIC                    0x50
+#define PLL_M                                0x04
+#define PLL_N                                0x05
+#define PLL_N_MOD                            0x06
+#define PLL_P1                               0x07
+#define ANALOG_MIXER_CLASSD                  0x10
+#define ANALOG_MIXER_AUX_OUT                 0x13
+#define ANALOG_MIXER_ADC                     0x15
+#define ANALOG_MIXER_AUXL_LVL                0x18
+#define ADC_MIXER                            0x23
+#define AUDIO_PORT1_IP                       0x42
+#define ADC_EFFECTS_HPF                      0x80
+#define ADC_EFFECTS_ADC_ALC4                 0x84
+#define ADC_EFFECTS_ADC_ALC5                 0x85
+#define ADC_EFFECTS_ADC_ALC6                 0x86
+#define ADC_EFFECTS_ADC_ALC7                 0x87
+#define ADC_EFFECTS_ADC_L_LEVEL                      0x89
+#define ADC_EFFECTS_ADC_R_LEVEL                      0x8A
+#define DAC_EFFECTS_DAC_ALC1                 0xA0
+#define DAC_EFFECTS_DAC_ALC4                 0xA3
+#define DAC_EFFECTS_DAC_ALC5                 0xA4
+#define DAC_EFFECTS_DAC_ALC6                 0xA5
+#define DAC_EFFECTS_DAC_ALC7                 0xA6
+#define DAC_EFFECTS_DAC_L_LEVEL                      0xA8
+#define DAC_EFFECTS_DAC_R_LEVEL                      0xA9
+#define SPREAD_SPECTRUM_RESET                0xF0
+
+
+#define LM49352_DAC_CONTROL3                  0x71
+#define LM49352_DAC_CONTROL4                  0xff
+#define LM49352_DAC_CONTROL5                  0x30
+#define LM49352_RESET                         0xf0
+#define LM49352_ADC_CONTROL1                  0x20
+#define LM49352_MUTE                          0x0C
+#define LM49352_DIGITAL_ATTENUATION_DACL1     0xA8
+#define LM49352_DIGITAL_ATTENUATION_DACR1     0xA9
+
+extern struct snd_soc_codec_device soc_codec_dev_lm49352;
+
+struct lm49352_setup_data {
+       unsigned short i2c_address;
+};
+
+#define LM49352_DAI_PAIFRX 0
+#define LM49352_DAI_PAIFTX 1
+
+
+extern struct snd_soc_codec_dai lm49352_dai[];
+extern struct snd_soc_codec_device soc_codec_dev_lm49352;
+
+#endif
+
diff -upNr -X linux-2.6.24-lm49352/Documentation/dontdiff linux-2.6.24/sound/soc/codecs/Makefile linux-2.6.24-lm49352/sound/soc/codecs/Makefile
--- linux-2.6.24/sound/soc/codecs/Makefile      2011-03-14 14:36:10.000000000 +0530
+++ linux-2.6.24-lm49352/sound/soc/codecs/Makefile      2010-03-27 11:33:10.000000000 +0530
@@ -1,4 +1,5 @@
 snd-soc-ac97-objs := ac97.o
+snd-soc-lm49352-objs := lm49352.o
 snd-soc-wm8731-objs := wm8731.o
 snd-soc-wm8750-objs := wm8750.o
 snd-soc-wm8753-objs := wm8753.o
@@ -19,6 +20,7 @@ snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o

 obj-$(CONFIG_SND_SOC_AC97_CODEC)       += snd-soc-ac97.o
+obj-$(CONFIG_SND_SOC_LM49352)  += snd-soc-lm49352.o
 obj-$(CONFIG_SND_SOC_WM8731)   += snd-soc-wm8731.o
 obj-$(CONFIG_SND_SOC_WM8750)   += snd-soc-wm8750.o
 obj-$(CONFIG_SND_SOC_WM8753)   += snd-soc-wm8753.o
