From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: TerraTec DMX 6Fire USB updates
Date: Sun, 03 Apr 2011 14:30:43 +0200
Message-ID: <12f1b580363.6419672029244585187.-6233154609191024090@zoho.com>
References: <12d995c1fa0.477955495632923443.5387390398635058860@zoho.com>
	<s5hr5c7bjmr.wl%tiwai@suse.de>
	<12da59486cd.-2882799020629445819.-7235974021966893201@zoho.com>
	<s5hmxmuiqgw.wl%tiwai@suse.de>
	<12da867d460.-8772675728917411279.-4777530225625691984@zoho.com>
	<12f0d60921e.7616534511239462585.4849758772336073987@zoho.com>
	<s5hr59mw2u5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_1193_1559666999.1301833843550"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id D215C2413B
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Apr 2011 14:30:46 +0200 (CEST)
In-Reply-To: <s5hr59mw2u5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

------=_Part_1193_1559666999.1301833843550
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Ok, fixed your two issues. Here the changelog and the patch again:

- control: digital thru added (for conversion optical<->tos)
- restructuring: samplerate, channel and streaming control moved to control.c
- firmware loader: loader now accepts all hardware versions of the device
- firmware loader: if firmware is already present it will be accepted if it is known to be working
- pcm: added support for s32_le sampleformat
- makefile: "experimental" dependency removed (tested and confirmed by users on http://sixfireusb.sourceforge.net)
- makefile: description updated
- bugfix: unsigned pcm_runtime.rate now never uses negative values (completion of signedness bug correction submitted by Dan Carpenter)
- bugfix: firmware leak fixed if error occurs (already submitted by Jesper Juhl but not in kernel yet)

Thanks
Torsten

------=_Part_1193_1559666999.1301833843550
Content-Type: application/octet-stream; name=usb6fire.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=usb6fire.patch

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
--- a/sound/usb/6fire/chip.c	2011-03-31 21:20:22.634973287 +0200
+++ b/sound/usb/6fire/chip.c	2011-04-03 14:08:29.753369038 +0200
@@ -5,7 +5,7 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.5
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
@@ -29,7 +29,7 @@
 #include <sound/initval.h>
 
 MODULE_AUTHOR("Torsten Schenk <torsten.schenk@zoho.com>");
-MODULE_DESCRIPTION("TerraTec DMX 6Fire USB audio driver, version 0.3.0");
+MODULE_DESCRIPTION("TerraTec DMX 6Fire USB audio driver, version 0.3.5");
 MODULE_LICENSE("GPL v2");
 MODULE_SUPPORTED_DEVICE("{{TerraTec, DMX 6Fire USB}}");
 
diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2011-03-31 21:20:22.633973308 +0200
+++ b/sound/usb/6fire/control.c	2011-04-02 05:40:48.812252998 +0200
@@ -5,7 +5,7 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.5
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
@@ -65,6 +65,15 @@
 	{ 0 } /* TERMINATING ENTRY */
 };
 
+static const int rates_altsetting[] = { 1, 1, 2, 2, 3, 3 };
+/* values to write to soundcard register for all samplerates */
+static const u16 rates_6fire_vl[] = {0x00, 0x01, 0x00, 0x01, 0x00, 0x01};
+static const u16 rates_6fire_vh[] = {0x11, 0x11, 0x10, 0x10, 0x00, 0x00};
+
+enum {
+	DIGITAL_THRU_ONLY_SAMPLERATE = 3
+};
+
 static void usb6fire_control_master_vol_update(struct control_runtime *rt)
 {
 	struct comm_runtime *comm_rt = rt->chip->comm;
@@ -95,6 +104,67 @@
 	}
 }
 
