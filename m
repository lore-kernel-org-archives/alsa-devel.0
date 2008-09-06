From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] ice1712/wtm: fix coding style
Date: Sun, 7 Sep 2008 01:54:27 +0400
Message-ID: <20080906215427.GB6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D1F12440B
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Sep 2008 23:54:39 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1010349fgg.44
	for <alsa-devel@alsa-project.org>; Sat, 06 Sep 2008 14:54:38 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

before:
total: 2 errors, 0 warnings, 20 lines checked
total: 49 errors, 2 warnings, 518 lines checked

after:
total: 0 errors, 0 warnings, 20 lines checked
total: 0 errors, 0 warnings, 518 lines checked

Compile tested, size and code are equal.


Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/ice1712/wtm.c |  104 +++++++++++++++++++++++-----------------------
 sound/pci/ice1712/wtm.h |    4 +-
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/sound/pci/ice1712/wtm.c b/sound/pci/ice1712/wtm.c
index a08d17c..5af9e84 100644
--- a/sound/pci/ice1712/wtm.c
+++ b/sound/pci/ice1712/wtm.c
@@ -1,12 +1,12 @@
 /*
  *	ALSA driver for ICEnsemble VT1724 (Envy24HT)
- *	
+ *
  *	Lowlevel functions for Ego Sys Waveterminal 192M
  *
  *		Copyright (c) 2006 Guedez Clement <klem.dev@gmail.com>
  *		Some functions are taken from the Prodigy192 driver
  *		source
- *		
+ *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation; either version 2 of the License, or
@@ -20,12 +20,12 @@
  *	You should have received a copy of the GNU General Public License
  *	along with this program; if not, write to the Free Software
  *	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *	
- */	
+ *
+ */
 
 
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -39,9 +39,9 @@
 
 
 /*
- *	2*ADC 6*DAC no1 ringbuffer r/w on i2c bus 
+ *	2*ADC 6*DAC no1 ringbuffer r/w on i2c bus
  */
