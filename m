From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 6/9] ALSA: usb-audio: unify constants from
	specification
Date: Mon, 31 May 2010 13:35:41 +0200
Message-ID: <1275305744-6590-6-git-send-email-daniel@caiaq.de>
References: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 968131038B0
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 13:36:07 +0200 (CEST)
In-Reply-To: <1275305744-6590-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Move more definitions from private enums to appropriate header files.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 include/linux/usb/audio.h |   88 ++++++++++++++++++++++++++++-----------
 sound/usb/mixer.c         |   99 +++++++++++++++------------------------------
 sound/usb/mixer_maps.c    |    4 +-
 3 files changed, 98 insertions(+), 93 deletions(-)

diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index ed5cf92..c51200c 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -47,6 +47,15 @@
 #define UAC_FORMAT_TYPE			0x02
 #define UAC_FORMAT_SPECIFIC		0x03
 
+/* A.7 Processing Unit Process Types */
+#define UAC_PROCESS_UNDEFINED		0x00
+#define UAC_PROCESS_UP_DOWNMIX		0x01
+#define UAC_PROCESS_DOLBY_PROLOGIC	0x02
+#define UAC_PROCESS_STEREO_EXTENDER	0x03
+#define UAC_PROCESS_REVERB		0x04
+#define UAC_PROCESS_CHORUS		0x05
+#define UAC_PROCESS_DYN_RANGE_COMP	0x06
+
 /* A.8 Audio Class-Specific Endpoint Descriptor Subtypes */
 #define UAC_EP_GENERAL			0x01
 
@@ -73,6 +82,60 @@
 
 #define UAC_GET_STAT			0xff
 
+/* A.10 Control Selector Codes */
+
+/* A.10.1 Terminal Control Selectors */
+#define UAC_TERM_COPY_PROTECT		0x01
+
+/* A.10.2 Feature Unit Control Selectors */
+#define UAC_FU_MUTE			0x01
+#define UAC_FU_VOLUME			0x02
+#define UAC_FU_BASS			0x03
+#define UAC_FU_MID			0x04
+#define UAC_FU_TREBLE			0x05
+#define UAC_FU_GRAPHIC_EQUALIZER	0x06
+#define UAC_FU_AUTOMATIC_GAIN		0x07
+#define UAC_FU_DELAY			0x08
+#define UAC_FU_BASS_BOOST		0x09
+#define UAC_FU_LOUDNESS			0x0a
+
+#define UAC_CONTROL_BIT(CS)	(1 << ((CS) - 1))
+
+/* A.10.3.1 Up/Down-mix Processing Unit Controls Selectors */
+#define UAC_UD_ENABLE			0x01
+#define UAC_UD_MODE_SELECT		0x02
+
+/* A.10.3.2 Dolby Prologic (tm) Processing Unit Controls Selectors */
+#define UAC_DP_ENABLE			0x01
+#define UAC_DP_MODE_SELECT		0x02
+
+/* A.10.3.3 3D Stereo Extender Processing Unit Control Selectors */
+#define UAC_3D_ENABLE			0x01
+#define UAC_3D_SPACE			0x02
+
+/* A.10.3.4 Reverberation Processing Unit Control Selectors */
+#define UAC_REVERB_ENABLE		0x01
+#define UAC_REVERB_LEVEL		0x02
+#define UAC_REVERB_TIME			0x03
+#define UAC_REVERB_FEEDBACK		0x04
+
+/* A.10.3.5 Chorus Processing Unit Control Selectors */
+#define UAC_CHORUS_ENABLE		0x01
+#define UAC_CHORUS_LEVEL		0x02
+#define UAC_CHORUS_RATE			0x03
+#define UAC_CHORUS_DEPTH		0x04
+
+/* A.10.3.6 Dynamic Range Compressor Unit Control Selectors */
+#define UAC_DCR_ENABLE			0x01
+#define UAC_DCR_RATE			0x02
+#define UAC_DCR_MAXAMPL			0x03
+#define UAC_DCR_THRESHOLD		0x04
+#define UAC_DCR_ATTACK_TIME		0x05
+#define UAC_DCR_RELEASE_TIME		0x06
+
+/* A.10.4 Extension Unit Control Selectors */
+#define UAC_XU_ENABLE			0x01
+
 /* MIDI - A.1 MS Class-Specific Interface Descriptor Subtypes */
 #define UAC_MS_HEADER			0x01
 #define UAC_MIDI_IN_JACK		0x02
