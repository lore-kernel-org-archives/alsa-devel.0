From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Subject: [PATCH 1/4] AC97 wm9713 support
Date: Fri, 25 Feb 2005 14:23:17 +0000
Message-ID: <1109341397.30473.671.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-fXo3HXh1RN95wUU2DmAO"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-fXo3HXh1RN95wUU2DmAO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is against ac97_codec.c and includes parts of Takashi's AC97
low power codec patch posted to lkml on Jan 4th 2005. It also includes
better enumerated mixer type support.

Apologies for the size of this patch. This was the minimum changes
required to get audio in/out of the codec.

Changes:-

  o Added WM9713/WM9714 to codec ID table
  o Removed snd_ac97_[info|get|put]_mux().
  o Added snd_ac97_[info|get|put]_enum_single() for single channel enums
  o Added snd_ac97_[info|get|put]_enum_double() for double channel enums
  o Moved AC97_ENUM_DOUBLE macro to ac97_local.h
  o Moved AC97_DOUBLE macro to ac97_local.h
  o Changed existing std enums to use new enum macros
  o Added the following AC97 flags to be checked at setup:-
AC97_HAS_NO_PC_BEEP, AC97_HAS_NO_PHONE, AC97_HAS_NO_CD,
AC97_HAS_NO_VIDEO, AC97_HAS_NO_REC_GAIN.
  o Added look_for_codec_id() to match given id with the codec id.
  o Added register reset protection for codecs that need it.


Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>


--=-fXo3HXh1RN95wUU2DmAO
Content-Disposition: attachment; filename=ac97_codec.c.diff
Content-Type: text/x-patch; name=ac97_codec.c.diff; charset=
Content-Transfer-Encoding: 7bit

diff -u -r1.172 ac97_codec.c
--- pci/ac97/ac97_codec.c	16 Feb 2005 18:27:12 -0000	1.172
+++ pci/ac97/ac97_codec.c	24 Feb 2005 16:49:55 -0000
@@ -56,6 +56,7 @@
 	const char *name;
 	int (*patch)(ac97_t *ac97);
 	int (*mpatch)(ac97_t *ac97);
+	unsigned int flags;
 } ac97_codec_id_t;
 
 static const ac97_codec_id_t snd_ac97_codec_id_vendors[] = {
@@ -161,6 +162,7 @@
 { 0x574d4C05, 0xffffffff, "WM9705/WM9710",	patch_wolfson05, NULL},
 { 0x574d4C09, 0xffffffff, "WM9709",		NULL,		NULL},
 { 0x574d4C12, 0xffffffff, "WM9711/WM9712",	patch_wolfson11, NULL},
+{ 0x574d4c13, 0xffffffff, "WM9713/WM9714",	patch_wolfson13, NULL, WM9713_AC97_FLAGS},
 { 0x594d4800, 0xffffffff, "YMF743",		NULL,		NULL },
 { 0x594d4802, 0xffffffff, "YMF752",		NULL,		NULL },
 { 0x594d4803, 0xffffffff, "YMF753",		patch_yamaha_ymf753,	NULL },
@@ -441,108 +443,85 @@
  * Controls
  */
 
-/* input mux */
-static int snd_ac97_info_mux(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+int snd_ac97_info_enum_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	static char *texts[8] = {
-		"Mic", "CD", "Video", "Aux", "Line",
-		"Mix", "Mix Mono", "Phone"
-	};
-
+	struct ac97_enum *e = (struct ac97_enum *)kcontrol->private_value;
+	
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 2;
-	uinfo->value.enumerated.items = 8;
-	if (uinfo->value.enumerated.item > 7)
-		uinfo->value.enumerated.item = 7;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = e->mask;
+	
+	if (uinfo->value.enumerated.item > e->mask - 1)
+		uinfo->value.enumerated.item = e->mask - 1;
+	strcpy(uinfo->value.enumerated.name, e->texts[uinfo->value.enumerated.item]);
 	return 0;
 }
 
-static int snd_ac97_get_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_ac97_get_enum_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	struct ac97_enum *e = (struct ac97_enum *)kcontrol->private_value;
 	unsigned short val;
-	
-	val = snd_ac97_read_cache(ac97, AC97_REC_SEL);
-	ucontrol->value.enumerated.item[0] = (val >> 8) & 7;
-	ucontrol->value.enumerated.item[1] = (val >> 0) & 7;
+
+	val = snd_ac97_read_cache(ac97, e->reg);
+	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & (e->mask - 1);
+
 	return 0;
 }
 
