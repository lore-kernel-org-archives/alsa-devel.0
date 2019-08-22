From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: usb-audio: Remove superfluous
	bLength checks
Date: Thu, 22 Aug 2019 09:32:07 +0200
Message-ID: <20190822073207.8696-6-tiwai@suse.de>
References: <20190822073207.8696-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 300B9F803D5
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 09:32:12 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3A791B005
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 07:32:09 +0000 (UTC)
In-Reply-To: <20190822073207.8696-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Now that we got the more comprehensive validation code for USB-audio
descriptors, the check of overflow in each descriptor unit parser
became superfluous.  Drop some of the obvious cases.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/clock.c | 14 ++++------
 sound/usb/mixer.c | 84 -------------------------------------------------------
 2 files changed, 6 insertions(+), 92 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 72e9bdf76115..6b8c14f9b5d4 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -38,39 +38,37 @@ static void *find_uac_clock_desc(struct usb_host_interface *iface, int id,
 static bool validate_clock_source_v2(void *p, int id)
 {
 	struct uac_clock_source_descriptor *cs = p;
-	return cs->bLength == sizeof(*cs) && cs->bClockID == id;
+	return cs->bClockID == id;
 }
 
 static bool validate_clock_source_v3(void *p, int id)
 {
 	struct uac3_clock_source_descriptor *cs = p;
-	return cs->bLength == sizeof(*cs) && cs->bClockID == id;
+	return cs->bClockID == id;
 }
 
 static bool validate_clock_selector_v2(void *p, int id)
 {
 	struct uac_clock_selector_descriptor *cs = p;
-	return cs->bLength >= sizeof(*cs) && cs->bClockID == id &&
-		cs->bLength == 7 + cs->bNrInPins;
+	return cs->bClockID == id;
 }
 
 static bool validate_clock_selector_v3(void *p, int id)
 {
 	struct uac3_clock_selector_descriptor *cs = p;
-	return cs->bLength >= sizeof(*cs) && cs->bClockID == id &&
-		cs->bLength == 11 + cs->bNrInPins;
+	return cs->bClockID == id;
 }
 
 static bool validate_clock_multiplier_v2(void *p, int id)
 {
 	struct uac_clock_multiplier_descriptor *cs = p;
-	return cs->bLength == sizeof(*cs) && cs->bClockID == id;
+	return cs->bClockID == id;
 }
 
 static bool validate_clock_multiplier_v3(void *p, int id)
 {
 	struct uac3_clock_multiplier_descriptor *cs = p;
-	return cs->bLength == sizeof(*cs) && cs->bClockID == id;
+	return cs->bClockID == id;
 }
 
 #define DEFINE_FIND_HELPER(name, obj, validator, type)		\
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 7f498528be48..61b240835574 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -740,13 +740,6 @@ static int uac_mixer_unit_get_channels(struct mixer_build *state,
 {
 	int mu_channels;
 
-	if (desc->bLength < sizeof(*desc))
-		return -EINVAL;
-	if (!desc->bNrInPins)
-		return -EINVAL;
-	if (desc->bLength < sizeof(*desc) + desc->bNrInPins)
-		return -EINVAL;
-
 	switch (state->mixer->protocol) {
 	case UAC_VERSION_1:
 	case UAC_VERSION_2:
@@ -1781,13 +1774,6 @@ static int parse_clock_source_unit(struct mixer_build *state, int unitid,
 	if (state->mixer->protocol != UAC_VERSION_2)
 		return -EINVAL;
 
-	if (hdr->bLength != sizeof(*hdr)) {
-		usb_audio_dbg(state->chip,
-			      "Bogus clock source descriptor length of %d, ignoring.\n",
-			      hdr->bLength);
-		return 0;
-	}
-
 	/*
 	 * The only property of this unit we are interested in is the
 	 * clock source validity. If that isn't readable, just bail out.
@@ -1846,62 +1832,20 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 	__u8 *bmaControls;
 
 	if (state->mixer->protocol == UAC_VERSION_1) {
-		if (hdr->bLength < 7) {
-			usb_audio_err(state->chip,
-				      "unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
-				      unitid);
-			return -EINVAL;
-		}
 		csize = hdr->bControlSize;
-		if (!csize) {
-			usb_audio_dbg(state->chip,
-				      "unit %u: invalid bControlSize == 0\n",
-				      unitid);
-			return -EINVAL;
-		}
 		channels = (hdr->bLength - 7) / csize - 1;
 		bmaControls = hdr->bmaControls;
-		if (hdr->bLength < 7 + csize) {
-			usb_audio_err(state->chip,
-				      "unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
-				      unitid);
-			return -EINVAL;
-		}
 	} else if (state->mixer->protocol == UAC_VERSION_2) {
 		struct uac2_feature_unit_descriptor *ftr = _ftr;
-		if (hdr->bLength < 6) {
-			usb_audio_err(state->chip,
-				      "unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
-				      unitid);
-			return -EINVAL;
-		}
 		csize = 4;
 		channels = (hdr->bLength - 6) / 4 - 1;
 		bmaControls = ftr->bmaControls;
-		if (hdr->bLength < 6 + csize) {
-			usb_audio_err(state->chip,
-				      "unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
-				      unitid);
-			return -EINVAL;
-		}
 	} else { /* UAC_VERSION_3 */
 		struct uac3_feature_unit_descriptor *ftr = _ftr;
 
-		if (hdr->bLength < 7) {
-			usb_audio_err(state->chip,
-				      "unit %u: invalid UAC3_FEATURE_UNIT descriptor\n",
-				      unitid);
-			return -EINVAL;
-		}
 		csize = 4;
 		channels = (ftr->bLength - 7) / 4 - 1;
 		bmaControls = ftr->bmaControls;
-		if (hdr->bLength < 7 + csize) {
-			usb_audio_err(state->chip,
-				      "unit %u: invalid UAC3_FEATURE_UNIT descriptor\n",
-				      unitid);
-			return -EINVAL;
-		}
 	}
 
 	/* parse the source unit */
@@ -2099,15 +2043,11 @@ static int parse_audio_input_terminal(struct mixer_build *state, int unitid,
 
 	if (state->mixer->protocol == UAC_VERSION_2) {
 		struct uac2_input_terminal_descriptor *d_v2 = raw_desc;
-		if (d_v2->bLength < sizeof(*d_v2))
-			return -EINVAL;
 		control = UAC2_TE_CONNECTOR;
 		term_id = d_v2->bTerminalID;
 		bmctls = le16_to_cpu(d_v2->bmControls);
 	} else if (state->mixer->protocol == UAC_VERSION_3) {
 		struct uac3_input_terminal_descriptor *d_v3 = raw_desc;
-		if (d_v3->bLength < sizeof(*d_v3))
-			return -EINVAL;
 		control = UAC3_TE_INSERTION;
 		term_id = d_v3->bTerminalID;
 		bmctls = le32_to_cpu(d_v3->bmControls);
@@ -2369,18 +2309,7 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 	const char *name = extension_unit ?
 		"Extension Unit" : "Processing Unit";
 
-	if (desc->bLength < 13) {
-		usb_audio_err(state->chip, "invalid %s descriptor (id %d)\n", name, unitid);
-		return -EINVAL;
-	}
-
 	num_ins = desc->bNrInPins;
-	if (desc->bLength < 13 + num_ins ||
-	    desc->bLength < num_ins + uac_processing_unit_bControlSize(desc, state->mixer->protocol)) {
-		usb_audio_err(state->chip, "invalid %s descriptor (id %d)\n", name, unitid);
-		return -EINVAL;
-	}
-
 	for (i = 0; i < num_ins; i++) {
 		err = parse_audio_unit(state, desc->baSourceID[i]);
 		if (err < 0)
@@ -2635,13 +2564,6 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	const struct usbmix_name_map *map;
 	char **namelist;
 
-	if (desc->bLength < 5 || !desc->bNrInPins ||
-	    desc->bLength < 5 + desc->bNrInPins) {
-		usb_audio_err(state->chip,
-			"invalid SELECTOR UNIT descriptor %d\n", unitid);
-		return -EINVAL;
-	}
-
 	for (i = 0; i < desc->bNrInPins; i++) {
 		err = parse_audio_unit(state, desc->baSourceID[i]);
 		if (err < 0)
@@ -3147,8 +3069,6 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 		if (mixer->protocol == UAC_VERSION_1) {
 			struct uac1_output_terminal_descriptor *desc = p;
 
-			if (desc->bLength < sizeof(*desc))
-				continue; /* invalid descriptor? */
 			/* mark terminal ID as visited */
 			set_bit(desc->bTerminalID, state.unitbitmap);
 			state.oterm.id = desc->bTerminalID;
@@ -3160,8 +3080,6 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 		} else if (mixer->protocol == UAC_VERSION_2) {
 			struct uac2_output_terminal_descriptor *desc = p;
 
-			if (desc->bLength < sizeof(*desc))
-				continue; /* invalid descriptor? */
 			/* mark terminal ID as visited */
 			set_bit(desc->bTerminalID, state.unitbitmap);
 			state.oterm.id = desc->bTerminalID;
@@ -3187,8 +3105,6 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 		} else {  /* UAC_VERSION_3 */
 			struct uac3_output_terminal_descriptor *desc = p;
 
-			if (desc->bLength < sizeof(*desc))
-				continue; /* invalid descriptor? */
 			/* mark terminal ID as visited */
 			set_bit(desc->bTerminalID, state.unitbitmap);
 			state.oterm.id = desc->bTerminalID;
-- 
2.16.4
