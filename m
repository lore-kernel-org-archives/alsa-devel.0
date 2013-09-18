From: klem.dev@gmail.com
Subject: [PATCH - Ego Sys Waveterminal 192M 1/1] Update driver
	to support alsa changes happened since last driver commit.
	Add TLV support for dB scales. Add sampling rate control.
Date: Wed, 18 Sep 2013 22:15:32 +0200
Message-ID: <523a09ee.27d0b40a.70ae.477f@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Clement Guedez <klem.dev@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Clement Guedez <klem.dev@gmail.com>


Signed-off-by: Clement Guedez <klem.dev@gmail.com>

diff --git a/sound/pci/ice1712/wtm.c b/sound/pci/ice1712/wtm.c
index bcf30a3..286be47 100644
--- a/sound/pci/ice1712/wtm.c
+++ b/sound/pci/ice1712/wtm.c
@@ -4,8 +4,8 @@
  *	Lowlevel functions for Ego Sys Waveterminal 192M
  *
  *		Copyright (c) 2006 Guedez Clement <klem.dev@gmail.com>
- *		Some functions are taken from the Prodigy192 driver
- *		source
+ *		Thanks to the developers of the Prodigy192 driver on which
+ *		I based this driver
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License as published by
@@ -25,15 +25,25 @@
 
 
 
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/slab.h>
 #include <sound/core.h>
 
 #include "ice1712.h"
 #include "envy24ht.h"
 #include "wtm.h"
 #include "stac946x.h"
+#include <sound/tlv.h>
+
+struct wtm_spec {
+	struct ak4114 *ak4114;
+	/* rate change needs atomic mute/unmute of all dacs*/
+	struct mutex mute_mutex;
+};
+
 
 
 /*
@@ -68,6 +78,35 @@ static inline unsigned char stac9460_2_get(struct snd_ice1712 *ice, int reg)
 /*
  *	DAC mute control
  */
+static void stac9460_dac_mute_all(struct snd_ice1712 *ice, unsigned char mute,
+				   unsigned char *change)
+{
+	unsigned char new, old;
+	int idx;
+
+	/*stac9460 1*/
+	for (idx = 0; idx < 7; idx++) {
+		if (change[idx]) {
+			old = stac9460_get(ice, idx);
+			new = (~mute << 7 & 0x80) | (old & ~0x80);
+			change[idx] = (new != old);
+			if (change[idx])
+				stac9460_put(ice, idx, new);
+		}
+	}
+
+	/*stac9460 2*/
+	for (idx = 0; idx < 3; idx++) {
+		if (change[idx + 7]) {
+			old = stac9460_2_get(ice, idx);
+			new = (~mute << 7 & 0x80) | (old & ~0x80);
+			change[idx + 7] = (new != old);
+			if (change[idx + 7])
+				stac9460_2_put(ice, idx, new);
+		}
+	}
+}
+
 #define stac9460_dac_mute_info		snd_ctl_boolean_mono_info
 
 static int stac9460_dac_mute_get(struct snd_kcontrol *kcontrol,
@@ -96,10 +135,14 @@ static int stac9460_dac_mute_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
+	struct wtm_spec *spec = ice->spec;
 	unsigned char new, old;
 	int id, idx;
 	int change;
 
+	mutex_lock(&spec->mute_mutex);
+
+
 	if (kcontrol->private_value) {
 		idx = STAC946X_MASTER_VOLUME;
 		old = stac9460_get(ice, idx);
@@ -127,6 +170,7 @@ static int stac9460_dac_mute_put(struct snd_kcontrol *kcontrol,
 				stac9460_2_put(ice, idx - 6, new);
 		}
 	}
+	mutex_unlock(&spec->mute_mutex);
 	return change;
 }
 
