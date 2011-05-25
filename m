From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/5] ALSA: usb-audio: rework
	add_control_to_empty()
Date: Wed, 25 May 2011 09:09:00 +0200
Message-ID: <1306307343-3247-3-git-send-email-zonque@gmail.com>
References: <1306307343-3247-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id C804110381B
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 09:09:32 +0200 (CEST)
In-Reply-To: <1306307343-3247-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, gdiffey@gmail.com, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch renames add_control_to_empty() to snd_usb_mixer_add_control()
and exports it, so the quirks functions can make use of it.

Also, as "struct mixer_build" is private to mixer.c, rewrite the
function to take an argument of type "struct usb_mixer_interface"
instead.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/mixer.c |   19 ++++++++++---------
 sound/usb/mixer.h |    3 +++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index eab06ed..ba19bfd 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -535,20 +535,21 @@ static int check_matrix_bitmap(unsigned char *bmap, int ich, int och, int num_ou
  * if failed, give up and free the control instance.
  */
 
-static int add_control_to_empty(struct mixer_build *state, struct snd_kcontrol *kctl)
+int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
+			      struct snd_kcontrol *kctl)
 {
 	struct usb_mixer_elem_info *cval = kctl->private_data;
 	int err;
 
-	while (snd_ctl_find_id(state->chip->card, &kctl->id))
+	while (snd_ctl_find_id(mixer->chip->card, &kctl->id))
 		kctl->id.index++;
-	if ((err = snd_ctl_add(state->chip->card, kctl)) < 0) {
+	if ((err = snd_ctl_add(mixer->chip->card, kctl)) < 0) {
 		snd_printd(KERN_ERR "cannot add control (err = %d)\n", err);
 		return err;
 	}
 	cval->elem_id = &kctl->id;
-	cval->next_id_elem = state->mixer->id_elems[cval->id];
-	state->mixer->id_elems[cval->id] = cval;
+	cval->next_id_elem = mixer->id_elems[cval->id];
+	mixer->id_elems[cval->id] = cval;
 	return 0;
 }
 
@@ -1176,7 +1177,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 
 	snd_printdd(KERN_INFO "[%d] FU [%s] ch = %d, val = %d/%d/%d\n",
 		    cval->id, kctl->id.name, cval->channels, cval->min, cval->max, cval->res);
-	add_control_to_empty(state, kctl);
+	snd_usb_mixer_add_control(state->mixer, kctl);
 }
 
 
@@ -1340,7 +1341,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 
 	snd_printdd(KERN_INFO "[%d] MU [%s] ch = %d, val = %d/%d\n",
 		    cval->id, kctl->id.name, cval->channels, cval->min, cval->max);
-	add_control_to_empty(state, kctl);
+	snd_usb_mixer_add_control(state->mixer, kctl);
 }
 
 
@@ -1641,7 +1642,7 @@ static int build_audio_procunit(struct mixer_build *state, int unitid, void *raw
 
 		snd_printdd(KERN_INFO "[%d] PU [%s] ch = %d, val = %d/%d\n",
 			    cval->id, kctl->id.name, cval->channels, cval->min, cval->max);
-		if ((err = add_control_to_empty(state, kctl)) < 0)
+		if ((err = snd_usb_mixer_add_control(state->mixer, kctl)) < 0)
 			return err;
 	}
 	return 0;
@@ -1858,7 +1859,7 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid, void
 
 	snd_printdd(KERN_INFO "[%d] SU [%s] items = %d\n",
 		    cval->id, kctl->id.name, desc->bNrInPins);
-	if ((err = add_control_to_empty(state, kctl)) < 0)
+	if ((err = snd_usb_mixer_add_control(state->mixer, kctl)) < 0)
 		return err;
 
 	return 0;
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index b4a2c81..459551a 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -55,4 +55,7 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 void snd_usb_mixer_inactivate(struct usb_mixer_interface *mixer);
 int snd_usb_mixer_activate(struct usb_mixer_interface *mixer);
 
+int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
+			      struct snd_kcontrol *kctl);
+
 #endif /* __USBMIXER_H */
-- 
1.7.5.1
