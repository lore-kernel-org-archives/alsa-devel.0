From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 02/10] ALSA: usb-audio: Allow quirks to
	handle own resume and proc dump
Date: Thu, 20 Nov 2014 18:33:27 +0100
Message-ID: <1416504815-28685-3-git-send-email-tiwai@suse.de>
References: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D0EC260610
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E3E10AD2E
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

So far, we blindly assumed that the all usb-audio mixer elements
follow the standard and apply the standard resume method for the
registered elements in the id_elems[] list.  However, some quirks
really need the own resume and it's incomplete for now.

This patch enhances the resume handling in two folds:
- split some fields in struct usb_mixer_elem_info into a smaller
  header struct (usb_mixer_elem_list) for keeping the minimal
  information in the linked-list; the usb_mixer_elem_info embeds this
  header struct instead
- add resume and dump callbacks to usb_mixer_elem_list struct to allow
  quirks providing the own methods

For the standard mixer elements, these new callbacks are set to the
standard ones as default, thus there is no functional change by this
patch yet.

The dump and resume callbacks are typedef'ed for ease of later patches
using arrays of such function pointers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c          | 156 +++++++++++++++++++++++++--------------------
 sound/usb/mixer.h          |  26 ++++++--
 sound/usb/mixer_quirks.c   |  12 +---
 sound/usb/mixer_scarlett.c |   8 +--
 4 files changed, 114 insertions(+), 88 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 7756fcf877e0..7beb0939790b 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -138,7 +138,7 @@ check_mapped_name(const struct usbmix_name_map *p, char *buf, int buflen)
 
 /* ignore the error value if ignore_ctl_error flag is set */
 #define filter_error(cval, err) \
-	((cval)->mixer->ignore_ctl_error ? 0 : (err))
+	((cval)->head.mixer->ignore_ctl_error ? 0 : (err))
 
 /* check whether the control should be ignored */
 static inline int
