From: Chris J Arges <chris.j.arges@canonical.com>
Subject: [PATCH v3 3/4] ALSA: usb-audio: make set_*_mix_values
	functions public
Date: Wed, 29 Oct 2014 15:56:02 -0500
Message-ID: <1414616163-14146-4-git-send-email-chris.j.arges@canonical.com>
References: <s5h1tq0egzi.wl-tiwai@suse.de>
 <1414616163-14146-1-git-send-email-chris.j.arges@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CFBA2605C9
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 21:56:12 +0100 (CET)
In-Reply-To: <1414616163-14146-1-git-send-email-chris.j.arges@canonical.com>
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
Cc: tiwai@suse.de, th55@gmx.de, robin@gareus.org, clemens@ladisch.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Make the functions set_cur_mix_value and get_cur_mix_value accessible by files
that include mixer.h. In addition make usb_mixer_elem_free accessible.
This allows reuse of these functions by mixers that may require quirks.

The following summarizes the renamed functions:
  - set_cur_mix_value -> snd_usb_set_cur_mix_value
  - get_cur_mix_value -> snd_usb_get_cur_mix_value
  - usb_mixer_elem_free -> snd_usb_mixer_elem_free

Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
---
 sound/usb/mixer.c        | 34 +++++++++++++++++-----------------
 sound/usb/mixer.h        |  8 ++++++++
 sound/usb/mixer_quirks.c |  9 +--------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 2e4a9db..6b169fb 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -412,7 +412,7 @@ static inline int get_cur_mix_raw(struct usb_mixer_elem_info *cval,
 			     value);
 }
 
