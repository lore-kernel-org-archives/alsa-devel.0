From: Harsha Priya <priya.harsha@intel.com>
Subject: [PATCH 4/4] ASoC: mid-x86 add jack detect support
Date: Wed, 19 Jan 2011 18:18:16 +0530
Message-ID: <1295441296-32180-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EBDB24465
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 13:34:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds the jack detection in machine driver and
adds the jack detect logic in sn95031 codec.
This also adds code for reading the ADC to figure out the
mic bias and therby report jack type detected

Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/sn95031.c             |   82 +++++++++++++-
 sound/soc/codecs/sn95031.h             |   20 ++++
 sound/soc/codecs/sn95031_adc_control.h |  194 ++++++++++++++++++++++++++++++++
 sound/soc/mid-x86/mfld_machine.c       |  159 +++++++++++++++++++++-----
 4 files changed, 424 insertions(+), 31 deletions(-)
 create mode 100644 sound/soc/codecs/sn95031_adc_control.h

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 5e8d091..c436311 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -27,6 +27,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/input.h>
 #include <asm/intel_scu_ipc.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -35,13 +36,15 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include "sn95031.h"
+#include "sn95031_adc_control.h"
 
 #define SN95031_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_44100)
 #define SN95031_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
 
+struct snd_soc_codec *sn95031_codec;
+
 /*
  * todo:
- * jack detection
  * PM functions
  */
 
@@ -113,6 +116,15 @@ static int sn95031_set_vaud_bias(struct snd_soc_codec *codec,
 	return 0;
 }
 
+/* enables mic bias voltage */
+void sn95031_enable_mic_bias(struct snd_soc_codec *codec)
+{
+	snd_soc_write(codec, SN95031_VAUD,
+			BIT(2)|BIT(1)|BIT(0));
+	snd_soc_update_bits(codec, SN95031_MICBIAS,
+				BIT(2), BIT(2));
+}
+
 static int sn95031_vhs_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
