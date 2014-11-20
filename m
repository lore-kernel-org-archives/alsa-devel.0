From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 10/10] ALSA: usb-audio: Add resume support
	for Scarlett mixers
Date: Thu, 20 Nov 2014 18:33:35 +0100
Message-ID: <1416504815-28685-11-git-send-email-tiwai@suse.de>
References: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D8329260631
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E6A90AD94
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

Scarlett driver uses almost compatible usb_mixer_elem_info struct, so
we just need to add a couple of simple resume callbacks to handle them
accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_scarlett.c | 65 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 92dba35660b3..2ef312648aaa 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -285,6 +285,19 @@ static int scarlett_ctl_switch_put(struct snd_kcontrol *kctl,
 	return changed;
 }
 
+static int scarlett_ctl_resume(struct usb_mixer_elem_list *list)
+{
+	struct usb_mixer_elem_info *elem =
+		container_of(list, struct usb_mixer_elem_info, head);
+	int i;
+
+	for (i = 0; i < elem->channels; i++)
+		if (elem->cached & (1 << i))
+			snd_usb_set_cur_mix_value(elem, i, i,
+						  elem->cache_val[i]);
+	return 0;
+}
+
 static int scarlett_ctl_info(struct snd_kcontrol *kctl,
 			     struct snd_ctl_elem_info *uinfo)
 {
@@ -432,6 +445,16 @@ static int scarlett_ctl_enum_put(struct snd_kcontrol *kctl,
 	return 0;
 }
 
+static int scarlett_ctl_enum_resume(struct usb_mixer_elem_list *list)
+{
+	struct usb_mixer_elem_info *elem =
+		container_of(list, struct usb_mixer_elem_info, head);
+
+	if (elem->cached)
+		snd_usb_set_cur_mix_value(elem, 0, 0, *elem->cache_val);
+	return 0;
+}
+
 static int scarlett_ctl_meter_get(struct snd_kcontrol *kctl,
 				  struct snd_ctl_elem_value *ucontrol)
 {
@@ -514,6 +537,7 @@ static struct snd_kcontrol_new usb_scarlett_ctl_sync = {
 
 static int add_new_ctl(struct usb_mixer_interface *mixer,
 		       const struct snd_kcontrol_new *ncontrol,
+		       usb_mixer_elem_resume_func resume,
 		       int index, int offset, int num,
 		       int val_type, int channels, const char *name,
 		       const struct scarlett_mixer_elem_enum_info *opt,
@@ -529,6 +553,7 @@ static int add_new_ctl(struct usb_mixer_interface *mixer,
 		return -ENOMEM;
 
 	elem->head.mixer = mixer;
+	elem->head.resume = resume;
 	elem->control = offset;
 	elem->idx_off = num;
 	elem->head.id = index;
@@ -548,7 +573,7 @@ static int add_new_ctl(struct usb_mixer_interface *mixer,
 
 	strlcpy(kctl->id.name, name, sizeof(kctl->id.name));
 
-	err = snd_ctl_add(mixer->chip->card, kctl);
+	err = snd_usb_mixer_add_control(&elem->head, kctl);
 	if (err < 0)
 		return err;
 
@@ -569,7 +594,8 @@ static int add_output_ctls(struct usb_mixer_interface *mixer,
 	/* Add mute switch */
 	snprintf(mx, sizeof(mx), "Master %d (%s) Playback Switch",
 		index + 1, name);
-	err = add_new_ctl(mixer, &usb_scarlett_ctl_switch, 0x0a, 0x01,
+	err = add_new_ctl(mixer, &usb_scarlett_ctl_switch,
+			  scarlett_ctl_resume, 0x0a, 0x01,
 			  2*index+1, USB_MIXER_S16, 2, mx, NULL, &elem);
 	if (err < 0)
 		return err;
@@ -577,7 +603,8 @@ static int add_output_ctls(struct usb_mixer_interface *mixer,
 	/* Add volume control and initialize to 0 */
 	snprintf(mx, sizeof(mx), "Master %d (%s) Playback Volume",
 		index + 1, name);
-	err = add_new_ctl(mixer, &usb_scarlett_ctl_master, 0x0a, 0x02,
+	err = add_new_ctl(mixer, &usb_scarlett_ctl_master,
+			  scarlett_ctl_resume, 0x0a, 0x02,
 			  2*index+1, USB_MIXER_S16, 2, mx, NULL, &elem);
 	if (err < 0)
 		return err;
@@ -585,7 +612,8 @@ static int add_output_ctls(struct usb_mixer_interface *mixer,
 	/* Add L channel source playback enumeration */
 	snprintf(mx, sizeof(mx), "Master %dL (%s) Source Playback Enum",
 		index + 1, name);
-	err = add_new_ctl(mixer, &usb_scarlett_ctl_dynamic_enum, 0x33, 0x00,
+	err = add_new_ctl(mixer, &usb_scarlett_ctl_dynamic_enum,
+			  scarlett_ctl_enum_resume, 0x33, 0x00,
 			  2*index, USB_MIXER_S16, 1, mx, &info->opt_master,
 			  &elem);
 	if (err < 0)
@@ -594,7 +622,8 @@ static int add_output_ctls(struct usb_mixer_interface *mixer,
 	/* Add R channel source playback enumeration */
 	snprintf(mx, sizeof(mx), "Master %dR (%s) Source Playback Enum",
 		index + 1, name);
-	err = add_new_ctl(mixer, &usb_scarlett_ctl_dynamic_enum, 0x33, 0x00,
+	err = add_new_ctl(mixer, &usb_scarlett_ctl_dynamic_enum,
+			  scarlett_ctl_enum_resume, 0x33, 0x00,
 			  2*index+1, USB_MIXER_S16, 1, mx, &info->opt_master,
 			  &elem);
 	if (err < 0)
@@ -824,13 +853,15 @@ static int scarlett_controls_create_generic(struct usb_mixer_interface *mixer,
 	struct usb_mixer_elem_info *elem;
 
 	/* create master switch and playback volume */
-	err = add_new_ctl(mixer, &usb_scarlett_ctl_switch, 0x0a, 0x01, 0,
+	err = add_new_ctl(mixer, &usb_scarlett_ctl_switch,
+			  scarlett_ctl_resume, 0x0a, 0x01, 0,
 			  USB_MIXER_S16, 1, "Master Playback Switch", NULL,
 			  &elem);
 	if (err < 0)
 		return err;
 
-	err = add_new_ctl(mixer, &usb_scarlett_ctl_master, 0x0a, 0x02, 0,
+	err = add_new_ctl(mixer, &usb_scarlett_ctl_master,
+			  scarlett_ctl_resume, 0x0a, 0x02, 0,
 			  USB_MIXER_S16, 1, "Master Playback Volume", NULL,
 			  &elem);
 	if (err < 0)
@@ -848,7 +879,8 @@ static int scarlett_controls_create_generic(struct usb_mixer_interface *mixer,
 			break;
 		case SCARLETT_SWITCH_IMPEDANCE:
 			sprintf(mx, "Input %d Impedance Switch", ctl->num);
-			err = add_new_ctl(mixer, &usb_scarlett_ctl_enum, 0x01,
+			err = add_new_ctl(mixer, &usb_scarlett_ctl_enum,
+					  scarlett_ctl_enum_resume, 0x01,
 					  0x09, ctl->num, USB_MIXER_S16, 1, mx,
 					  &opt_impedance, &elem);
 			if (err < 0)
@@ -856,7 +888,8 @@ static int scarlett_controls_create_generic(struct usb_mixer_interface *mixer,
 			break;
 		case SCARLETT_SWITCH_PAD:
 			sprintf(mx, "Input %d Pad Switch", ctl->num);
-			err = add_new_ctl(mixer, &usb_scarlett_ctl_enum, 0x01,
+			err = add_new_ctl(mixer, &usb_scarlett_ctl_enum,
+					  scarlett_ctl_enum_resume, 0x01,
 					  0x0b, ctl->num, USB_MIXER_S16, 1, mx,
 					  &opt_pad, &elem);
 			if (err < 0)
@@ -912,7 +945,8 @@ int snd_scarlett_controls_create(struct usb_mixer_interface *mixer)
 	for (i = 0; i < info->matrix_in; i++) {
 		snprintf(mx, sizeof(mx), "Matrix %02d Input Playback Route",
 			 i+1);
-		err = add_new_ctl(mixer, &usb_scarlett_ctl_dynamic_enum, 0x32,
+		err = add_new_ctl(mixer, &usb_scarlett_ctl_dynamic_enum,
+				  scarlett_ctl_enum_resume, 0x32,
 				  0x06, i, USB_MIXER_S16, 1, mx,
 				  &info->opt_matrix, &elem);
 		if (err < 0)
@@ -921,7 +955,8 @@ int snd_scarlett_controls_create(struct usb_mixer_interface *mixer)
 		for (o = 0; o < info->matrix_out; o++) {
 			sprintf(mx, "Matrix %02d Mix %c Playback Volume", i+1,
 				o+'A');
-			err = add_new_ctl(mixer, &usb_scarlett_ctl, 0x3c, 0x00,
+			err = add_new_ctl(mixer, &usb_scarlett_ctl,
+					  scarlett_ctl_resume, 0x3c, 0x00,
 					  (i << 3) + (o & 0x07), USB_MIXER_S16,
 					  1, mx, NULL, &elem);
 			if (err < 0)
@@ -933,7 +968,8 @@ int snd_scarlett_controls_create(struct usb_mixer_interface *mixer)
 	for (i = 0; i < info->input_len; i++) {
 		snprintf(mx, sizeof(mx), "Input Source %02d Capture Route",
 			 i+1);
-		err = add_new_ctl(mixer, &usb_scarlett_ctl_dynamic_enum, 0x34,
+		err = add_new_ctl(mixer, &usb_scarlett_ctl_dynamic_enum,
+				  scarlett_ctl_enum_resume, 0x34,
 				  0x00, i, USB_MIXER_S16, 1, mx,
 				  &info->opt_master, &elem);
 		if (err < 0)
@@ -941,14 +977,15 @@ int snd_scarlett_controls_create(struct usb_mixer_interface *mixer)
 	}
 
 	/* val_len == 1 needed here */
-	err = add_new_ctl(mixer, &usb_scarlett_ctl_enum, 0x28, 0x01, 0,
+	err = add_new_ctl(mixer, &usb_scarlett_ctl_enum,
+			  scarlett_ctl_enum_resume, 0x28, 0x01, 0,
 			  USB_MIXER_U8, 1, "Sample Clock Source",
 			  &opt_clock, &elem);
 	if (err < 0)
 		return err;
 
 	/* val_len == 1 and UAC2_CS_MEM */
-	err = add_new_ctl(mixer, &usb_scarlett_ctl_sync, 0x3c, 0x00, 2,
+	err = add_new_ctl(mixer, &usb_scarlett_ctl_sync, NULL, 0x3c, 0x00, 2,
 			  USB_MIXER_U8, 1, "Sample Clock Sync Status",
 			  &opt_sync, &elem);
 	if (err < 0)
-- 
2.1.3