-static int snd_ac97_put_mux(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_ac97_put_enum_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	struct ac97_enum *e = (struct ac97_enum *)kcontrol->private_value;
 	unsigned short val;
 	
-	if (ucontrol->value.enumerated.item[0] > 7 ||
-	    ucontrol->value.enumerated.item[1] > 7)
+	if (ucontrol->value.enumerated.item[0] > e->mask - 1)
 		return -EINVAL;
-	val = (ucontrol->value.enumerated.item[0] << 8) |
-	      (ucontrol->value.enumerated.item[1] << 0);
-	return snd_ac97_update(ac97, AC97_REC_SEL, val);
-}
-
-/* standard stereo enums */
-#define AC97_ENUM_DOUBLE(xname, reg, shift, invert) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .info = snd_ac97_info_enum_double, \
-  .get = snd_ac97_get_enum_double, .put = snd_ac97_put_enum_double, \
-  .private_value = reg | (shift << 8) | (invert << 24) }
-
-static int snd_ac97_info_enum_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	static char *texts1[2] = { "pre 3D", "post 3D" };
-	static char *texts2[2] = { "Mix", "Mic" };
-	static char *texts3[2] = { "Mic1", "Mic2" };
-	char **texts = NULL;
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0xff;
+	val = (ucontrol->value.enumerated.item[0] << e->shift_l);
+	return snd_ac97_update_bits(ac97, e->reg, (e->mask - 1) << e->shift_l, val);
+}
 
-	switch (reg) {
-	case AC97_GENERAL_PURPOSE:
-		switch (shift) {
-		case 15: texts = texts1; break;
-		case 9: texts = texts2; break;
-		case 8: texts = texts3; break;
-		}
-	}
+int snd_ac97_info_enum_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	struct ac97_enum *e = (struct ac97_enum *)kcontrol->private_value;
+	
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	uinfo->count = 2;
+	uinfo->value.enumerated.items = e->mask;
+	
+	if (uinfo->value.enumerated.item > e->mask - 1)
+		uinfo->value.enumerated.item = e->mask - 1;
+	strcpy(uinfo->value.enumerated.name, e->texts[uinfo->value.enumerated.item]);
 	return 0;
 }
 
-static int snd_ac97_get_enum_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_ac97_get_enum_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	struct ac97_enum *e = (struct ac97_enum *)kcontrol->private_value;
 	unsigned short val;
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0xff;
-	int invert = (kcontrol->private_value >> 24) & 0xff;
 	
-	val = (snd_ac97_read_cache(ac97, reg) >> shift) & 1;
-	if (invert)
-		val ^= 1;
-	ucontrol->value.enumerated.item[0] = val;
+	val = snd_ac97_read_cache(ac97, e->reg);
+	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & (e->mask - 1);
+	ucontrol->value.enumerated.item[1] = (val >> e->shift_r) & (e->mask - 1);
+
 	return 0;
 }
 
-static int snd_ac97_put_enum_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+int snd_ac97_put_enum_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	ac97_t *ac97 = snd_kcontrol_chip(kcontrol);
+	struct ac97_enum *e = (struct ac97_enum *)kcontrol->private_value;
 	unsigned short val;
-	int reg = kcontrol->private_value & 0xff;
-	int shift = (kcontrol->private_value >> 8) & 0xff;
-	int invert = (kcontrol->private_value >> 24) & 0xff;
+	unsigned short mask = ((e->mask - 1) << e->shift_l) |
+		((e->mask - 1) << e->shift_r);
 	
-	if (ucontrol->value.enumerated.item[0] > 1)
+	if ((ucontrol->value.enumerated.item[0] > e->mask - 1) ||
+		(ucontrol->value.enumerated.item[1] > e->mask - 1))
 		return -EINVAL;
-	val = !!ucontrol->value.enumerated.item[0];
-	if (invert)
-		val = !val;
-	return snd_ac97_update_bits(ac97, reg, 1 << shift, val << shift);
+	val = (ucontrol->value.enumerated.item[0] << e->shift_l) |
+		(ucontrol->value.enumerated.item[1] << e->shift_r);
+	return snd_ac97_update_bits(ac97, e->reg, mask, val);
 }
 
 /* save/restore ac97 v2.3 paging */
@@ -634,11 +613,6 @@
 	return err;
 }
 
