From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH 2/4] snd-usb-6fire: add individual volume
 control for analog channels
Date: Thu, 12 Jan 2012 00:15:56 +0100
Message-ID: <134cf0e6cf1.3062713576219273949.-3180076178583385995@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 77C8D24763
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 00:15:57 +0100 (CET)
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

Add a stereo volume control for every analog output pair 1/2, 3/4, 5/6.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2012-01-09 22:33:01.512182294 +0100
+++ b/sound/usb/6fire/control.c	2012-01-12 00:10:48.981232196 +0100
@@ -7,6 +7,10 @@
  * Created:	Jan 01, 2011
  * Copyright:	(C) Torsten Schenk
  *
+ * Thanks to:
+ * - Holger Ruckdeschel: he found out how to control individual channel
+ *   volumes and introduced mute switch
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -24,26 +28,6 @@
 static char *line_phono_texts[2] = { "Line", "Phono" };
 
 /*
- * calculated with $value\[i\] = 128 \cdot sqrt[3]{\frac{i}{128}}$
- * this is done because the linear values cause rapid degredation
- * of volume in the uppermost region.
- */
-static const u8 log_volume_table[128] = {
-	0x00, 0x19, 0x20, 0x24, 0x28, 0x2b, 0x2e, 0x30, 0x32, 0x34,
-	0x36, 0x38, 0x3a, 0x3b, 0x3d, 0x3e, 0x40, 0x41, 0x42, 0x43,
-	0x44, 0x46, 0x47, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e,
-	0x4e, 0x4f, 0x50, 0x51, 0x52, 0x53, 0x53, 0x54, 0x55, 0x56,
-	0x56, 0x57, 0x58, 0x58, 0x59, 0x5a, 0x5b, 0x5b, 0x5c, 0x5c,
-	0x5d, 0x5e, 0x5e, 0x5f, 0x60, 0x60, 0x61, 0x61, 0x62, 0x62,
-	0x63, 0x63, 0x64, 0x65, 0x65, 0x66, 0x66, 0x67, 0x67, 0x68,
-	0x68, 0x69, 0x69, 0x6a, 0x6a, 0x6b, 0x6b, 0x6c, 0x6c, 0x6c,
-	0x6d, 0x6d, 0x6e, 0x6e, 0x6f, 0x6f, 0x70, 0x70, 0x70, 0x71,
-	0x71, 0x72, 0x72, 0x73, 0x73, 0x73, 0x74, 0x74, 0x75, 0x75,
-	0x75, 0x76, 0x76, 0x77, 0x77, 0x77, 0x78, 0x78, 0x78, 0x79,
-	0x79, 0x7a, 0x7a, 0x7a, 0x7b, 0x7b, 0x7b, 0x7c, 0x7c, 0x7c,
-	0x7d, 0x7d, 0x7d, 0x7e, 0x7e, 0x7e, 0x7f, 0x7f };
-
-/*
  * data that needs to be sent to device. sets up card internal stuff.
  * values dumped from windows driver and filtered by trial'n'error.
  */
@@ -58,7 +42,7 @@
 	{ 0x22, 0x03, 0x00 }, { 0x20, 0x03, 0x08 }, { 0x22, 0x04, 0x00 },
 	{ 0x20, 0x04, 0x08 }, { 0x22, 0x05, 0x01 }, { 0x20, 0x05, 0x08 },
 	{ 0x22, 0x04, 0x01 }, { 0x12, 0x04, 0x00 }, { 0x12, 0x05, 0x00 },
-	{ 0x12, 0x0d, 0x78 }, { 0x12, 0x21, 0x82 }, { 0x12, 0x22, 0x80 },
+	{ 0x12, 0x0d, 0x38 }, { 0x12, 0x21, 0x82 }, { 0x12, 0x22, 0x80 },
 	{ 0x12, 0x23, 0x00 }, { 0x12, 0x06, 0x02 }, { 0x12, 0x03, 0x00 },
 	{ 0x12, 0x02, 0x00 }, { 0x22, 0x03, 0x01 },
 	{ 0 } /* TERMINATING ENTRY */
@@ -73,16 +57,15 @@
 	DIGITAL_THRU_ONLY_SAMPLERATE = 3
 };
 
-static void usb6fire_control_master_vol_update(struct control_runtime *rt)
+static void usb6fire_control_output_vol_update(struct control_runtime *rt)
 {
 	struct comm_runtime *comm_rt = rt->chip->comm;
-	if (comm_rt) {
-		/* set volume */
-		comm_rt->write8(comm_rt, 0x12, 0x0f, 0x7f -
-				log_volume_table[rt->master_vol]);
-		 /* unmute */
-		comm_rt->write8(comm_rt, 0x12, 0x0e, 0x00);
-	}
+	int i;
+
+	if (comm_rt)
+		for (i = 0; i < 6; i++)
+			comm_rt->write8(comm_rt, 0x12, 0x0f + i,
+				180 - rt->output_vol[i]);
 }
 
 static void usb6fire_control_line_phono_update(struct control_runtime *rt)
@@ -141,7 +124,6 @@
 		return ret;
 
 	/* disable digital inputs and outputs */
-	/* TODO: use spdif_x to enable/disable digital channels */
 	ret = comm_rt->write16(comm_rt, 0x02, 0x03, 0x00, 0x00);
 	if (ret < 0)
 		return ret;
@@ -164,34 +146,61 @@
 	return -EINVAL;
 }
 
