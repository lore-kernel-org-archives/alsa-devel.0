From: Simone Zinanni <simone@develer.com>
Subject: [PATCH] Terratec Phase 28
Date: Sun, 10 Apr 2005 00:51:48 +0200
Message-ID: <200504100051.48331.simone@develer.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from develer.com (adsl-110-19.38-151.net24.it [151.38.19.110])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 6F5E6236
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2005 00:51:50 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Summary: Provides preliminary support for the Terratec Phase 28 card.

Not extensively tested and probably buggy, but it seems to work.


Signed-off-by: Simone Zinanni <simone@develer.com>


Index: alsa-kernel/pci/ice1712/ice1712.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/ice1712.h,v
retrieving revision 1.30
diff -u -r1.30 ice1712.h
--- alsa-kernel/pci/ice1712/ice1712.h	8 Mar 2005 15:42:41 -0000	1.30
+++ alsa-kernel/pci/ice1712/ice1712.h	9 Apr 2005 22:29:37 -0000
@@ -373,6 +373,11 @@
 			unsigned short master[2];
 			unsigned short vol[8];
 		} aureon;
+		/* AC97 register cache for Phase28 */
+		struct phase28_spec {
+			unsigned short master[2];
+			unsigned short vol[8];
+		} phase28;
 		/* Hoontech-specific setting */
 		struct hoontech_spec {
 			unsigned char boxbits[4];
Index: alsa-kernel/pci/ice1712/phase.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/phase.c,v
retrieving revision 1.1
diff -u -r1.1 phase.c
--- alsa-kernel/pci/ice1712/phase.c	9 Feb 2005 10:47:51 -0000	1.1
+++ alsa-kernel/pci/ice1712/phase.c	9 Apr 2005 22:29:39 -0000
@@ -45,6 +45,47 @@
 #include "envy24ht.h"
 #include "phase.h"
 
+/* WM8770 registers */
+#define WM_DAC_ATTEN		0x00	/* DAC1-8 analog attenuation */
+#define WM_DAC_MASTER_ATTEN	0x08	/* DAC master analog attenuation */
+#define WM_DAC_DIG_ATTEN	0x09	/* DAC1-8 digital attenuation */
+#define WM_DAC_DIG_MASTER_ATTEN	0x11	/* DAC master digital attenuation */
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
+/*
+ * Logarithmic volume values for WM8770
+ * Computed as 20 * Log10(255 / x)
+ */
+static unsigned char wm_vol[256] = {
+	127, 48, 42, 39, 36, 34, 33, 31, 30, 29, 28, 27, 27, 26, 25, 25, 24, 24, 23,
+	23, 22, 22, 21, 21, 21, 20, 20, 20, 19, 19, 19, 18, 18, 18, 18, 17, 17, 17,
+	17, 16, 16, 16, 16, 15, 15, 15, 15, 15, 15, 14, 14, 14, 14, 14, 13, 13, 13,
+	13, 13, 13, 13, 12, 12, 12, 12, 12, 12, 12, 11, 11, 11, 11, 11, 11, 11, 11,
+	11, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 8, 8,
+	8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 6, 6, 6,
+	6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
+	5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3,
+	3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
+	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
+	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0
+};
+
+#define WM_VOL_MAX	(sizeof(wm_vol) - 1)
+#define WM_VOL_MUTE	0x8000
+
 static akm4xxx_t akm_phase22 __devinitdata = {
 	.type = SND_AK4524,
 	.num_dacs = 2,
@@ -124,6 +165,684 @@
 	0x00,	/* GPIO_STATE2 */
 };
 
+static unsigned char phase28_eeprom[] __devinitdata = {
+	0x0b,	/* SYSCONF: clock 512, spdif-in/ADC, 4DACs */
+	0x80,	/* ACLINK: I2S */
+	0xfc,	/* I2S: vol, 96k, 24bit, 192k */
+	0xc3,	/* SPDIF: out-en, out-int, spdif-in */
+	0xff,	/* GPIO_DIR */
+	0xff,	/* GPIO_DIR1 */
+	0x5f,	/* GPIO_DIR2 */
+	0x00,	/* GPIO_MASK */
+	0x00,	/* GPIO_MASK1 */
+	0x00,	/* GPIO_MASK2 */
+	0x00,	/* GPIO_STATE */
+	0x00,	/* GPIO_STATE1 */
+	0x00,	/* GPIO_STATE2 */
+};
+
+/*
+ * write data in the SPI mode
+ */
+static void phase28_spi_write(ice1712_t *ice, unsigned int cs, unsigned int data, int bits)
+{
+	unsigned int tmp;
+	int i;
+
+	tmp = snd_ice1712_gpio_read(ice);
+
+	snd_ice1712_gpio_set_mask(ice, ~(PHASE28_WM_RW|PHASE28_SPI_MOSI|PHASE28_SPI_CLK|
+					 PHASE28_WM_CS));
+	tmp |= PHASE28_WM_RW;
+	tmp &= ~cs;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+
+	for (i = bits - 1; i >= 0; i--) {
+		tmp &= ~PHASE28_SPI_CLK;
+		snd_ice1712_gpio_write(ice, tmp);
+		udelay(1);
+		if (data & (1 << i))
+			tmp |= PHASE28_SPI_MOSI;
+		else
+			tmp &= ~PHASE28_SPI_MOSI;
+		snd_ice1712_gpio_write(ice, tmp);
+		udelay(1);
+		tmp |= PHASE28_SPI_CLK;
+		snd_ice1712_gpio_write(ice, tmp);
+		udelay(1);
+	}
+
+	tmp &= ~PHASE28_SPI_CLK;
+	tmp |= cs;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+	tmp |= PHASE28_SPI_CLK;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+}
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
+ * set the register value of WM codec
+ */
+static void wm_put_nocache(ice1712_t *ice, int reg, unsigned short val)
+{
+	phase28_spi_write(ice, PHASE28_WM_CS, (reg << 9) | (val & 0x1ff), 16);
+}
+
+/*
+ * set the register value of WM codec and remember it
+ */
+static void wm_put(ice1712_t *ice, int reg, unsigned short val)
+{
+	wm_put_nocache(ice, reg, val);
+	reg <<= 1;
+	ice->akm[0].images[reg] = val >> 8;
+	ice->akm[0].images[reg + 1] = val;
+}
+
+static void wm_set_vol(ice1712_t *ice, unsigned int index, unsigned short vol, unsigned short master)
+{
+	unsigned char nvol;
+
+	if ((master & WM_VOL_MUTE) || (vol & WM_VOL_MUTE))
+		nvol = 0;
+	else
+		nvol = 127 - wm_vol[(((vol & ~WM_VOL_MUTE) * (master & ~WM_VOL_MUTE)) / 127) & WM_VOL_MAX];
+
+	wm_put(ice, index, nvol);
+	wm_put_nocache(ice, index, 0x180 | nvol);
+}
+
+/*
+ * DAC mute control
+ */
+#define wm_pcm_mute_info	phase28_mono_bool_info
+
+static int wm_pcm_mute_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+
+	down(&ice->gpio_mutex);
+	ucontrol->value.integer.value[0] = (wm_get(ice, WM_MUTE) & 0x10) ? 0 : 1;
+	up(&ice->gpio_mutex);
+	return 0;
+}
+
+static int wm_pcm_mute_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	unsigned short nval, oval;
+	int change;
+
+	snd_ice1712_save_gpio_status(ice);
+	oval = wm_get(ice, WM_MUTE);
+	nval = (oval & ~0x10) | (ucontrol->value.integer.value[0] ? 0 : 0x10);
+	if ((change = (nval != oval)))
+		wm_put(ice, WM_MUTE, nval);
+	snd_ice1712_restore_gpio_status(ice);
+
+	return change;
+}
+
+/*
+ * Master volume attenuation mixer control
+ */
+static int wm_master_vol_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = WM_VOL_MAX;
+	return 0;
+}
+
+static int wm_master_vol_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int i;
+	for (i=0; i<2; i++)
+		ucontrol->value.integer.value[i] = ice->spec.phase28.master[i] & ~WM_VOL_MUTE;
+	return 0;
+}
+
+static int wm_master_vol_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int ch, change = 0;
+
+	snd_ice1712_save_gpio_status(ice);
+	for (ch = 0; ch < 2; ch++) {
+		if (ucontrol->value.integer.value[ch] != ice->spec.phase28.master[ch]) {
+			int dac;
+			ice->spec.phase28.master[ch] &= WM_VOL_MUTE;
+			ice->spec.phase28.master[ch] |= ucontrol->value.integer.value[ch];
+			for (dac = 0; dac < ice->num_total_dacs; dac += 2)
+				wm_set_vol(ice, WM_DAC_ATTEN + dac + ch,
+					   ice->spec.phase28.vol[dac + ch],
+					   ice->spec.phase28.master[ch]);
+			change = 1;
+		}
+	}
+	snd_ice1712_restore_gpio_status(ice);
+	return change;
+}
+
+static int __devinit phase28_init(ice1712_t *ice)
+{
+	static unsigned short wm_inits_phase28[] = {
+		/* These come first to reduce init pop noise */
+		0x1b, 0x044,		/* ADC Mux (AC'97 source) */
+		0x1c, 0x00B,		/* Out Mux1 (VOUT1 = DAC+AUX, VOUT2 = DAC) */
+		0x1d, 0x009,		/* Out Mux2 (VOUT2 = DAC, VOUT3 = DAC) */
+
+		0x18, 0x000,		/* All power-up */
+
+		0x16, 0x122,		/* I2S, normal polarity, 24bit */
+		0x17, 0x022,		/* 256fs, slave mode */
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
+		(unsigned short)-1
+	};
+
+	unsigned int tmp;
+	akm4xxx_t *ak;
+	unsigned short *p;
+	int i;
+
+	ice->num_total_dacs = 8;
+	ice->num_total_adcs = 2;
+
+	// Initialize analog chips
+	ak = ice->akm = kcalloc(1, sizeof(akm4xxx_t), GFP_KERNEL);
+	if (!ak)
+		return -ENOMEM;
+	ice->akm_codecs = 1;
+
+	snd_ice1712_gpio_set_dir(ice, 0x5fffff); /* fix this for the time being */
+
+	/* reset the wm codec as the SPI mode */
+	snd_ice1712_save_gpio_status(ice);
+	snd_ice1712_gpio_set_mask(ice, ~(PHASE28_WM_RESET|PHASE28_WM_CS|PHASE28_HP_SEL));
+
+	tmp = snd_ice1712_gpio_read(ice);
+	tmp &= ~PHASE28_WM_RESET;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+	tmp |= PHASE28_WM_CS;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+	tmp |= PHASE28_WM_RESET;
+	snd_ice1712_gpio_write(ice, tmp);
+	udelay(1);
+
+	p = wm_inits_phase28;
+	for (; *p != (unsigned short)-1; p += 2)
+		wm_put(ice, p[0], p[1]);
+
+	snd_ice1712_restore_gpio_status(ice);
+
+	ice->spec.phase28.master[0] = WM_VOL_MUTE;
+	ice->spec.phase28.master[1] = WM_VOL_MUTE;
+	for (i = 0; i < ice->num_total_dacs; i++) {
+		ice->spec.phase28.vol[i] = WM_VOL_MUTE;
+		wm_set_vol(ice, i, ice->spec.phase28.vol[i], ice->spec.phase28.master[i % 2]);
+	}
+
+	return 0;
+}
+
+/*
+ * DAC volume attenuation mixer control
+ */
+static int wm_vol_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	int voices = kcontrol->private_value >> 8;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = voices;
+	uinfo->value.integer.min = 0;		/* mute (-101dB) */
+	uinfo->value.integer.max = 0x7F;	/* 0dB */
+	return 0;
+}
+
+static int wm_vol_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int i, ofs, voices;
+
+	voices = kcontrol->private_value >> 8;
+	ofs = kcontrol->private_value & 0xff;
+	for (i = 0; i < voices; i++)
+		ucontrol->value.integer.value[i] = ice->spec.phase28.vol[ofs+i] & ~WM_VOL_MUTE;
+	return 0;
+}
+
+static int wm_vol_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int i, idx, ofs, voices;
+	int change = 0;
+
+	voices = kcontrol->private_value >> 8;
+	ofs = kcontrol->private_value & 0xff;
+	snd_ice1712_save_gpio_status(ice);
+	for (i = 0; i < voices; i++) {
+		idx  = WM_DAC_ATTEN + ofs + i;
+		if (ucontrol->value.integer.value[i] != ice->spec.phase28.vol[ofs+i]) {
+			ice->spec.phase28.vol[ofs+i] &= WM_VOL_MUTE;
+			ice->spec.phase28.vol[ofs+i] |= ucontrol->value.integer.value[i];
+			wm_set_vol(ice, idx, ice->spec.phase28.vol[ofs+i],
+				   ice->spec.phase28.master[i]);
+			change = 1;
+		}
+	}
+	snd_ice1712_restore_gpio_status(ice);
+	return change;
+}
+
+/*
+ * WM8770 mute control
+ */
+static int wm_mute_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) {
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = kcontrol->private_value >> 8;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int wm_mute_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int voices, ofs, i;
+
+	voices = kcontrol->private_value >> 8;
+	ofs = kcontrol->private_value & 0xFF;
+
+	for (i = 0; i < voices; i++)
+		ucontrol->value.integer.value[i] = (ice->spec.phase28.vol[ofs+i] & WM_VOL_MUTE) ? 0 : 1;
+	return 0;
+}
+
+static int wm_mute_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int change = 0, voices, ofs, i;
+
+	voices = kcontrol->private_value >> 8;
+	ofs = kcontrol->private_value & 0xFF;
+
+	snd_ice1712_save_gpio_status(ice);
+	for (i = 0; i < voices; i++) {
+		int val = (ice->spec.phase28.vol[ofs + i] & WM_VOL_MUTE) ? 0 : 1;
+		if (ucontrol->value.integer.value[i] != val) {
+			ice->spec.phase28.vol[ofs + i] &= ~WM_VOL_MUTE;
+			ice->spec.phase28.vol[ofs + i] |=
+				ucontrol->value.integer.value[i] ? 0 : WM_VOL_MUTE;
+			wm_set_vol(ice, ofs + i, ice->spec.phase28.vol[ofs + i],
+				   ice->spec.phase28.master[i]);
+			change = 1;
+		}
+	}
+	snd_ice1712_restore_gpio_status(ice);
+
+	return change;
+}
+
+/*
+ * WM8770 master mute control
+ */
+static int wm_master_mute_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo) {
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int wm_master_mute_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = (ice->spec.phase28.master[0] & WM_VOL_MUTE) ? 0 : 1;
+	ucontrol->value.integer.value[1] = (ice->spec.phase28.master[1] & WM_VOL_MUTE) ? 0 : 1;
+	return 0;
+}
+
+static int wm_master_mute_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int change = 0, i;
+
+	snd_ice1712_save_gpio_status(ice);
+	for (i = 0; i < 2; i++) {
+		int val = (ice->spec.phase28.master[i] & WM_VOL_MUTE) ? 0 : 1;
+		if (ucontrol->value.integer.value[i] != val) {
+			int dac;
+			ice->spec.phase28.master[i] &= ~WM_VOL_MUTE;
+			ice->spec.phase28.master[i] |=
+				ucontrol->value.integer.value[i] ? 0 : WM_VOL_MUTE;
+			for (dac = 0; dac < ice->num_total_dacs; dac += 2)
+				wm_set_vol(ice, WM_DAC_ATTEN + dac + i,
+					   ice->spec.phase28.vol[dac + i],
+					   ice->spec.phase28.master[i]);
+			change = 1;
+		}
+	}
+	snd_ice1712_restore_gpio_status(ice);
+
+	return change;
+}
+
+/* digital master volume */
+#define PCM_0dB 0xff
+#define PCM_RES 128	/* -64dB */
+#define PCM_MIN (PCM_0dB - PCM_RES)
+static int wm_pcm_vol_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;		/* mute (-64dB) */
+	uinfo->value.integer.max = PCM_RES;	/* 0dB */
+	return 0;
+}
+
+static int wm_pcm_vol_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	down(&ice->gpio_mutex);
+	val = wm_get(ice, WM_DAC_DIG_MASTER_ATTEN) & 0xff;
+	val = val > PCM_MIN ? (val - PCM_MIN) : 0;
+	ucontrol->value.integer.value[0] = val;
+	up(&ice->gpio_mutex);
+	return 0;
+}
+
+static int wm_pcm_vol_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	unsigned short ovol, nvol;
+	int change = 0;
+
+	snd_ice1712_save_gpio_status(ice);
+	nvol = ucontrol->value.integer.value[0];
+	nvol = (nvol ? (nvol + PCM_MIN) : 0) & 0xff;
+	ovol = wm_get(ice, WM_DAC_DIG_MASTER_ATTEN) & 0xff;
+	if (ovol != nvol) {
+		wm_put(ice, WM_DAC_DIG_MASTER_ATTEN, nvol); /* prelatch */
+		wm_put_nocache(ice, WM_DAC_DIG_MASTER_ATTEN, nvol | 0x100); /* update */
+		change = 1;
+	}
+	snd_ice1712_restore_gpio_status(ice);
+	return change;
+}
+
+/*
+ */
+static int phase28_mono_bool_info(snd_kcontrol_t *k, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+/*
+ * Deemphasis
+ */
+#define phase28_deemp_info	phase28_mono_bool_info
+
+static int phase28_deemp_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.integer.value[0] = (wm_get(ice, WM_DAC_CTRL2) & 0xf) == 0xf;
+	return 0;
+}
+
+static int phase28_deemp_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	int temp, temp2;
+	temp2 = temp = wm_get(ice, WM_DAC_CTRL2);
+	if (ucontrol->value.integer.value[0])
+		temp |= 0xf;
+	else
+		temp &= ~0xf;
+	if (temp != temp2) {
+		wm_put(ice, WM_DAC_CTRL2, temp);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * ADC Oversampling
+ */
+static int phase28_oversampling_info(snd_kcontrol_t *k, snd_ctl_elem_info_t *uinfo)
+{
+	static char *texts[2] = { "128x", "64x"	};
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
+static int phase28_oversampling_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.enumerated.item[0] = (wm_get(ice, WM_MASTER) & 0x8) == 0x8;
+	return 0;
+}
+
+static int phase28_oversampling_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	int temp, temp2;
+	ice1712_t *ice = snd_kcontrol_chip(kcontrol);
+
+	temp2 = temp = wm_get(ice, WM_MASTER);
+
+	if (ucontrol->value.enumerated.item[0])
+		temp |= 0x8;
+	else
+		temp &= ~0x8;
+
+	if (temp != temp2) {
+		wm_put(ice, WM_MASTER, temp);
+		return 1;
+	}
+	return 0;
+}
+
+static snd_kcontrol_new_t phase28_dac_controls[] __devinitdata = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Switch",
+		.info = wm_master_mute_info,
+		.get = wm_master_mute_get,
+		.put = wm_master_mute_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Volume",
+		.info = wm_master_vol_info,
+		.get = wm_master_vol_get,
+		.put = wm_master_vol_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Front Playback Switch",
+		.info = wm_mute_info,
+		.get = wm_mute_get,
+		.put = wm_mute_put,
+		.private_value = (2 << 8) | 0
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Front Playback Volume",
+		.info = wm_vol_info,
+		.get = wm_vol_get,
+		.put = wm_vol_put,
+		.private_value = (2 << 8) | 0
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Rear Playback Switch",
+		.info = wm_mute_info,
+		.get = wm_mute_get,
+		.put = wm_mute_put,
+		.private_value = (2 << 8) | 2
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Rear Playback Volume",
+		.info = wm_vol_info,
+		.get = wm_vol_get,
+		.put = wm_vol_put,
+		.private_value = (2 << 8) | 2
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Center Playback Switch",
+		.info = wm_mute_info,
+		.get = wm_mute_get,
+		.put = wm_mute_put,
+		.private_value = (1 << 8) | 4
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Center Playback Volume",
+		.info = wm_vol_info,
+		.get = wm_vol_get,
+		.put = wm_vol_put,
+		.private_value = (1 << 8) | 4
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "LFE Playback Switch",
+		.info = wm_mute_info,
+		.get = wm_mute_get,
+		.put = wm_mute_put,
+		.private_value = (1 << 8) | 5
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "LFE Playback Volume",
+		.info = wm_vol_info,
+		.get = wm_vol_get,
+		.put = wm_vol_put,
+		.private_value = (1 << 8) | 5
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Side Playback Switch",
+		.info = wm_mute_info,
+		.get = wm_mute_get,
+		.put = wm_mute_put,
+		.private_value = (2 << 8) | 6
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Side Playback Volume",
+		.info = wm_vol_info,
+		.get = wm_vol_get,
+		.put = wm_vol_put,
+		.private_value = (2 << 8) | 6
+	}
+};
+
+static snd_kcontrol_new_t wm_controls[] __devinitdata = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "PCM Playback Switch",
+		.info = wm_pcm_mute_info,
+		.get = wm_pcm_mute_get,
+		.put = wm_pcm_mute_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "PCM Playback Volume",
+		.info = wm_pcm_vol_info,
+		.get = wm_pcm_vol_get,
+		.put = wm_pcm_vol_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "DAC Deemphasis Switch",
+		.info = phase28_deemp_info,
+		.get = phase28_deemp_get,
+		.put = phase28_deemp_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "ADC Oversampling",
+		.info = phase28_oversampling_info,
+		.get = phase28_oversampling_get,
+		.put = phase28_oversampling_put
+	}
+};
+
+static int __devinit phase28_add_controls(ice1712_t *ice)
+{
+	unsigned int i, counts;
+	int err;
+
+	counts = ARRAY_SIZE(phase28_dac_controls);
+	for (i = 0; i < counts; i++) {
+		err = snd_ctl_add(ice->card, snd_ctl_new1(&phase28_dac_controls[i], ice));
+		if (err < 0)
+			return err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(wm_controls); i++) {
+		err = snd_ctl_add(ice->card, snd_ctl_new1(&wm_controls[i], ice));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 struct snd_ice1712_card_info snd_vt1724_phase_cards[] __devinitdata = {
 	{
 		.subvendor = VT1724_SUBDEVICE_PHASE22,
@@ -134,5 +853,14 @@
 		.eeprom_size = sizeof(phase22_eeprom),
 		.eeprom_data = phase22_eeprom,
 	},
+	{
+		.subvendor = VT1724_SUBDEVICE_PHASE28,
+		.name = "Terratec PHASE 28",
+		.model = "phase28",
+		.chip_init = phase28_init,
+		.build_controls = phase28_add_controls,
+		.eeprom_size = sizeof(phase28_eeprom),
+		.eeprom_data = phase28_eeprom,
+	},
 	{ } /* terminator */
 };
Index: alsa-kernel/pci/ice1712/phase.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/phase.h,v
retrieving revision 1.1
diff -u -r1.1 phase.h
--- alsa-kernel/pci/ice1712/phase.h	9 Feb 2005 10:47:51 -0000	1.1
+++ alsa-kernel/pci/ice1712/phase.h	9 Apr 2005 22:29:40 -0000
@@ -24,11 +24,28 @@
  *
  */      
 
-#define PHASE_DEVICE_DESC "{Terratec,Phase 22},"
+#define PHASE_DEVICE_DESC "{Terratec,Phase 22},"\
+                          "{Terratec,Phase 28},"
 
 #define VT1724_SUBDEVICE_PHASE22	0x3b155011
+#define VT1724_SUBDEVICE_PHASE28	0x3b154911
 
 /* entry point */
 extern struct snd_ice1712_card_info snd_vt1724_phase_cards[];
 
+/* PHASE28 GPIO bits */
+#define PHASE28_SPI_MISO	(1 << 21)
+#define PHASE28_WM_RESET	(1 << 20)
+#define PHASE28_SPI_CLK		(1 << 19)
+#define PHASE28_SPI_MOSI	(1 << 18)
+#define PHASE28_WM_RW		(1 << 17)
+#define PHASE28_AC97_RESET	(1 << 16)
+#define PHASE28_DIGITAL_SEL1	(1 << 15)
+#define PHASE28_HP_SEL		(1 << 14)
+#define PHASE28_WM_CS		(1 << 12)
+#define PHASE28_AC97_COMMIT	(1 << 11)
+#define PHASE28_AC97_ADDR	(1 << 10)
+#define PHASE28_AC97_DATA_LOW	(1 << 9)
+#define PHASE28_AC97_DATA_HIGH	(1 << 8)
+#define PHASE28_AC97_DATA_MASK	0xFF
 #endif /* __SOUND_PHASE */


-- 
Simone Zinanni - s.zinanni@develer.com
Develer S.r.l. - http://www.develer.com/
Software Solutions


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
