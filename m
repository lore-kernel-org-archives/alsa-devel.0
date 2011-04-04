From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH 5/5] TerraTec DMX 6Fire USB updates
Date: Mon, 04 Apr 2011 11:50:53 +0200
Message-ID: <12f1fec096a.6574913021697029576.6281653297113690464@zoho.com>
References: <12d995c1fa0.477955495632923443.5387390398635058860@zoho.com>
	<s5hr5c7bjmr.wl%tiwai@suse.de>
	<12da59486cd.-2882799020629445819.-7235974021966893201@zoho.com>
	<s5hmxmuiqgw.wl%tiwai@suse.de>
	<12da867d460.-8772675728917411279.-4777530225625691984@zoho.com>
	<12f0d60921e.7616534511239462585.4849758772336073987@zoho.com>
	<s5hr59mw2u5.wl%tiwai@suse.de>
	<12f1b580363.6419672029244585187.-6233154609191024090@zoho.com>
	<s5hwrjamq64.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id BFFC31038FD
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 11:50:54 +0200 (CEST)
In-Reply-To: <s5hwrjamq64.wl%tiwai@suse.de>
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

Digital Thru mixer element added (device can act as converter optical<->coax)

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2011-03-31 21:20:22.000000000 +0200
+++ b/sound/usb/6fire/control.c	2011-04-04 11:30:05.664833001 +0200
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
--- a/sound/usb/6fire/control.h	2011-03-31 21:20:22.000000000 +0200
+++ b/sound/usb/6fire/control.h	2011-04-04 11:30:10.821833002 +0200
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
 
diff -Nur a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
--- a/sound/usb/6fire/pcm.c	2011-04-04 11:23:10.000000000 +0200
+++ b/sound/usb/6fire/pcm.c	2011-04-04 11:30:15.623833002 +0200
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
