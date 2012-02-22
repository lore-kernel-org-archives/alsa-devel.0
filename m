From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH v2 3/5] snd-usb-6fire: add individual volume
 control for analog channels
Date: Wed, 22 Feb 2012 14:07:14 +0100
Message-ID: <20120222140714.40e2e872ebcba2a6c226f6d0@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F923103F24
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:07:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Add a stereo volume control for every analog output pair 1/2, 3/4, 5/6.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2012-01-17 18:36:14.480508754 +0100
+++ b/sound/usb/6fire/control.c	2012-01-17 19:46:16.278171321 +0100
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
@@ -39,7 +43,7 @@
 	{ 0x22, 0x03, 0x00 }, { 0x20, 0x03, 0x08 }, { 0x22, 0x04, 0x00 },
 	{ 0x20, 0x04, 0x08 }, { 0x22, 0x05, 0x01 }, { 0x20, 0x05, 0x08 },
 	{ 0x22, 0x04, 0x01 }, { 0x12, 0x04, 0x00 }, { 0x12, 0x05, 0x00 },
-	{ 0x12, 0x0d, 0x78 }, { 0x12, 0x21, 0x82 }, { 0x12, 0x22, 0x80 },
+	{ 0x12, 0x0d, 0x38 }, { 0x12, 0x21, 0x82 }, { 0x12, 0x22, 0x80 },
 	{ 0x12, 0x23, 0x00 }, { 0x12, 0x06, 0x02 }, { 0x12, 0x03, 0x00 },
 	{ 0x12, 0x02, 0x00 }, { 0x22, 0x03, 0x01 },
 	{ 0 } /* TERMINATING ENTRY */
@@ -56,15 +60,15 @@
 	DIGITAL_THRU_ONLY_SAMPLERATE = 3
 };
 
-static void usb6fire_control_master_vol_update(struct control_runtime *rt)
+static void usb6fire_control_output_vol_update(struct control_runtime *rt)
 {
 	struct comm_runtime *comm_rt = rt->chip->comm;
-	if (comm_rt) {
-		/* set volume */
-		comm_rt->write8(comm_rt, 0x12, 0x0f, 180 - rt->master_vol);
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
@@ -146,34 +150,56 @@
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
 	uinfo->value.integer.max = 180;
 	return 0;
 }
 
-static int usb6fire_control_master_vol_put(struct snd_kcontrol *kcontrol,
+static int usb6fire_control_output_vol_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	unsigned int ch = kcontrol->private_value;
 	int changed = 0;
-	if (rt->master_vol != ucontrol->value.integer.value[0]) {
-		rt->master_vol = ucontrol->value.integer.value[0];
-		usb6fire_control_master_vol_update(rt);
+
+	if (ch > 4) {
+		snd_printk(KERN_ERR PREFIX "Invalid channel in volume control.");
+		return -EINVAL;
+	}
+
+	if (rt->output_vol[ch] != ucontrol->value.integer.value[0]) {
+		rt->output_vol[ch] = ucontrol->value.integer.value[0];
 		changed = 1;
 	}
+	if (rt->output_vol[ch + 1] != ucontrol->value.integer.value[1]) {
+		rt->output_vol[ch + 1] = ucontrol->value.integer.value[1];
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
+	unsigned int ch = kcontrol->private_value;
+
+	if (ch > 4) {
+		snd_printk(KERN_ERR PREFIX "Invalid channel in volume control.");
+		return -EINVAL;
+	}
+
+	ucontrol->value.integer.value[0] = rt->output_vol[ch];
+	ucontrol->value.integer.value[1] = rt->output_vol[ch + 1];
 	return 0;
 }
 
@@ -268,20 +294,49 @@
 	return 0;
 }
 
-static struct __devinitdata snd_kcontrol_new elements[] = {
+static struct __devinitdata snd_kcontrol_new vol_elements[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Master Playback Volume",
-		.index = 0,
+		.name = "Analog Playback Volume",
+		.index = 1,
+		.private_value = 0,
 		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			SNDRV_CTL_ELEM_ACCESS_TLV_READ,
-		.info = usb6fire_control_master_vol_info,
-		.get = usb6fire_control_master_vol_get,
-		.put = usb6fire_control_master_vol_put,
+		.info = usb6fire_control_output_vol_info,
+		.get = usb6fire_control_output_vol_get,
+		.put = usb6fire_control_output_vol_put,
 		.tlv = { .p = tlv_output }
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Analog Playback Volume",
+		.index = 2,
+		.private_value = 2,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+		.info = usb6fire_control_output_vol_info,
+		.get = usb6fire_control_output_vol_get,
+		.put = usb6fire_control_output_vol_put,
+		.tlv = { .p = tlv_output }
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Analog Playback Volume",
+		.index = 3,
+		.private_value = 4,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+		.info = usb6fire_control_output_vol_info,
+		.get = usb6fire_control_output_vol_get,
+		.put = usb6fire_control_output_vol_put,
+		.tlv = { .p = tlv_output }
+	},
+	{}
+};
+
+static struct __devinitdata snd_kcontrol_new elements[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Line/Phono Capture Route",
 		.index = 0,
 		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -310,6 +365,39 @@
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
@@ -335,9 +423,17 @@
 
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
