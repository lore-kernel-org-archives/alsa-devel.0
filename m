From: Andrew Chant <achant@google.com>
Subject: [PATCH 1/2] ALSA: usb-audio: UAC2 jack detection
Date: Fri, 23 Mar 2018 18:55:48 -0700
Message-ID: <20180324015549.162765-2-achant@google.com>
References: <20180324015549.162765-1-achant@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 94958266B67
 for <alsa-devel@alsa-project.org>; Sat, 24 Mar 2018 02:56:53 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id y186so5412202pfb.2
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 18:56:53 -0700 (PDT)
In-Reply-To: <20180324015549.162765-1-achant@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andrew Chant <achant@google.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Benson Leung <bleung@google.com>
List-Id: alsa-devel@alsa-project.org

This implements UAC2 jack detection support, presenting
jack status as a boolean read-only mono mixer.

The presence of any channel in the UAC2_TE_CONNECTOR
control for a terminal will result in the mixer saying
the jack is connected.

Mixer naming follows the convention in sound/core/ctljack.c,
terminating the mixer with " Jack".
For additional clues as to which jack is being presented,
the name is prefixed with " - Input Jack" or " - Output Jack"
depending on if it's an input or output terminal.

This is required because terminal names are ambiguous
between inputs and outputs and often duplicated -
Bidirectional terminal types (0x400 -> 0x4FF)
"... may be used separately for input only or output only.
These types require two Terminal descriptors. Both have the same type."
(quote from "USB Device Class Definition for Terminal Types")

Since bidirectional terminal types are common for headphone adapters,
this distinguishes between two otherwise identically-named
jack controls.

Tested with a UAC2 audio device with connector control capability.

Signed-off-by: Andrew Chant <achant@google.com>
---
 sound/usb/mixer.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 3075ac50a391..3db4185a5f96 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1235,6 +1235,21 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
+/* get the current value from a mixer element */
+static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	int val, err;
+
+	err = snd_usb_get_cur_mix_value(cval, 0, 0, &val);
+	if (err < 0)
+		return filter_error(cval, err);
+	val = (val != 0);
+	ucontrol->value.integer.value[0] = val;
+	return 0;
+}
+
 static struct snd_kcontrol_new usb_feature_unit_ctl = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "", /* will be filled later manually */
@@ -1252,6 +1267,16 @@ static const struct snd_kcontrol_new usb_feature_unit_ctl_ro = {
 	.put = NULL,
 };
 
+/* A UAC connector mixer control */
+static struct snd_kcontrol_new usb_connector_ctl_ro = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.name = "", /* will be filled later manually */
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.info = snd_ctl_boolean_mono_info,
+	.get = mixer_ctl_connector_get,
+	.put = NULL,
+};
+
 /*
  * This symbol is exported in order to allow the mixer quirks to
  * hook up to the standard feature unit control mechanism
@@ -1464,6 +1489,55 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 	snd_usb_mixer_add_control(&cval->head, kctl);
 }
 
+static void get_connector_control_name(struct mixer_build *state,
+				       struct usb_audio_term *term,
+				       bool is_input, char *name, int name_size)
+{
+	int name_len = get_term_name(state, term, name, name_size, 0);
+
+	if (name_len == 0)
+		strlcpy(name, "Unknown", name_size);
+
+	/*
+	 *  sound/core/ctljack.c has a convention of naming jack controls
+	 * by ending in " Jack".  Make it slightly more useful by
+	 * indicating Input or Output after the terminal name.
+	 */
+	if (is_input)
+		strlcat(name, " - Input Jack", name_size);
+	else
+		strlcat(name, " - Output Jack", name_size);
+}
+
+/* Build a mixer control for a UAC connector control (jack-detect) */
+static void build_connector_control(struct mixer_build *state,
+				    struct usb_audio_term *term, bool is_input)
+{
+	struct snd_kcontrol *kctl;
+	struct usb_mixer_elem_info *cval;
+
+	cval = kzalloc(sizeof(*cval), GFP_KERNEL);
+	if (!cval)
+		return;
+	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, term->id);
+	cval->control = UAC2_TE_CONNECTOR;
+	cval->val_type = USB_MIXER_BOOLEAN;
+	cval->channels = term->channels;
+	cval->cmask = term->chconfig;
+	cval->min = 0;
+	cval->max = 1;
+	kctl = snd_ctl_new1(&usb_connector_ctl_ro, cval);
+	if (!kctl) {
+		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
+		kfree(cval);
+		return;
+	}
+	get_connector_control_name(state, term, is_input, kctl->id.name,
+				   sizeof(kctl->id.name));
+	kctl->private_free = snd_usb_mixer_elem_free;
+	snd_usb_mixer_add_control(&cval->head, kctl);
+}
+
 static int parse_clock_source_unit(struct mixer_build *state, int unitid,
 				   void *_ftr)
 {
@@ -1770,6 +1844,23 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 	snd_usb_mixer_add_control(&cval->head, kctl);
 }
 
+static int parse_audio_input_terminal(struct mixer_build *state, int unitid,
+				      void *raw_desc)
+{
+	struct usb_audio_term iterm;
+	struct uac2_input_terminal_descriptor *d = raw_desc;
+
+	check_input_term(state, d->bTerminalID, &iterm);
+	if (state->mixer->protocol == UAC_VERSION_2) {
+		/* Check for jack detection. */
+		if (uac_v2v3_control_is_readable(d->bmControls,
+						 UAC2_TE_CONNECTOR)) {
+			build_connector_control(state, &iterm, true);
+		}
+	}
+	return 0;
+}
+
 /*
  * parse a mixer unit
  */
@@ -2320,7 +2411,7 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 	if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
 		switch (p1[2]) {
 		case UAC_INPUT_TERMINAL:
-			return 0; /* NOP */
+			return parse_audio_input_terminal(state, unitid, p1);
 		case UAC_MIXER_UNIT:
 			return parse_audio_mixer_unit(state, unitid, p1);
 		case UAC2_CLOCK_SOURCE:
@@ -2463,6 +2554,12 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 			err = parse_audio_unit(&state, desc->bCSourceID);
 			if (err < 0 && err != -EINVAL)
 				return err;
+
+			if (uac_v2v3_control_is_readable(desc->bmControls,
+							 UAC2_TE_CONNECTOR)) {
+				build_connector_control(&state, &state.oterm,
+							false);
+			}
 		} else {  /* UAC_VERSION_3 */
 			struct uac3_output_terminal_descriptor *desc = p;
 
-- 
2.17.0.rc0.231.g781580f067-goog