@@ -463,31 +526,6 @@ struct uac_iso_endpoint_descriptor {
 #define UAC_EP_CS_ATTR_PITCH_CONTROL	0x02
 #define UAC_EP_CS_ATTR_FILL_MAX		0x80
 
-/* A.10.2 Feature Unit Control Selectors */
-
-#define UAC_FU_CONTROL_UNDEFINED	0x00
-#define UAC_MUTE_CONTROL		0x01
-#define UAC_VOLUME_CONTROL		0x02
-#define UAC_BASS_CONTROL		0x03
-#define UAC_MID_CONTROL			0x04
-#define UAC_TREBLE_CONTROL		0x05
-#define UAC_GRAPHIC_EQUALIZER_CONTROL	0x06
-#define UAC_AUTOMATIC_GAIN_CONTROL	0x07
-#define UAC_DELAY_CONTROL		0x08
-#define UAC_BASS_BOOST_CONTROL		0x09
-#define UAC_LOUDNESS_CONTROL		0x0a
-
-#define UAC_FU_MUTE		(1 << (UAC_MUTE_CONTROL - 1))
-#define UAC_FU_VOLUME		(1 << (UAC_VOLUME_CONTROL - 1))
-#define UAC_FU_BASS		(1 << (UAC_BASS_CONTROL - 1))
-#define UAC_FU_MID		(1 << (UAC_MID_CONTROL - 1))
-#define UAC_FU_TREBLE		(1 << (UAC_TREBLE_CONTROL - 1))
-#define UAC_FU_GRAPHIC_EQ	(1 << (UAC_GRAPHIC_EQUALIZER_CONTROL - 1))
-#define UAC_FU_AUTO_GAIN	(1 << (UAC_AUTOMATIC_GAIN_CONTROL - 1))
-#define UAC_FU_DELAY		(1 << (UAC_DELAY_CONTROL - 1))
-#define UAC_FU_BASS_BOOST	(1 << (UAC_BASS_BOOST_CONTROL - 1))
-#define UAC_FU_LOUDNESS		(1 << (UAC_LOUDNESS_CONTROL - 1))
-
 /* status word format (3.7.1.1) */
 
 #define UAC1_STATUS_TYPE_ORIG_MASK		0x0f
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 9149a84..2442819 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -78,39 +78,6 @@ enum {
 	USB_MIXER_U16,
 };
 
-enum {
-	USB_PROC_UPDOWN = 1,
-	USB_PROC_UPDOWN_SWITCH = 1,
-	USB_PROC_UPDOWN_MODE_SEL = 2,
-
-	USB_PROC_PROLOGIC = 2,
-	USB_PROC_PROLOGIC_SWITCH = 1,
-	USB_PROC_PROLOGIC_MODE_SEL = 2,
-
-	USB_PROC_3DENH = 3,
-	USB_PROC_3DENH_SWITCH = 1,
-	USB_PROC_3DENH_SPACE = 2,
-
-	USB_PROC_REVERB = 4,
-	USB_PROC_REVERB_SWITCH = 1,
-	USB_PROC_REVERB_LEVEL = 2,
-	USB_PROC_REVERB_TIME = 3,
-	USB_PROC_REVERB_DELAY = 4,
-
-	USB_PROC_CHORUS = 5,
-	USB_PROC_CHORUS_SWITCH = 1,
-	USB_PROC_CHORUS_LEVEL = 2,
-	USB_PROC_CHORUS_RATE = 3,
-	USB_PROC_CHORUS_DEPTH = 4,
-
-	USB_PROC_DCR = 6,
-	USB_PROC_DCR_SWITCH = 1,
-	USB_PROC_DCR_RATIO = 2,
-	USB_PROC_DCR_MAX_AMP = 3,
-	USB_PROC_DCR_THRESHOLD = 4,
-	USB_PROC_DCR_ATTACK = 5,
-	USB_PROC_DCR_RELEASE = 6,
-};
 
 /*E-mu 0202(0404) eXtension Unit(XU) control*/
 enum {
@@ -980,7 +947,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 
 	control++; /* change from zero-based to 1-based value */
 
-	if (control == UAC_GRAPHIC_EQUALIZER_CONTROL) {
+	if (control == UAC_FU_GRAPHIC_EQUALIZER) {
 		/* FIXME: not supported yet */
 		return;
 	}
@@ -1036,8 +1003,8 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 				kctl->id.name, sizeof(kctl->id.name));
 
 	switch (control) {
-	case UAC_MUTE_CONTROL:
-	case UAC_VOLUME_CONTROL:
+	case UAC_FU_MUTE:
+	case UAC_FU_VOLUME:
 		/* determine the control name.  the rule is:
 		 * - if a name id is given in descriptor, use it.
 		 * - if the connected input can be determined, then use the name
@@ -1064,9 +1031,9 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 				len = append_ctl_name(kctl, " Playback");
 			}
 		}
-		append_ctl_name(kctl, control == UAC_MUTE_CONTROL ?
+		append_ctl_name(kctl, control == UAC_FU_MUTE ?
 				" Switch" : " Volume");
-		if (control == UAC_VOLUME_CONTROL) {
+		if (control == UAC_FU_VOLUME) {
 			kctl->tlv.c = mixer_vol_tlv;
 			kctl->vd[0].access |= 
 				SNDRV_CTL_ELEM_ACCESS_TLV_READ |
@@ -1165,7 +1132,7 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 		snd_printk(KERN_INFO
 			   "usbmixer: master volume quirk for PCM2702 chip\n");
 		/* disable non-functional volume control */
-		master_bits &= ~UAC_FU_VOLUME;
+		master_bits &= ~UAC_CONTROL_BIT(UAC_FU_VOLUME);
 		break;
 	}
 	if (channels > 0)
@@ -1410,51 +1377,51 @@ struct procunit_info {
 };
 
 static struct procunit_value_info updown_proc_info[] = {
-	{ USB_PROC_UPDOWN_SWITCH, "Switch", USB_MIXER_BOOLEAN },
-	{ USB_PROC_UPDOWN_MODE_SEL, "Mode Select", USB_MIXER_U8, 1 },
+	{ UAC_UD_ENABLE, "Switch", USB_MIXER_BOOLEAN },
+	{ UAC_UD_MODE_SELECT, "Mode Select", USB_MIXER_U8, 1 },
 	{ 0 }
 };
 static struct procunit_value_info prologic_proc_info[] = {
-	{ USB_PROC_PROLOGIC_SWITCH, "Switch", USB_MIXER_BOOLEAN },
-	{ USB_PROC_PROLOGIC_MODE_SEL, "Mode Select", USB_MIXER_U8, 1 },
+	{ UAC_DP_ENABLE, "Switch", USB_MIXER_BOOLEAN },
+	{ UAC_DP_MODE_SELECT, "Mode Select", USB_MIXER_U8, 1 },
 	{ 0 }
 };
 static struct procunit_value_info threed_enh_proc_info[] = {
-	{ USB_PROC_3DENH_SWITCH, "Switch", USB_MIXER_BOOLEAN },
-	{ USB_PROC_3DENH_SPACE, "Spaciousness", USB_MIXER_U8 },
+	{ UAC_3D_ENABLE, "Switch", USB_MIXER_BOOLEAN },
+	{ UAC_3D_SPACE, "Spaciousness", USB_MIXER_U8 },
 	{ 0 }
 };
 static struct procunit_value_info reverb_proc_info[] = {
-	{ USB_PROC_REVERB_SWITCH, "Switch", USB_MIXER_BOOLEAN },
-	{ USB_PROC_REVERB_LEVEL, "Level", USB_MIXER_U8 },
-	{ USB_PROC_REVERB_TIME, "Time", USB_MIXER_U16 },
-	{ USB_PROC_REVERB_DELAY, "Delay", USB_MIXER_U8 },
+	{ UAC_REVERB_ENABLE, "Switch", USB_MIXER_BOOLEAN },
+	{ UAC_REVERB_LEVEL, "Level", USB_MIXER_U8 },
+	{ UAC_REVERB_TIME, "Time", USB_MIXER_U16 },
+	{ UAC_REVERB_FEEDBACK, "Feedback", USB_MIXER_U8 },
 	{ 0 }
 };
 static struct procunit_value_info chorus_proc_info[] = {
-	{ USB_PROC_CHORUS_SWITCH, "Switch", USB_MIXER_BOOLEAN },
-	{ USB_PROC_CHORUS_LEVEL, "Level", USB_MIXER_U8 },
-	{ USB_PROC_CHORUS_RATE, "Rate", USB_MIXER_U16 },
-	{ USB_PROC_CHORUS_DEPTH, "Depth", USB_MIXER_U16 },
+	{ UAC_CHORUS_ENABLE, "Switch", USB_MIXER_BOOLEAN },
+	{ UAC_CHORUS_LEVEL, "Level", USB_MIXER_U8 },
+	{ UAC_CHORUS_RATE, "Rate", USB_MIXER_U16 },
+	{ UAC_CHORUS_DEPTH, "Depth", USB_MIXER_U16 },
 	{ 0 }
 };
 static struct procunit_value_info dcr_proc_info[] = {
-	{ USB_PROC_DCR_SWITCH, "Switch", USB_MIXER_BOOLEAN },
-	{ USB_PROC_DCR_RATIO, "Ratio", USB_MIXER_U16 },
-	{ USB_PROC_DCR_MAX_AMP, "Max Amp", USB_MIXER_S16 },
-	{ USB_PROC_DCR_THRESHOLD, "Threshold", USB_MIXER_S16 },
-	{ USB_PROC_DCR_ATTACK, "Attack Time", USB_MIXER_U16 },
-	{ USB_PROC_DCR_RELEASE, "Release Time", USB_MIXER_U16 },
+	{ UAC_DCR_ENABLE, "Switch", USB_MIXER_BOOLEAN },
+	{ UAC_DCR_RATE, "Ratio", USB_MIXER_U16 },
+	{ UAC_DCR_MAXAMPL, "Max Amp", USB_MIXER_S16 },
+	{ UAC_DCR_THRESHOLD, "Threshold", USB_MIXER_S16 },
+	{ UAC_DCR_ATTACK_TIME, "Attack Time", USB_MIXER_U16 },
+	{ UAC_DCR_RELEASE_TIME, "Release Time", USB_MIXER_U16 },
 	{ 0 }
 };
 
 static struct procunit_info procunits[] = {
-	{ USB_PROC_UPDOWN, "Up Down", updown_proc_info },
-	{ USB_PROC_PROLOGIC, "Dolby Prologic", prologic_proc_info },
-	{ USB_PROC_3DENH, "3D Stereo Extender", threed_enh_proc_info },
-	{ USB_PROC_REVERB, "Reverb", reverb_proc_info },
-	{ USB_PROC_CHORUS, "Chorus", chorus_proc_info },
-	{ USB_PROC_DCR, "DCR", dcr_proc_info },
+	{ UAC_PROCESS_UP_DOWNMIX, "Up Down", updown_proc_info },
+	{ UAC_PROCESS_DOLBY_PROLOGIC, "Dolby Prologic", prologic_proc_info },
+	{ UAC_PROCESS_STEREO_EXTENDER, "3D Stereo Extender", threed_enh_proc_info },
+	{ UAC_PROCESS_REVERB, "Reverb", reverb_proc_info },
+	{ UAC_PROCESS_CHORUS, "Chorus", chorus_proc_info },
+	{ UAC_PROCESS_DYN_RANGE_COMP, "DCR", dcr_proc_info },
 	{ 0 },
 };
 /*
@@ -1542,7 +1509,7 @@ static int build_audio_procunit(struct mixer_build *state, int unitid, void *raw
 		cval->channels = 1;
 
 		/* get min/max values */
-		if (type == USB_PROC_UPDOWN && cval->control == USB_PROC_UPDOWN_MODE_SEL) {
+		if (type == UAC_PROCESS_UP_DOWNMIX && cval->control == UAC_UD_MODE_SELECT) {
 			__u8 *control_spec = uac_processing_unit_specific(desc, state->mixer->protocol);
 			/* FIXME: hard-coded */
 			cval->min = 1;
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index d93fc89..f1324c4 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -85,8 +85,8 @@ static struct usbmix_name_map extigy_map[] = {
 	/* 16: MU (w/o controls) */
 	{ 17, NULL, 1 }, /* DISABLED: PU-switch (any effect?) */
 	{ 17, "Channel Routing", 2 },	/* PU: mode select */
-	{ 18, "Tone Control - Bass", UAC_BASS_CONTROL }, /* FU */
-	{ 18, "Tone Control - Treble", UAC_TREBLE_CONTROL }, /* FU */
+	{ 18, "Tone Control - Bass", UAC_FU_BASS }, /* FU */
+	{ 18, "Tone Control - Treble", UAC_FU_TREBLE }, /* FU */
 	{ 18, "Master Playback" }, /* FU; others */
 	/* 19: OT speaker */
 	/* 20: OT headphone */
-- 
1.7.1
