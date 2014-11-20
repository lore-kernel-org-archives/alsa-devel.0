From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 04/10] ALSA: usb-audio: Add Emu0204 channel
	switch resume support
Date: Thu, 20 Nov 2014 18:33:29 +0100
Message-ID: <1416504815-28685-5-git-send-email-tiwai@suse.de>
References: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D44B1260623
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E3E9CAD7D
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 17:33:46 +0000 (UTC)
In-Reply-To: <1416504815-28685-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Similar as the previous fix, this adds the proper resume support to
Emu0202 "Front Jack Channels" enum mixer element.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_quirks.c | 84 ++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index b412d085e593..870d8975ae2e 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -473,63 +473,71 @@ static int snd_emu0204_ch_switch_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_emu0204_ch_switch_put(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
+static int snd_emu0204_ch_switch_update(struct usb_mixer_interface *mixer,
+					int value)
 {
-	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
-	unsigned int value = ucontrol->value.enumerated.item[0];
-	int err, changed;
+	struct snd_usb_audio *chip = mixer->chip;
+	int err;
 	unsigned char buf[2];
 
-	if (value > 1)
-		return -EINVAL;
-
-	buf[0] = 0x01;
-	buf[1] = value ? 0x02 : 0x01;
-
-	changed = value != kcontrol->private_value;
-	down_read(&mixer->chip->shutdown_rwsem);
+	down_read(&chip->shutdown_rwsem);
 	if (mixer->chip->shutdown) {
 		err = -ENODEV;
 		goto out;
 	}
-	err = snd_usb_ctl_msg(mixer->chip->dev,
-		      usb_sndctrlpipe(mixer->chip->dev, 0), UAC_SET_CUR,
+
+	buf[0] = 0x01;
+	buf[1] = value ? 0x02 : 0x01;
+	err = snd_usb_ctl_msg(chip->dev,
+		      usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
 		      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 		      0x0400, 0x0e00, buf, 2);
  out:
-	up_read(&mixer->chip->shutdown_rwsem);
-	if (err < 0)
-		return err;
+	up_read(&chip->shutdown_rwsem);
+	return err;
+}
+
+static int snd_emu0204_ch_switch_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct usb_mixer_interface *mixer = list->mixer;
+	unsigned int value = ucontrol->value.enumerated.item[0];
+	int err;
+
+	if (value > 1)
+		return -EINVAL;
+
+	if (value == kcontrol->private_value)
+		return 0;
+
 	kcontrol->private_value = value;
-	return changed;
+	err = snd_emu0204_ch_switch_update(mixer, value);
+	return err < 0 ? err : 1;
 }
 
+static int snd_emu0204_ch_switch_resume(struct usb_mixer_elem_list *list)
+{
+	return snd_emu0204_ch_switch_update(list->mixer,
+					    list->kctl->private_value);
+}
 
-static struct snd_kcontrol_new snd_emu0204_controls[] = {
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Front Jack Channels",
-		.info = snd_emu0204_ch_switch_info,
-		.get = snd_emu0204_ch_switch_get,
-		.put = snd_emu0204_ch_switch_put,
-		.private_value = 0,
-	},
+static struct snd_kcontrol_new snd_emu0204_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Front Jack Channels",
+	.info = snd_emu0204_ch_switch_info,
+	.get = snd_emu0204_ch_switch_get,
+	.put = snd_emu0204_ch_switch_put,
+	.private_value = 0,
 };
 
 static int snd_emu0204_controls_create(struct usb_mixer_interface *mixer)
 {
-	int i, err;
-
-	for (i = 0; i < ARRAY_SIZE(snd_emu0204_controls); ++i) {
-		err = snd_ctl_add(mixer->chip->card,
-			snd_ctl_new1(&snd_emu0204_controls[i], mixer));
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
+	return add_single_ctl_with_resume(mixer, 0,
+					  snd_emu0204_ch_switch_resume,
+					  &snd_emu0204_control, NULL);
 }
+
 /* ASUS Xonar U1 / U3 controls */
 
 static int snd_xonar_u1_switch_get(struct snd_kcontrol *kcontrol,
-- 
2.1.3
