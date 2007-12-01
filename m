From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Patch - switching rate in STAC9460 codec of Prodigy192
Date: Sat, 01 Dec 2007 13:07:16 +0100
Message-ID: <47514E74.2050902@insite.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090406010808040702080900"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id A0CD624572
	for <alsa-devel@alsa-project.org>; Sat,  1 Dec 2007 13:07:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090406010808040702080900
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here is a patch for switching rate in STAC9460 codec.

Thanks,

Pavel.


Signed-off-by: Pavel Hofman <dustin@seznam.cz>

* support for switching rate in STAC9460 - using set_rate_val of the akm 
infrastructure
* listing all STAC9460 registers in proc
* disabling mpu401 device for Prodigy192 - otherwise the currently 
flawed mpu401 code
   hangs kernel when opening the midi device
* removing old unused commented-out code

--------------090406010808040702080900
Content-Type: text/x-patch;
 name="prodigy192.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prodigy192.diff"

diff -r 7f4b25ff79d6 i2c/other/ak4xxx-adda.c
--- a/i2c/other/ak4xxx-adda.c	Fri Nov 30 17:59:25 2007 +0100
+++ b/i2c/other/ak4xxx-adda.c	Fri Nov 30 21:58:53 2007 +0100
@@ -293,6 +293,10 @@ void snd_akm4xxx_init(struct snd_akm4xxx
 	case SND_AK5365:
 		/* FIXME: any init sequence? */
 		return;
+	case NON_AKM:
+		/* fake value for non-akm codecs using akm infrastructure
+		 * (e.g. of ice1724) - certainly FIXME */
+		return;
 	default:
 		snd_BUG();
 		return;
diff -r 7f4b25ff79d6 include/ak4xxx-adda.h
--- a/include/ak4xxx-adda.h	Fri Nov 30 17:59:25 2007 +0100
+++ b/include/ak4xxx-adda.h	Fri Nov 30 21:58:53 2007 +0100
@@ -68,7 +68,7 @@ struct snd_akm4xxx {
 	enum {
 		SND_AK4524, SND_AK4528, SND_AK4529,
 		SND_AK4355, SND_AK4358, SND_AK4381,
-		SND_AK5365
+		SND_AK5365, NON_AKM
 	} type;
 
 	/* (array) information of combined codecs */
diff -r 7f4b25ff79d6 pci/ice1712/ice1712.h
--- a/pci/ice1712/ice1712.h	Fri Nov 30 17:59:25 2007 +0100
+++ b/pci/ice1712/ice1712.h	Fri Nov 30 21:58:53 2007 +0100
@@ -399,6 +399,8 @@ struct snd_ice1712 {
 		} juli;
 		struct {
 			struct ak4114 *ak4114;
+			/* rate change needs atomic mute/unmute of all dacs*/
+			struct mutex mute_mutex;
 		} prodigy192;
 		struct {
 			struct {
diff -r 7f4b25ff79d6 pci/ice1712/prodigy192.c
--- a/pci/ice1712/prodigy192.c	Fri Nov 30 17:59:25 2007 +0100
+++ b/pci/ice1712/prodigy192.c	Fri Nov 30 21:58:53 2007 +0100
@@ -81,6 +81,24 @@ static inline unsigned char stac9460_get
 /*
  * DAC mute control
  */
+
+/*
+ * idx = STAC9460 volume register number, mute: 0 = mute, 1 = unmute
+ */
+static int stac9460_dac_mute(struct snd_ice1712 *ice, int idx,
+		unsigned char mute)
+{
+	unsigned char new, old;
+	int change;
+	old = stac9460_get(ice, idx);
+	new = (~mute << 7 & 0x80) | (old & ~0x80);
+	change = (new != old);
+	if (change)
+		/*printk ("Volume register 0x%02x: 0x%02x\n", idx, new);*/
+		stac9460_put(ice, idx, new);
+	return change;
+}
+
 #define stac9460_dac_mute_info		snd_ctl_boolean_mono_info
 
 static int stac9460_dac_mute_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -101,20 +119,19 @@ static int stac9460_dac_mute_put(struct 
 static int stac9460_dac_mute_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-	unsigned char new, old;
-	int idx;
-	int change;
+	int idx, change;
+
 
 	if (kcontrol->private_value)
 		idx = STAC946X_MASTER_VOLUME;
 	else
 		idx  = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id) + STAC946X_LF_VOLUME;
-	old = stac9460_get(ice, idx);
-	new = (~ucontrol->value.integer.value[0]<< 7 & 0x80) | (old & ~0x80);
-	change = (new != old);
-	if (change)
-		stac9460_put(ice, idx, new);
-
+	/* due to possible conflicts with stac9460_set_rate_val, mutexing */
+	mutex_lock(&ice->spec.prodigy192.mute_mutex);
+	/*printk("Mute put: reg 0x%02x, ctrl value: 0x%02x\n", idx,
+		ucontrol->value.integer.value[0]);*/
+	change = stac9460_dac_mute(ice, idx, ucontrol->value.integer.value[0]);
+	mutex_unlock(&ice->spec.prodigy192.mute_mutex);
 	return change;
 }
 
@@ -162,6 +179,8 @@ static int stac9460_dac_vol_put(struct s
 	ovol = 0x7f - (tmp & 0x7f);
 	change = (ovol != nvol);
 	if (change) {
+		ovol =  (0x7f - nvol) | (tmp & 0x80);
+		/*printk("DAC Volume: reg 0x%02x: 0x%02x\n", idx, ovol);*/
 		stac9460_put(ice, idx, (0x7f - nvol) | (tmp & 0x80));
 	}
 	return change;
@@ -251,121 +270,6 @@ static int stac9460_adc_vol_put(struct s
 	return change;
 }
 
-#if 0
-/*
- * Headphone Amplifier
- */
-static int aureon_set_headphone_amp(struct snd_ice1712 *ice, int enable)
-{
-	unsigned int tmp, tmp2;
-
-	tmp2 = tmp = snd_ice1712_gpio_read(ice);
-	if (enable)
-		tmp |= AUREON_HP_SEL;
-	else
-		tmp &= ~ AUREON_HP_SEL;
-	if (tmp != tmp2) {
-		snd_ice1712_gpio_write(ice, tmp);
-		return 1;
-	}
-	return 0;
-}
-
-static int aureon_get_headphone_amp(struct snd_ice1712 *ice)
-{
-	unsigned int tmp = snd_ice1712_gpio_read(ice);
-
-	return ( tmp & AUREON_HP_SEL )!= 0;
-}
-
-#define aureon_bool_info	snd_ctl_boolean_mono_info
-
-static int aureon_hpamp_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-
-	ucontrol->value.integer.value[0] = aureon_get_headphone_amp(ice);
-	return 0;
-}
-
-
-static int aureon_hpamp_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-
-	return aureon_set_headphone_amp(ice,ucontrol->value.integer.value[0]);
-}
-
-/*
- * Deemphasis
- */
-static int aureon_deemp_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-	ucontrol->value.integer.value[0] = (wm_get(ice, WM_DAC_CTRL2) & 0xf) == 0xf;
-	return 0;
-}
-
-static int aureon_deemp_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-	int temp, temp2;
-	temp2 = temp = wm_get(ice, WM_DAC_CTRL2);
-	if (ucontrol->value.integer.value[0])
-		temp |= 0xf;
-	else
-		temp &= ~0xf;
-	if (temp != temp2) {
-		wm_put(ice, WM_DAC_CTRL2, temp);
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * ADC Oversampling
- */
-static int aureon_oversampling_info(struct snd_kcontrol *k, struct snd_ctl_elem_info *uinfo)
-{
-	static char *texts[2] = { "128x", "64x"	};
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-
-        return 0;
-}
-
-static int aureon_oversampling_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-	ucontrol->value.enumerated.item[0] = (wm_get(ice, WM_MASTER) & 0x8) == 0x8;
-	return 0;
-}
-
-static int aureon_oversampling_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	int temp, temp2;
-	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
-
-	temp2 = temp = wm_get(ice, WM_MASTER);
-
-	if (ucontrol->value.enumerated.item[0])
-		temp |= 0x8;
-	else
-		temp &= ~0x8;
-
-	if (temp != temp2) {
-		wm_put(ice, WM_MASTER, temp);
-		return 1;
-	}
-	return 0;
-}
-#endif
 static int stac9460_mic_sw_info(struct snd_kcontrol *kcontrol,
 	       			struct snd_ctl_elem_info *uinfo)
 {
@@ -407,6 +311,56 @@ static int stac9460_mic_sw_put(struct sn
 		stac9460_put(ice, STAC946X_GENERAL_PURPOSE, new);
 	return change;
 }
+/*
+ * Handler for setting correct codec rate - called when rate change is detected
+ */
+static void stac9460_set_rate_val (struct snd_akm4xxx *ak, unsigned int rate)
+{
+	unsigned char old, new;
+	int idx;
+	unsigned char changed[7];
+	struct snd_ice1712 *ice = ak->private_data[0];
+
+	if (rate == 0)  /* no hint - S/PDIF input is master, simply return */
+		return;
+	else if (rate <= 48000)
+		new = 0x08;	/* 256x, base rate mode */
+	else if (rate <= 96000)
+		new = 0x11;	/* 256x, mid rate mode */
+	else
+		new = 0x12;	/* 128x, high rate mode */
+	old = stac9460_get(ice, STAC946X_MASTER_CLOCKING);
+	if (old == new)
+		return;
+	/* change detected, setting master clock, muting first */
+	/* due to possible conflicts with mute controls - mutexing */
+	mutex_lock(&ice->spec.prodigy192.mute_mutex);
+	/* we have to remember current mute status for each DAC */
+	for (idx = 0; idx < 7 ; ++idx)
+		changed[idx] = stac9460_dac_mute(ice,
+				STAC946X_MASTER_VOLUME + idx, 0);
+	/*printk("Rate change: %d, new MC: 0x%02x\n", rate, new);*/
+	stac9460_put(ice, STAC946X_MASTER_CLOCKING, new);
+	udelay(10);
+	/* unmuting - only originally unmuted dacs -
+	 * i.e. those changed when muting */
+	for (idx = 0; idx < 7 ; ++idx) {
+		if (changed[idx])
+			stac9460_dac_mute(ice, STAC946X_MASTER_VOLUME + idx, 1);
+	}
+	mutex_unlock(&ice->spec.prodigy192.mute_mutex);
+}
+
+/* using akm infrastructure for setting rate of the codec */
+static struct snd_akm4xxx akmlike_stac9460 __devinitdata = {
+	.type = NON_AKM,	/* special value */
+	.num_adcs = 6,		/* not used in any way, just for completeness */
+	.num_dacs = 2,
+	.ops = {
+		.set_rate_val = stac9460_set_rate_val
+	}
+};
+
 
 static const DECLARE_TLV_DB_SCALE(db_scale_dac, -19125, 75, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_adc, 0, 150, 0);
@@ -483,38 +437,7 @@ static struct snd_kcontrol_new stac_cont
 		.put = stac9460_mic_sw_put,
 
 	},
