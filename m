From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: usb-audio: Follow standard coding
	style
Date: Mon, 28 May 2018 11:58:21 +0200
Message-ID: <20180528095821.28710-4-tiwai@suse.de>
References: <20180528095821.28710-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 28D2626763F
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 17:54:08 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C95C0AEA1
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 15:54:07 +0000 (UTC)
In-Reply-To: <20180528095821.28710-1-tiwai@suse.de>
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

Avoid if ((err = ...) style and expand to multiple lines instead.
No change in the end result, but just the beautification.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/clock.c        | 18 ++++++++++--------
 sound/usb/mixer.c        | 25 +++++++++++++++++--------
 sound/usb/mixer_quirks.c |  3 ++-
 sound/usb/pcm.c          | 18 ++++++++++--------
 4 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 17673f37fcc8..c79749613fa6 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -443,10 +443,11 @@ static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
 	data[0] = rate;
 	data[1] = rate >> 8;
 	data[2] = rate >> 16;
-	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
-				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
-				   data, sizeof(data))) < 0) {
+	err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
+			      USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+			      UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
+			      data, sizeof(data));
+	if (err < 0) {
 		dev_err(&dev->dev, "%d:%d: cannot set freq %d to ep %#x\n",
 			iface, fmt->altsetting, rate, ep);
 		return err;
@@ -460,10 +461,11 @@ static int set_sample_rate_v1(struct snd_usb_audio *chip, int iface,
 	if (chip->sample_rate_read_error > 2)
 		return 0;
 
-	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
-				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
-				   UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
-				   data, sizeof(data))) < 0) {
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
+			      USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
+			      UAC_EP_CS_ATTR_SAMPLE_RATE << 8, ep,
+			      data, sizeof(data));
+	if (err < 0) {
 		dev_err(&dev->dev, "%d:%d: cannot get freq at ep %#x\n",
 			iface, fmt->altsetting, ep);
 		chip->sample_rate_read_error++;
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index bf74e7edc92b..898afd3001ea 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -598,7 +598,8 @@ int snd_usb_mixer_add_control(struct usb_mixer_elem_list *list,
 
 	while (snd_ctl_find_id(mixer->chip->card, &kctl->id))
 		kctl->id.index++;
-	if ((err = snd_ctl_add(mixer->chip->card, kctl)) < 0) {
+	err = snd_ctl_add(mixer->chip->card, kctl);
+	if (err < 0) {
 		usb_audio_dbg(mixer->chip, "cannot add control (err = %d)\n",
 			      err);
 		return err;
@@ -1850,7 +1851,8 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 	}
 
 	/* parse the source unit */
-	if ((err = parse_audio_unit(state, hdr->bSourceID)) < 0)
+	err = parse_audio_unit(state, hdr->bSourceID);
+	if (err < 0)
 		return err;
 
 	/* determine the input source type and name */
@@ -2270,7 +2272,8 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 	}
 
 	for (i = 0; i < num_ins; i++) {
-		if ((err = parse_audio_unit(state, desc->baSourceID[i])) < 0)
+		err = parse_audio_unit(state, desc->baSourceID[i]);
+		if (err < 0)
 			return err;
 	}
 
@@ -2483,7 +2486,8 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	}
 
 	for (i = 0; i < desc->bNrInPins; i++) {
-		if ((err = parse_audio_unit(state, desc->baSourceID[i])) < 0)
+		err = parse_audio_unit(state, desc->baSourceID[i]);
+		if (err < 0)
 			return err;
 	}
 
@@ -3310,11 +3314,16 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 
 	if (mixer->protocol == UAC_VERSION_3 &&
 			chip->badd_profile >= UAC3_FUNCTION_SUBCLASS_GENERIC_IO) {
-		if ((err = snd_usb_mixer_controls_badd(mixer, ctrlif)) < 0)
+		err = snd_usb_mixer_controls_badd(mixer, ctrlif);
+		if (err < 0)
+			goto _error;
+	} else {
+		err = snd_usb_mixer_controls(mixer);
+		if (err < 0)
+			goto _error;
+		err = snd_usb_mixer_status_create(mixer);
+		if (err < 0)
 			goto _error;
-	} else if ((err = snd_usb_mixer_controls(mixer)) < 0 ||
-			(err = snd_usb_mixer_status_create(mixer)) < 0) {
-		goto _error;
 	}
 	err = create_keep_iface_ctl(mixer);
 	if (err < 0)
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 1b94387e18b6..4149543f613e 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1824,7 +1824,8 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	int err = 0;
 	struct snd_info_entry *entry;
 
-	if ((err = snd_usb_soundblaster_remote_init(mixer)) < 0)
+	err = snd_usb_soundblaster_remote_init(mixer);
+	if (err < 0)
 		return err;
 
 	switch (mixer->chip->usb_id) {
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index a66bc717b952..897a2cbef6de 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -163,10 +163,11 @@ static int init_pitch_v1(struct snd_usb_audio *chip, int iface,
 	ep = get_endpoint(alts, 0)->bEndpointAddress;
 
 	data[0] = 1;
-	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
-				   USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
-				   UAC_EP_CS_ATTR_PITCH_CONTROL << 8, ep,
-				   data, sizeof(data))) < 0) {
+	err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
+			      USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT,
+			      UAC_EP_CS_ATTR_PITCH_CONTROL << 8, ep,
+			      data, sizeof(data));
+	if (err < 0) {
 		usb_audio_err(chip, "%d:%d: cannot set enable PITCH\n",
 			      iface, ep);
 		return err;
@@ -184,10 +185,11 @@ static int init_pitch_v2(struct snd_usb_audio *chip, int iface,
 	int err;
 
 	data[0] = 1;
-	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
-				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-				   UAC2_EP_CS_PITCH << 8, 0,
-				   data, sizeof(data))) < 0) {
+	err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
+			      USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+			      UAC2_EP_CS_PITCH << 8, 0,
+			      data, sizeof(data));
+	if (err < 0) {
 		usb_audio_err(chip, "%d:%d: cannot set enable PITCH (v2)\n",
 			      iface, fmt->altsetting);
 		return err;
-- 
2.16.3