+static int usb6fire_control_set_rate(struct control_runtime *rt, int rate)
+{
+	int ret;
+	struct usb_device *device = rt->chip->dev;
+	struct comm_runtime *comm_rt = rt->chip->comm;
+
+	if (rate < 0 || rate >= CONTROL_N_RATES)
+		return -EINVAL;
+
+	ret = usb_set_interface(device, 1, rates_altsetting[rate]);
+	if (ret < 0)
+		return ret;
+
+	/* set soundcard clock */
+	ret = comm_rt->write16(comm_rt, 0x02, 0x01, rates_6fire_vl[rate],
+			rates_6fire_vh[rate]);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int usb6fire_control_set_channels(
+	struct control_runtime *rt, int n_analog_out,
+	int n_analog_in, bool spdif_out, bool spdif_in)
+{
+	int ret;
+	struct comm_runtime *comm_rt = rt->chip->comm;
+
+	/* enable analog inputs and outputs
+	 * (one bit per stereo-channel) */
+	ret = comm_rt->write16(comm_rt, 0x02, 0x02,
+			(1 << (n_analog_out / 2)) - 1,
+			(1 << (n_analog_in / 2)) - 1);
+	if (ret < 0)
+		return ret;
+
+	/* disable digital inputs and outputs */
+	/* TODO: use spdif_x to enable/disable digital channels */
+	ret = comm_rt->write16(comm_rt, 0x02, 0x03, 0x00, 0x00);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int usb6fire_control_streaming_update(struct control_runtime *rt)
+{
+	struct comm_runtime *comm_rt = rt->chip->comm;
+
+	if (comm_rt) {
+		if (!rt->usb_streaming && rt->digital_thru_switch)
+			usb6fire_control_set_rate(rt,
+				DIGITAL_THRU_ONLY_SAMPLERATE);
+		return comm_rt->write16(comm_rt, 0x02, 0x00, 0x00,
+			(rt->usb_streaming ? 0x01 : 0x00) |
+			(rt->digital_thru_switch ? 0x08 : 0x00));
+	}
+	return -EINVAL;
+}
+
 static int usb6fire_control_master_vol_info(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
 {
@@ -195,6 +265,28 @@
 	return 0;
 }
 
+static int usb6fire_control_digital_thru_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
+
+	if (rt->digital_thru_switch != ucontrol->value.integer.value[0]) {
+		rt->digital_thru_switch = ucontrol->value.integer.value[0];
+		usb6fire_control_streaming_update(rt);
+		changed = 1;
+	}
+	return changed;
+}
+
+static int usb6fire_control_digital_thru_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.integer.value[0] = rt->digital_thru_switch;
+	return 0;
+}
+
 static struct __devinitdata snd_kcontrol_new elements[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -223,6 +315,15 @@
 		.get = usb6fire_control_opt_coax_get,
 		.put = usb6fire_control_opt_coax_put
 	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Digital Thru Playback Route",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_mono_info,
+		.get = usb6fire_control_digital_thru_get,
+		.put = usb6fire_control_digital_thru_put
+	},
 	{}
 };
 
@@ -238,6 +339,9 @@
 		return -ENOMEM;
 
 	rt->chip = chip;
+	rt->update_streaming = usb6fire_control_streaming_update;
+	rt->set_rate = usb6fire_control_set_rate;
+	rt->set_channels = usb6fire_control_set_channels;
 
 	i = 0;
 	while (init_data[i].type) {
@@ -249,6 +353,7 @@
 	usb6fire_control_opt_coax_update(rt);
 	usb6fire_control_line_phono_update(rt);
 	usb6fire_control_master_vol_update(rt);
+	usb6fire_control_streaming_update(rt);
 
 	i = 0;
 	while (elements[i].name) {
diff -Nur a/sound/usb/6fire/control.h b/sound/usb/6fire/control.h
--- a/sound/usb/6fire/control.h	2011-03-31 21:20:22.633973308 +0200
+++ b/sound/usb/6fire/control.h	2011-03-31 21:07:57.018973241 +0200
@@ -3,7 +3,7 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.4
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
@@ -21,12 +21,29 @@
 	CONTROL_MAX_ELEMENTS = 32
 };
 
+enum {
+	CONTROL_RATE_44KHZ,
+	CONTROL_RATE_48KHZ,
+	CONTROL_RATE_88KHZ,
+	CONTROL_RATE_96KHZ,
+	CONTROL_RATE_176KHZ,
+	CONTROL_RATE_192KHZ,
+	CONTROL_N_RATES
+};
+
 struct control_runtime {
+	int (*update_streaming)(struct control_runtime *rt);
+	int (*set_rate)(struct control_runtime *rt, int rate);
+	int (*set_channels)(struct control_runtime *rt, int n_analog_out,
+		int n_analog_in, bool spdif_out, bool spdif_in);
+
 	struct sfire_chip *chip;
 
 	struct snd_kcontrol *element[CONTROL_MAX_ELEMENTS];
 	bool opt_coax_switch;
 	bool line_phono_switch;
+	bool digital_thru_switch;
+	bool usb_streaming;
 	u8 master_vol;
 };
 
diff -Nur a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
--- a/sound/usb/6fire/firmware.c	2011-03-31 21:20:22.633973308 +0200
+++ b/sound/usb/6fire/firmware.c	2011-04-02 05:41:04.483252999 +0200
@@ -3,15 +3,9 @@
  *
  * Firmware loader
  *
- * Currently not working for all devices. To be able to use the device
- * in linux, it is also possible to let the windows driver upload the firmware.
- * For that, start the computer in windows and reboot.
- * As long as the device is connected to the power supply, no firmware reload
- * needs to be performed.
- *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.5
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
@@ -72,6 +66,10 @@
 	0x94, 0x01, 0x5c, 0x02  /* alt 3: 404 EP2 and 604 EP6 (25 fpp) */
 };
 