-#define AC97_DOUBLE(xname, reg, shift_left, shift_right, mask, invert) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), .info = snd_ac97_info_volsw, \
-  .get = snd_ac97_get_volsw, .put = snd_ac97_put_volsw, \
-  .private_value = (reg) | ((shift_left) << 8) | ((shift_right) << 12) | ((mask) << 16) | ((invert) << 24) }
-
 static const snd_kcontrol_new_t snd_ac97_controls_master_mono[2] = {
 AC97_SINGLE("Master Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),
 AC97_SINGLE("Master Mono Playback Volume", AC97_MASTER_MONO, 0, 31, 1)
@@ -658,14 +632,21 @@
 	AC97_SINGLE("Mic Boost (+20dB)", AC97_MIC, 6, 1, 0);
 
 
-static const snd_kcontrol_new_t snd_ac97_control_capture_src = {
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "Capture Source",
-	.info = snd_ac97_info_mux,
-	.get = snd_ac97_get_mux,
-	.put = snd_ac97_put_mux,
+static const char* std_rec_sel[] = {"Mic", "CD", "Video", "Aux", "Line", "Mix", "Mix Mono", "Phone"};
+static const char* std_3d_path[] = {"pre 3D", "post 3D"};
+static const char* std_mix[] = {"Mix", "Mic"};
+static const char* std_mic[] = {"Mic1", "Mic2"};
+
+static const struct ac97_enum std_enum[] = {
+AC97_ENUM(AC97_REC_SEL, 8, 0, 8, std_rec_sel),
+AC97_ENUM(AC97_GENERAL_PURPOSE, 15, 0, 2, std_3d_path),
+AC97_ENUM(AC97_GENERAL_PURPOSE, 9, 0, 2, std_mix),
+AC97_ENUM(AC97_GENERAL_PURPOSE, 8, 0, 2, std_mic),
 };
 
+static const snd_kcontrol_new_t snd_ac97_control_capture_src = 
+AC97_ENUM_DOUBLE("Capture Source", std_enum[0]); 
+
 static const snd_kcontrol_new_t snd_ac97_control_capture_vol =
 AC97_DOUBLE("Capture Volume", AC97_REC_GAIN, 8, 0, 15, 0);
 
@@ -685,12 +666,12 @@
 } ac97_general_index_t;
 
 static const snd_kcontrol_new_t snd_ac97_controls_general[7] = {
-AC97_ENUM_DOUBLE("PCM Out Path & Mute", AC97_GENERAL_PURPOSE, 15, 0),
+AC97_ENUM_SINGLE("PCM Out Path & Mute", std_enum[1]),
 AC97_SINGLE("Simulated Stereo Enhancement", AC97_GENERAL_PURPOSE, 14, 1, 0),
 AC97_SINGLE("3D Control - Switch", AC97_GENERAL_PURPOSE, 13, 1, 0),
 AC97_SINGLE("Loudness (bass boost)", AC97_GENERAL_PURPOSE, 12, 1, 0),
-AC97_ENUM_DOUBLE("Mono Output Select", AC97_GENERAL_PURPOSE, 9, 0),
-AC97_ENUM_DOUBLE("Mic Select", AC97_GENERAL_PURPOSE, 8, 0),
+AC97_ENUM_SINGLE("Mono Output Select", std_enum[2]),
+AC97_ENUM_SINGLE("Mic Select", std_enum[3]),
 AC97_SINGLE("ADC/DAC Loopback", AC97_GENERAL_PURPOSE, 7, 1, 0)
 };
 
@@ -1356,8 +1337,9 @@
 	}
 	
 	/* build PC Speaker controls */
-	if ((ac97->flags & AC97_HAS_PC_BEEP) ||
-	    snd_ac97_try_volume_mix(ac97, AC97_PC_BEEP)) {
+	if (!(ac97->flags & AC97_HAS_NO_PC_BEEP) && 
+		((ac97->flags & AC97_HAS_PC_BEEP) ||
+	    snd_ac97_try_volume_mix(ac97, AC97_PC_BEEP))) {
 		for (idx = 0; idx < 2; idx++)
 			if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_controls_pc_beep[idx], ac97))) < 0)
 				return err;
@@ -1366,9 +1348,11 @@
 	}
 	
 	/* build Phone controls */
-	if (snd_ac97_try_volume_mix(ac97, AC97_PHONE)) {
-		if ((err = snd_ac97_cmix_new(card, "Phone Playback", AC97_PHONE, ac97)) < 0)
-			return err;
+	if (!(ac97->flags & AC97_HAS_NO_PHONE)) {
+		if (snd_ac97_try_volume_mix(ac97, AC97_PHONE)) {
+			if ((err = snd_ac97_cmix_new(card, "Phone Playback", AC97_PHONE, ac97)) < 0)
+				return err;
+		}
 	}
 	
 	/* build MIC controls */
@@ -1386,15 +1370,19 @@
 	}
 	
 	/* build CD controls */
