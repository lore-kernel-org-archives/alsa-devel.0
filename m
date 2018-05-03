From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Clean up mixer element list
	traverse
Date: Thu,  3 May 2018 20:23:27 +0200
Message-ID: <20180503182327.27869-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CBF00266C1C
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 20:23:32 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 425A4AF60
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 18:23:31 +0000 (UTC)
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

Introduce a new macro for iterating over mixer element list for
avoiding the open codes in many places.  Also the open-coded
container_of() and the forced cast to struct usb_mixer_elem_info are
replaced with another simple macro, too.

No functional changes but just readability improvement.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c          | 20 +++++++++-----------
 sound/usb/mixer.h          |  6 ++++++
 sound/usb/mixer_quirks.c   |  2 +-
 sound/usb/mixer_scarlett.c |  6 ++----
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index bb203b3684fc..265258b0e74c 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2598,9 +2598,9 @@ void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid)
 {
 	struct usb_mixer_elem_list *list;
 
-	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem) {
+	for_each_mixer_elem(list, mixer, unitid) {
 		struct usb_mixer_elem_info *info =
-			(struct usb_mixer_elem_info *)list;
+			mixer_elem_list_to_info(list);
 		/* invalidate cache, so the value is read from the device */
 		info->cached = 0;
 		snd_ctl_notify(mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
@@ -2611,7 +2611,7 @@ void snd_usb_mixer_notify_id(struct usb_mixer_interface *mixer, int unitid)
 static void snd_usb_mixer_dump_cval(struct snd_info_buffer *buffer,
 				    struct usb_mixer_elem_list *list)
 {
-	struct usb_mixer_elem_info *cval = (struct usb_mixer_elem_info *)list;
+	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
 	static char *val_types[] = {"BOOLEAN", "INV_BOOLEAN",
 				    "S8", "U8", "S16", "U16"};
 	snd_iprintf(buffer, "    Info: id=%i, control=%i, cmask=0x%x, "
@@ -2637,8 +2637,7 @@ static void snd_usb_mixer_proc_read(struct snd_info_entry *entry,
 				mixer->ignore_ctl_error);
 		snd_iprintf(buffer, "Card: %s\n", chip->card->longname);
 		for (unitid = 0; unitid < MAX_ID_ELEMS; unitid++) {
-			for (list = mixer->id_elems[unitid]; list;
-			     list = list->next_id_elem) {
+			for_each_mixer_elem(list, mixer, unitid) {
 				snd_iprintf(buffer, "  Unit: %i\n", list->id);
 				if (list->kctl)
 					snd_iprintf(buffer,
@@ -2668,19 +2667,19 @@ static void snd_usb_mixer_interrupt_v2(struct usb_mixer_interface *mixer,
 		return;
 	}
 
-	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem)
+	for_each_mixer_elem(list, mixer, unitid)
 		count++;
 
 	if (count == 0)
 		return;
 
-	for (list = mixer->id_elems[unitid]; list; list = list->next_id_elem) {
+	for_each_mixer_elem(list, mixer, unitid) {
 		struct usb_mixer_elem_info *info;
 
 		if (!list->kctl)
 			continue;
 
-		info = (struct usb_mixer_elem_info *)list;
+		info = mixer_elem_list_to_info(list);
 		if (count > 1 && info->control != control)
 			continue;
 
@@ -2946,7 +2945,7 @@ int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer)
 
 static int restore_mixer_value(struct usb_mixer_elem_list *list)
 {
-	struct usb_mixer_elem_info *cval = (struct usb_mixer_elem_info *)list;
+	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
 	int c, err, idx;
 
 	if (cval->cmask) {
@@ -2982,8 +2981,7 @@ int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume)
 	if (reset_resume) {
 		/* restore cached mixer values */
 		for (id = 0; id < MAX_ID_ELEMS; id++) {
-			for (list = mixer->id_elems[id]; list;
-			     list = list->next_id_elem) {
+			for_each_mixer_elem(list, mixer, id) {
 				if (list->resume) {
 					err = list->resume(list);
 					if (err < 0)
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index ba27f7ade670..e02653465e29 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -53,6 +53,12 @@ struct usb_mixer_elem_list {
 	usb_mixer_elem_resume_func_t resume;
 };
 
+/* iterate over mixer element list of the given unit id */
+#define for_each_mixer_elem(list, mixer, id)	\
+	for ((list) = (mixer)->id_elems[id]; (list); (list) = (list)->next_id_elem)
+#define mixer_elem_list_to_info(list) \
+	container_of(list, struct usb_mixer_elem_info, head)
+
 struct usb_mixer_elem_info {
 	struct usb_mixer_elem_list head;
 	unsigned int control;	/* CS or ICN (high byte) */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 4377374affd3..1b94387e18b6 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1172,7 +1172,7 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 	int unitid = 12; /* SamleRate ExtensionUnit ID */
 
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
-		cval = (struct usb_mixer_elem_info *)mixer->id_elems[unitid];
+		cval = mixer_elem_list_to_info(mixer->id_elems[unitid]);
 		if (cval) {
 			snd_usb_mixer_set_ctl_value(cval, UAC_SET_CUR,
 						    cval->control << 8,
diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index c33e2378089d..4aeb9488a0c9 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -287,8 +287,7 @@ static int scarlett_ctl_switch_put(struct snd_kcontrol *kctl,
 
 static int scarlett_ctl_resume(struct usb_mixer_elem_list *list)
 {
-	struct usb_mixer_elem_info *elem =
-		container_of(list, struct usb_mixer_elem_info, head);
+	struct usb_mixer_elem_info *elem = mixer_elem_list_to_info(list);
 	int i;
 
 	for (i = 0; i < elem->channels; i++)
@@ -447,8 +446,7 @@ static int scarlett_ctl_enum_put(struct snd_kcontrol *kctl,
 
 static int scarlett_ctl_enum_resume(struct usb_mixer_elem_list *list)
 {
-	struct usb_mixer_elem_info *elem =
-		container_of(list, struct usb_mixer_elem_info, head);
+	struct usb_mixer_elem_info *elem = mixer_elem_list_to_info(list);
 
 	if (elem->cached)
 		snd_usb_set_cur_mix_value(elem, 0, 0, *elem->cache_val);
-- 
2.16.3
