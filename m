From: Apostolos Dimitromanolakis <apostolos@aei.ca>
Subject: [Fwd: AudioTrak Prodigy 7.1 support - patch]
Date: Sun, 09 Nov 2003 21:50:36 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAEFCFC.9000606@aei.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040809010100050404010206"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040809010100050404010206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Well, this is the first version of the audiotrak prodigy 7.1 driver.

It is basically a copy of aureon.c with some fixes here and there and 
support for the hi-fi headphone amplifier of the prodigy. Communication 
with the DAC/ADC chip (wm8770) seems ok and is exactly the same as the 
Terratec Aureon.  Unfortunately, pretty much everything else does not 
work. This includes any capture and any digital input/output. Moreover 
clicks and pops occur when you try to change adc mux and other mixer 
fiddling. Any suggestions/ideas welcome.

  I will work more on it to see if I can get other things working. There 
are some io-traces I grabbed from windows with DriverStudio probably you 
can figure some stuff out of them, if anybody wants them. An updated 
version hopefully will be out soon.

PS. The patch is splitted into two files one for the alsa-driver tree 
and the other for the alsa-kernel. It is against 0.9.8 but applies to 
CVS too.

Cheers..






--------------040809010100050404010206
Content-Type: text/plain;
 name="prodigy-0.5.patch-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prodigy-0.5.patch-1"

diff --new-file -d -u --exclude '*.o' --exclude .depend -r alsa-driver-0.9.8.orig/pci/ice1712/prodigy.c alsa-driver-0.9.8/pci/ice1712/prodigy.c
--- alsa-driver-0.9.8.orig/pci/ice1712/prodigy.c	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver-0.9.8/pci/ice1712/prodigy.c	2003-11-06 23:12:13.000000000 -0500
@@ -0,0 +1,2 @@
+#define __NO_VERSION__
+#include "../../alsa-kernel/pci/ice1712/prodigy.c"


--------------040809010100050404010206
Content-Type: text/plain;
 name="prodigy-0.5.patch-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prodigy-0.5.patch-2"

diff --new-file -b -d -u --exclude '*.o' --exclude .depend -r alsa-driver-0.9.8.orig/alsa-kernel/pci/ice1712/ice1724.c alsa-driver-0.9.8/alsa-kernel/pci/ice1712/ice1724.c
--- alsa-driver-0.9.8.orig/alsa-kernel/pci/ice1712/ice1724.c	2003-09-10 14:01:16.000000000 -0400
+++ alsa-driver-0.9.8/alsa-kernel/pci/ice1712/ice1724.c	2003-11-06 23:35:18.000000000 -0500
@@ -43,6 +43,8 @@
 #include "amp.h"
 #include "revo.h"
 #include "aureon.h"
+#include "prodigy.h"
+
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("ICEnsemble ICE1724 (Envy24HT)");
@@ -52,6 +54,7 @@
 	       REVO_DEVICE_DESC
 	       AMP_AUDIO2000_DEVICE_DESC
 	       AUREON_DEVICE_DESC
+	       PRODIGY_DEVICE_DESC
 		"{VIA,VT1724},"
 		"{ICEnsemble,Generic ICE1724},"
 		"{ICEnsemble,Generic Envy24HT}}");
@@ -1576,6 +1579,7 @@
 	snd_vt1724_revo_cards,
 	snd_vt1724_amp_cards, 
 	snd_vt1724_aureon_cards,
+	snd_vt1724_prodigy_cards,
 	0,
 };
 
@@ -1610,6 +1614,9 @@
 				(snd_vt1724_read_i2c(ice, dev, 0x02) << 16) | 
 				(snd_vt1724_read_i2c(ice, dev, 0x03) << 24);
 