-static int usb6fire_control_master_vol_info(struct snd_kcontrol *kcontrol,
+static int usb6fire_control_output_vol_info(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 1;
+	uinfo->count = 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 127;
+	uinfo->value.integer.max = 180;
 	return 0;
 }
 
-static int usb6fire_control_master_vol_put(struct snd_kcontrol *kcontrol,
+static int usb6fire_control_output_vol_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	unsigned long chs = kcontrol->private_value;
+	unsigned long ch0 = 2 * chs;
+	unsigned long ch1 = 2 * chs + 1;
 	int changed = 0;
-	if (rt->master_vol != ucontrol->value.integer.value[0]) {
-		rt->master_vol = ucontrol->value.integer.value[0];
-		usb6fire_control_master_vol_update(rt);
+
+	if (chs < 0 || chs > 2) {
+		snd_printk(KERN_ERR PREFIX "Invalid channel in volume control.");
+		return 0;
+	}
+
+	if (rt->output_vol[ch0] != ucontrol->value.integer.value[0]) {
+		rt->output_vol[ch0] = ucontrol->value.integer.value[0];
 		changed = 1;
 	}
+	if (rt->output_vol[ch1] != ucontrol->value.integer.value[1]) {
+		rt->output_vol[ch1] = ucontrol->value.integer.value[1];
+		changed = 1;
+	}
+
+	if (changed)
+		usb6fire_control_output_vol_update(rt);
+
 	return changed;
 }
 
-static int usb6fire_control_master_vol_get(struct snd_kcontrol *kcontrol,
+static int usb6fire_control_output_vol_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
-	ucontrol->value.integer.value[0] = rt->master_vol;
+	unsigned long chs = kcontrol->private_value;
+	unsigned long ch0 = 2 * chs;
+	unsigned long ch1 = 2 * chs + 1;
+
+	if (chs < 0 || chs > 2) {
+		snd_printk(KERN_ERR PREFIX "Invalid channel in volume control.");
+		return 0;
+	}
+
+	ucontrol->value.integer.value[0] = rt->output_vol[ch0];
+	ucontrol->value.integer.value[1] = rt->output_vol[ch1];
+
 	return 0;
 }
 
@@ -286,18 +295,42 @@
 	return 0;
 }
 
-static struct __devinitdata snd_kcontrol_new elements[] = {
+static struct __devinitdata snd_kcontrol_new vol_elements[] = {
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
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Master Playback Volume",
+		.name = "Output 3/4 Playback Volume",
 		.index = 0,
 		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
-		.info = usb6fire_control_master_vol_info,
-		.get = usb6fire_control_master_vol_get,
-		.put = usb6fire_control_master_vol_put
+		.info = usb6fire_control_output_vol_info,
+		.get = usb6fire_control_output_vol_get,
+		.put = usb6fire_control_output_vol_put,
+		.private_value = 1
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 5/6 Playback Volume",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = usb6fire_control_output_vol_info,
+		.get = usb6fire_control_output_vol_get,
+		.put = usb6fire_control_output_vol_put,
+		.private_value = 2
+	}
+};
+
+static struct __devinitdata snd_kcontrol_new elements[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Line/Phono Capture Route",
 		.index = 0,
 		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -326,6 +359,39 @@
 	{}
 };
 
+static int usb6fire_control_add_virtual(
+	struct control_runtime *rt,
+	struct snd_card *card,
+	char *name,
+	struct snd_kcontrol_new *elems)
+{
+	int ret;
+	int i;
+	struct snd_kcontrol *vmaster = snd_ctl_make_virtual_master(name, NULL);
+	struct snd_kcontrol *control;
+
+	if (!vmaster)
+		return -ENOMEM;
+	ret = snd_ctl_add(card, vmaster);
+	if (ret < 0)
+		return ret;
+
+	i = 0;
+	while (elems[i].name) {
+		control = snd_ctl_new1(&elems[i], rt);
+		if (!control)
+			return -ENOMEM;
+		ret = snd_ctl_add(card, control);
+		if (ret < 0)
+			return ret;
+		ret = snd_ctl_add_slave(vmaster, control);
+		if (ret < 0)
+			return ret;
+		i++;
+	}
+	return 0;
+}
+
 int __devinit usb6fire_control_init(struct sfire_chip *chip)
 {
 	int i;
@@ -351,9 +417,17 @@
 
 	usb6fire_control_opt_coax_update(rt);
 	usb6fire_control_line_phono_update(rt);
-	usb6fire_control_master_vol_update(rt);
+	usb6fire_control_output_vol_update(rt);
 	usb6fire_control_streaming_update(rt);
 
+	ret = usb6fire_control_add_virtual(rt, chip->card,
+		"Master Playback Volume", vol_elements);
+	if (ret) {
+		kfree(rt);
+		snd_printk(KERN_ERR PREFIX "cannot add control.\n");
+		return ret;
+	}
+
 	i = 0;
 	while (elements[i].name) {
 		ret = snd_ctl_add(chip->card, snd_ctl_new1(&elements[i], rt));
diff -Nur a/sound/usb/6fire/control.h b/sound/usb/6fire/control.h
--- a/sound/usb/6fire/control.h	2012-01-09 22:32:56.088002206 +0100
+++ b/sound/usb/6fire/control.h	2012-01-09 22:36:07.698544501 +0100
@@ -43,7 +43,7 @@
 	bool line_phono_switch;
 	bool digital_thru_switch;
 	bool usb_streaming;
-	u8 master_vol;
+	u8 output_vol[6];
 };
 
 int __devinit usb6fire_control_init(struct sfire_chip *chip);