+static const u8 known_fw_versions[][4] = {
+	{ 0x03, 0x01, 0x0b, 0x00 }
+};
+
 struct ihex_record {
 	u16 address;
 	u8 len;
@@ -254,6 +252,7 @@
 	ret = usb6fire_fw_ihex_init(fw, rec);
 	if (ret < 0) {
 		kfree(rec);
+		release_firmware(fw);
 		snd_printk(KERN_ERR PREFIX "error validating ezusb "
 				"firmware %s.\n", fwname);
 		return ret;
@@ -363,6 +362,25 @@
 	return 0;
 }
 
+/* check, if the firmware version the devices has currently loaded
+ * is known by this driver. 'version' needs to have 4 bytes version
+ * info data. */
+static int usb6fire_fw_check(u8 *version)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(known_fw_versions); i++)
+		if (!memcmp(version, known_fw_versions + i, 4))
+			return 0;
+
+	snd_printk(KERN_ERR PREFIX "invalid fimware version in device: "
+			"%02x %02x %02x %02x. "
+			"please reconnect to power. if this failure "
+			"still happens, check your firmware installation.",
+			version[0], version[1], version[2], version[3]);
+	return -EINVAL;
+}
+
 int usb6fire_fw_init(struct usb_interface *intf)
 {
 	int i;
@@ -378,9 +396,12 @@
 				"firmware state.\n");
 		return ret;
 	}
