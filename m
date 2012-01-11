From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH 3/4] snd-usb-6fire: add mute controls for
	analog outputs
Date: Thu, 12 Jan 2012 00:20:53 +0100
Message-ID: <134cf12f4fd.1574118752958116911.-3721388930631012079@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id ABF2224759
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 00:20:56 +0100 (CET)
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

Add an individual mute control for every analog output channel.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2012-01-12 00:10:48.981232196 +0100
+++ b/sound/usb/6fire/control.c	2012-01-12 00:19:40.680844042 +0100
@@ -68,6 +68,14 @@
 				180 - rt->output_vol[i]);
 }
 
+static void usb6fire_control_output_mute_update(struct control_runtime *rt)
+{
+	struct comm_runtime *comm_rt = rt->chip->comm;
+
+	if (comm_rt)
+		comm_rt->write8(comm_rt, 0x12, 0x0e, ~rt->output_mute);
+}
+
 static void usb6fire_control_line_phono_update(struct control_runtime *rt)
 {
 	struct comm_runtime *comm_rt = rt->chip->comm;
@@ -204,6 +212,51 @@
 	return 0;
 }
 
+static int usb6fire_control_output_mute_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	unsigned long chs = kcontrol->private_value;
+	unsigned long ch0 = 2 * chs;
+	unsigned long ch1 = 2 * chs + 1;
+	u8 old = rt->output_mute;
+
+	if (chs < 0 || chs > 2) {
+		snd_printk(KERN_ERR PREFIX
+			"Invalid channel in volume control.");
+		return 0;
+	}
+
+	rt->output_mute &= ~((1 << ch0) | (1 << ch1));
+	rt->output_mute |= ucontrol->value.integer.value[0] << ch0;
+	rt->output_mute |= ucontrol->value.integer.value[1] << ch1;
+
+	if (rt->output_mute != old)
+		usb6fire_control_output_mute_update(rt);
+
+	return rt->output_mute != old;
+}
+
+static int usb6fire_control_output_mute_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
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
+	ucontrol->value.integer.value[0] = 1 & (rt->output_mute >> ch0);
+	ucontrol->value.integer.value[1] = 1 & (rt->output_mute >> ch1);
+
+	return 0;
+}
+
 static int usb6fire_control_line_phono_info(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
 {
@@ -328,6 +381,39 @@
 	}
 };
 
+static struct __devinitdata snd_kcontrol_new mute_elements[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 1/2 Playback Switch",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_stereo_info,
+		.get = usb6fire_control_output_mute_get,
+		.put = usb6fire_control_output_mute_put,
+		.private_value = 0
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 3/4 Playback Switch",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_stereo_info,
+		.get = usb6fire_control_output_mute_get,
+		.put = usb6fire_control_output_mute_put,
+		.private_value = 1
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 5/6 Playback Switch",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_stereo_info,
+		.get = usb6fire_control_output_mute_get,
+		.put = usb6fire_control_output_mute_put,
+		.private_value = 2
+	}
+};
+
 static struct __devinitdata snd_kcontrol_new elements[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -418,13 +504,21 @@
 	usb6fire_control_opt_coax_update(rt);
 	usb6fire_control_line_phono_update(rt);
 	usb6fire_control_output_vol_update(rt);
+	usb6fire_control_output_mute_update(rt);
 	usb6fire_control_streaming_update(rt);
 
 	ret = usb6fire_control_add_virtual(rt, chip->card,
 		"Master Playback Volume", vol_elements);
 	if (ret) {
+		snd_printk(KERN_ERR PREFIX "cannot add control.\n");
 		kfree(rt);
+		return ret;
+	}
+	ret = usb6fire_control_add_virtual(rt, chip->card,
+		"Master Playback Switch", mute_elements);
+	if (ret) {
 		snd_printk(KERN_ERR PREFIX "cannot add control.\n");
+		kfree(rt);
 		return ret;
 	}
 
diff -Nur a/sound/usb/6fire/control.h b/sound/usb/6fire/control.h
--- a/sound/usb/6fire/control.h	2012-01-09 22:36:07.698544501 +0100
+++ b/sound/usb/6fire/control.h	2012-01-11 19:54:50.651190007 +0100
@@ -44,6 +44,7 @@
 	bool digital_thru_switch;
 	bool usb_streaming;
 	u8 output_vol[6];
+	u8 output_mute;
 };
 
 int __devinit usb6fire_control_init(struct sfire_chip *chip);
