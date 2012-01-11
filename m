From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH 4/4] snd-usb-6fire: add analog input volume
	control
Date: Thu, 12 Jan 2012 00:26:26 +0100
Message-ID: <134cf180abb.215448976766498892.6045923433041263329@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F33F103AED
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 00:26:31 +0100 (CET)
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

- Add a stereo volume control for analog input channel pair 1/2.
- Add missing end-of-list entry at end of list for array mute_elements
  and vol_elements

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2012-01-12 00:19:40.680844042 +0100
+++ b/sound/usb/6fire/control.c	2012-01-12 00:23:21.013835655 +0100
@@ -76,6 +76,17 @@
 		comm_rt->write8(comm_rt, 0x12, 0x0e, ~rt->output_mute);
 }
 
+static void usb6fire_control_input_vol_update(struct control_runtime *rt)
+{
+	struct comm_runtime *comm_rt = rt->chip->comm;
+	int i;
+
+	if (comm_rt)
+		for (i = 0; i < 2; i++)
+			comm_rt->write8(comm_rt, 0x12, 0x1c + i,
+				rt->input_vol[i] & 0x3f);
+}
+
 static void usb6fire_control_line_phono_update(struct control_runtime *rt)
 {
 	struct comm_runtime *comm_rt = rt->chip->comm;
@@ -257,6 +268,48 @@
 	return 0;
 }
 
+static int usb6fire_control_input_vol_info(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = -15;
+	uinfo->value.integer.max = 15;
+	return 0;
+}
+
+static int usb6fire_control_input_vol_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
+
+	if (rt->input_vol[0] != ucontrol->value.integer.value[0]) {
+		rt->input_vol[0] = ucontrol->value.integer.value[0];
+		changed = 1;
+	}
+	if (rt->input_vol[1] != ucontrol->value.integer.value[1]) {
+		rt->input_vol[1] = ucontrol->value.integer.value[1];
+		changed = 1;
+	}
+
+	if (changed)
+		usb6fire_control_input_vol_update(rt);
+
+	return changed;
+}
+
+static int usb6fire_control_input_vol_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = rt->input_vol[0];
+	ucontrol->value.integer.value[1] = rt->input_vol[1];
+
+	return 0;
+}
+
 static int usb6fire_control_line_phono_info(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
 {
@@ -378,7 +431,8 @@
 		.get = usb6fire_control_output_vol_get,
 		.put = usb6fire_control_output_vol_put,
 		.private_value = 2
-	}
+	},
+	{}
 };
 
 static struct __devinitdata snd_kcontrol_new mute_elements[] = {
@@ -411,7 +465,8 @@
 		.get = usb6fire_control_output_mute_get,
 		.put = usb6fire_control_output_mute_put,
 		.private_value = 2
-	}
+	},
+	{}
 };
 
 static struct __devinitdata snd_kcontrol_new elements[] = {
@@ -442,6 +497,15 @@
 		.get = usb6fire_control_digital_thru_get,
 		.put = usb6fire_control_digital_thru_put
 	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 1/2 Capture Volume",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = usb6fire_control_input_vol_info,
+		.get = usb6fire_control_input_vol_get,
+		.put = usb6fire_control_input_vol_put
+	},
 	{}
 };
 
@@ -505,6 +569,7 @@
 	usb6fire_control_line_phono_update(rt);
 	usb6fire_control_output_vol_update(rt);
 	usb6fire_control_output_mute_update(rt);
+	usb6fire_control_input_vol_update(rt);
 	usb6fire_control_streaming_update(rt);
 
 	ret = usb6fire_control_add_virtual(rt, chip->card,
diff -Nur a/sound/usb/6fire/control.h b/sound/usb/6fire/control.h
--- a/sound/usb/6fire/control.h	2012-01-11 19:54:50.651190007 +0100
+++ b/sound/usb/6fire/control.h	2012-01-11 23:44:43.212950616 +0100
@@ -45,6 +45,7 @@
 	bool usb_streaming;
 	u8 output_vol[6];
 	u8 output_mute;
+	s8 input_vol[2];
 };
 
 int __devinit usb6fire_control_init(struct sfire_chip *chip);