+
+	snd_printk("eeprom subvendor=%x\n",ice->eeprom.subvendor);
+
 	/* if the EEPROM is given by the driver, use it */
 	for (tbl = card_tables; *tbl; tbl++) {
 		for (c = *tbl; c->subvendor; c++) {
@@ -1627,6 +1634,8 @@
 
  found:
 	ice->eeprom.size = snd_vt1724_read_i2c(ice, dev, 0x04);
+
+
 	if (ice->eeprom.size < 6)
 		ice->eeprom.size = 32;
 	else if (ice->eeprom.size > 32) {
diff --new-file -b -d -u --exclude '*.o' --exclude .depend -r alsa-driver-0.9.8.orig/alsa-kernel/pci/ice1712/Makefile alsa-driver-0.9.8/alsa-kernel/pci/ice1712/Makefile
--- alsa-driver-0.9.8.orig/alsa-kernel/pci/ice1712/Makefile	2003-06-10 10:07:21.000000000 -0400
+++ alsa-driver-0.9.8/alsa-kernel/pci/ice1712/Makefile	2003-11-06 23:11:36.000000000 -0500
@@ -5,7 +5,7 @@
 
 snd-ice17xx-ak4xxx-objs := ak4xxx.o
 snd-ice1712-objs := ice1712.o delta.o hoontech.o ews.o
-snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o
+snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o prodigy.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o snd-ice17xx-ak4xxx.o
diff --new-file -b -d -u --exclude '*.o' --exclude .depend -r alsa-driver-0.9.8.orig/alsa-kernel/pci/ice1712/prodigy.c alsa-driver-0.9.8/alsa-kernel/pci/ice1712/prodigy.c
--- alsa-driver-0.9.8.orig/alsa-kernel/pci/ice1712/prodigy.c	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver-0.9.8/alsa-kernel/pci/ice1712/prodigy.c	2003-11-09 21:23:22.000000000 -0500
@@ -0,0 +1,545 @@
+/*
+ *   ALSA driver for ICEnsemble VT1724 (Envy24HT)
+ *
+ *   Lowlevel functions for AudioTrak Prodigy 7.1 (and possibly 192) cards
+ *      Copyright (c) 2003 Dimitromanolakis Apostolos <apostol@cs.utoronto.ca>
+ *	based on the aureon.c code (c) 2003 by Takashi Iwai <tiwai@suse.de>
+ *
+ *   version 0.5: Initial release:
+ *           working: analog output, mixer, headphone amplifier switch
+ *       not working: prety much everything else, at least i could verify that
+ *                    we have no digital output, no capture, pretty bad clicks and poops
+ *                    on mixer switch and other coll stuff.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ *
+ * NOTES:
+ *
+ *
+ *
+ * - we reuse the akm4xxx_t record for storing the wm8770 codec data.
+ *   both wm and akm codecs are pretty similar, so we can integrate
+ *   both controls in the future, once if wm codecs are reused in
+ *   many boards.
+ *
+ * - writing over SPI is implemented but reading is not yet.
+ *   the SPDIF-in channel status, etc. can be read from CS chip.
+ *
+ * - DAC digital volumes are not implemented in the mixer.
+ *   if they show better response than DAC analog volumes, we can use them
+ *   instead.
+ *
+ * - Prodigy boards are equipped with AC97 codec, too.  it's used to do
+ *   the analog mixing but not easily controllable (it's not connected
+ *   directly from envy24ht chip).  so let's leave it as it is.
+ *
+ */
+
+#include <sound/driver.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+
+#include "ice1712.h"
+#include "envy24ht.h"
+#include "prodigy.h"
+
+
+static void prodigy_set_headphone_amp(ice1712_t *ice, int enable)
+{
+	unsigned int tmp = snd_ice1712_gpio_read(ice);
+
+	tmp &= ~ PRODIGY_HP_AMP_EN;
+	if(enable)
+		tmp |= PRODIGY_HP_AMP_EN;
+	else
+		tmp &= ~ PRODIGY_HP_AMP_EN;
+
+
+	snd_ice1712_gpio_write(ice, tmp);
+}
+
+
+static int prodigy_get_headphone_amp(ice1712_t *ice)
+{
+	unsigned int tmp = snd_ice1712_gpio_read(ice);
+
+	return ( tmp & PRODIGY_HP_AMP_EN )!= 0;
+}
+
+
+/*
+ * write data in the SPI mode
+ */
+static void prodigy_spi_write(ice1712_t *ice, unsigned int cs, unsigned int data, int bits)
+{
+	unsigned int tmp;
+	int i;
+
+	tmp = snd_ice1712_gpio_read(ice);
+
+	snd_ice1712_gpio_set_mask(ice, ~(PRODIGY_WM_RW|PRODIGY_WM_DATA|PRODIGY_WM_CLK|
+					 PRODIGY_WM_CS|PRODIGY_CS8415_CS|PRODIGY_HP_AMP_EN));
+	tmp |= PRODIGY_WM_RW;
+	tmp &= ~cs;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+
+	for (i = bits - 1; i >= 0; i--) {
+		tmp &= ~PRODIGY_WM_CLK;
+		snd_ice1712_gpio_write(ice, tmp);
+		udelay(1);
+		if (data & (1 << i))
+			tmp |= PRODIGY_WM_DATA;
+		else
+			tmp &= ~PRODIGY_WM_DATA;
+		snd_ice1712_gpio_write(ice, tmp);
+		udelay(1);
+		tmp |= PRODIGY_WM_CLK;
+		snd_ice1712_gpio_write(ice, tmp);
+		udelay(1);
+	}
+
+	tmp &= ~PRODIGY_WM_CLK;
+	tmp |= cs;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+	tmp |= PRODIGY_WM_CLK;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+}
+
+
+/*
+ * get the current register value of WM codec
+ */
+static unsigned short wm_get(ice1712_t *ice, int reg)
+{
+	reg <<= 1;
+	return ((unsigned short)ice->akm[0].images[reg] << 8) |
+		ice->akm[0].images[reg + 1];
+}
+
+/*
+ * set the register value of WM codec and remember it
+ */
+static void wm_put(ice1712_t *ice, int reg, unsigned short val)
+{
+	prodigy_spi_write(ice, PRODIGY_WM_CS, (reg << 9) | (val & 0x1ff), 16);
+	reg <<= 1;
+	ice->akm[0].images[reg] = val >> 8;
+	ice->akm[0].images[reg + 1] = val;
+}
+
+
+/*********************************
+ ********* Controls section ******
+ *********************************/
+
+#define PRODIGY_CON_HPAMP \
+        {                                            \
+                .iface = SNDRV_CTL_ELEM_IFACE_MIXER,      \
+                .name =  "Headphone Amplifier", \
+                .info =  prodigy_hpamp_info,         \
+                .get =   prodigy_hpamp_get, \
+                .put =   prodigy_hpamp_put  \
+        }
+
+static int prodigy_hpamp_info(snd_kcontrol_t *k, snd_ctl_elem_info_t *uinfo)
+{
+        uinfo->type= SNDRV_CTL_ELEM_TYPE_INTEGER;
+
+	static char *texts[2] = {
+		"Off", "On"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+
+        return 0;
+}
+
+
+static int prodigy_hpamp_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = prodigy_get_headphone_amp(ice);
+	return 0;
+}
+
+
+static int prodigy_hpamp_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+
+	/*snd_printk("Prodigy set headphone amplifier: %d\n",ucontrol->value.integer.value[0]);*/
+	prodigy_set_headphone_amp(ice,ucontrol->value.integer.value[0]);
+	return 1;
+}
+
+
+/*
+ * DAC volume attenuation mixer control
+ */
+static int wm_dac_vol_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;		/* mute */
+	uinfo->value.integer.max = 101;		/* 0dB */
+	return 0;
+}
+
+static int wm_dac_vol_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int idx;
+	unsigned short vol;
+
+	down(&ice->gpio_mutex);
+	if (kcontrol->private_value)
+		idx = WM_DAC_MASTER_ATTEN;
+	else
+		idx  = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) + WM_DAC_ATTEN;
+	vol = wm_get(ice, idx) & 0x7f;
+	if (vol <= 0x1a)
+		ucontrol->value.integer.value[0] = 0;
+	else
+		ucontrol->value.integer.value[0] = vol - 0x1a;
+	up(&ice->gpio_mutex);
+
+	return 0;
+}
+
+static int wm_dac_vol_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int idx;
+	unsigned short ovol, nvol;
+	int change;
+
+	snd_ice1712_save_gpio_status(ice);
+	if (kcontrol->private_value)
+		idx = WM_DAC_MASTER_ATTEN;
+	else
+		idx  = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) + WM_DAC_ATTEN;
+	nvol = ucontrol->value.integer.value[0] + 0x1a;
+	ovol = wm_get(ice, idx) & 0x7f;
+	change = (ovol != nvol);
+	if (change) {
+		if (nvol <= 0x1a && ovol <= 0x1a)
+			change = 0;
+		else
+			wm_put(ice, idx, nvol | 0x100);
+	}
+	snd_ice1712_restore_gpio_status(ice);
+	return change;
+}
+
+/*
+ * ADC gain mixer control
+ */
+static int wm_adc_vol_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;		/* -12dB */
+	uinfo->value.integer.max = 0x1f;	/* 19dB */
+	return 0;
+}
+
+static int wm_adc_vol_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int idx;
+	unsigned short vol;
+
+	down(&ice->gpio_mutex);
+	idx  = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) + WM_ADC_GAIN;
+	vol = wm_get(ice, idx) & 0x1f;
+	ucontrol->value.integer.value[0] = vol;
+	up(&ice->gpio_mutex);
+	return 0;
+}
+
+static int wm_adc_vol_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int idx;
+	unsigned short ovol, nvol;
+	int change;
+
+	snd_ice1712_save_gpio_status(ice);
+	idx  = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) + WM_ADC_GAIN;
+	nvol = ucontrol->value.integer.value[0];
+	ovol = wm_get(ice, idx) & 0x1f;
+	change = (ovol != nvol);
+	if (change)
+		wm_put(ice, idx, nvol);
+	snd_ice1712_restore_gpio_status(ice);
+	return change;
+}
+
+/*
+ * ADC input mux mixer control
+ */
+static int wm_adc_mux_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	static char *texts[] = {
+		"CD Left",
+		"CD Right",
+		"Aux Left",
+		"Aux Right",
+		"Line Left",
+		"Line Right",
+		"Mic Left",
+		"Mic Right",
+	};
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 2;
+	uinfo->value.enumerated.items = 8;
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int wm_adc_mux_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	down(&ice->gpio_mutex);
+	val = wm_get(ice, WM_ADC_MUX);
+	ucontrol->value.integer.value[0] = val & 7;
+	ucontrol->value.integer.value[1] = (val >> 4) & 7;
+	up(&ice->gpio_mutex);
+	return 0;
+}
+
+static int wm_adc_mux_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	unsigned short oval, nval;
+	int change;
+
+	snd_ice1712_save_gpio_status(ice);
+	oval = wm_get(ice, WM_ADC_MUX);
+	nval = oval & ~0x77;
+	nval |= ucontrol->value.integer.value[0] & 7;
+	nval |= (ucontrol->value.integer.value[1] & 7) << 4;
+	change = (oval != nval);
+	if (change)
+		wm_put(ice, WM_ADC_MUX, nval);
+	snd_ice1712_restore_gpio_status(ice);
+	return 0;
+}
+
+/*
+ * mixers
+ */
+
+static snd_kcontrol_new_t prodigy71_dac_control __devinitdata = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "DAC Volume",
+	.count = 8,
+	.info = wm_dac_vol_info,
+	.get = wm_dac_vol_get,
+	.put = wm_dac_vol_put,
+};
+
+static snd_kcontrol_new_t wm_controls[] __devinitdata = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Volume",
+		.info = wm_dac_vol_info,
+		.get = wm_dac_vol_get,
+		.put = wm_dac_vol_put,
+		.private_value = 1,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "ADC Volume",
+		.count = 2,
+		.info = wm_adc_vol_info,
+		.get = wm_adc_vol_get,
+		.put = wm_adc_vol_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Route",
+		.info = wm_adc_mux_info,
+		.get = wm_adc_mux_get,
+		.put = wm_adc_mux_put,
+	},
+PRODIGY_CON_HPAMP
+
+};
+
+
+static int __devinit prodigy_add_controls(ice1712_t *ice)
+{
+	unsigned int i;
+	int err;
+
+	// if (ice->eeprom.subvendor == VT1724_SUBDEVICE_PRODIGY71)
+
+	err = snd_ctl_add(ice->card, snd_ctl_new1(&prodigy71_dac_control, ice));
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < ARRAY_SIZE(wm_controls); i++) {
+		err = snd_ctl_add(ice->card, snd_ctl_new1(&wm_controls[i], ice));
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+
+/*
+ * initialize the chip
+ */
+static int __devinit prodigy_init(ice1712_t *ice)
+{
+	static unsigned short wm_inits[] = {
+		0x16, 0x122,		/* I2S, normal polarity, 24bit */
+		0x17, 0x022,		/* 256fs, slave mode */
+		0x18, 0x000,		/* All power-up */
+		0x00, 0,		/* DAC1 analog mute */
+		0x01, 0,		/* DAC2 analog mute */
+		0x02, 0,		/* DAC3 analog mute */
+		0x03, 0,		/* DAC4 analog mute */
+		0x04, 0,		/* DAC5 analog mute */
+		0x05, 0,		/* DAC6 analog mute */
+		0x06, 0,		/* DAC7 analog mute */
+		0x07, 0,		/* DAC8 analog mute */
+		0x08, 0x100,		/* master analog mute */
+		0x09, 0xff,		/* DAC1 digital full */
+		0x0a, 0xff,		/* DAC2 digital full */
+		0x0b, 0xff,		/* DAC3 digital full */
+		0x0c, 0xff,		/* DAC4 digital full */
+		0x0d, 0xff,		/* DAC5 digital full */
+		0x0e, 0xff,		/* DAC6 digital full */
+		0x0f, 0xff,		/* DAC7 digital full */
+		0x10, 0xff,		/* DAC8 digital full */
+		0x11, 0x1ff,		/* master digital full */
+		0x12, 0x000,		/* phase normal */
+		0x13, 0x090,		/* unmute DAC L/R */
+		0x14, 0x000,		/* all unmute */
+		0x15, 0x000,		/* no deemphasis, no ZFLG */
+		0x19, 0x000,		/* -12dB ADC/L */
+		0x1a, 0x000,		/* -12dB ADC/R */
+		0x1b, 0x000,		/* ADC Mux */
+		0x1c, 0x009,		/* Out Mux1 */
+		0x1d, 0x009,		/* Out Mux2 */
+	};
+	static unsigned short cs_inits[] = {
+		0x0441, /* RUN */
+		0x0100, /* no mute */
+		0x0200, /* */
+		0x0600, /* slave, 24bit */
+	};
+	unsigned int tmp;
+	unsigned int i;
+
+	ice->num_total_dacs = 8;
+
+	/* to remeber the register values */
+	ice->akm = snd_kcalloc(sizeof(akm4xxx_t), GFP_KERNEL);
+	if (! ice->akm)
+		return -ENOMEM;
+	ice->akm_codecs = 1;
+
+	snd_ice1712_gpio_set_dir(ice, 0xbfffff); /* fix this for the time being */
+
+	/* reset the wm codec as the SPI mode */
+	snd_ice1712_save_gpio_status(ice);
+	snd_ice1712_gpio_set_mask(ice,~( PRODIGY_WM_RESET|PRODIGY_WM_CS|
+		PRODIGY_CS8415_CS|PRODIGY_HP_AMP_EN ));
+
+	tmp = snd_ice1712_gpio_read(ice);
+	tmp &= ~PRODIGY_WM_RESET;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+	tmp |= PRODIGY_WM_CS | PRODIGY_CS8415_CS;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+	tmp |= PRODIGY_WM_RESET;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+
+	/* initialize WM8770 codec */
+	for (i = 0; i < ARRAY_SIZE(wm_inits); i += 2)
+		wm_put(ice, wm_inits[i], wm_inits[i+1]);
+
+	/* initialize CS8415A codec */
+	for (i = 0; i < ARRAY_SIZE(cs_inits); i++)
+		prodigy_spi_write(ice, PRODIGY_CS8415_CS,
+				 cs_inits[i] | 0x200000, 24);
+
+
+	prodigy_set_headphone_amp(ice, 1);
+
+	snd_ice1712_restore_gpio_status(ice);
+
+	return 0;
+}
+
+
+/*
+ * Prodigy boards don't provide the EEPROM data except for the vendor IDs.
+ * hence the driver needs to sets up it properly.
+ */
+
+static unsigned char prodigy71_eeprom[] __devinitdata = {
+	0x13,	/* SYSCONF: clock 512, mpu401, spdif-in/ADC, 4DACs */
+	0x80,	/* ACLINK: I2S */
+	0xf8,	/* I2S: vol, 96k, 24bit, 192k */
+	0xc3,	/* SPDIF: out-en, out-int, spdif-in */
+	0xff,	/* GPIO_DIR */
+	0xff,	/* GPIO_DIR1 */
+	0xbf,	/* GPIO_DIR2 */
+	0x00,	/* GPIO_MASK */
+	0x00,	/* GPIO_MASK1 */
+	0x00,	/* GPIO_MASK2 */
+	0x00,	/* GPIO_STATE */
+	0x00,	/* GPIO_STATE1 */
+	0x00,	/* GPIO_STATE2 */
+};
+
+/* entry point */
+struct snd_ice1712_card_info snd_vt1724_prodigy_cards[] __devinitdata = {
+	{
+		.subvendor = VT1724_SUBDEVICE_PRODIGY71,
+		.name = "Audiotrak Prodigy 7.1",
+		.chip_init = prodigy_init,
+		.build_controls = prodigy_add_controls,
+		.eeprom_size = sizeof(prodigy71_eeprom),
+		.eeprom_data = prodigy71_eeprom,
+	},
+	{ } /* terminator */
+};
diff --new-file -b -d -u --exclude '*.o' --exclude .depend -r alsa-driver-0.9.8.orig/alsa-kernel/pci/ice1712/prodigy.h alsa-driver-0.9.8/alsa-kernel/pci/ice1712/prodigy.h
--- alsa-driver-0.9.8.orig/alsa-kernel/pci/ice1712/prodigy.h	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver-0.9.8/alsa-kernel/pci/ice1712/prodigy.h	2003-11-09 20:52:45.000000000 -0500
@@ -0,0 +1,67 @@
+#ifndef __SOUND_PRODIGY_H
+#define __SOUND_PRODIGY_H
+
+/*
+ *   ALSA driver for VIA VT1724 (Envy24HT)
+ *
+ *   Lowlevel functions for Terratec PRODIGY cards
+ *
+ *	Copyright (c) 2003 Takashi Iwai <tiwai@suse.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */      
+
+#define  PRODIGY_DEVICE_DESC 	       "{AudioTrak,Prodigy 7.1},"
+
+#define VT1724_SUBDEVICE_PRODIGY71	0x33495345	/* PRODIGY 7.1 */
+
+extern struct snd_ice1712_card_info  snd_vt1724_prodigy_cards[];
+
+/* GPIO bits */
+#define PRODIGY_CS8415_CS	(1 << 23)
+#define PRODIGY_CS8415_CDTO	(1 << 22)
+#define PRODIGY_WM_RESET	(1 << 20)
+#define PRODIGY_WM_CLK		(1 << 19)
+#define PRODIGY_WM_DATA		(1 << 18)
+#define PRODIGY_WM_RW		(1 << 17)
+#define PRODIGY_AC97_RESET	(1 << 16)
+#define PRODIGY_DIGITAL_SEL1	(1 << 15)
+// #define PRODIGY_HP_SEL		(1 << 14)
+#define PRODIGY_WM_CS		(1 << 12)
+
+#define PRODIGY_HP_AMP_EN	(1 << 14)
+
+
+/* WM8770 registers */
+#define WM_DAC_ATTEN		0x00	/* DAC1-8 analog attenuation */
+#define WM_DAC_MASTER_ATTEN	0x08	/* DAC master analog attenuation */
+#define WM_DAC_DIG_ATTEN	0x09	/* DAC1-8 digital attenuation */
+#define WM_DAC_DIG_MATER_ATTEN	0x11	/* DAC master digital attenuation */
+#define WM_PHASE_SWAP		0x12	/* DAC phase */
+#define WM_DAC_CTRL1		0x13	/* DAC control bits */
+#define WM_MUTE			0x14	/* mute controls */
+#define WM_DAC_CTRL2		0x15	/* de-emphasis and zefo-flag */
+#define WM_INT_CTRL		0x16	/* interface control */
+#define WM_MASTER		0x17	/* master clock and mode */
+#define WM_POWERDOWN		0x18	/* power-down controls */
+#define WM_ADC_GAIN		0x19	/* ADC gain L(19)/R(1a) */
+#define WM_ADC_MUX		0x1b	/* input MUX */
+#define WM_OUT_MUX1		0x1c	/* output MUX */
+#define WM_OUT_MUX2		0x1e	/* output MUX */
+#define WM_RESET		0x1f	/* software reset */
+
+
+#endif /* __SOUND_PRODIGY_H */


--------------040809010100050404010206--



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