-static inline void stac9460_put(struct snd_ice1712 *ice, int reg, 
+static inline void stac9460_put(struct snd_ice1712 *ice, int reg,
 						unsigned char val)
 {
 	snd_vt1724_write_i2c(ice, STAC9460_I2C_ADDR, reg, val);
@@ -73,7 +73,7 @@ static inline unsigned char stac9460_2_get(struct snd_ice1712 *ice, int reg)
 #define stac9460_dac_mute_info		snd_ctl_boolean_mono_info
 
 static int stac9460_dac_mute_get(struct snd_kcontrol *kcontrol,
-	       			struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char val;
@@ -88,14 +88,14 @@ static int stac9460_dac_mute_get(struct snd_kcontrol *kcontrol,
 	}
 	if (id < 6)
 		val = stac9460_get(ice, idx);
-	else 
-		val = stac9460_2_get(ice,idx - 6);
+	else
+		val = stac9460_2_get(ice, idx - 6);
 	ucontrol->value.integer.value[0] = (~val >> 7) & 0x1;
 	return 0;
 }
 
 static int stac9460_dac_mute_put(struct snd_kcontrol *kcontrol,
-	       			struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char new, old;
@@ -105,8 +105,8 @@ static int stac9460_dac_mute_put(struct snd_kcontrol *kcontrol,
 	if (kcontrol->private_value) {
 		idx = STAC946X_MASTER_VOLUME;
 		old = stac9460_get(ice, idx);
-		new = (~ucontrol->value.integer.value[0]<< 7 & 0x80) |
-		       					(old & ~0x80);
+		new = (~ucontrol->value.integer.value[0] << 7 & 0x80) |
+							(old & ~0x80);
 		change = (new != old);
 		if (change) {
 			stac9460_put(ice, idx, new);
@@ -117,16 +117,16 @@ static int stac9460_dac_mute_put(struct snd_kcontrol *kcontrol,
 		idx = id + STAC946X_LF_VOLUME;
 		if (id < 6)
 			old = stac9460_get(ice, idx);
-		else 
+		else
 			old = stac9460_2_get(ice, idx - 6);
-		new = (~ucontrol->value.integer.value[0]<< 7 & 0x80) |
+		new = (~ucontrol->value.integer.value[0] << 7 & 0x80) |
 							(old & ~0x80);
 		change = (new != old);
 		if (change) {
 			if (id < 6)
-			       	stac9460_put(ice, idx, new);
+				stac9460_put(ice, idx, new);
 			else
-			       	stac9460_2_put(ice, idx - 6, new);
+				stac9460_2_put(ice, idx - 6, new);
 		}
 	}
 	return change;
@@ -136,7 +136,7 @@ static int stac9460_dac_mute_put(struct snd_kcontrol *kcontrol,
  * 	DAC volume attenuation mixer control
  */
 static int stac9460_dac_vol_info(struct snd_kcontrol *kcontrol,
-	       			struct snd_ctl_elem_info *uinfo)
+				struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
@@ -146,7 +146,7 @@ static int stac9460_dac_vol_info(struct snd_kcontrol *kcontrol,
 }
 
 static int stac9460_dac_vol_get(struct snd_kcontrol *kcontrol,
-	       			struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int idx, id;
@@ -161,14 +161,14 @@ static int stac9460_dac_vol_get(struct snd_kcontrol *kcontrol,
 	}
 	if (id < 6)
 		vol = stac9460_get(ice, idx) & 0x7f;
-	else 
+	else
 		vol = stac9460_2_get(ice, idx - 6) & 0x7f;
 	ucontrol->value.integer.value[0] = 0x7f - vol;
 	return 0;
 }
 
 static int stac9460_dac_vol_put(struct snd_kcontrol *kcontrol,
-	       			struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int idx, id;
@@ -182,8 +182,8 @@ static int stac9460_dac_vol_put(struct snd_kcontrol *kcontrol,
 		ovol = 0x7f - (tmp & 0x7f);
 		change = (ovol != nvol);
 		if (change) {
-			 stac9460_put(ice, idx, (0x7f - nvol) | (tmp & 0x80));
-			 stac9460_2_put(ice, idx, (0x7f - nvol) | (tmp & 0x80));
+			stac9460_put(ice, idx, (0x7f - nvol) | (tmp & 0x80));
+			stac9460_2_put(ice, idx, (0x7f - nvol) | (tmp & 0x80));
 		}
 	} else {
 		id = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
@@ -191,17 +191,17 @@ static int stac9460_dac_vol_put(struct snd_kcontrol *kcontrol,
 		nvol = ucontrol->value.integer.value[0] & 0x7f;
 		if (id < 6)
 			tmp = stac9460_get(ice, idx);
-		else 
+		else
 			tmp = stac9460_2_get(ice, idx - 6);
 		ovol = 0x7f - (tmp & 0x7f);
 		change = (ovol != nvol);
 		if (change) {
 			if (id < 6)
 				stac9460_put(ice, idx, (0x7f - nvol) |
-					       		(tmp & 0x80));
-			else 
+							(tmp & 0x80));
+			else
 				stac9460_2_put(ice, idx-6, (0x7f - nvol) |
-					       			(tmp & 0x80));
+							(tmp & 0x80));
 		}
 	}
 	return change;
@@ -213,12 +213,12 @@ static int stac9460_dac_vol_put(struct snd_kcontrol *kcontrol,
 #define stac9460_adc_mute_info		snd_ctl_boolean_stereo_info
 
 static int stac9460_adc_mute_get(struct snd_kcontrol *kcontrol,
-	       			struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char val;
 	int i, id;
-	
+
 	id = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	if (id == 0) {
 		for (i = 0; i < 2; ++i) {
@@ -235,20 +235,20 @@ static int stac9460_adc_mute_get(struct snd_kcontrol *kcontrol,
 }
 
 static int stac9460_adc_mute_put(struct snd_kcontrol *kcontrol,
-	       			struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char new, old;
 	int i, reg, id;
 	int change;
-	
+
 	id = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	if (id == 0) {
 		for (i = 0; i < 2; ++i) {
 			reg = STAC946X_MIC_L_VOLUME + i;
 			old = stac9460_get(ice, reg);
 			new = (~ucontrol->value.integer.value[i]<<7&0x80) |
-			       					(old&~0x80);
+								(old&~0x80);
 			change = (new != old);
 			if (change)
 				stac9460_put(ice, reg, new);
@@ -258,7 +258,7 @@ static int stac9460_adc_mute_put(struct snd_kcontrol *kcontrol,
 			reg = STAC946X_MIC_L_VOLUME + i;
 			old = stac9460_2_get(ice, reg);
 			new = (~ucontrol->value.integer.value[i]<<7&0x80) |
-			       					(old&~0x80);
+								(old&~0x80);
 			change = (new != old);
 			if (change)
 				stac9460_2_put(ice, reg, new);
@@ -271,7 +271,7 @@ static int stac9460_adc_mute_put(struct snd_kcontrol *kcontrol,
  *ADC gain mixer control
  */
 static int stac9460_adc_vol_info(struct snd_kcontrol *kcontrol,
-	       			struct snd_ctl_elem_info *uinfo)
+				struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
@@ -281,12 +281,12 @@ static int stac9460_adc_vol_info(struct snd_kcontrol *kcontrol,
 }
 
 static int stac9460_adc_vol_get(struct snd_kcontrol *kcontrol,
-	       			struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int i, reg, id;
 	unsigned char vol;
-	
+
 	id = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	if (id == 0) {
 		for (i = 0; i < 2; ++i) {
@@ -305,13 +305,13 @@ static int stac9460_adc_vol_get(struct snd_kcontrol *kcontrol,
 }
 
 static int stac9460_adc_vol_put(struct snd_kcontrol *kcontrol,
-	       		struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int i, reg, id;
 	unsigned char ovol, nvol;
 	int change;
-	
+
 	id = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	if (id == 0) {
 		for (i = 0; i < 2; ++i) {
@@ -321,7 +321,7 @@ static int stac9460_adc_vol_put(struct snd_kcontrol *kcontrol,
 			change = ((ovol & 0x0f) != nvol);
 			if (change)
 				stac9460_put(ice, reg, (0x0f - nvol) |
-					       		(ovol & ~0x0f));
+							(ovol & ~0x0f));
 		}
 	} else {
 		for (i = 0; i < 2; ++i) {
@@ -331,7 +331,7 @@ static int stac9460_adc_vol_put(struct snd_kcontrol *kcontrol,
 			change = ((ovol & 0x0f) != nvol);
 			if (change)
 				stac9460_2_put(ice, reg, (0x0f - nvol) |
-					       		(ovol & ~0x0f));
+							(ovol & ~0x0f));
 		}
 	}
 	return change;
@@ -344,23 +344,23 @@ static int stac9460_adc_vol_put(struct snd_kcontrol *kcontrol,
 #define stac9460_mic_sw_info		snd_ctl_boolean_mono_info
 
 static int stac9460_mic_sw_get(struct snd_kcontrol *kcontrol,
-	       		struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char val;
 	int id;
-		
+
 	id = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	if (id == 0)
-	       	val = stac9460_get(ice, STAC946X_GENERAL_PURPOSE);
+		val = stac9460_get(ice, STAC946X_GENERAL_PURPOSE);
 	else
-	       	val = stac9460_2_get(ice, STAC946X_GENERAL_PURPOSE);
+		val = stac9460_2_get(ice, STAC946X_GENERAL_PURPOSE);
 	ucontrol->value.integer.value[0] = ~val>>7 & 0x1;
 	return 0;
 }
 
 static int stac9460_mic_sw_put(struct snd_kcontrol *kcontrol,
-	       		struct snd_ctl_elem_value *ucontrol)
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char new, old;
@@ -368,16 +368,16 @@ static int stac9460_mic_sw_put(struct snd_kcontrol *kcontrol,
 
 	id = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	if (id == 0)
-	       	old = stac9460_get(ice, STAC946X_GENERAL_PURPOSE);
+		old = stac9460_get(ice, STAC946X_GENERAL_PURPOSE);
 	else
-	       	old = stac9460_2_get(ice, STAC946X_GENERAL_PURPOSE);
-	new = (~ucontrol->value.integer.value[0]<< 7 & 0x80) | (old & ~0x80);
+		old = stac9460_2_get(ice, STAC946X_GENERAL_PURPOSE);
+	new = (~ucontrol->value.integer.value[0] << 7 & 0x80) | (old & ~0x80);
 	change = (new != old);
 	if (change) {
 		if (id == 0)
-		       	stac9460_put(ice, STAC946X_GENERAL_PURPOSE, new);
+			stac9460_put(ice, STAC946X_GENERAL_PURPOSE, new);
 		else
-		       	stac9460_2_put(ice, STAC946X_GENERAL_PURPOSE, new);
+			stac9460_2_put(ice, STAC946X_GENERAL_PURPOSE, new);
 	}
 	return change;
 }
@@ -443,7 +443,7 @@ static struct snd_kcontrol_new stac9640_controls[] __devinitdata = {
 		.get = stac9460_adc_vol_get,
 		.put = stac9460_adc_vol_put,
 
-	}	
+	}
 };
 
 
@@ -470,7 +470,7 @@ static int __devinit wtm_init(struct snd_ice1712 *ice)
 		(unsigned short)-1
 	};
 	unsigned short *p;
-		
+
 	/*WTM 192M*/
 	ice->num_total_dacs = 8;
 	ice->num_total_adcs = 4;
diff --git a/sound/pci/ice1712/wtm.h b/sound/pci/ice1712/wtm.h
index 03a394e..423c1a2 100644
--- a/sound/pci/ice1712/wtm.h
+++ b/sound/pci/ice1712/wtm.h
@@ -10,8 +10,8 @@
  */
 
 #define	AK4114_ADDR		0x20	/*S/PDIF receiver*/
-#define STAC9460_I2C_ADDR	0x54	/* ADC*2 | DAC*6 */	
-#define STAC9460_2_I2C_ADDR	0x56	/* ADC|DAC *2 */	
+#define STAC9460_I2C_ADDR	0x54	/* ADC*2 | DAC*6 */
+#define STAC9460_2_I2C_ADDR	0x56	/* ADC|DAC *2 */
 
 
 extern struct snd_ice1712_card_info snd_vt1724_wtm_cards[];
