From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: [PATCH v3 5/5] snd-usb-6fire: add analog input volume
	control
Date: Wed, 22 Feb 2012 15:21:30 +0100
Message-ID: <20120222152130.f2c496f3ecac03552b524c60@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 36DF7104092
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 15:21:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Add a stereo volume control for analog input channel pair 1/2.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
--- a/sound/usb/6fire/control.c	2012-02-22 15:05:47.206526365 +0100
+++ b/sound/usb/6fire/control.c	2012-02-22 15:11:26.846504694 +0100
@@ -55,6 +55,7 @@
 static const u16 rates_6fire_vh[] = {0x11, 0x11, 0x10, 0x10, 0x00, 0x00};
 
 static DECLARE_TLV_DB_MINMAX(tlv_output, -9000, 0);
+static DECLARE_TLV_DB_MINMAX(tlv_input, -1500, 1500);
 
 enum {
 	DIGITAL_THRU_ONLY_SAMPLERATE = 3
@@ -82,6 +83,20 @@
 		comm_rt->write8(comm_rt, 0x12, 0x0e, ~rt->output_mute);
 }
 
+static void usb6fire_control_input_vol_update(struct control_runtime *rt)
+{
+	struct comm_runtime *comm_rt = rt->chip->comm;
+	int i;
+
+	if (comm_rt)
+		for (i = 0; i < 2; i++)
+			if (!(rt->ivol_updated & (1 << i))) {
+				comm_rt->write8(comm_rt, 0x12, 0x1c + i,
+					rt->input_vol[i] & 0x3f);
+				rt->ivol_updated |= 1 << i;
+			}
+}
+
 static void usb6fire_control_line_phono_update(struct control_runtime *rt)
 {
 	struct comm_runtime *comm_rt = rt->chip->comm;
@@ -261,6 +276,50 @@
 	return 0;
 }
 
+static int usb6fire_control_input_vol_info(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 30;
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
+		rt->input_vol[0] = ucontrol->value.integer.value[0] - 15;
+		rt->ivol_updated &= ~(1 << 0);
+		changed = 1;
+	}
+	if (rt->input_vol[1] != ucontrol->value.integer.value[1]) {
+		rt->input_vol[1] = ucontrol->value.integer.value[1] - 15;
+		rt->ivol_updated &= ~(1 << 1);
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
+	ucontrol->value.integer.value[0] = rt->input_vol[0] + 15;
+	ucontrol->value.integer.value[1] = rt->input_vol[1] + 15;
+
+	return 0;
+}
+
 static int usb6fire_control_line_phono_info(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_info *uinfo)
 {
@@ -454,6 +513,17 @@
 		.get = usb6fire_control_digital_thru_get,
 		.put = usb6fire_control_digital_thru_put
 	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Analog Capture Volume",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+		.info = usb6fire_control_input_vol_info,
+		.get = usb6fire_control_input_vol_get,
+		.put = usb6fire_control_input_vol_put,
+		.tlv = { .p = tlv_input }
+	},
 	{}
 };
 
@@ -518,6 +588,7 @@
 	usb6fire_control_line_phono_update(rt);
 	usb6fire_control_output_vol_update(rt);
 	usb6fire_control_output_mute_update(rt);
+	usb6fire_control_input_vol_update(rt);
 	usb6fire_control_streaming_update(rt);
 
 	ret = usb6fire_control_add_virtual(rt, chip->card,
diff -Nur a/sound/usb/6fire/control.h b/sound/usb/6fire/control.h
--- a/sound/usb/6fire/control.h	2012-02-22 15:03:44.370251101 +0100
+++ b/sound/usb/6fire/control.h	2012-02-22 15:10:05.055517247 +0100
@@ -46,6 +46,8 @@
 	u8 output_vol[6];
 	u8 ovol_updated;
 	u8 output_mute;
+	s8 input_vol[2];
+	u8 ivol_updated;
 };
 
 int __devinit usb6fire_control_init(struct sfire_chip *chip);
