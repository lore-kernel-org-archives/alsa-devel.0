From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH] snd-usb-6fire: volume control for individual
 analog channels
Date: Thu, 15 Sep 2011 17:32:10 +0200
Message-ID: <1326db76d53.-6181476231545168842.2132841142197504851@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id D7C4B10384C
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 17:32:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: tiwai <tiwai@suse.de>, clemens <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Added a stereo volume control for each analog output channel pair.
Master volume modified so that it acts as a software weight for
the individual channel faders.
Added mute switches for master and individual analog channels.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>
Cc: stable@kernel.org [3.0+]
---
diff -Nur a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
--- a/sound/usb/6fire/chip.c	2011-09-15 16:11:08.000000000 +0000
+++ b/sound/usb/6fire/chip.c	2011-09-15 16:11:46.000000000 +0000
@@ -5,7 +5,7 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.6
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
@@ -29,7 +29,7 @@
 #include <sound/initval.h>
 
 MODULE_AUTHOR("Torsten Schenk <torsten.schenk@zoho.com>");
-MODULE_DESCRIPTION("TerraTec DMX 6Fire USB audio driver, version 0.3.0");
+MODULE_DESCRIPTION("TerraTec DMX 6Fire USB audio driver, version 0.3.6");
 MODULE_LICENSE("GPL v2");
 MODULE_SUPPORTED_DEVICE("{{TerraTec, DMX 6Fire USB}}");
 
diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2011-09-02 13:48:10.000000000 +0000
+++ b/sound/usb/6fire/control.c	2011-09-02 13:50:35.000000000 +0000
@@ -5,9 +5,13 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.6
  * Copyright:	(C) Torsten Schenk
  *
+ * Thanks to:
+ * - Holger Ruckdeschel: he found out how to control individual analog
+ *   channel volumes and introduced mute switches
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -59,7 +63,7 @@
 	{ 0x22, 0x03, 0x00 }, { 0x20, 0x03, 0x08 }, { 0x22, 0x04, 0x00 },
 	{ 0x20, 0x04, 0x08 }, { 0x22, 0x05, 0x01 }, { 0x20, 0x05, 0x08 },
 	{ 0x22, 0x04, 0x01 }, { 0x12, 0x04, 0x00 }, { 0x12, 0x05, 0x00 },
-	{ 0x12, 0x0d, 0x78 }, { 0x12, 0x21, 0x82 }, { 0x12, 0x22, 0x80 },
+	{ 0x12, 0x0d, 0x38 }, { 0x12, 0x21, 0x82 }, { 0x12, 0x22, 0x80 },
 	{ 0x12, 0x23, 0x00 }, { 0x12, 0x06, 0x02 }, { 0x12, 0x03, 0x00 },
 	{ 0x12, 0x02, 0x00 }, { 0x22, 0x03, 0x01 },
 	{ 0 } /* TERMINATING ENTRY */
@@ -74,15 +78,35 @@
 	DIGITAL_THRU_ONLY_SAMPLERATE = 3
 };
 
-static void usb6fire_control_master_vol_update(struct control_runtime *rt)
+static void usb6fire_control_output_vol_update(struct control_runtime *rt)
+{
+	struct comm_runtime *comm_rt = rt->chip->comm;
+	u8 value;
+
+	if (comm_rt) {
+		int i;
+		for (i = 0; i < 6; i++) {
+			/* set volume */
+			value = rt->output_vol[i] * rt->master_vol / 0x7f;
+			comm_rt->write8(comm_rt, 0x12, 0x0f + i, 0x7f -
+					log_volume_table[value]);
+		}
+	}
+}
+
+static void usb6fire_control_output_switch_update(struct control_runtime *rt)
 {
 	struct comm_runtime *comm_rt = rt->chip->comm;
+	int i;
+	u8 value = 0x00;
+
 	if (comm_rt) {
-		/* set volume */
-		comm_rt->write8(comm_rt, 0x12, 0x0f, 0x7f -
-				log_volume_table[rt->master_vol]);
-		 /* unmute */
-		comm_rt->write8(comm_rt, 0x12, 0x0e, 0x00);
+		if (rt->master_switch) /* mute/unmute single outputs */
+			for (i = 0; i < 6; i++)
+				value |= !rt->output_switch[i] << i;
+		else /* mute all outputs */
+			value = 0x3f;
+		comm_rt->write8(comm_rt, 0x12, 0x0e, value);
 	}
 }
 
@@ -171,7 +195,17 @@
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 127;
+	uinfo->value.integer.max = 0x7f;
+	return 0;
+}
+
+static int usb6fire_control_output_vol_info(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0x7f;
 	return 0;
 }
 
@@ -182,7 +216,12 @@
 	int changed = 0;
 	if (rt->master_vol != ucontrol->value.integer.value[0]) {
 		rt->master_vol = ucontrol->value.integer.value[0];
-		usb6fire_control_master_vol_update(rt);
+		usb6fire_control_output_vol_update(rt);
+		changed = 1;
+	}
+	if (rt->master_vol != ucontrol->value.integer.value[0]) {
+		rt->master_vol = ucontrol->value.integer.value[0];
+		usb6fire_control_output_vol_update(rt);
 		changed = 1;
 	}
 	return changed;
@@ -196,6 +235,127 @@
 	return 0;
 }
 
