From: Andrew Chant <achant@google.com>
Subject: [PATCH v3 2/2] ALSA: usb-audio: update clock valid
	control
Date: Fri, 23 Mar 2018 19:25:24 -0700
Message-ID: <20180324022524.227748-3-achant@google.com>
References: <20180324022524.227748-1-achant@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A6BA266F60
 for <alsa-devel@alsa-project.org>; Sat, 24 Mar 2018 03:25:58 +0100 (CET)
Received: by mail-pg0-f67.google.com with SMTP id n11so5250330pgp.4
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 19:25:58 -0700 (PDT)
In-Reply-To: <20180324022524.227748-1-achant@google.com>
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

Make the "clock valid" control a global control instead of a mixer
so that it doesn't appear in mixer applications.

Additionally, remove the check for writeability prohibited by spec, and
Use common code to read the control value.

Tested with a UAC2 Audio device that presents a clock validity
control.  The control still shows up in /proc usbmixer but not
in alsamixer.

Signed-off-by: Andrew Chant <achant@google.com>
---
 sound/usb/mixer.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 97ed2155205d..04dab6f65535 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1235,9 +1235,9 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-/* get the current value from a mixer element */
-static int mixer_ctl_connector_get(struct snd_kcontrol *kcontrol,
-				   struct snd_ctl_elem_value *ucontrol)
+/* get the boolean value from the master channel of a UAC control */
+static int mixer_ctl_master_bool_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_info *cval = kcontrol->private_data;
 	int val, err;
@@ -1267,13 +1267,16 @@ static const struct snd_kcontrol_new usb_feature_unit_ctl_ro = {
 	.put = NULL,
 };
 
-/* A UAC connector mixer control */
-static struct snd_kcontrol_new usb_connector_ctl_ro = {
+/*
+ * A control which shows the boolean value from reading a UAC control on
+ * the master channel.
+ */
+static struct snd_kcontrol_new usb_bool_master_control_ctl_ro = {
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.name = "", /* will be filled later manually */
 	.access = SNDRV_CTL_ELEM_ACCESS_READ,
 	.info = snd_ctl_boolean_mono_info,
-	.get = mixer_ctl_connector_get,
+	.get = mixer_ctl_master_bool_get,
 	.put = NULL,
 };
 
@@ -1520,12 +1523,18 @@ static void build_connector_control(struct mixer_build *state,
 	if (!cval)
 		return;
 	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, term->id);
+	/*
+	 * The first byte from reading the UAC2_TE_CONNECTOR control returns the
+	 * number of channels connected.  This boolean ctl will simply report
+	 * if any channels are connected or not.
+	 * (Audio20_final.pdf Table 5-10: Connector Control CUR Parameter Block)
+	 */
 	cval->control = UAC2_TE_CONNECTOR;
 	cval->val_type = USB_MIXER_BOOLEAN;
 	cval->channels = 1; /* report true if any channel is connected */
 	cval->min = 0;
 	cval->max = 1;
-	kctl = snd_ctl_new1(&usb_connector_ctl_ro, cval);
+	kctl = snd_ctl_new1(&usb_bool_master_control_ctl_ro, cval);
 	if (!kctl) {
 		usb_audio_err(state->chip, "cannot malloc kcontrol\n");
 		kfree(cval);
@@ -1576,13 +1585,9 @@ static int parse_clock_source_unit(struct mixer_build *state, int unitid,
 	cval->val_type = USB_MIXER_BOOLEAN;
 	cval->control = UAC2_CS_CONTROL_CLOCK_VALID;
 
-	if (uac_v2v3_control_is_writeable(hdr->bmControls,
-				      UAC2_CS_CONTROL_CLOCK_VALID))
-		kctl = snd_ctl_new1(&usb_feature_unit_ctl, cval);
-	else {
-		cval->master_readonly = 1;
-		kctl = snd_ctl_new1(&usb_feature_unit_ctl_ro, cval);
-	}
+	cval->master_readonly = 1;
+	/* From UAC2 5.2.5.1.2 "Only the get request is supported." */
+	kctl = snd_ctl_new1(&usb_bool_master_control_ctl_ro, cval);
 
 	if (!kctl) {
 		kfree(cval);
-- 
2.17.0.rc0.231.g781580f067-goog
