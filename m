From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH RFC] ALSA: usb-audio: add front jack channel
	selector for EMU0204
Date: Thu, 11 Jul 2013 22:57:51 +0300
Message-ID: <1373572671-3851-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 56D602658BC
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 21:59:12 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id na10so3497143bkb.19
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 12:59:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Yury Bushmelev <jay@jay-tech.ru>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add support for front jack channel selector which is present on EMU0204.
It allows to get 4 channels out of this soundcard.

Tested-by: Yury Bushmelev <jay@jay-tech.ru>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
Control request looks like generic UAC_SET_CUR request, but with a bit weird values,
valid values are { 0x01, 0x01} and { 0x01, 0x02 }, and there's no such control type ATM.
I'm not well familiar with UAC so any suggestins how to get rid of custom control req are welcome!

 sound/usb/mixer.h        |  1 +
 sound/usb/mixer_quirks.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index aab80df..4a5f001 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -23,6 +23,7 @@ struct usb_mixer_interface {
 
 	u8 audigy2nx_leds[3];
 	u8 xonar_u1_status;
+	u8 emu0204_ch_switch;
 };
 
 #define MAX_CHANNELS	16	/* max logical channels */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ebe9144..dc9a397 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -430,6 +430,76 @@ static void snd_audigy2nx_proc_read(struct snd_info_entry *entry,
 	}
 }
 
+/* EMU0204 */
+#define snd_emu0204_ch_switch_info		snd_ctl_boolean_mono_info
+
+static int snd_emu0204_ch_switch_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = mixer->emu0204_ch_switch;
+	return 0;
+}
+
+static int snd_emu0204_ch_switch_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	int value = ucontrol->value.integer.value[0];
+	int err, changed;
+	unsigned char buf[2];
+
+	if (value > 1)
+		return -EINVAL;
+
+	buf[0] = 0x01;
+	buf[1] = value ? 0x02 : 0x01;
+
+	changed = value != mixer->emu0204_ch_switch;
+	down_read(&mixer->chip->shutdown_rwsem);
+	if (mixer->chip->shutdown) {
+		err = -ENODEV;
+		goto out;
+	}
+	err = snd_usb_ctl_msg(mixer->chip->dev,
+		      usb_sndctrlpipe(mixer->chip->dev, 0), 0x1,
+		      0x21,
+		      0x0400, 0x0e00, buf, 2);
+ out:
+	up_read(&mixer->chip->shutdown_rwsem);
+	if (err < 0)
+		return err;
+	mixer->emu0204_ch_switch = value;
+	return changed;
+}
+
+
+static struct snd_kcontrol_new snd_emu0204_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Route channels 3/4 to front jack",
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
+	mixer->emu0204_ch_switch = 0; /* Default is 1/2 */
+
+	return 0;
+}
 /* ASUS Xonar U1 / U3 controls */
 
 static int snd_xonar_u1_switch_get(struct snd_kcontrol *kcontrol,
@@ -1337,6 +1407,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
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
1.8.3.2