-#if 0
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Route",
-		.info = wm_adc_mux_info,
-		.get = wm_adc_mux_get,
-		.put = wm_adc_mux_put,
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Headphone Amplifier Switch",
-		.info = aureon_bool_info,
-		.get = aureon_hpamp_get,
-		.put = aureon_hpamp_put
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "DAC Deemphasis Switch",
-		.info = aureon_bool_info,
-		.get = aureon_deemp_get,
-		.put = aureon_deemp_put
-	},
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "ADC Oversampling",
-		.info = aureon_oversampling_info,
-		.get = aureon_oversampling_get,
-		.put = aureon_oversampling_put
-	},
-#endif
 };
-
 
 /* AK4114 - ICE1724 connections on Prodigy192 + MI/ODI/O */
 /* CDTO (pin 32) -- GPIO11 pin 86
@@ -720,6 +643,27 @@ static int prodigy192_ak4114_init(struct
 				 ice, &ice->spec.prodigy192.ak4114);
 }
 
+static void stac9460_proc_regs_read(struct snd_info_entry *entry,
+		struct snd_info_buffer *buffer)
+{
+	struct snd_ice1712 *ice = (struct snd_ice1712 *)entry->private_data;
+	int reg, val;
+	/* registers 0x0 - 0x14 */
+	for (reg = 0; reg <= 0x15; reg++) {
+		val = stac9460_get(ice, reg);
+		snd_iprintf(buffer, "0x%02x = 0x%02x\n", reg, val);
+	}
+}
+
+
+static void stac9460_proc_init(struct snd_ice1712 *ice)
+{
+	struct snd_info_entry *entry;
+	if (!snd_card_proc_new(ice->card, "stac9460_codec", &entry))
+		snd_info_set_text_ops(entry, ice, stac9460_proc_regs_read);
+}
+
+
 static int __devinit prodigy192_add_controls(struct snd_ice1712 *ice)
 {
 	unsigned int i;
@@ -746,6 +690,7 @@ static int __devinit prodigy192_add_cont
 		if (err < 0)
 			return err;
 	}
