From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Resume mixer values properly
Date: Tue, 21 Jan 2014 12:53:45 +0100
Message-ID: <1390305225-26739-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C725C2610D7
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 12:53:45 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B8602AC6B
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 11:53:45 +0000 (UTC)
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

Implement reset_resume callback so that the mixer values are properly
restored.  Still no boot quirks are called, so it might not work well
on some devices.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c  | 18 ++++++++--
 sound/usb/mixer.c | 99 ++++++++++++++++++++++++++++++++++++++++++++-----------
 sound/usb/mixer.h |  7 ++--
 3 files changed, 99 insertions(+), 25 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index d979050e6a6a..025224136129 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -691,12 +691,12 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 	}
 
 	list_for_each_entry(mixer, &chip->mixer_list, list)
-		snd_usb_mixer_inactivate(mixer);
+		snd_usb_mixer_suspend(mixer);
 
 	return 0;
 }
 
-static int usb_audio_resume(struct usb_interface *intf)
+static int __usb_audio_resume(struct usb_interface *intf, bool reset_resume)
 {
 	struct snd_usb_audio *chip = usb_get_intfdata(intf);
 	struct usb_mixer_interface *mixer;
@@ -711,7 +711,7 @@ static int usb_audio_resume(struct usb_interface *intf)
 	 * we just notify and restart the mixers
 	 */
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
-		err = snd_usb_mixer_activate(mixer);
+		err = snd_usb_mixer_resume(mixer, reset_resume);
 		if (err < 0)
 			goto err_out;
 	}
@@ -723,9 +723,20 @@ static int usb_audio_resume(struct usb_interface *intf)
 err_out:
 	return err;
 }
+
+static int usb_audio_resume(struct usb_interface *intf)
+{
+	return __usb_audio_resume(intf, false);
+}
+
+static int usb_audio_reset_resume(struct usb_interface *intf)
+{
+	return __usb_audio_resume(intf, true);
+}
 #else
 #define usb_audio_suspend	NULL
 #define usb_audio_resume	NULL
+#define usb_audio_reset_resume	NULL
 #endif		/* CONFIG_PM */
 
 static struct usb_device_id usb_audio_ids [] = {
@@ -747,6 +758,7 @@ static struct usb_driver usb_audio_driver = {
 	.disconnect =	usb_audio_disconnect,
 	.suspend =	usb_audio_suspend,
 	.resume =	usb_audio_resume,
+	.reset_resume =	usb_audio_reset_resume,
 	.id_table =	usb_audio_ids,
 	.supports_autosuspend = 1,
 };
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 44b0ba4feab3..aa9bc19aae68 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2299,26 +2299,6 @@ requeue:
 	}
 }
 
-/* stop any bus activity of a mixer */
-void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer)
-{
-	usb_kill_urb(mixer->urb);
-	usb_kill_urb(mixer->rc_urb);
-}
-
-int snd_usb_mixer_activate(struct usb_mixer_interface *mixer)
-{
-	int err;
-
-	if (mixer->urb) {
-		err = usb_submit_urb(mixer->urb, GFP_NOIO);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
-}
-
 /* create the handler for the optional status interrupt endpoint */
 static int snd_usb_mixer_status_create(struct usb_mixer_interface *mixer)
 {
@@ -2417,3 +2397,82 @@ void snd_usb_mixer_disconnect(struct list_head *p)
 	usb_kill_urb(mixer->urb);
 	usb_kill_urb(mixer->rc_urb);
 }
+
+#ifdef CONFIG_PM
+/* stop any bus activity of a mixer */
+static void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer)
+{
+	usb_kill_urb(mixer->urb);
+	usb_kill_urb(mixer->rc_urb);
+}
+
+static int snd_usb_mixer_activate(struct usb_mixer_interface *mixer)
+{
+	int err;
+
+	if (mixer->urb) {
+		err = usb_submit_urb(mixer->urb, GFP_NOIO);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer)
+{
+	snd_usb_mixer_inactivate(mixer);
+	return 0;
+}
+
+static int restore_mixer_value(struct usb_mixer_elem_info *cval)
+{
+	int c, err, idx;
+
+	if (cval->cmask) {
+		idx = 0;
+		for (c = 0; c < MAX_CHANNELS; c++) {
+			if (!(cval->cmask & (1 << c)))
+				continue;
+			if (cval->cached & (1 << c)) {
+				err = set_cur_mix_value(cval, c + 1, idx,
+							cval->cache_val[idx]);
+				if (err < 0)
+					return err;
+			}
+			idx++;
+		}
+	} else {
+		/* master */
+		if (cval->cached) {
+			err = set_cur_mix_value(cval, 0, 0, *cval->cache_val);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
+{
+	struct usb_mixer_elem_info *cval;
+	int id, err;
+
+	/* FIXME: any mixer quirks? */
+
+	if (reset_resume) {
+		/* restore cached mixer values */
+		for (id = 0; id < MAX_ID_ELEMS; id++) {
+			for (cval = mixer->id_elems[id]; cval;
+			     cval = cval->next_id_elem) {
+				err = restore_mixer_value(cval);
+				if (err < 0)
+					return err;
+			}
+		}
+	}
+
+	return snd_usb_mixer_activate(mixer);
+}
+#endif
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index aab80df201bd..73b1f649447b 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -63,8 +63,6 @@ void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid);
 
 int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 				int request, int validx, int value_set);
-void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer);
-int snd_usb_mixer_activate(struct usb_mixer_interface *mixer);
 
 int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
 			      struct snd_kcontrol *kctl);
@@ -72,4 +70,9 @@ int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
 int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 			  unsigned int size, unsigned int __user *_tlv);
 
+#ifdef CONFIG_PM
+int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer);
+int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume);
+#endif
+
 #endif /* __USBMIXER_H */
-- 
1.8.5.2