@@ -290,13 +290,13 @@ static int get_abs_value(struct usb_mixer_elem_info *cval, int val)
 static int get_ctl_value_v1(struct usb_mixer_elem_info *cval, int request,
 			    int validx, int *value_ret)
 {
-	struct snd_usb_audio *chip = cval->mixer->chip;
+	struct snd_usb_audio *chip = cval->head.mixer->chip;
 	unsigned char buf[2];
 	int val_len = cval->val_type >= USB_MIXER_S16 ? 2 : 1;
 	int timeout = 10;
 	int idx = 0, err;
 
-	err = snd_usb_autoresume(cval->mixer->chip);
+	err = snd_usb_autoresume(chip);
 	if (err < 0)
 		return -EIO;
 
@@ -304,7 +304,7 @@ static int get_ctl_value_v1(struct usb_mixer_elem_info *cval, int request,
 	while (timeout-- > 0) {
 		if (chip->shutdown)
 			break;
-		idx = snd_usb_ctrl_intf(chip) | (cval->id << 8);
+		idx = snd_usb_ctrl_intf(chip) | (cval->head.id << 8);
 		if (snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				    validx, idx, buf, val_len) >= val_len) {
@@ -320,14 +320,14 @@ static int get_ctl_value_v1(struct usb_mixer_elem_info *cval, int request,
 
  out:
 	up_read(&chip->shutdown_rwsem);
-	snd_usb_autosuspend(cval->mixer->chip);
+	snd_usb_autosuspend(chip);
 	return err;
 }
 
 static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request,
 			    int validx, int *value_ret)
 {
-	struct snd_usb_audio *chip = cval->mixer->chip;
+	struct snd_usb_audio *chip = cval->head.mixer->chip;
 	unsigned char buf[2 + 3 * sizeof(__u16)]; /* enough space for one range */
 	unsigned char *val;
 	int idx = 0, ret, size;
@@ -351,7 +351,7 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request,
 	if (chip->shutdown) {
 		ret = -ENODEV;
 	} else {
-		idx = snd_usb_ctrl_intf(chip) | (cval->id << 8);
+		idx = snd_usb_ctrl_intf(chip) | (cval->head.id << 8);
 		ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), bRequest,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			      validx, idx, buf, size);
@@ -396,7 +396,7 @@ static int get_ctl_value(struct usb_mixer_elem_info *cval, int request,
 {
 	validx += cval->idx_off;
 
-	return (cval->mixer->protocol == UAC_VERSION_1) ?
+	return (cval->head.mixer->protocol == UAC_VERSION_1) ?
 		get_ctl_value_v1(cval, request, validx, value_ret) :
 		get_ctl_value_v2(cval, request, validx, value_ret);
 }
@@ -427,8 +427,8 @@ int snd_usb_get_cur_mix_value(struct usb_mixer_elem_info *cval,
 	}
 	err = get_cur_mix_raw(cval, channel, value);
 	if (err < 0) {
-		if (!cval->mixer->ignore_ctl_error)
-			usb_audio_dbg(cval->mixer->chip,
+		if (!cval->head.mixer->ignore_ctl_error)
+			usb_audio_dbg(cval->head.mixer->chip,
 				"cannot get current value for control %d ch %d: err = %d\n",
 				      cval->control, channel, err);
 		return err;
@@ -445,13 +445,13 @@ int snd_usb_get_cur_mix_value(struct usb_mixer_elem_info *cval,
 int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 				int request, int validx, int value_set)
 {
-	struct snd_usb_audio *chip = cval->mixer->chip;
+	struct snd_usb_audio *chip = cval->head.mixer->chip;
 	unsigned char buf[2];
 	int idx = 0, val_len, err, timeout = 10;
 
 	validx += cval->idx_off;
 
-	if (cval->mixer->protocol == UAC_VERSION_1) {
+	if (cval->head.mixer->protocol == UAC_VERSION_1) {
 		val_len = cval->val_type >= USB_MIXER_S16 ? 2 : 1;
 	} else { /* UAC_VERSION_2 */
 		/* audio class v2 controls are always 2 bytes in size */
@@ -476,7 +476,7 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 	while (timeout-- > 0) {
 		if (chip->shutdown)
 			break;
-		idx = snd_usb_ctrl_intf(chip) | (cval->id << 8);
+		idx = snd_usb_ctrl_intf(chip) | (cval->head.id << 8);
 		if (snd_usb_ctl_msg(chip->dev,
 				    usb_sndctrlpipe(chip->dev, 0), request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
@@ -510,7 +510,7 @@ int snd_usb_set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
 		cval->ch_readonly & (1 << (channel - 1));
 
 	if (read_only) {
-		usb_audio_dbg(cval->mixer->chip,
+		usb_audio_dbg(cval->head.mixer->chip,
 			      "%s(): channel %d of control %d is read_only\n",
 			    __func__, channel, cval->control);
 		return 0;
@@ -569,10 +569,10 @@ static int check_matrix_bitmap(unsigned char *bmap,
  * if failed, give up and free the control instance.
  */
 
-int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
+int snd_usb_mixer_add_control(struct usb_mixer_elem_list *list,
 			      struct snd_kcontrol *kctl)
 {
-	struct usb_mixer_elem_info *cval = kctl->private_data;
+	struct usb_mixer_interface *mixer = list->mixer;
 	int err;
 
 	while (snd_ctl_find_id(mixer->chip->card, &kctl->id))
@@ -582,9 +582,9 @@ int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
 			      err);
 		return err;
 	}
-	cval->elem_id = &kctl->id;
-	cval->next_id_elem = mixer->id_elems[cval->id];
-	mixer->id_elems[cval->id] = cval;
+	list->kctl = kctl;
+	list->next_id_elem = mixer->id_elems[list->id];
+	mixer->id_elems[list->id] = list;
 	return 0;
 }
 
@@ -833,7 +833,7 @@ void snd_usb_mixer_elem_free(struct snd_kcontrol *kctl)
 static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 				  struct snd_kcontrol *kctl)
 {
-	struct snd_usb_audio *chip = cval->mixer->chip;
+	struct snd_usb_audio *chip = cval->head.mixer->chip;
 	switch (chip->usb_id) {
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C600 */
@@ -958,10 +958,10 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 		}
 		if (get_ctl_value(cval, UAC_GET_MAX, (cval->control << 8) | minchn, &cval->max) < 0 ||
 		    get_ctl_value(cval, UAC_GET_MIN, (cval->control << 8) | minchn, &cval->min) < 0) {
-			usb_audio_err(cval->mixer->chip,
+			usb_audio_err(cval->head.mixer->chip,
 				      "%d:%d: cannot get min/max values for control %d (id %d)\n",
-				   cval->id, snd_usb_ctrl_intf(cval->mixer->chip),
-							       cval->control, cval->id);
+				   cval->head.id, snd_usb_ctrl_intf(cval->head.mixer->chip),
+							       cval->control, cval->head.id);
 			return -EINVAL;
 		}
 		if (get_ctl_value(cval, UAC_GET_RES,
@@ -1065,7 +1065,7 @@ static int mixer_ctl_feature_info(struct snd_kcontrol *kcontrol,
 				kcontrol->vd[0].access &= 
 					~(SNDRV_CTL_ELEM_ACCESS_TLV_READ |
 					  SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK);
-				snd_ctl_notify(cval->mixer->chip->card,
+				snd_ctl_notify(cval->head.mixer->chip->card,
 					       SNDRV_CTL_EVENT_MASK_INFO,
 					       &kcontrol->id);
 			}
@@ -1235,8 +1235,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
 	if (!cval)
 		return;
-	cval->mixer = state->mixer;
-	cval->id = unitid;
+	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
 	cval->control = control;
 	cval->cmask = ctl_mask;
 	cval->val_type = audio_feature_info[control-1].type;
@@ -1347,14 +1346,14 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 			       range);
 		usb_audio_warn(state->chip,
 			       "[%d] FU [%s] ch = %d, val = %d/%d/%d",
-			       cval->id, kctl->id.name, cval->channels,
+			       cval->head.id, kctl->id.name, cval->channels,
 			       cval->min, cval->max, cval->res);
 	}
 
 	usb_audio_dbg(state->chip, "[%d] FU [%s] ch = %d, val = %d/%d/%d\n",
-		      cval->id, kctl->id.name, cval->channels,
+		      cval->head.id, kctl->id.name, cval->channels,
 		      cval->min, cval->max, cval->res);
-	snd_usb_mixer_add_control(state->mixer, kctl);
+	snd_usb_mixer_add_control(&cval->head, kctl);
 }
 
 /*
@@ -1528,8 +1527,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 	if (!cval)
 		return;
 
-	cval->mixer = state->mixer;
-	cval->id = unitid;
+	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
 	cval->control = in_ch + 1; /* based on 1 */
 	cval->val_type = USB_MIXER_S16;
 	for (i = 0; i < num_outs; i++) {
@@ -1561,8 +1559,8 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 	append_ctl_name(kctl, " Volume");
 
 	usb_audio_dbg(state->chip, "[%d] MU [%s] ch = %d, val = %d/%d\n",
-		    cval->id, kctl->id.name, cval->channels, cval->min, cval->max);
-	snd_usb_mixer_add_control(state->mixer, kctl);
+		    cval->head.id, kctl->id.name, cval->channels, cval->min, cval->max);
+	snd_usb_mixer_add_control(&cval->head, kctl);
 }
 
 /*
@@ -1812,8 +1810,7 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 		cval = kzalloc(sizeof(*cval), GFP_KERNEL);
 		if (!cval)
 			return -ENOMEM;
-		cval->mixer = state->mixer;
-		cval->id = unitid;
+		snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
 		cval->control = valinfo->control;
 		cval->val_type = valinfo->val_type;
 		cval->channels = 1;
@@ -1866,10 +1863,10 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 
 		usb_audio_dbg(state->chip,
 			      "[%d] PU [%s] ch = %d, val = %d/%d\n",
-			      cval->id, kctl->id.name, cval->channels,
+			      cval->head.id, kctl->id.name, cval->channels,
 			      cval->min, cval->max);
 
-		err = snd_usb_mixer_add_control(state->mixer, kctl);
+		err = snd_usb_mixer_add_control(&cval->head, kctl);
 		if (err < 0)
 			return err;
 	}
@@ -2016,8 +2013,7 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
 	if (!cval)
 		return -ENOMEM;
-	cval->mixer = state->mixer;
-	cval->id = unitid;
+	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
 	cval->val_type = USB_MIXER_U8;
 	cval->channels = 1;
 	cval->min = 1;
@@ -2087,11 +2083,8 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	}
 
 	usb_audio_dbg(state->chip, "[%d] SU [%s] items = %d\n",
-		    cval->id, kctl->id.name, desc->bNrInPins);
-	if ((err = snd_usb_mixer_add_control(state->mixer, kctl)) < 0)
-		return err;
-
-	return 0;
+		    cval->head.id, kctl->id.name, desc->bNrInPins);
+	return snd_usb_mixer_add_control(&cval->head, kctl);
 }
 
 /*
@@ -2236,25 +2229,21 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 
 void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid)
 {
-	struct usb_mixer_elem_info *info;
+	struct usb_mixer_elem_list *list;
 
-	for (info = mixer->id_elems[unitid]; info; info = info->next_id_elem)
+	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem)
 		snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       info->elem_id);
+			       &list->kctl->id);
 }
 
 static void snd_usb_mixer_dump_cval(struct snd_info_buffer *buffer,
-				    int unitid,
-				    struct usb_mixer_elem_info *cval)
+				    struct usb_mixer_elem_list *list)
 {
+	struct usb_mixer_elem_info *cval = (struct usb_mixer_elem_info *)list;
 	static char *val_types[] = {"BOOLEAN", "INV_BOOLEAN",
 				    "S8", "U8", "S16", "U16"};
-	snd_iprintf(buffer, "  Unit: %i\n", unitid);
-	if (cval->elem_id)
-		snd_iprintf(buffer, "    Control: name=\"%s\", index=%i\n",
-				cval->elem_id->name, cval->elem_id->index);
 	snd_iprintf(buffer, "    Info: id=%i, control=%i, cmask=0x%x, "
-			    "channels=%i, type=\"%s\"\n", cval->id,
+			    "channels=%i, type=\"%s\"\n", cval->head.id,
 			    cval->control, cval->cmask, cval->channels,
 			    val_types[cval->val_type]);
 	snd_iprintf(buffer, "    Volume: min=%i, max=%i, dBmin=%i, dBmax=%i\n",
@@ -2266,7 +2255,7 @@ static void snd_usb_mixer_proc_read(struct snd_info_entry *entry,
 {
 	struct snd_usb_audio *chip = entry->private_data;
 	struct usb_mixer_interface *mixer;
-	struct usb_mixer_elem_info *cval;
+	struct usb_mixer_elem_list *list;
 	int unitid;
 
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
@@ -2276,9 +2265,17 @@ static void snd_usb_mixer_proc_read(struct snd_info_entry *entry,
 				mixer->ignore_ctl_error);
 		snd_iprintf(buffer, "Card: %s\n", chip->card->longname);
 		for (unitid = 0; unitid < MAX_ID_ELEMS; unitid++) {
-			for (cval = mixer->id_elems[unitid]; cval;
-						cval = cval->next_id_elem)
-				snd_usb_mixer_dump_cval(buffer, unitid, cval);
+			for (list = mixer->id_elems[unitid]; list;
+			     list = list->next_id_elem) {
+				snd_iprintf(buffer, "  Unit: %i\n", list->id);
+				if (list->kctl)
+					snd_iprintf(buffer,
+						    "    Control: name=\"%s\", index=%i\n",
+						    list->kctl->id.name,
+						    list->kctl->id.index);
+				if (list->dump)
+					list->dump(buffer, list);
+			}
 		}
 	}
 }
@@ -2286,7 +2283,7 @@ static void snd_usb_mixer_proc_read(struct snd_info_entry *entry,
 static void snd_usb_mixer_interrupt_v2(struct usb_mixer_interface *mixer,
 				       int attribute, int value, int index)
 {
-	struct usb_mixer_elem_info *info;
+	struct usb_mixer_elem_list *list;
 	__u8 unitid = (index >> 8) & 0xff;
 	__u8 control = (value >> 8) & 0xff;
 	__u8 channel = value & 0xff;
@@ -2298,7 +2295,13 @@ static void snd_usb_mixer_interrupt_v2(struct usb_mixer_interface *mixer,
 		return;
 	}
 
-	for (info = mixer->id_elems[unitid]; info; info = info->next_id_elem) {
+	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem) {
+		struct usb_mixer_elem_info *info;
+
+		if (!list->kctl)
+			continue;
+
+		info = (struct usb_mixer_elem_info *)list;
 		if (info->control != control)
 			continue;
 
@@ -2311,7 +2314,7 @@ static void snd_usb_mixer_interrupt_v2(struct usb_mixer_interface *mixer,
 				info->cached = 0;
 
 			snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
-					info->elem_id);
+				       &info->head.kctl->id);
 			break;
 
 		case UAC2_CS_RANGE:
@@ -2509,8 +2512,9 @@ int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
-static int restore_mixer_value(struct usb_mixer_elem_info *cval)
+static int restore_mixer_value(struct usb_mixer_elem_list *list)
 {
+	struct usb_mixer_elem_info *cval = (struct usb_mixer_elem_info *)list;
 	int c, err, idx;
 
 	if (cval->cmask) {
@@ -2540,19 +2544,19 @@ static int restore_mixer_value(struct usb_mixer_elem_info *cval)
 
 int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
 {
-	struct usb_mixer_elem_info *cval;
+	struct usb_mixer_elem_list *list;
 	int id, err;
 
-	/* FIXME: any mixer quirks? */
-
 	if (reset_resume) {
 		/* restore cached mixer values */
 		for (id = 0; id < MAX_ID_ELEMS; id++) {
-			for (cval = mixer->id_elems[id]; cval;
-			     cval = cval->next_id_elem) {
-				err = restore_mixer_value(cval);
-				if (err < 0)
-					return err;
+			for (list = mixer->id_elems[id]; list;
+			     list = list->next_id_elem) {
+				if (list->resume) {
+					err = list->resume(list);
+					if (err < 0)
+						return err;
+				}
 			}
 		}
 	}
@@ -2560,3 +2564,15 @@ int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
 	return snd_usb_mixer_activate(mixer);
 }
 #endif
+
+void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
+				 struct usb_mixer_interface *mixer,
+				 int unitid)
+{
+	list->mixer = mixer;
+	list->id = unitid;
+	list->dump = snd_usb_mixer_dump_cval;
+#ifdef CONFIG_PM
+	list->resume = restore_mixer_value;
+#endif
+}
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 2478a844a322..05d812f7d5e5 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -1,6 +1,8 @@
 #ifndef __USBMIXER_H
 #define __USBMIXER_H
 
+#include <sound/info.h>
+
 struct usb_mixer_interface {
 	struct snd_usb_audio *chip;
 	struct usb_host_interface *hostif;
@@ -8,7 +10,7 @@ struct usb_mixer_interface {
 	unsigned int ignore_ctl_error;
 	struct urb *urb;
 	/* array[MAX_ID_ELEMS], indexed by unit id */
-	struct usb_mixer_elem_info **id_elems;
+	struct usb_mixer_elem_list **id_elems;
 
 	/* the usb audio specification version this interface complies to */
 	int protocol;
@@ -36,11 +38,21 @@ enum {
 	USB_MIXER_U16,
 };
 
-struct usb_mixer_elem_info {
+typedef void (*usb_mixer_elem_dump_func)(struct snd_info_buffer *buffer,
+					 struct usb_mixer_elem_list *list);
+typedef int (*usb_mixer_elem_resume_func)(struct usb_mixer_elem_list *elem);
+
+struct usb_mixer_elem_list {
 	struct usb_mixer_interface *mixer;
-	struct usb_mixer_elem_info *next_id_elem; /* list of controls with same id */
-	struct snd_ctl_elem_id *elem_id;
+	struct usb_mixer_elem_list *next_id_elem; /* list of controls with same id */
+	struct snd_kcontrol *kctl;
 	unsigned int id;
+	usb_mixer_elem_dump_func dump;
+	usb_mixer_elem_resume_func resume;
+};
+
+struct usb_mixer_elem_info {
+	struct usb_mixer_elem_list head;
 	unsigned int control;	/* CS or ICN (high byte) */
 	unsigned int cmask; /* channel mask bitmap: 0 = master */
 	unsigned int idx_off; /* Control index offset */
@@ -65,9 +77,13 @@ void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid);
 int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 				int request, int validx, int value_set);
 
-int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
+int snd_usb_mixer_add_control(struct usb_mixer_elem_list *list,
 			      struct snd_kcontrol *kctl);
 
+void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
+				 struct usb_mixer_interface *mixer,
+				 int unitid);
+
 int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 			  unsigned int size, unsigned int __user *_tlv);
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 03405b93b438..4cc32892dc6f 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -69,7 +69,6 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 				const char *name,
 				snd_kcontrol_tlv_rw_t *tlv_callback)
 {
-	int err;
 	struct usb_mixer_elem_info *cval;
 	struct snd_kcontrol *kctl;
 
@@ -77,8 +76,7 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 	if (!cval)
 		return -ENOMEM;
 
-	cval->id = unitid;
-	cval->mixer = mixer;
+	snd_usb_mixer_elem_init_std(&cval->head, mixer, unitid);
 	cval->val_type = val_type;
 	cval->channels = 1;
 	cval->control = control;
@@ -112,11 +110,7 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 			SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
 	}
 	/* Add control to mixer */
-	err = snd_usb_mixer_add_control(mixer, kctl);
-	if (err < 0)
-		return err;
-
-	return 0;
+	return snd_usb_mixer_add_control(&cval->head, kctl);
 }
 
 static int snd_create_std_mono_ctl(struct usb_mixer_interface *mixer,
@@ -1206,7 +1200,7 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 	int unitid = 12; /* SamleRate ExtensionUnit ID */
 
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
-		cval = mixer->id_elems[unitid];
+		cval = (struct usb_mixer_elem_info *)mixer->id_elems[unitid];
 		if (cval) {
 			snd_usb_mixer_set_ctl_value(cval, UAC_SET_CUR,
 						    cval->control << 8,
diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index a0a874507de5..92dba35660b3 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -436,10 +436,10 @@ static int scarlett_ctl_meter_get(struct snd_kcontrol *kctl,
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_info *elem = kctl->private_data;
-	struct snd_usb_audio *chip = elem->mixer->chip;
+	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	unsigned char buf[2 * MAX_CHANNELS] = {0, };
 	int wValue = (elem->control << 8) | elem->idx_off;
-	int idx = snd_usb_ctrl_intf(chip) | (elem->id << 8);
+	int idx = snd_usb_ctrl_intf(chip) | (elem->head.id << 8);
 	int err;
 
 	err = snd_usb_ctl_msg(chip->dev,
@@ -528,10 +528,10 @@ static int add_new_ctl(struct usb_mixer_interface *mixer,
 	if (!elem)
 		return -ENOMEM;
 
-	elem->mixer = mixer;
+	elem->head.mixer = mixer;
 	elem->control = offset;
 	elem->idx_off = num;
-	elem->id = index;
+	elem->head.id = index;
 	elem->val_type = val_type;
 
 	elem->channels = channels;
-- 
2.1.3
