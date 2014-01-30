From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix inconsistent Mic mute LED
Date: Thu, 30 Jan 2014 18:04:19 +0100
Message-ID: <1391101459-2973-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 317132654E6
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 18:04:19 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 102FAAC56
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 17:04:19 +0000 (UTC)
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

The current code for controlling mic mute LED in patch_sigmatel.c
blindly assumes that there is a single capture switch.  But, there can
be multiple multiple ones, and each of them flips the state, ended up
in an inconsistent state.

For fixing this problem, this patch adds kcontrol to be passed to the
hook function so that the callee can check which switch is being
accessed.  In stac_capture_led_hook(), the state is checked as a
bitmask, and turns on the LED when all capture switches are off.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c     |  8 ++++----
 sound/pci/hda/hda_generic.h     |  1 +
 sound/pci/hda/patch_conexant.c  |  3 ++-
 sound/pci/hda/patch_realtek.c   |  9 ++++++---
 sound/pci/hda/patch_sigmatel.c  | 27 +++++++++++++++++----------
 sound/pci/hda/thinkpad_helper.c |  1 +
 6 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 8321a97d5c05..d9a09bdd09db 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3269,7 +3269,7 @@ static int cap_put_caller(struct snd_kcontrol *kcontrol,
 	mutex_unlock(&codec->control_mutex);
 	snd_hda_codec_flush_cache(codec); /* flush the updates */
 	if (err >= 0 && spec->cap_sync_hook)
-		spec->cap_sync_hook(codec, ucontrol);
+		spec->cap_sync_hook(codec, kcontrol, ucontrol);
 	return err;
 }
 
@@ -3390,7 +3390,7 @@ static int cap_single_sw_put(struct snd_kcontrol *kcontrol,
 		return ret;
 
 	if (spec->cap_sync_hook)
-		spec->cap_sync_hook(codec, ucontrol);
+		spec->cap_sync_hook(codec, kcontrol, ucontrol);
 
 	return ret;
 }
@@ -3795,7 +3795,7 @@ static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
 		return 0;
 	snd_hda_activate_path(codec, path, true, false);
 	if (spec->cap_sync_hook)
-		spec->cap_sync_hook(codec, NULL);
+		spec->cap_sync_hook(codec, NULL, NULL);
 	path_power_down_sync(codec, old_path);
 	return 1;
 }
@@ -5270,7 +5270,7 @@ static void init_input_src(struct hda_codec *codec)
 	}
 
 	if (spec->cap_sync_hook)
-		spec->cap_sync_hook(codec, NULL);
+		spec->cap_sync_hook(codec, NULL, NULL);
 }
 
 /* set right pin controls for digital I/O */
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 07f767231c9f..c908afbe4d94 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -274,6 +274,7 @@ struct hda_gen_spec {
 	void (*init_hook)(struct hda_codec *codec);
 	void (*automute_hook)(struct hda_codec *codec);
 	void (*cap_sync_hook)(struct hda_codec *codec,
+			      struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol);
 
 	/* PCM hooks */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 4e0ec146553d..bcf91bea3317 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3291,7 +3291,8 @@ static void cxt_update_headset_mode(struct hda_codec *codec)
 }
 
 static void cxt_update_headset_mode_hook(struct hda_codec *codec,
-			     struct snd_ctl_elem_value *ucontrol)
+					 struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	cxt_update_headset_mode(codec);
 }
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 56a8f1876603..6aabaa1c19f5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -708,7 +708,8 @@ static void alc_inv_dmic_sync(struct hda_codec *codec, bool force)
 }
 
 static void alc_inv_dmic_hook(struct hda_codec *codec,
-			     struct snd_ctl_elem_value *ucontrol)
+			      struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
 {
 	alc_inv_dmic_sync(codec, false);
 }
@@ -3211,7 +3212,8 @@ static void alc269_fixup_hp_gpio_mute_hook(void *private_data, int enabled)
 
 /* turn on/off mic-mute LED per capture hook */
 static void alc269_fixup_hp_gpio_mic_mute_hook(struct hda_codec *codec,
-			       struct snd_ctl_elem_value *ucontrol)
+					       struct snd_kcontrol *kcontrol,
+					       struct snd_ctl_elem_value *ucontrol)
 {
 	struct alc_spec *spec = codec->spec;
 	unsigned int oldval = spec->gpio_led;
@@ -3521,7 +3523,8 @@ static void alc_update_headset_mode(struct hda_codec *codec)
 }
 
 static void alc_update_headset_mode_hook(struct hda_codec *codec,
-			     struct snd_ctl_elem_value *ucontrol)
+					 struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	alc_update_headset_mode(codec);
 }
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 6998cf29b9bc..7311badf6a94 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -194,7 +194,7 @@ struct sigmatel_spec {
 	int default_polarity;
 
 	unsigned int mic_mute_led_gpio; /* capture mute LED GPIO */
-	bool mic_mute_led_on; /* current mic mute state */
+	unsigned int mic_enabled; /* current mic mute state (bitmask) */
 
 	/* stream */
 	unsigned int stream_delay;
@@ -324,19 +324,26 @@ static void stac_gpio_set(struct hda_codec *codec, unsigned int mask,
 
 /* hook for controlling mic-mute LED GPIO */
 static void stac_capture_led_hook(struct hda_codec *codec,
-			       struct snd_ctl_elem_value *ucontrol)
+				  struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct sigmatel_spec *spec = codec->spec;
-	bool mute;
+	unsigned int mask;
+	bool cur_mute, prev_mute;
 
-	if (!ucontrol)
+	if (!kcontrol || !ucontrol)
 		return;
 
-	mute = !(ucontrol->value.integer.value[0] ||
-		 ucontrol->value.integer.value[1]);
-	if (spec->mic_mute_led_on != mute) {
-		spec->mic_mute_led_on = mute;
-		if (mute)
+	mask = 1U << snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	prev_mute = !spec->mic_enabled;
+	if (ucontrol->value.integer.value[0] ||
+	    ucontrol->value.integer.value[1])
+		spec->mic_enabled |= mask;
+	else
+		spec->mic_enabled &= ~mask;
+	cur_mute = !spec->mic_enabled;
+	if (cur_mute != prev_mute) {
+		if (cur_mute)
 			spec->gpio_data |= spec->mic_mute_led_gpio;
 		else
 			spec->gpio_data &= ~spec->mic_mute_led_gpio;
@@ -4462,7 +4469,7 @@ static void stac_setup_gpio(struct hda_codec *codec)
 	if (spec->mic_mute_led_gpio) {
 		spec->gpio_mask |= spec->mic_mute_led_gpio;
 		spec->gpio_dir |= spec->mic_mute_led_gpio;
-		spec->mic_mute_led_on = true;
+		spec->mic_enabled = 0;
 		spec->gpio_data |= spec->mic_mute_led_gpio;
 
 		spec->gen.cap_sync_hook = stac_capture_led_hook;
diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
index 5799fbc24c28..8fe3b8c18ed4 100644
--- a/sound/pci/hda/thinkpad_helper.c
+++ b/sound/pci/hda/thinkpad_helper.c
@@ -39,6 +39,7 @@ static void update_tpacpi_mute_led(void *private_data, int enabled)
 }
 
 static void update_tpacpi_micmute_led(struct hda_codec *codec,
+				      struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
 	if (!ucontrol || !led_set_func)
-- 
1.8.5.2