-	if (snd_ac97_try_volume_mix(ac97, AC97_CD)) {
-		if ((err = snd_ac97_cmix_new(card, "CD Playback", AC97_CD, ac97)) < 0)
-			return err;
+	if (!(ac97->flags & AC97_HAS_NO_CD)) {
+		if (snd_ac97_try_volume_mix(ac97, AC97_CD)) {
+			if ((err = snd_ac97_cmix_new(card, "CD Playback", AC97_CD, ac97)) < 0)
+				return err;
+		}
 	}
 	
 	/* build Video controls */
-	if (snd_ac97_try_volume_mix(ac97, AC97_VIDEO)) {
-		if ((err = snd_ac97_cmix_new(card, "Video Playback", AC97_VIDEO, ac97)) < 0)
-			return err;
+	if (!(ac97->flags & AC97_HAS_NO_VIDEO)) {
+		if (snd_ac97_try_volume_mix(ac97, AC97_VIDEO)) {
+			if ((err = snd_ac97_cmix_new(card, "Video Playback", AC97_VIDEO, ac97)) < 0)
+				return err;
+		}
 	}
 
 	/* build Aux controls */
@@ -1440,17 +1428,18 @@
 	}
 
 	/* build Capture controls */
-	if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_control_capture_src, ac97))) < 0)
-		return err;
-	if (snd_ac97_try_bit(ac97, AC97_REC_GAIN, 15)) {
-		if ((err = snd_ac97_cmute_new(card, "Capture Switch", AC97_REC_GAIN, ac97)) < 0)
+	if (!(ac97->flags & AC97_HAS_NO_REC_GAIN)) {
+		if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_control_capture_src, ac97))) < 0)
+			return err;
+		if (snd_ac97_try_bit(ac97, AC97_REC_GAIN, 15)) {
+			if ((err = snd_ac97_cmute_new(card, "Capture Switch", AC97_REC_GAIN, ac97)) < 0)
+				return err;
+		}
+		if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_control_capture_vol, ac97))) < 0)
 			return err;
+		snd_ac97_write_cache(ac97, AC97_REC_SEL, 0x0000);
+		snd_ac97_write_cache(ac97, AC97_REC_GAIN, 0x0000);
 	}
-	if ((err = snd_ctl_add(card, snd_ac97_cnew(&snd_ac97_control_capture_vol, ac97))) < 0)
-		return err;
-	snd_ac97_write_cache(ac97, AC97_REC_SEL, 0x0000);
-	snd_ac97_write_cache(ac97, AC97_REC_GAIN, 0x0000);
-
 	/* build MIC Capture controls */
 	if (snd_ac97_try_volume_mix(ac97, AC97_REC_GAIN_MIC)) {
 		for (idx = 0; idx < 2; idx++)
@@ -1662,6 +1651,18 @@
 	return result;
 }
 
+/* look for the codec id table matching with the given id */
+static const ac97_codec_id_t *look_for_codec_id(const ac97_codec_id_t *table,
+						unsigned int id)
+{
+	const ac97_codec_id_t *pid;
+
+	for (pid = table; pid->id; pid++)
+		if (pid->id == (id & pid->mask))
+			return pid;
+	return NULL;
+}
+
 void snd_ac97_get_name(ac97_t *ac97, unsigned int id, char *name, int modem)
 {
 	const ac97_codec_id_t *pid;
@@ -1670,35 +1671,30 @@
 		printable(id >> 24),
 		printable(id >> 16),
 		printable(id >> 8));
-	for (pid = snd_ac97_codec_id_vendors; pid->id; pid++)
-		if (pid->id == (id & pid->mask)) {
-			strcpy(name, pid->name);
-			if (ac97) {
-				if (!modem && pid->patch)
-					pid->patch(ac97);
-				else if (modem && pid->mpatch)
-					pid->mpatch(ac97);
-			} 
-			goto __vendor_ok;
-		}
-	return;
+	pid = look_for_codec_id(snd_ac97_codec_id_vendors, id);
+	if (! pid)
+		return;
 
