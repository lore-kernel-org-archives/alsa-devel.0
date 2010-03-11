From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/6] ALSA: usb-mixer: use defines from audio.h
Date: Thu, 11 Mar 2010 21:13:21 +0100
Message-ID: <1268338405-8944-3-git-send-email-daniel@caiaq.de>
References: <1268338405-8944-1-git-send-email-daniel@caiaq.de>
	<1268338405-8944-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 11726103841
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 21:14:15 +0100 (CET)
In-Reply-To: <1268338405-8944-2-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

No need for the private enum.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/format.c        |    6 ++++--
 sound/usb/usbmixer.c      |   27 ++++++---------------------
 sound/usb/usbmixer_maps.c |    4 ++--
 3 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 0e04efe..fcadedd 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -218,7 +218,8 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 	/* get the number of sample rates first by only fetching 2 bytes */
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-			      0x0100, chip->clock_id << 8, tmp, sizeof(tmp), 1000);
+			      UAC2_CS_CONTROL_SAM_FREQ << 8, chip->clock_id << 8,
+			      tmp, sizeof(tmp), 1000);
 
 	if (ret < 0) {
 		snd_printk(KERN_ERR "unable to retrieve number of sample rates\n");
@@ -236,7 +237,8 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 	/* now get the full information */
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			       USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-			       0x0100, chip->clock_id << 8, data, data_size, 1000);
+			       UAC2_CS_CONTROL_SAM_FREQ << 8, chip->clock_id << 8,
+			       data, data_size, 1000);
 
 	if (ret < 0) {
 		snd_printk(KERN_ERR "unable to retrieve sample rate range\n");
diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 5c05683..ab8f0f0 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -136,21 +136,6 @@ struct usb_mixer_elem_info {
 	u8 initialized;
 };
 
-
-enum {
-	USB_FEATURE_NONE = 0,
-	USB_FEATURE_MUTE = 1,
-	USB_FEATURE_VOLUME,
-	USB_FEATURE_BASS,
-	USB_FEATURE_MID,
-	USB_FEATURE_TREBLE,
-	USB_FEATURE_GEQ,
-	USB_FEATURE_AGC,
-	USB_FEATURE_DELAY,
-	USB_FEATURE_BASSBOOST,
-	USB_FEATURE_LOUDNESS
-};
-
 enum {
 	USB_MIXER_BOOLEAN,
 	USB_MIXER_INV_BOOLEAN,
@@ -954,7 +939,7 @@ static void build_feature_ctl(struct mixer_build *state, unsigned char *desc,
 
 	control++; /* change from zero-based to 1-based value */
 
-	if (control == USB_FEATURE_GEQ) {
+	if (control == UAC_GRAPHIC_EQUALIZER_CONTROL) {
 		/* FIXME: not supported yet */
 		return;
 	}
@@ -1001,8 +986,8 @@ static void build_feature_ctl(struct mixer_build *state, unsigned char *desc,
 				kctl->id.name, sizeof(kctl->id.name));
 
 	switch (control) {
-	case USB_FEATURE_MUTE:
-	case USB_FEATURE_VOLUME:
+	case UAC_MUTE_CONTROL:
+	case UAC_VOLUME_CONTROL:
 		/* determine the control name.  the rule is:
 		 * - if a name id is given in descriptor, use it.
 		 * - if the connected input can be determined, then use the name
@@ -1029,9 +1014,9 @@ static void build_feature_ctl(struct mixer_build *state, unsigned char *desc,
 				len = append_ctl_name(kctl, " Playback");
 			}
 		}
-		append_ctl_name(kctl, control == USB_FEATURE_MUTE ?
+		append_ctl_name(kctl, control == UAC_MUTE_CONTROL ?
 				" Switch" : " Volume");
-		if (control == USB_FEATURE_VOLUME) {
+		if (control == UAC_VOLUME_CONTROL) {
 			kctl->tlv.c = mixer_vol_tlv;
 			kctl->vd[0].access |= 
 				SNDRV_CTL_ELEM_ACCESS_TLV_READ |
@@ -1120,7 +1105,7 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 		snd_printk(KERN_INFO
 			   "usbmixer: master volume quirk for PCM2702 chip\n");
 		/* disable non-functional volume control */
-		master_bits &= ~(1 << (USB_FEATURE_VOLUME - 1));
+		master_bits &= ~UAC_FU_VOLUME;
 		break;
 	}
 	if (channels > 0)
diff --git a/sound/usb/usbmixer_maps.c b/sound/usb/usbmixer_maps.c
index 79e903a..d93fc89 100644
--- a/sound/usb/usbmixer_maps.c
+++ b/sound/usb/usbmixer_maps.c
@@ -85,8 +85,8 @@ static struct usbmix_name_map extigy_map[] = {
 	/* 16: MU (w/o controls) */
 	{ 17, NULL, 1 }, /* DISABLED: PU-switch (any effect?) */
 	{ 17, "Channel Routing", 2 },	/* PU: mode select */
-	{ 18, "Tone Control - Bass", USB_FEATURE_BASS }, /* FU */
-	{ 18, "Tone Control - Treble", USB_FEATURE_TREBLE }, /* FU */
+	{ 18, "Tone Control - Bass", UAC_BASS_CONTROL }, /* FU */
+	{ 18, "Tone Control - Treble", UAC_TREBLE_CONTROL }, /* FU */
 	{ 18, "Master Playback" }, /* FU; others */
 	/* 19: OT speaker */
 	/* 20: OT headphone */
-- 
1.6.6.2