+static int usb6fire_control_master_switch_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
+	if (rt->master_switch != ucontrol->value.integer.value[0]) {
+		rt->master_switch = ucontrol->value.integer.value[0];
+		usb6fire_control_output_switch_update(rt);
+		changed = 1;
+	}
+	return changed;
+}
+
+static int usb6fire_control_master_switch_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.integer.value[0] = rt->master_switch;
+	return 0;
+}
+
+static int usb6fire_control_output_vol_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	unsigned long chs = kcontrol->private_value;
+	unsigned long ch0 = 2 * chs;
+	unsigned long ch1 = 2 * chs + 1;
+	int changed = 0;
+
+	if (chs < 0 || chs > 2) {
+		snd_printk(KERN_ERR PREFIX
+			"Invalid channel in volume control.");
+		return 0;
+	}
+
+	if (rt->output_vol[ch0] != ucontrol->value.integer.value[0]) {
+		rt->output_vol[ch0] = ucontrol->value.integer.value[0];
+		changed = 1;
+	}
+	if (rt->output_vol[ch1] != ucontrol->value.integer.value[1]) {
+		rt->output_vol[ch1] = ucontrol->value.integer.value[1];
+		changed = 1;
+	}
+
+	if (changed)
+		usb6fire_control_output_vol_update(rt);
+
+	return changed;
+}
+
+static int usb6fire_control_output_vol_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	unsigned long chs = kcontrol->private_value;
+	unsigned long ch0 = 2 * chs;
+	unsigned long ch1 = 2 * chs + 1;
+
+	if (chs < 0 || chs > 2) {
+		snd_printk(KERN_ERR PREFIX
+			"Invalid channel in volume control.");
+		return 0;
+	}
+
+	ucontrol->value.integer.value[0] = rt->output_vol[ch0];
+	ucontrol->value.integer.value[1] = rt->output_vol[ch1];
+
+	return 0;
+}
+
+static int usb6fire_control_output_switch_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	unsigned long chs = kcontrol->private_value;
+	unsigned long ch0 = 2 * chs;
+	unsigned long ch1 = 2 * chs + 1;
+	int changed = 0;
+
+	if (chs < 0 || chs > 2) {
+		snd_printk(KERN_ERR PREFIX
+			"Invalid channel in volume control.");
+		return 0;
+	}
+
+	if (rt->output_switch[ch0] != ucontrol->value.integer.value[0]) {
+		rt->output_switch[ch0] = ucontrol->value.integer.value[0];
+		changed = 1;
+	}
+	if (rt->output_switch[ch1] != ucontrol->value.integer.value[1]) {
+		rt->output_switch[ch1] = ucontrol->value.integer.value[1];
+		changed = 1;
+	}
+
+	if (changed)
+		usb6fire_control_output_switch_update(rt);
+
+	return changed;
+}
+
+static int usb6fire_control_output_switch_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	unsigned long chs = kcontrol->private_value;
+	unsigned long ch0 = 2 * chs;
+	unsigned long ch1 = 2 * chs + 1;
+
+	if (chs < 0 || chs > 2) {
+		snd_printk(KERN_ERR PREFIX
+			"Invalid channel in volume control.");
+		return 0;
+	}
+
+	ucontrol->value.integer.value[0] = rt->output_switch[ch0];
+	ucontrol->value.integer.value[1] = rt->output_switch[ch1];
+
+	return 0;
+}
+
 static int usb6fire_control_line_phono_info(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
 {
@@ -299,6 +459,75 @@
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Switch",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_mono_info,
+		.get = usb6fire_control_master_switch_get,
+		.put = usb6fire_control_master_switch_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 1/2 Playback Volume",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = usb6fire_control_output_vol_info,
+		.get = usb6fire_control_output_vol_get,
+		.put = usb6fire_control_output_vol_put,
+		.private_value = 0
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 1/2 Playback Switch",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_stereo_info,
+		.get = usb6fire_control_output_switch_get,
+		.put = usb6fire_control_output_switch_put,
+		.private_value = 0
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 3/4 Playback Volume",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = usb6fire_control_output_vol_info,
+		.get = usb6fire_control_output_vol_get,
+		.put = usb6fire_control_output_vol_put,
+		.private_value = 1
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 3/4 Playback Switch",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_stereo_info,
+		.get = usb6fire_control_output_switch_get,
+		.put = usb6fire_control_output_switch_put,
+		.private_value = 1
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 5/6 Playback Volume",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = usb6fire_control_output_vol_info,
+		.get = usb6fire_control_output_vol_get,
+		.put = usb6fire_control_output_vol_put,
+		.private_value = 2
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 5/6 Playback Switch",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_stereo_info,
+		.get = usb6fire_control_output_switch_get,
+		.put = usb6fire_control_output_switch_put,
+		.private_value = 2
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Line/Phono Capture Route",
 		.index = 0,
 		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -352,7 +581,8 @@
 
 	usb6fire_control_opt_coax_update(rt);
 	usb6fire_control_line_phono_update(rt);
-	usb6fire_control_master_vol_update(rt);
+	usb6fire_control_output_vol_update(rt);
+	usb6fire_control_output_switch_update(rt);
 	usb6fire_control_streaming_update(rt);
 
 	i = 0;
@@ -378,3 +608,4 @@
 	kfree(chip->control);
 	chip->control = NULL;
 }
+
diff -Nur a/sound/usb/6fire/control.h b/sound/usb/6fire/control.h
--- a/sound/usb/6fire/control.h	2011-09-02 13:48:10.000000000 +0000
+++ b/sound/usb/6fire/control.h	2011-09-02 13:50:30.000000000 +0000
@@ -3,9 +3,13 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.6
  * Copyright:	(C) Torsten Schenk
  *
+ * Thanks to:
+ * - Holger Ruckdeschel: he found out how to control individual analog
+ *   channel volumes and introduced mute switches
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -45,6 +49,9 @@
 	bool digital_thru_switch;
 	bool usb_streaming;
 	u8 master_vol;
+	bool master_switch;
+	u8 output_vol[6];
+	bool output_switch[6];
 };
 
 int __devinit usb6fire_control_init(struct sfire_chip *chip);
