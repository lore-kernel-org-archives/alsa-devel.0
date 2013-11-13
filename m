From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v3] ALSA: usb-audio: add front jack channel
	selector for EMU0204
Date: Wed, 13 Nov 2013 13:13:35 +0300
Message-ID: <1384337615-7335-1-git-send-email-anarsoul@gmail.com>
References: <CA+E=qVfpLEprvr01pJY6jFxV+AufpD+EYbRnbnsfC2y7g3PJAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f44.google.com (mail-ee0-f44.google.com [74.125.83.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 145FD260864
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 11:14:42 +0100 (CET)
Received: by mail-ee0-f44.google.com with SMTP id d51so101908eek.17
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 02:14:41 -0800 (PST)
In-Reply-To: <CA+E=qVfpLEprvr01pJY6jFxV+AufpD+EYbRnbnsfC2y7g3PJAQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Yury Bushmelev <jay@jay-tech.ru>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add support for front jack channel selector which is present on EMU0204.
It allows to get 4 channels out of this soundcard.

Tested-by: Yury Bushmelev <jay@jay-tech.ru>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
v2: - pass constants for bRequest and bRequestType into snd_usb_ctl_msg()
    - implement control as an enum instead of a switch.
v3: - Fix declared array size
    - Add sanity check for a passed value to snd_emu0204_ch_switch_put()

 sound/usb/mixer_quirks.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index d42a584..3454262 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -433,6 +433,89 @@ static void snd_audigy2nx_proc_read(struct snd_info_entry *entry,
 	}
 }
 
+/* EMU0204 */
+static int snd_emu0204_ch_switch_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	static const char *texts[2] = {"1/2",
+				       "3/4"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item > 1)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
+static int snd_emu0204_ch_switch_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.enumerated.item[0] = kcontrol->private_value;
+	return 0;
+}
+
+static int snd_emu0204_ch_switch_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	unsigned int value = ucontrol->value.enumerated.item[0];
+	int err, changed;
+	unsigned char buf[2];
+
+	if (value > 1)
+		return -EINVAL;
+
+	buf[0] = 0x01;
+	buf[1] = value ? 0x02 : 0x01;
+
+	changed = value != kcontrol->private_value;
+	down_read(&mixer->chip->shutdown_rwsem);
+	if (mixer->chip->shutdown) {
+		err = -ENODEV;
+		goto out;
+	}
+	err = snd_usb_ctl_msg(mixer->chip->dev,
+		      usb_sndctrlpipe(mixer->chip->dev, 0), UAC_SET_CUR,
+		      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+		      0x0400, 0x0e00, buf, 2);
+ out:
+	up_read(&mixer->chip->shutdown_rwsem);
+	if (err < 0)
+		return err;
+	kcontrol->private_value = value;
+	return changed;
+}
+
+
+static struct snd_kcontrol_new snd_emu0204_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Front Jack Channels",
+		.info = snd_emu0204_ch_switch_info,
+		.get = snd_emu0204_ch_switch_get,
+		.put = snd_emu0204_ch_switch_put,
+		.private_value = 0,
+	},
+};
+
+static int snd_emu0204_controls_create(struct usb_mixer_interface *mixer)
+{
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(snd_emu0204_controls); ++i) {
+		err = snd_ctl_add(mixer->chip->card,
+			snd_ctl_new1(&snd_emu0204_controls[i], mixer));
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
 /* ASUS Xonar U1 / U3 controls */
 
 static int snd_xonar_u1_switch_get(struct snd_kcontrol *kcontrol,
@@ -1545,6 +1628,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 					      snd_audigy2nx_proc_read);
 		break;
 
+	/* EMU0204 */
+	case USB_ID(0x041e, 0x3f19):
+		err = snd_emu0204_controls_create(mixer);
+		if (err < 0)
+			break;
+		break;
+
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C400 */
 		err = snd_c400_create_mixer(mixer);
-- 
1.8.4.2