@@ -310,6 +322,7 @@ static const struct snd_kcontrol_new sn95031_snd_controls[] = {
 static const struct snd_soc_dapm_widget sn95031_dapm_widgets[] = {
 
 	/* all end points mic, hs etc */
+	SND_SOC_DAPM_HP("HeadPhones", NULL),
 	SND_SOC_DAPM_OUTPUT("HPOUTL"),
 	SND_SOC_DAPM_OUTPUT("HPOUTR"),
 	SND_SOC_DAPM_OUTPUT("EPOUT"),
@@ -428,6 +441,8 @@ static const struct snd_soc_dapm_widget sn95031_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route sn95031_audio_map[] = {
 	/* headset and earpiece map */
+	{ "HeadPhones", NULL, "HPOUTR" },
+	{ "HeadPhones", NULL, "HPOUTL" },
 	{ "HPOUTL", NULL, "Headset Left Playback" },
 	{ "HPOUTR", NULL, "Headset Right Playback" },
 	{ "EPOUT", NULL, "Earpiece Playback" },
@@ -658,6 +673,66 @@ struct snd_soc_dai_driver sn95031_dais[] = {
 },
 };
 
+int sn95031_get_headset_state(void)
+{
+	unsigned int mic_bias = sn95031_get_mic_bias(sn95031_codec);
+
+	if (mic_bias >= SN_HP_START && mic_bias < SN_HP_END) {
+		pr_debug("sst: Detected Headphone!!!\n");
+		snd_soc_update_bits(sn95031_codec, AUDIO_GPIO_CTRL,
+					BIT(1), BIT(0));
+	} else if (mic_bias >= SN_AM_HS_START && mic_bias < SN_AM_HS_END) {
+		pr_debug("sst: Detected American headset\n");
+		snd_soc_update_bits(sn95031_codec, AUDIO_GPIO_CTRL,
+					BIT(1), BIT(1));
+	} else if (mic_bias >= SN_HS_START && mic_bias < SN_HS_END) {
+		pr_debug("sst: Detected Headset!!!\n");
+		snd_soc_update_bits(sn95031_codec, AUDIO_GPIO_CTRL,
+					BIT(1), BIT(0));
+		enable_jack_btn(sn95031_codec);
+		return SND_JACK_HEADSET;
+	} else
+		pr_debug("sst: Detected Open Cable!!!\n");
+
+	return SND_JACK_HEADPHONE;
+}
+
+void sn95031_jack_detection(struct snd_soc_jack *mfld_jack,
+		struct mfld_jack_msg_wq *jack_msg)
+{
+	unsigned int status, mask;
+	static int jack_state = SND_JACK_HEADSET;
+
+	if (!sn95031_codec) {
+		pr_err("codec is null\n");
+		return;
+	}
+	pr_debug("interrupt id read in sram = 0x%x\n", jack_msg->intr_id);
+	if (jack_msg->intr_id & 0x1) {
+		pr_debug("short_push detected\n");
+		mask = status = SND_JACK_BTN_0;
+	} else if (jack_msg->intr_id & 0x2) {
+		pr_debug("long_push detected\n");
+		mask = status = SND_JACK_BTN_1;
+	} else if (jack_msg->intr_id & 0x4) {
+		mask = status = sn95031_get_headset_state();
+		jack_state = mask;
+	} else if (jack_msg->intr_id & 0x8) {
+		pr_debug("headset or headphones removed\n");
+		status = 0;
+		mask = jack_state;
+		disable_jack_btn(sn95031_codec);
+	} else {
+		pr_err("unidentified interrupt\n");
+		return;
+	}
+
+	snd_soc_jack_report(mfld_jack, status, mask);
+	/*button pressed and released */
+	if (status == SND_JACK_BTN_0 || status == SND_JACK_BTN_1)
+		snd_soc_jack_report(mfld_jack, 0, mask);
+}
+EXPORT_SYMBOL_GPL(sn95031_jack_detection);
 /* codec registration */
 static int sn95031_codec_probe(struct snd_soc_codec *codec)
 {
@@ -667,6 +742,7 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.idle_bias_off = 1;
+	sn95031_codec = codec;
 
 	/* PCM interface config
 	 * This sets the pcm rx slot conguration to max 6 slots
@@ -733,7 +809,7 @@ static int sn95031_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-struct snd_soc_codec_driver sn95031_codec = {
+struct snd_soc_codec_driver sn95031_soc_codec = {
 	.probe		= sn95031_codec_probe,
 	.remove		= sn95031_codec_remove,
 	.read		= sn95031_read,
@@ -744,7 +820,7 @@ struct snd_soc_codec_driver sn95031_codec = {
 static int __devinit sn95031_device_probe(struct platform_device *pdev)
 {
 	pr_debug("codec device probe called for %s\n", dev_name(&pdev->dev));
-	return snd_soc_register_codec(&pdev->dev, &sn95031_codec,
+	return snd_soc_register_codec(&pdev->dev, &sn95031_soc_codec,
 			sn95031_dais, ARRAY_SIZE(sn95031_dais));
 }
 
diff --git a/sound/soc/codecs/sn95031.h b/sound/soc/codecs/sn95031.h
index e2b17d9..e79176d 100644
--- a/sound/soc/codecs/sn95031.h
+++ b/sound/soc/codecs/sn95031.h
@@ -25,6 +25,7 @@
  */
 #ifndef _SN95031_H
 #define _SN95031_H
+#include <sound/jack.h>
 
 /*register map*/
 #define SN95031_VAUD			0xDB
@@ -96,4 +97,23 @@
 #define SN95031_SSR5			0x384
 #define SN95031_SSR6			0x385
 
+struct mfld_jack_msg_wq {
+	u8 intr_id;
+	struct work_struct wq;
+};
+
+static inline void disable_jack_btn(struct snd_soc_codec *codec)
+{
+	snd_soc_write(codec, SN95031_BTNCTRL2, 0x00);
+}
+
+static inline void enable_jack_btn(struct snd_soc_codec *codec)
+{
+	snd_soc_write(codec, SN95031_BTNCTRL1, 0x77);
+	snd_soc_write(codec, SN95031_BTNCTRL2, 0x01);
+}
+
+extern void sn95031_jack_detection(struct snd_soc_jack *mfld_jack,
+		struct mfld_jack_msg_wq *jack_msg);
+
 #endif
diff --git a/sound/soc/codecs/sn95031_adc_control.h b/sound/soc/codecs/sn95031_adc_control.h
new file mode 100644
index 0000000..0971321
--- /dev/null
+++ b/sound/soc/codecs/sn95031_adc_control.h
@@ -0,0 +1,194 @@
+#ifndef __MFLD_MACHINE_ADC_CONTROL_H__
+#define __MFLD_MACHINE_ADC_CONTROL_H_
+/*
+ *  sn95031_adc_control.h - Module for adc programming
+ *
+ *  Copyright (C) 2008-10 Intel Corporation
+ *  Authors:	R Durgadadoss <r.durgadoss@intel.com>
+ *		Dharageswari R <dharageswari.r@intel.com>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+
+#define SN95031_ADC1CNTL1 0x1C0
+#define SN95031_ADC_ENBL 0x10
+#define SN95031_ADC_START 0x08
+
+#define SN95031_ADC1CNTL3 0x1C2
+#define SN95031_ADCTHERM_ENBL 0x04
+#define SN95031_ADCRRDATA_ENBL 0x05
+
+#define SN95031_STOPBIT_MASK 16
+#define SN95031_ADCTHERM_MASK 4
+
+#define ADC_CHANLS_MAX 15 /* Number of ADC channels */
+#define ADC_LOOP_MAX (ADC_CHANLS_MAX - 1)
+
+/* ADC channel code values */
+#define AUDIO_DETECT_CODE 0x06
+
+#define AUDIO_GPIO_CTRL 0x070
+
+/* ADC base addresses */
+#define ADC_CHNL_START_ADDR 0x1C5 /* increments by 1 */
+#define ADC_DATA_START_ADDR 0x1D4  /* increments by 2 */
+
+/* multipier to convert to mV */
+#define ADC_ONE_LSB_MULTIPLIER 2346
+
+enum MIC_BIAS_ZONES {
+	SN_HP_START = 0,
+	SN_HP_END = 400,
+	SN_AM_HS_START = 400,
+	SN_AM_HS_END = 650,
+	SN_HS_START = 650,
+	SN_HS_END = 2000,
+	SN_UNDEFINED,
+};
+
+void sn95031_enable_mic_bias(struct snd_soc_codec *codec);
+
+/**
+ * configure_adc - enables/disables the ADC for conversion
+ * @val: zero: disables the ADC non-zero:enables the ADC
+ *
+ * Enable/Disable the ADC depending on the argument
+ *
+ * Can sleep
+ */
+static inline void configure_adc(struct snd_soc_codec *sn95031_codec, int val)
+{
+	int value = snd_soc_read(sn95031_codec, SN95031_ADC1CNTL1);
+
+	if (val)
+		/* Enable and start the ADC */
+		value |= (SN95031_ADC_ENBL | SN95031_ADC_START);
+	else
+		/* Just stop the ADC */
+		value &= (~SN95031_ADC_START);
+	snd_soc_write(sn95031_codec, SN95031_ADC1CNTL1, value);
+}
+
+/**
+ * find_free_channel - finds an empty channel for conversion
+ *
+ * If the ADC is not enabled then start using 0th channel
+ * itself. Otherwise find an empty channel by looking for a
+ * channel in which the stopbit is set to 1. returns the index
+ * of the first free channel if succeeds or an error code.
+ *
+ * Context: can sleep
+ *
+ */
+static inline int find_free_channel(struct snd_soc_codec *sn95031_codec)
+{
+	int ret = 0, i, value;
+
+	/* check whether ADC is enabled */
+	value = snd_soc_read(sn95031_codec, SN95031_ADC1CNTL1);
+
+	if ((value & SN95031_ADC_ENBL) == 0)
+		return 0;
+
+	/* ADC is already enabled; Looking for an empty channel */
+	for (i = 0; i < ADC_CHANLS_MAX; i++) {
+		value = snd_soc_read(sn95031_codec, ADC_CHNL_START_ADDR + i);
+		if (value & SN95031_STOPBIT_MASK) {
+			ret = i;
+			break;
+		}
+	}
+	return (ret > ADC_LOOP_MAX) ? (-EINVAL) : ret;
+}
+
+/**
+ * sn95031_initialize_adc - initializing the ADC
+ * @dev: our device structure
+ *
+ * Initialize the ADC for reading thermistor values. Can sleep.
+ */
+static int sn95031_initialize_adc(struct snd_soc_codec *sn95031_codec)
+{
+	int base_addr, chnl_addr;
+	int value;
+	static int channel_index;
+
+	/* Index of the first channel in which the stop bit is set */
+	channel_index = find_free_channel(sn95031_codec);
+	if (channel_index < 0) {
+		pr_err("No free ADC channels");
+		return channel_index;
+	}
+
+	base_addr = ADC_CHNL_START_ADDR + channel_index;
+
+	if (!(channel_index == 0 || channel_index == ADC_LOOP_MAX)) {
+		/* Reset stop bit for channels other than 0 and 12 */
+		value = snd_soc_read(sn95031_codec, base_addr);
+		/* Set the stop bit to zero */
+		snd_soc_write(sn95031_codec, base_addr, value & 0xEF);
+		/* Index of the first free channel */
+		base_addr++;
+		channel_index++;
+	}
+
+	/* Since this is the last channel, set the stop bit
+	   to 1 by ORing the DIE_SENSOR_CODE with 0x10 */
+	snd_soc_write(sn95031_codec, base_addr, AUDIO_DETECT_CODE | 0x10);
+
+	chnl_addr = ADC_DATA_START_ADDR + 2 * channel_index;
+	pr_debug("mid_initialize : %x", chnl_addr);
+	configure_adc(sn95031_codec, 1);
+	return chnl_addr;
+}
+
+
+/**
+ * sn95031_get_mic_bias - get the mic bias in mV
+ *
+ * reads the ADC registers and gets the mic bias value in mV.
+ */
+static unsigned int sn95031_get_mic_bias(struct snd_soc_codec *codec)
+{
+	u16 adc_adr = sn95031_initialize_adc(codec);
+	u16 adc_val1, adc_val2;
+	unsigned int mic_bias;
+
+	sn95031_enable_mic_bias(codec);
+
+	/* Enable the sound card for conversion before reading */
+	snd_soc_write(codec, SN95031_ADC1CNTL3, 0x05);
+	/* Re-toggle the RRDATARD bit */
+	snd_soc_write(codec, SN95031_ADC1CNTL3, 0x04);
+
+	/* Read the higher bits of data */
+	msleep(1000);
+	adc_val1 = snd_soc_read(codec, adc_adr);
+	adc_adr++;
+	adc_val2 = snd_soc_read(codec, adc_adr);
+
+	/* Adding lower two bits to the higher bits */
+	mic_bias = (adc_val1 << 2) + (adc_val2 & 3);
+	/* convesion into mV */
+	mic_bias = (ADC_ONE_LSB_MULTIPLIER * mic_bias) / 1000;
+	pr_debug("mic bias = %dmV\n", mic_bias);
+	return mic_bias;
+}
+#endif
+
diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 1cd49a2..7926151 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -35,10 +36,32 @@
 #define MID_MONO 1
 #define MID_STEREO 2
 #define MID_MAX_CAP 5
+#define IRQ_BASE 0xFFFF7FCD
+#define IRQ_SIZE 1
 
 static unsigned int	hs_switch;
 static unsigned int	lo_dac;
 
+struct mfld_mc_private {
+	struct platform_device *socdev;
+	struct workqueue_struct *mfld_jack_wq;
+	void __iomem *int_base;
+};
+
+struct snd_soc_jack mfld_jack;
+
+/*Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin mfld_jack_pins[] = {
+	{
+		.pin = "HeadPhones",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "AMIC1",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
 /* sound card controls */
 static const char *headset_switch_text[] = {"Earpiece", "Headset"};
 
@@ -67,13 +90,11 @@ static int headset_set_switch(struct snd_kcontrol *kcontrol,
 
 	if (ucontrol->value.integer.value[0]) {
 		pr_debug("hs_set HS path\n");
-		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_enable_pin(&codec->dapm, "HeadPhones");
 		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
 	} else {
 		pr_debug("hs_set EP path\n");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HeadPhones");
 		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
 	}
 	snd_soc_dapm_sync(&codec->dapm);
@@ -91,12 +112,10 @@ static void lo_enable_out_pins(struct snd_soc_codec *codec)
 	snd_soc_dapm_enable_pin(&codec->dapm, "VIB1OUT");
 	snd_soc_dapm_enable_pin(&codec->dapm, "VIB2OUT");
 	if (hs_switch) {
-		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_enable_pin(&codec->dapm, "HeadPhones");
 		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
 	} else {
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HeadPhones");
 		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
 	}
 }
@@ -130,8 +149,7 @@ static int lo_set_switch(struct snd_kcontrol *kcontrol,
 
 	case 1:
 		pr_debug("set hs  path\n");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
-		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
+		snd_soc_dapm_disable_pin(&codec->dapm, "HeadPhones");
 		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
 		snd_soc_update_bits(codec, SN95031_LOCTL, 0x66, 0x22);
 		break;
@@ -175,8 +193,7 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 		return ret_val;
 	}
 	/* default is earpiece pin, userspace sets it explcitly */
-	snd_soc_dapm_disable_pin(dapm, "HPOUTL");
-	snd_soc_dapm_disable_pin(dapm, "HPOUTR");
+	snd_soc_dapm_disable_pin(dapm, "HeadPhones");
 	/* default is lineout NC, userspace sets it explcitly */
 	snd_soc_dapm_disable_pin(dapm, "LINEOUTL");
 	snd_soc_dapm_disable_pin(dapm, "LINEOUTR");
@@ -185,11 +202,31 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 	/* we dont use linein in this so set to NC */
 	snd_soc_dapm_disable_pin(dapm, "LINEINL");
 	snd_soc_dapm_disable_pin(dapm, "LINEINR");
-	/* we are using DMICs here so configure how the clock and out pin is set */
+	/* we are using DMICs here so configure how the
+	 * clock and out pin is set */
 	snd_soc_write(codec, SN95031_DMICBUF0123, 0x85);
 	snd_soc_write(codec, SN95031_DMICBUF45, 0x02);
 	snd_soc_update_bits(codec, SN95031_DMICMUX, 0x7, 0x07);
-	return snd_soc_dapm_sync(dapm);
+	snd_soc_dapm_sync(dapm);
+		/* Headset jack detection */
+	ret_val = snd_soc_jack_new(codec, "Intel(R) MID Audio Jack",
+			SND_JACK_HEADSET | SND_JACK_BTN_0 |
+			SND_JACK_BTN_1, &mfld_jack);
+
+	if (ret_val) {
+		pr_err("jack creation failed\n");
+		return ret_val;
+	}
+
+	ret_val = snd_soc_jack_add_pins(&mfld_jack,
+			ARRAY_SIZE(mfld_jack_pins), mfld_jack_pins);
+	if (ret_val) {
+		pr_err("adding jack pins failed\n");
+		return ret_val;
+	}
+	disable_jack_btn(codec);
+	return ret_val;
+
 }
 
 struct snd_soc_dai_link mfld_msic_dailink[] = {
@@ -238,37 +275,103 @@ static struct snd_soc_card snd_soc_card_mfld = {
 	.num_links = ARRAY_SIZE(mfld_msic_dailink),
 };
 
+void snd_mfld_jack_detection(struct work_struct *work)
+{
+	struct mfld_jack_msg_wq *jack_msg =
+			container_of(work, struct mfld_jack_msg_wq, wq);
+
+	sn95031_jack_detection(&mfld_jack, jack_msg);
+	kfree(jack_msg);
+}
+
+static irqreturn_t snd_mfld_jack_intr_handler(int irq, void *dev)
+{
+	struct mfld_jack_msg_wq *jack_msg;
+	struct mfld_mc_private *mc_private = (struct mfld_mc_private *) dev;
+
+	jack_msg = kzalloc(sizeof(*jack_msg), GFP_ATOMIC);
+	memcpy_fromio(&jack_msg->intr_id,
+			((void *)(mc_private->int_base)),
+			sizeof(u8));
+	pr_debug("intr_handler called value %x\n", jack_msg->intr_id);
+	INIT_WORK(&jack_msg->wq, snd_mfld_jack_detection);
+	queue_work(mc_private->mfld_jack_wq, &jack_msg->wq);
+
+	return IRQ_HANDLED;
+}
+
 static int __devinit snd_mfld_mc_probe(struct platform_device *pdev)
 {
-	struct platform_device *socdev;
-	int ret_val = 0;
+	int ret_val = 0, irq;
+	struct mfld_mc_private *mc_private_data;
 
 	pr_debug("snd_mfld_mc_probe called\n");
 
-	socdev =  platform_device_alloc("soc-audio", -1);
-	if (!socdev) {
-		pr_err("soc-audio device allocation failed\n");
+	mc_private_data = kzalloc(sizeof(*mc_private_data), GFP_ATOMIC);
+	if (!mc_private_data) {
+		pr_err("mem alloation of mc_private failed\n");
 		return -ENOMEM;
 	}
-	platform_set_drvdata(socdev, &snd_soc_card_mfld);
-	ret_val = platform_device_add(socdev);
+
+	/* retrive the irq number */
+	irq = platform_get_irq(pdev, 0);
+	/*	audio interrupt base of SRAM location where
+	*	interrupts are stored by System FW */
+	mc_private_data->int_base = ioremap_nocache(IRQ_BASE, IRQ_SIZE);
+	if (!mc_private_data->int_base) {
+		pr_err("Mapping of cache failed\n");
+		ret_val = -ENOMEM;
+		goto unalloc;
+	}
+	/* create botoom half handler for interrupt */
+	mc_private_data->mfld_jack_wq = create_workqueue("mfld_jack_wq");
+	if (!mc_private_data->mfld_jack_wq) {
+		pr_err("cannot create jack workqueue\n");
+		ret_val = -ENOMEM;
+		goto unalloc;
+	}
+	/* register for interrupt */
+	ret_val = request_irq(irq, snd_mfld_jack_intr_handler,
+				IRQF_SHARED, pdev->dev.driver->name,
+				mc_private_data);
+	if (ret_val) {
+		pr_err("cannot register IRQ\n");
+		goto destroy_wq;
+	}
+	/* create soc device */
+	mc_private_data->socdev =  platform_device_alloc("soc-audio", -1);
+	if (!mc_private_data->socdev) {
+		pr_err("soc-audio device allocation failed\n");
+		ret_val = -ENOMEM;
+		goto destroy_wq;
+	}
+	platform_set_drvdata(mc_private_data->socdev, &snd_soc_card_mfld);
+	ret_val = platform_device_add(mc_private_data->socdev);
 	if (ret_val) {
 		pr_err("Unable to add soc-audio device, err %d\n", ret_val);
-		platform_device_put(socdev);
+		goto unregister;
 	}
-
-	platform_set_drvdata(pdev, socdev);
-
+	platform_set_drvdata(pdev, mc_private_data);
 	pr_debug("successfully exited probe\n");
 	return ret_val;
+
+unregister:
+	platform_device_put(mc_private_data->socdev);
+destroy_wq:
+	destroy_workqueue(mc_private_data->mfld_jack_wq);
+unalloc:
+	kfree(mc_private_data);
+	return ret_val;
 }
 
 static int __devexit snd_mfld_mc_remove(struct platform_device *pdev)
 {
-	struct platform_device *socdev =  platform_get_drvdata(pdev);
-	pr_debug("snd_mfld_mc_remove called\n");
+	struct mfld_mc_private *mc_private_data = platform_get_drvdata(pdev);
 
-	platform_device_unregister(socdev);
+	pr_debug("snd_mfld_mc_remove called\n");
+	free_irq(platform_get_irq(pdev, 0), mc_private_data);
+	destroy_workqueue(mc_private_data->mfld_jack_wq);
+	platform_device_unregister(mc_private_data->socdev);
 	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
-- 
1.7.2.3