-	if (buffer[0] != 0xeb || buffer[1] != 0xaa || buffer[2] != 0x55
-			|| buffer[4] != 0x03 || buffer[5] != 0x01 || buffer[7]
-			!= 0x00) {
+		snd_printk(KERN_ERR PREFIX "device firmware state"
+				": ");
+		for (i = 0; i < 8; i++)
+			snd_printk("%02x ", buffer[i]);
+		snd_printk("\n");
+	if (buffer[0] != 0xeb || buffer[1] != 0xaa || buffer[2] != 0x55) {
 		snd_printk(KERN_ERR PREFIX "unknown device firmware state "
 				"received from device: ");
 		for (i = 0; i < 8; i++)
@@ -389,7 +410,7 @@
 		return -EIO;
 	}
 	/* do we need fpga loader ezusb firmware? */
-	if (buffer[3] == 0x01 && buffer[6] == 0x19) {
+	if (buffer[3] == 0x01) {
 		ret = usb6fire_fw_ezusb_upload(intf,
 				"6fire/dmx6firel2.ihx", 0, NULL, 0);
 		if (ret < 0)
@@ -397,7 +418,10 @@
 		return FW_NOT_READY;
 	}
 	/* do we need fpga firmware and application ezusb firmware? */
-	else if (buffer[3] == 0x02 && buffer[6] == 0x0b) {
+	else if (buffer[3] == 0x02) {
+		ret = usb6fire_fw_check(buffer + 4);
+		if (ret < 0)
+			return ret;
 		ret = usb6fire_fw_fpga_upload(intf, "6fire/dmx6firecf.bin");
 		if (ret < 0)
 			return ret;
@@ -410,8 +434,8 @@
 		return FW_NOT_READY;
 	}
 	/* all fw loaded? */
-	else if (buffer[3] == 0x03 && buffer[6] == 0x0b)
-		return 0;
+	else if (buffer[3] == 0x03)
+		return usb6fire_fw_check(buffer + 4);
 	/* unknown data? */
 	else {
 		snd_printk(KERN_ERR PREFIX "unknown device firmware state "
diff -Nur a/sound/usb/6fire/firmware.h b/sound/usb/6fire/firmware.h
--- a/sound/usb/6fire/firmware.h	2011-03-31 21:20:22.634973287 +0200
+++ b/sound/usb/6fire/firmware.h	2011-03-31 21:13:59.276973000 +0200
@@ -1,8 +1,9 @@
 /*
  * Linux driver for TerraTec DMX 6Fire USB
  *
- * Author: Torsten Schenk
- * Created: Jan 01, 2011
+ * Author:	Torsten Schenk
+ * Created:	Jan 01, 2011
+ * Version:	0.3.0
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
diff -Nur a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
--- a/sound/usb/6fire/pcm.c	2011-03-31 21:20:22.632973329 +0200
+++ b/sound/usb/6fire/pcm.c	2011-04-02 05:40:58.672253000 +0200
@@ -5,7 +5,7 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.5
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
@@ -17,26 +17,23 @@
 #include "pcm.h"
 #include "chip.h"
 #include "comm.h"
+#include "control.h"
 
 enum {
 	OUT_N_CHANNELS = 6, IN_N_CHANNELS = 4
 };
 
 /* keep next two synced with
- * FW_EP_W_MAX_PACKET_SIZE[] and RATES_MAX_PACKET_SIZE */
+ * FW_EP_W_MAX_PACKET_SIZE[] and RATES_MAX_PACKET_SIZE
+ * and CONTROL_RATE_XXX in control.h */
 static const int rates_in_packet_size[] = { 228, 228, 420, 420, 404, 404 };
 static const int rates_out_packet_size[] = { 228, 228, 420, 420, 604, 604 };
 static const int rates[] = { 44100, 48000, 88200, 96000, 176400, 192000 };
-static const int rates_altsetting[] = { 1, 1, 2, 2, 3, 3 };
 static const int rates_alsaid[] = {
 	SNDRV_PCM_RATE_44100, SNDRV_PCM_RATE_48000,
 	SNDRV_PCM_RATE_88200, SNDRV_PCM_RATE_96000,
 	SNDRV_PCM_RATE_176400, SNDRV_PCM_RATE_192000 };
 
-/* values to write to soundcard register for all samplerates */
-static const u16 rates_6fire_vl[] = {0x00, 0x01, 0x00, 0x01, 0x00, 0x01};
-static const u16 rates_6fire_vh[] = {0x11, 0x11, 0x10, 0x10, 0x00, 0x00};
-
 enum { /* settings for pcm */
 	OUT_EP = 6, IN_EP = 2, MAX_BUFSIZE = 128 * 1024
 };
@@ -48,15 +45,6 @@
 	STREAM_STOPPING
 };
 
-enum { /* pcm sample rates (also index into RATES_XXX[]) */
-	RATE_44KHZ,
-	RATE_48KHZ,
-	RATE_88KHZ,
-	RATE_96KHZ,
-	RATE_176KHZ,
-	RATE_192KHZ
-};
-
 static const struct snd_pcm_hardware pcm_hw = {
 	.info = SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_INTERLEAVED |
@@ -64,7 +52,7 @@
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_BATCH,
 
-	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.formats = SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
 
 	.rates = SNDRV_PCM_RATE_44100 |
 		SNDRV_PCM_RATE_48000 |
@@ -87,57 +75,34 @@
 static int usb6fire_pcm_set_rate(struct pcm_runtime *rt)
 {
 	int ret;
-	struct usb_device *device = rt->chip->dev;
-	struct comm_runtime *comm_rt = rt->chip->comm;
+	struct control_runtime *ctrl_rt = rt->chip->control;
 
-	if (rt->rate >= ARRAY_SIZE(rates))
-		return -EINVAL;
-	/* disable streaming */
-	ret = comm_rt->write16(comm_rt, 0x02, 0x00, 0x00, 0x00);
+	ctrl_rt->usb_streaming = false;
+	ret = ctrl_rt->update_streaming(ctrl_rt);
 	if (ret < 0) {
 		snd_printk(KERN_ERR PREFIX "error stopping streaming while "
 				"setting samplerate %d.\n", rates[rt->rate]);
 		return ret;
 	}
 
-	ret = usb_set_interface(device, 1, rates_altsetting[rt->rate]);
-	if (ret < 0) {
-		snd_printk(KERN_ERR PREFIX "error setting interface "
-				"altsetting %d for samplerate %d.\n",
-				rates_altsetting[rt->rate], rates[rt->rate]);
-		return ret;
-	}
-
-	/* set soundcard clock */
-	ret = comm_rt->write16(comm_rt, 0x02, 0x01, rates_6fire_vl[rt->rate],
-			rates_6fire_vh[rt->rate]);
+	ret = ctrl_rt->set_rate(ctrl_rt, rt->rate);
 	if (ret < 0) {
 		snd_printk(KERN_ERR PREFIX "error setting samplerate %d.\n",
 				rates[rt->rate]);
 		return ret;
 	}
 
-	/* enable analog inputs and outputs
-	 * (one bit per stereo-channel) */
-	ret = comm_rt->write16(comm_rt, 0x02, 0x02,
-			(1 << (OUT_N_CHANNELS / 2)) - 1,
-			(1 << (IN_N_CHANNELS / 2)) - 1);
+	ret = ctrl_rt->set_channels(ctrl_rt, OUT_N_CHANNELS, IN_N_CHANNELS,
+			false, false);
 	if (ret < 0) {
-		snd_printk(KERN_ERR PREFIX "error initializing analog channels "
+		snd_printk(KERN_ERR PREFIX "error initializing channels "
 				"while setting samplerate %d.\n",
 				rates[rt->rate]);
 		return ret;
 	}
-	/* disable digital inputs and outputs */
-	ret = comm_rt->write16(comm_rt, 0x02, 0x03, 0x00, 0x00);
-	if (ret < 0) {
-		snd_printk(KERN_ERR PREFIX "error initializing digital "
-				"channels while setting samplerate %d.\n",
-				rates[rt->rate]);
-		return ret;
-	}
 
-	ret = comm_rt->write16(comm_rt, 0x02, 0x00, 0x00, 0x01);
+	ctrl_rt->usb_streaming = true;
+	ret = ctrl_rt->update_streaming(ctrl_rt);
 	if (ret < 0) {
 		snd_printk(KERN_ERR PREFIX "error starting streaming while "
 				"setting samplerate %d.\n", rates[rt->rate]);
@@ -168,12 +133,15 @@
 static void usb6fire_pcm_stream_stop(struct pcm_runtime *rt)
 {
 	int i;
+	struct control_runtime *ctrl_rt = rt->chip->control;
 
 	if (rt->stream_state != STREAM_DISABLED) {
 		for (i = 0; i < PCM_N_URBS; i++) {
 			usb_kill_urb(&rt->in_urbs[i].instance);
 			usb_kill_urb(&rt->out_urbs[i].instance);
 		}
+		ctrl_rt->usb_streaming = false;
+		ctrl_rt->update_streaming(ctrl_rt);
 		rt->stream_state = STREAM_DISABLED;
 	}
 }
@@ -228,7 +196,7 @@
 	unsigned int total_length = 0;
 	struct pcm_runtime *rt = snd_pcm_substream_chip(sub->instance);
 	struct snd_pcm_runtime *alsa_rt = sub->instance->runtime;
-	u32 *src = (u32 *) urb->buffer;
+	u32 *src = NULL;
 	u32 *dest = (u32 *) (alsa_rt->dma_area + sub->dma_off
 			* (alsa_rt->frame_bits >> 3));
 	u32 *dest_end = (u32 *) (alsa_rt->dma_area + alsa_rt->buffer_size
@@ -244,7 +212,12 @@
 		else
 			frame_count = 0;
 
-		src = (u32 *) (urb->buffer + total_length);
+		if (alsa_rt->format == SNDRV_PCM_FORMAT_S24_LE)
+			src = (u32 *) (urb->buffer + total_length);
+		else if (alsa_rt->format == SNDRV_PCM_FORMAT_S32_LE)
+			src = (u32 *) (urb->buffer - 1 + total_length);
+		else
+			return;
 		src++; /* skip leading 4 bytes of every packet */
 		total_length += urb->packets[i].length;
 		for (frame = 0; frame < frame_count; frame++) {
@@ -274,9 +247,18 @@
 			* (alsa_rt->frame_bits >> 3));
 	u32 *src_end = (u32 *) (alsa_rt->dma_area + alsa_rt->buffer_size
 			* (alsa_rt->frame_bits >> 3));
-	u32 *dest = (u32 *) urb->buffer;
+	u32 *dest;
 	int bytes_per_frame = alsa_rt->channels << 2;
 
+	if (alsa_rt->format == SNDRV_PCM_FORMAT_S32_LE)
+		dest = (u32 *) (urb->buffer - 1);
+	else if (alsa_rt->format == SNDRV_PCM_FORMAT_S24_LE)
+		dest = (u32 *) (urb->buffer);
+	else {
+		snd_printk(KERN_ERR PREFIX "Unknown sample format.");
+		return;
+	}
+
 	for (i = 0; i < PCM_N_PACKETS_PER_URB; i++) {
 		/* at least 4 header bytes for valid packet.
 		 * after that: 32 bits per sample for analog channels */
@@ -456,7 +438,7 @@
 		/* all substreams closed? if so, stop streaming */
 		if (!rt->playback.instance && !rt->capture.instance) {
 			usb6fire_pcm_stream_stop(rt);
-			rt->rate = -1;
+			rt->rate = ARRAY_SIZE(rates);
 		}
 	}
 	mutex_unlock(&rt->stream_mutex);
@@ -480,7 +462,6 @@
 	struct pcm_runtime *rt = snd_pcm_substream_chip(alsa_sub);
 	struct pcm_substream *sub = usb6fire_pcm_get_substream(alsa_sub);
 	struct snd_pcm_runtime *alsa_rt = alsa_sub->runtime;
-	int i;
 	int ret;
 
 	if (rt->panic)
@@ -493,12 +474,10 @@
 	sub->period_off = 0;
 
 	if (rt->stream_state == STREAM_DISABLED) {
-		for (i = 0; i < ARRAY_SIZE(rates); i++)
-			if (alsa_rt->rate == rates[i]) {
-				rt->rate = i;
+		for (rt->rate = 0; rt->rate < ARRAY_SIZE(rates); rt->rate++)
+			if (alsa_rt->rate == rates[rt->rate])
 				break;
-			}
-		if (i == ARRAY_SIZE(rates)) {
+		if (rt->rate == ARRAY_SIZE(rates)) {
 			mutex_unlock(&rt->stream_mutex);
 			snd_printk("invalid rate %d in prepare.\n",
 					alsa_rt->rate);
@@ -613,7 +592,7 @@
 
 	rt->chip = chip;
 	rt->stream_state = STREAM_DISABLED;
-	rt->rate = -1;
+	rt->rate = ARRAY_SIZE(rates);
 	init_waitqueue_head(&rt->stream_wait_queue);
 	mutex_init(&rt->stream_mutex);
 
diff -Nur a/sound/usb/6fire/pcm.h b/sound/usb/6fire/pcm.h
--- a/sound/usb/6fire/pcm.h	2011-03-31 21:20:22.633973308 +0200
+++ b/sound/usb/6fire/pcm.h	2011-04-02 05:40:52.960252998 +0200
@@ -3,7 +3,7 @@
  *
  * Author:	Torsten Schenk <torsten.schenk@zoho.com>
  * Created:	Jan 01, 2011
- * Version:	0.3.0
+ * Version:	0.3.5
  * Copyright:	(C) Torsten Schenk
  *
  * This program is free software; you can redistribute it and/or modify
@@ -65,7 +65,7 @@
 
 	struct mutex stream_mutex;
 	u8 stream_state; /* one of STREAM_XXX (pcm.c) */
-	u8 rate; /* one of PCM_RATE_XXX */
+	u8 rate; /* one of PCM_RATE_XXX or ARRAY_SIZE(rates) if invalid */
 	wait_queue_head_t stream_wait_queue;
 	bool stream_wait_cond;
 };
diff -Nur a/sound/usb/Kconfig b/sound/usb/Kconfig
--- a/sound/usb/Kconfig	2011-03-31 21:20:22.632973329 +0200
+++ b/sound/usb/Kconfig	2011-03-31 21:07:57.017973262 +0200
@@ -100,7 +100,6 @@
 
 config SND_USB_6FIRE
         tristate "TerraTec DMX 6Fire USB"
-        depends on EXPERIMENTAL
         select FW_LOADER
         select SND_RAWMIDI
         select SND_PCM
@@ -111,5 +111,3 @@
           Say Y here to include support for TerraTec 6fire DMX USB interface.
 
           You will need firmware files in order to be able to use the device
-          after it has been coldstarted. This driver currently does not support
-          firmware loading for all devices. If you own such a device,
-          you could start windows and let the windows driver upload
-          the firmware. As long as you do not unplug your device from power,
-          it should be usable.
+          after it has been coldstarted. An install script for the firmware
+          and further help can be found at
+          http://sixfireusb.sourceforge.net
 
 endif	# SND_USB
 

------=_Part_1193_1559666999.1301833843550
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_1193_1559666999.1301833843550--