+	stac9460_proc_init(ice);
 	return 0;
 }
 
@@ -778,6 +723,7 @@ static int __devinit prodigy192_init(str
 {
 	static const unsigned short stac_inits_prodigy[] = {
 		STAC946X_RESET, 0,
+		STAC946X_MASTER_CLOCKING, 0x11,
 /*		STAC946X_MASTER_VOLUME, 0,
 		STAC946X_LF_VOLUME, 0,
 		STAC946X_RF_VOLUME, 0,
@@ -789,6 +735,7 @@ static int __devinit prodigy192_init(str
 	};
 	const unsigned short *p;
 	int err = 0;
+	struct snd_akm4xxx *ak;
 
 	/* prodigy 192 */
 	ice->num_total_dacs = 6;
@@ -799,6 +746,15 @@ static int __devinit prodigy192_init(str
 	p = stac_inits_prodigy;
 	for (; *p != (unsigned short)-1; p += 2)
 		stac9460_put(ice, p[0], p[1]);
+	/* reusing the akm codecs infrastructure,
+	 * for setting rate on stac9460 */
+	ak = ice->akm = kmalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
+	if (!ak)
+		return -ENOMEM;
+	ice->akm_codecs = 1;
+	err = snd_ice1712_akm4xxx_init(ak, &akmlike_stac9460, NULL, ice);
+	if (err < 0)
+		return err;
 
 	/* MI/ODI/O add on card with AK4114 */
 	if (prodigy192_miodio_exists(ice)) {
@@ -811,6 +767,8 @@ static int __devinit prodigy192_init(str
 		snd_printdd("AK4114 not found\n");
 	if (err < 0)
 		return err;
+
+	mutex_init(&ice->spec.prodigy192.mute_mutex);
 
 	return 0;
 }
@@ -854,6 +812,9 @@ struct snd_ice1712_card_info snd_vt1724_
 		.build_controls = prodigy192_add_controls,
 		.eeprom_size = sizeof(prodigy71_eeprom),
 		.eeprom_data = prodigy71_eeprom,
+		/* the current MPU401 code loops infinitely
+		 * when opening midi device */
+		.no_mpu401 = 1,
 	},
 	{ } /* terminator */
 };

--------------090406010808040702080900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090406010808040702080900--