-static int get_cur_mix_value(struct usb_mixer_elem_info *cval,
+int snd_usb_get_cur_mix_value(struct usb_mixer_elem_info *cval,
 			     int channel, int index, int *value)
 {
 	int err;
@@ -497,7 +497,7 @@ static int set_cur_ctl_value(struct usb_mixer_elem_info *cval,
 	return snd_usb_mixer_set_ctl_value(cval, UAC_SET_CUR, validx, value);
 }
 
-static int set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
+int snd_usb_set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
 			     int index, int value)
 {
 	int err;
@@ -815,7 +815,7 @@ static struct usb_feature_control_info audio_feature_info[] = {
 };
 
 /* private_free callback */
-static void usb_mixer_elem_free(struct snd_kcontrol *kctl)
+void snd_usb_mixer_elem_free(struct snd_kcontrol *kctl)
 {
 	kfree(kctl->private_data);
 	kctl->private_data = NULL;
@@ -998,7 +998,7 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 				else
 					test -= cval->res;
 				if (test < cval->min || test > cval->max ||
-				    set_cur_mix_value(cval, minchn, 0, test) ||
+				    snd_usb_set_cur_mix_value(cval, minchn, 0, test) ||
 				    get_cur_mix_raw(cval, minchn, &check)) {
 					cval->res = last_valid_res;
 					break;
@@ -1007,7 +1007,7 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 					break;
 				cval->res *= 2;
 			}
-			set_cur_mix_value(cval, minchn, 0, saved);
+			snd_usb_set_cur_mix_value(cval, minchn, 0, saved);
 		}
 
 		cval->initialized = 1;
@@ -1086,7 +1086,7 @@ static int mixer_ctl_feature_get(struct snd_kcontrol *kcontrol,
 		for (c = 0; c < MAX_CHANNELS; c++) {
 			if (!(cval->cmask & (1 << c)))
 				continue;
-			err = get_cur_mix_value(cval, c + 1, cnt, &val);
+			err = snd_usb_get_cur_mix_value(cval, c + 1, cnt, &val);
 			if (err < 0)
 				return cval->mixer->ignore_ctl_error ? 0 : err;
 			val = get_relative_value(cval, val);
@@ -1096,7 +1096,7 @@ static int mixer_ctl_feature_get(struct snd_kcontrol *kcontrol,
 		return 0;
 	} else {
 		/* master channel */
-		err = get_cur_mix_value(cval, 0, 0, &val);
+		err = snd_usb_get_cur_mix_value(cval, 0, 0, &val);
 		if (err < 0)
 			return cval->mixer->ignore_ctl_error ? 0 : err;
 		val = get_relative_value(cval, val);
@@ -1118,26 +1118,26 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 		for (c = 0; c < MAX_CHANNELS; c++) {
 			if (!(cval->cmask & (1 << c)))
 				continue;
-			err = get_cur_mix_value(cval, c + 1, cnt, &oval);
+			err = snd_usb_get_cur_mix_value(cval, c + 1, cnt, &oval);
 			if (err < 0)
 				return cval->mixer->ignore_ctl_error ? 0 : err;
 			val = ucontrol->value.integer.value[cnt];
 			val = get_abs_value(cval, val);
 			if (oval != val) {
-				set_cur_mix_value(cval, c + 1, cnt, val);
+				snd_usb_set_cur_mix_value(cval, c + 1, cnt, val);
 				changed = 1;
 			}
 			cnt++;
 		}
 	} else {
 		/* master channel */
-		err = get_cur_mix_value(cval, 0, 0, &oval);
+		err = snd_usb_get_cur_mix_value(cval, 0, 0, &oval);
 		if (err < 0)
 			return cval->mixer->ignore_ctl_error ? 0 : err;
 		val = ucontrol->value.integer.value[0];
 		val = get_abs_value(cval, val);
 		if (val != oval) {
-			set_cur_mix_value(cval, 0, 0, val);
+			snd_usb_set_cur_mix_value(cval, 0, 0, val);
 			changed = 1;
 		}
 	}
@@ -1250,7 +1250,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 
 	/*
 	 * If all channels in the mask are marked read-only, make the control
-	 * read-only. set_cur_mix_value() will check the mask again and won't
+	 * read-only. snd_usb_set_cur_mix_value() will check the mask again and won't
 	 * issue write commands to read-only channels.
 	 */
 	if (cval->channels == readonly_mask)
@@ -1263,7 +1263,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 		kfree(cval);
 		return;
 	}
-	kctl->private_free = usb_mixer_elem_free;
+	kctl->private_free = snd_usb_mixer_elem_free;
 
 	len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
 	mapped_name = len != 0;
@@ -1547,7 +1547,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 		kfree(cval);
 		return;
 	}
-	kctl->private_free = usb_mixer_elem_free;
+	kctl->private_free = snd_usb_mixer_elem_free;
 
 	len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
 	if (!len)
@@ -1847,7 +1847,7 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 			kfree(cval);
 			return -ENOMEM;
 		}
-		kctl->private_free = usb_mixer_elem_free;
+		kctl->private_free = snd_usb_mixer_elem_free;
 
 		if (check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name))) {
 			/* nothing */ ;
@@ -2530,7 +2530,7 @@ static int restore_mixer_value(struct usb_mixer_elem_info *cval)
 			if (!(cval->cmask & (1 << c)))
 				continue;
 			if (cval->cached & (1 << c)) {
-				err = set_cur_mix_value(cval, c + 1, idx,
+				err = snd_usb_set_cur_mix_value(cval, c + 1, idx,
 							cval->cache_val[idx]);
 				if (err < 0)
 					return err;
@@ -2540,7 +2540,7 @@ static int restore_mixer_value(struct usb_mixer_elem_info *cval)
 	} else {
 		/* master */
 		if (cval->cached) {
-			err = set_cur_mix_value(cval, 0, 0, *cval->cache_val);
+			err = snd_usb_set_cur_mix_value(cval, 0, 0, *cval->cache_val);
 			if (err < 0)
 				return err;
 		}
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index cf3967a4..af4772e 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -82,4 +82,12 @@ int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer);
 int snd_usb_mixer_resume(struct usb_mixer_interface *mixer, bool reset_resume);
 #endif
 
+int snd_usb_set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
+                             int index, int value);
+
+int snd_usb_get_cur_mix_value(struct usb_mixer_elem_info *cval,
+                             int channel, int index, int *value);
+
+extern void snd_usb_mixer_elem_free(struct snd_kcontrol *kctl);
+
 #endif /* __USBMIXER_H */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index f119a41..c9665bf 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -52,13 +52,6 @@ struct std_mono_table {
 	snd_kcontrol_tlv_rw_t *tlv_callback;
 };
 
-/* private_free callback */
-static void usb_mixer_elem_free(struct snd_kcontrol *kctl)
-{
-	kfree(kctl->private_data);
-	kctl->private_data = NULL;
-}
-
 /* This function allows for the creation of standard UAC controls.
  * See the quirks for M-Audio FTUs or Ebox-44.
  * If you don't want to set a TLV callback pass NULL.
@@ -108,7 +101,7 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 
 	/* Set name */
 	snprintf(kctl->id.name, sizeof(kctl->id.name), name);
-	kctl->private_free = usb_mixer_elem_free;
+	kctl->private_free = snd_usb_mixer_elem_free;
 
 	/* set TLV */
 	if (tlv_callback) {
-- 
2.1.0
