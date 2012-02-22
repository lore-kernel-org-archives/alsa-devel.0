From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH v2 4/5] snd-usb-6fire: add mute control for
	analog outputs
Date: Wed, 22 Feb 2012 14:07:38 +0100
Message-ID: <20120222140738.11066cbb652f5f8a85606fbe@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 772A7103F38
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:07:43 +0100 (CET)
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

Add a mute control for every analog output channel.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2012-01-17 19:46:16.278171321 +0100
+++ b/sound/usb/6fire/control.c	2012-01-30 11:57:10.557379497 +0100
@@ -71,6 +71,14 @@
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
@@ -203,6 +211,51 @@
 	return 0;
 }
 
+static int usb6fire_control_output_mute_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	unsigned int ch = kcontrol->private_value;
+	u8 old = rt->output_mute;
+	u8 value = 0;
+
+	if (ch > 4) {
+		snd_printk(KERN_ERR PREFIX "Invalid channel in volume control.");
+		return -EINVAL;
+	}
+
+	rt->output_mute &= ~(3 << ch);
+	if (ucontrol->value.integer.value[0])
+		value |= 1;
+	if (ucontrol->value.integer.value[1])
+		value |= 2;
+	rt->output_mute |= value << ch;
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
+	unsigned int ch = kcontrol->private_value;
+	u8 value = rt->output_mute >> ch;
+
+	if (ch > 4) {
+		snd_printk(KERN_ERR PREFIX "Invalid channel in volume control.");
+		return -EINVAL;
+	}
+
+	ucontrol->value.integer.value[0] = 1 & value;
+	value >>= 1;
+	ucontrol->value.integer.value[1] = 1 & value;
+
+	return 0;
+}
+
 static int usb6fire_control_line_phono_info(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
 {
@@ -334,6 +387,40 @@
 	{}
 };
 
+static struct __devinitdata snd_kcontrol_new mute_elements[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Analog Playback Switch",
+		.index = 1,
+		.private_value = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_stereo_info,
+		.get = usb6fire_control_output_mute_get,
+		.put = usb6fire_control_output_mute_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Analog Playback Switch",
+		.index = 2,
+		.private_value = 2,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_stereo_info,
+		.get = usb6fire_control_output_mute_get,
+		.put = usb6fire_control_output_mute_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Analog Playback Switch",
+		.index = 3,
+		.private_value = 4,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_stereo_info,
+		.get = usb6fire_control_output_mute_get,
+		.put = usb6fire_control_output_mute_put,
+	},
+	{}
+};
+
 static struct __devinitdata snd_kcontrol_new elements[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -424,13 +511,21 @@
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