@@ -175,7 +219,7 @@ static int stac9460_dac_vol_put(struct snd_kcontrol *kcontrol,
 
 	if (kcontrol->private_value) {
 		idx = STAC946X_MASTER_VOLUME;
-		nvol = ucontrol->value.integer.value[0] & 0x7f;
+		nvol = ucontrol->value.integer.value[0];
 		tmp = stac9460_get(ice, idx);
 		ovol = 0x7f - (tmp & 0x7f);
 		change = (ovol != nvol);
@@ -186,7 +230,7 @@ static int stac9460_dac_vol_put(struct snd_kcontrol *kcontrol,
 	} else {
 		id = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 		idx = id + STAC946X_LF_VOLUME;
-		nvol = ucontrol->value.integer.value[0] & 0x7f;
+		nvol = ucontrol->value.integer.value[0];
 		if (id < 6)
 			tmp = stac9460_get(ice, idx);
 		else
@@ -339,7 +383,24 @@ static int stac9460_adc_vol_put(struct snd_kcontrol *kcontrol,
  * MIC / LINE switch fonction
  */
 
-#define stac9460_mic_sw_info		snd_ctl_boolean_mono_info
+static int stac9460_mic_sw_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[2] = { "Line In", "Mic" };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items
+						- 1;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
 
 static int stac9460_mic_sw_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
@@ -353,7 +414,7 @@ static int stac9460_mic_sw_get(struct snd_kcontrol *kcontrol,
 		val = stac9460_get(ice, STAC946X_GENERAL_PURPOSE);
 	else
 		val = stac9460_2_get(ice, STAC946X_GENERAL_PURPOSE);
-	ucontrol->value.integer.value[0] = ~val>>7 & 0x1;
+	ucontrol->value.enumerated.item[0] = (val >> 7) & 0x1;
 	return 0;
 }
 
@@ -369,7 +430,7 @@ static int stac9460_mic_sw_put(struct snd_kcontrol *kcontrol,
 		old = stac9460_get(ice, STAC946X_GENERAL_PURPOSE);
 	else
 		old = stac9460_2_get(ice, STAC946X_GENERAL_PURPOSE);
-	new = (~ucontrol->value.integer.value[0] << 7 & 0x80) | (old & ~0x80);
+	new = (ucontrol->value.enumerated.item[0] << 7 & 0x80) | (old & ~0x80);
 	change = (new != old);
 	if (change) {
 		if (id == 0)
@@ -380,6 +441,46 @@ static int stac9460_mic_sw_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
+
+/*
+ * Handler for setting correct codec rate - called when rate change is detected
+ */
+static void stac9460_set_rate_val(struct snd_ice1712 *ice, unsigned int rate)
+{
+	unsigned char old, new;
+	unsigned char changed[10];
+	struct wtm_spec *spec = ice->spec;
+
+	if (rate == 0)  /* no hint - S/PDIF input is master, simply return */
+		return;
+	else if (rate <= 48000)
+		new = 0x08;     /* 256x, base rate mode */
+	else if (rate <= 96000)
+		new = 0x11;     /* 256x, mid rate mode */
+	else
+		new = 0x12;     /* 128x, high rate mode */
+	old = stac9460_get(ice, STAC946X_MASTER_CLOCKING);
+	if (old == new)
+		return;
+	/* change detected, setting master clock, muting first */
+	/* due to possible conflicts with mute controls - mutexing */
+	mutex_lock(&spec->mute_mutex);
+	/* we have to remember current mute status for each DAC */
+	stac9460_dac_mute_all(ice, 0, changed);
+	/*printk(KERN_DEBUG "Rate change: %d, new MC: 0x%02x\n", rate, new);*/
+	stac9460_put(ice, STAC946X_MASTER_CLOCKING, new);
+	udelay(10);
+	/* unmuting - only originally unmuted dacs -
+	* i.e. those changed when muting */
+	stac9460_dac_mute_all(ice, 1, changed);
+	mutex_unlock(&spec->mute_mutex);
+}
+
+
+
+static const DECLARE_TLV_DB_SCALE(db_scale_dac, -19125, 75, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_adc, 0, 150, 0);
+
 /*
  * Control tabs
  */
@@ -390,15 +491,19 @@ static struct snd_kcontrol_new stac9640_controls[] = {
 		.info = stac9460_dac_mute_info,
 		.get = stac9460_dac_mute_get,
 		.put = stac9460_dac_mute_put,
-		.private_value = 1
+		.private_value = 1,
+		.tlv = { .p = db_scale_dac }
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "Master Playback Volume",
 		.info = stac9460_dac_vol_info,
 		.get = stac9460_dac_vol_get,
 		.put = stac9460_dac_vol_put,
 		.private_value = 1,
+		.tlv = { .p = db_scale_dac }
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -419,11 +524,14 @@ static struct snd_kcontrol_new stac9640_controls[] = {
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "DAC Volume",
 		.count = 8,
 		.info = stac9460_dac_vol_info,
 		.get = stac9460_dac_vol_get,
 		.put = stac9460_dac_vol_put,
+		.tlv = { .p = db_scale_dac }
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -435,18 +543,40 @@ static struct snd_kcontrol_new stac9640_controls[] = {
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "ADC Volume",
 		.count = 2,
 		.info = stac9460_adc_vol_info,
 		.get = stac9460_adc_vol_get,
 		.put = stac9460_adc_vol_put,
-
+		.tlv = { .p = db_scale_adc }
 	}
 };
 
 
 
 /*INIT*/
+static void stac9460_proc_regs_read(struct snd_info_entry *entry,
+				    struct snd_info_buffer *buffer)
+{
+	struct snd_ice1712 *ice = entry->private_data;
+	int reg, val;
+	/* registers 0x0 - 0x14 */
+	for (reg = 0; reg <= 0x15; reg++) {
+		val = stac9460_get(ice, reg);
+		snd_iprintf(buffer, "0x%02x = 0x%02x\n", reg, val);
+	}
+}
+
+static void stac9460_proc_init(struct snd_ice1712 *ice)
+{
+	struct snd_info_entry *entry;
+	if (!snd_card_proc_new(ice->card, "stac9460_codec", &entry))
+		snd_info_set_text_ops(entry, ice, stac9460_proc_regs_read);
+}
+
+
 static int wtm_add_controls(struct snd_ice1712 *ice)
 {
 	unsigned int i;
@@ -458,46 +588,64 @@ static int wtm_add_controls(struct snd_ice1712 *ice)
 		if (err < 0)
 			return err;
 	}
+	stac9460_proc_init(ice);
 	return 0;
 }
 
 static int wtm_init(struct snd_ice1712 *ice)
 {
-	static unsigned short stac_inits_prodigy[] = {
+	static unsigned short stac_inits_wtm[] = {
 		STAC946X_RESET, 0,
+		STAC946X_MASTER_CLOCKING, 0x11,
 		(unsigned short)-1
 	};
 	unsigned short *p;
+	struct wtm_spec *spec;
+
 
 	/*WTM 192M*/
 	ice->num_total_dacs = 8;
 	ice->num_total_adcs = 4;
 	ice->force_rdma1 = 1;
+	ice->vt1720 = 0;  /* ice1724, e.g. 23 GPIOs */
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+	ice->spec = spec;
+	mutex_init(&spec->mute_mutex);
 
 	/*initialize codec*/
-	p = stac_inits_prodigy;
+	p = stac_inits_wtm;
 	for (; *p != (unsigned short)-1; p += 2) {
 		stac9460_put(ice, p[0], p[1]);
 		stac9460_2_put(ice, p[0], p[1]);
 	}
+	ice->gpio.set_pro_rate = stac9460_set_rate_val;
 	return 0;
 }
 
 
 static unsigned char wtm_eeprom[] = {
-	0x47,	/*SYSCONF: clock 192KHz, 4ADC, 8DAC */
-	0x80,	/* ACLINK : I2S */
-	0xf8,	/* I2S: vol; 96k, 24bit, 192k */
-	0xc1	/*SPDIF: out-en, spidf ext out*/,
-	0x9f,	/* GPIO_DIR */
-	0xff,	/* GPIO_DIR1 */
-	0x7f,	/* GPIO_DIR2 */
-	0x9f,	/* GPIO_MASK */
-	0xff,	/* GPIO_MASK1 */
-	0x7f,	/* GPIO_MASK2 */
-	0x16,	/* GPIO_STATE */
-	0x80,	/* GPIO_STATE1 */
-	0x00,	/* GPIO_STATE2 */
+	[ICE_EEP2_SYSCONF]     = 0x67,  /* 49MHz crystal, mpu401,
+					 * spdif-in+ 1 stereo ADC,
+					 * 4 stereo DACs
+					 */
+	[ICE_EEP2_ACLINK]      = 0x80,  /* I2S */
+	[ICE_EEP2_I2S]         = 0xf8,  /* vol, 96k, 24bit, 192k */
+	[ICE_EEP2_SPDIF]       = 0xc1,  /* out-en, out-int, spdif-in */
+	[ICE_EEP2_GPIO_DIR]    = 0x9f,
+	[ICE_EEP2_GPIO_DIR1]   = 0xff,
+	[ICE_EEP2_GPIO_DIR2]   = 0x7f,
+	[ICE_EEP2_GPIO_MASK]   = 0x9f,
+	[ICE_EEP2_GPIO_MASK1]  = 0xff,
+	[ICE_EEP2_GPIO_MASK2]  = 0x7f,
+	[ICE_EEP2_GPIO_STATE]  = 0x16,
+	[ICE_EEP2_GPIO_STATE1] = 0x80,
+	[ICE_EEP2_GPIO_STATE2] = 0x00,  /* GPIO20: 0 = CD drive dig. input
+					 * passthrough,
+					 * 1 = SPDIF-OUT from ice1724
+					 */
 };
 
 
-- 
1.7.10.4
