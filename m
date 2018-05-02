From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: usb-audio: Add "Keep Interface"
	control
Date: Wed,  2 May 2018 16:11:14 +0200
Message-ID: <20180502141116.31966-5-tiwai@suse.de>
References: <20180502141116.31966-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 55176267035
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 16:11:20 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7DA69AF08
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 14:11:19 +0000 (UTC)
In-Reply-To: <20180502141116.31966-1-tiwai@suse.de>
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

This patch adds "Keep Interface" control for each USB-audio device.
The control element is with SND_CTL_IFACE_CARD, so that it won't
appear on any sane mixer applications.  For a device that is confirmed
to work well with "keep-interface" mode, user can flip the control via
amixer, e.g.
  % amixer -c1 cset iface=CARD,name='Keep Interface' on

and save/restore the state via alsactl.

The reason to provide this via control API is that the behavior must
be pretty depending on the device (and the firmware in it), so it's
not ideal to apply via module option.

For a device that certainly works, we may set it statically via a
quirk table entry.  But a device like Dell WD15 dock behaves so
differently depending on the firmware, and we can't set it
statically.  So leave this as a dynamic switch each user can adjust
freely.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 76fabc4b72b5..bb203b3684fc 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2801,6 +2801,48 @@ static int snd_usb_mixer_status_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+static int keep_iface_ctl_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = mixer->chip->keep_iface;
+	return 0;
+}
+
+static int keep_iface_ctl_put(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	bool keep_iface = !!ucontrol->value.integer.value[0];
+
+	if (mixer->chip->keep_iface == keep_iface)
+		return 0;
+	mixer->chip->keep_iface = keep_iface;
+	return 1;
+}
+
+static const struct snd_kcontrol_new keep_iface_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.name = "Keep Interface",
+	.info = snd_ctl_boolean_mono_info,
+	.get = keep_iface_ctl_get,
+	.put = keep_iface_ctl_put,
+};
+
+static int create_keep_iface_ctl(struct usb_mixer_interface *mixer)
+{
+	struct snd_kcontrol *kctl = snd_ctl_new1(&keep_iface_ctl, mixer);
+
+	/* need only one control per card */
+	if (snd_ctl_find_id(mixer->chip->card, &kctl->id)) {
+		snd_ctl_free_one(kctl);
+		return 0;
+	}
+
+	return snd_ctl_add(mixer->chip->card, kctl);
+}
+
 int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 			 int ignore_error)
 {
@@ -2842,6 +2884,9 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 	if ((err = snd_usb_mixer_controls(mixer)) < 0 ||
 	    (err = snd_usb_mixer_status_create(mixer)) < 0)
 		goto _error;
+	err = create_keep_iface_ctl(mixer);
+	if (err < 0)
+		goto _error;
 
 	snd_usb_mixer_apply_create_quirk(mixer);
 
-- 
2.16.3