-      __vendor_ok:
-	for (pid = snd_ac97_codec_ids; pid->id; pid++)
-		if (pid->id == (id & pid->mask)) {
-			strcat(name, " ");
-			strcat(name, pid->name);
-			if (pid->mask != 0xffffffff)
-				sprintf(name + strlen(name), " rev %d", id & ~pid->mask);
-			if (ac97) {
-				if (!modem && pid->patch)
-					pid->patch(ac97);
-				else if (modem && pid->mpatch)
-					pid->mpatch(ac97);
-			}
-			return;
+	strcpy(name, pid->name);
+	if (ac97 && pid->patch) {
+		if ((modem && (pid->flags & AC97_MODEM_PATCH)) ||
+		    (! modem && ! (pid->flags & AC97_MODEM_PATCH)))
+			pid->patch(ac97);
+	} 
+
+	pid = look_for_codec_id(snd_ac97_codec_ids, id);
+	if (pid) {
+		strcat(name, " ");
+		strcat(name, pid->name);
+		if (pid->mask != 0xffffffff)
+			sprintf(name + strlen(name), " rev %d", id & ~pid->mask);
+		if (ac97 && pid->patch) {
+			if ((modem && (pid->flags & AC97_MODEM_PATCH)) ||
+			    (! modem && ! (pid->flags & AC97_MODEM_PATCH)))
+				pid->patch(ac97);
 		}
-	sprintf(name + strlen(name), " id %x", id & 0xff);
+	} else
+		sprintf(name + strlen(name), " id %x", id & 0xff);
 }
 
 /**
@@ -1840,6 +1836,7 @@
 	char name[64];
 	unsigned long end_time;
 	unsigned int reg;
+	const ac97_codec_id_t *pid;
 	static snd_device_ops_t ops = {
 		.dev_free =	snd_ac97_dev_free,
 	};
@@ -1890,6 +1887,14 @@
 		goto __access_ok;
 	}
 
+	ac97->id = snd_ac97_read(ac97, AC97_VENDOR_ID1) << 16;
+	ac97->id |= snd_ac97_read(ac97, AC97_VENDOR_ID2);
+	if (ac97->id && ac97->id != (unsigned int)-1) {
+		pid = look_for_codec_id(snd_ac97_codec_ids, ac97->id);
+		if (pid && (pid->flags & AC97_DEFAULT_POWER_OFF))
+			goto __access_ok;
+	}
+
 	snd_ac97_write(ac97, AC97_RESET, 0);	/* reset to defaults */
 	if (bus->ops->wait)
 		bus->ops->wait(ac97);
@@ -1916,6 +1921,9 @@
 		snd_ac97_free(ac97);
 		return -EIO;
 	}
+	pid = look_for_codec_id(snd_ac97_codec_ids, ac97->id);
+	if (pid)
+		ac97->flags |= pid->flags;
 	
 	/* test for AC'97 */
 	if (!(ac97->scaps & AC97_SCAP_SKIP_AUDIO) && !(ac97->scaps & AC97_SCAP_AUDIO)) {
@@ -1954,10 +1962,12 @@
 	if (ac97_is_audio(ac97)) {
 		/* nothing should be in powerdown mode */
 		snd_ac97_write_cache(ac97, AC97_POWERDOWN, 0);
-		snd_ac97_write_cache(ac97, AC97_RESET, 0);		/* reset to defaults */
-		udelay(100);
+		if (! (ac97->flags & AC97_DEFAULT_POWER_OFF)) {
+			snd_ac97_write_cache(ac97, AC97_RESET, 0); /* reset to defaults */
+			udelay(100);
+			snd_ac97_write_cache(ac97, AC97_POWERDOWN, 0);
+		}
 		/* nothing should be in powerdown mode */
-		snd_ac97_write_cache(ac97, AC97_POWERDOWN, 0);
 		snd_ac97_write_cache(ac97, AC97_GENERAL_PURPOSE, 0);
 		end_time = jiffies + (HZ / 10);
 		do {
@@ -2224,9 +2234,11 @@
 	}
 
 	snd_ac97_write(ac97, AC97_POWERDOWN, 0);
-	snd_ac97_write(ac97, AC97_RESET, 0);
-	udelay(100);
-	snd_ac97_write(ac97, AC97_POWERDOWN, 0);
+	if (! (ac97->flags & AC97_DEFAULT_POWER_OFF)) {
+		snd_ac97_write(ac97, AC97_RESET, 0);
+		udelay(100);
+		snd_ac97_write(ac97, AC97_POWERDOWN, 0);
+	}
 	snd_ac97_write(ac97, AC97_GENERAL_PURPOSE, 0);
 
 	snd_ac97_write(ac97, AC97_POWERDOWN, ac97->regs[AC97_POWERDOWN]);

--=-fXo3HXh1RN95wUU2DmAO--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
