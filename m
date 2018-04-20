From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 1/4] ALSA: usb-audio: UAC3. Add support for
	mixer unit.
Date: Fri, 20 Apr 2018 18:03:24 +0100
Message-ID: <20180420170327.31569-2-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 587792675F4
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 19:03:38 +0200 (CEST)
In-Reply-To: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

This adds support for the MIXER UNIT in UAC3. All the information
is obtained from the (HIGH CAPABILITY) Cluster's header. We don't
read the rest of the logical cluster to obtain the channel config
as that wont make any difference in the current mixer behaviour.

The name of the mixer unit is not yet requested as there is not
support for the UAC3 Class Specific String requests.

Tested in an UAC3 device working as a HEADSET with a basic mixer
unit (same as the one in the BADD spec) with no controls.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 include/uapi/linux/usb/audio.h | 13 +++++++--
 sound/usb/mixer.c              | 64 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index 3a78e7145689..f9be472cd025 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -285,9 +285,16 @@ static inline __u8 uac_mixer_unit_iChannelNames(struct uac_mixer_unit_descriptor
 static inline __u8 *uac_mixer_unit_bmControls(struct uac_mixer_unit_descriptor *desc,
 					      int protocol)
 {
-	return (protocol == UAC_VERSION_1) ?
-		&desc->baSourceID[desc->bNrInPins + 4] :
-		&desc->baSourceID[desc->bNrInPins + 6];
+	switch (protocol) {
+	case UAC_VERSION_1:
+		return &desc->baSourceID[desc->bNrInPins + 4];
+	case UAC_VERSION_2:
+		return &desc->baSourceID[desc->bNrInPins + 6];
+	case UAC_VERSION_3:
+		return &desc->baSourceID[desc->bNrInPins + 2];
+	default:
+		return NULL;
+	}
 }
 
 static inline __u8 uac_mixer_unit_iMixer(struct uac_mixer_unit_descriptor *desc)
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 301ad61ed426..738ca37e6d6e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -719,6 +719,35 @@ static int get_term_name(struct mixer_build *state, struct usb_audio_term *iterm
 }
 
 /*
+ * Get logical cluster information for UAC3 devices.
+ */
+static int get_cluster_channels_v3(struct mixer_build *state, unsigned int cluster_id)
+{
+	struct uac3_cluster_header_descriptor c_header;
+	int err;
+
+	err = snd_usb_ctl_msg(state->chip->dev,
+			usb_rcvctrlpipe(state->chip->dev, 0),
+			UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
+			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+			cluster_id,
+			snd_usb_ctrl_intf(state->chip),
+			&c_header, sizeof(c_header));
+	if (err < 0)
+		goto error;
+	else if (err != sizeof(c_header)) {
+		err = -EIO;
+		goto error;
+	}
+
+	return c_header.bNrChannels;
+
+error:
+	usb_audio_err(state->chip, "cannot request logical cluster ID: %d (err: %d)\n", cluster_id, err);
+	return err;
+}
+
+/*
  * parse the source unit recursively until it reaches to a terminal
  * or a branched unit.
  */
@@ -865,6 +894,19 @@ static int check_input_term(struct mixer_build *state, int id,
 				term->name = le16_to_cpu(d->wClockSourceStr);
 				return 0;
 			}
+			case UAC3_MIXER_UNIT: {
+				struct uac_mixer_unit_descriptor *d = p1;
+				unsigned int cluster_id = le16_to_cpu(d->baSourceID[d->bNrInPins]);
+
+				err = get_cluster_channels_v3(state, cluster_id);
+				if (err < 0)
+					return err;
+
+				term->channels = err;
+				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+
+				return 0;
+			}
 			default:
 				return -ENODEV;
 			}
@@ -1801,7 +1843,7 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 				 struct usb_audio_term *iterm)
 {
 	struct usb_mixer_elem_info *cval;
-	unsigned int num_outs = uac_mixer_unit_bNrChannels(desc);
+	unsigned int num_outs;
 	unsigned int i, len;
 	struct snd_kcontrol *kctl;
 	const struct usbmix_name_map *map;
@@ -1814,6 +1856,14 @@ static void build_mixer_unit_ctl(struct mixer_build *state,
 	if (!cval)
 		return;
 
+	if (state->mixer->protocol == UAC_VERSION_3) {
+		num_outs = get_cluster_channels_v3(state,
+				le16_to_cpu(desc->baSourceID[desc->bNrInPins]));
+		if (num_outs < 0)
+			return;
+	} else /* UAC_VERSION_1/2 */
+		num_outs = uac_mixer_unit_bNrChannels(desc);
+
 	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
 	cval->control = in_ch + 1; /* based on 1 */
 	cval->val_type = USB_MIXER_S16;
@@ -1878,8 +1928,16 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
 	int input_pins, num_ins, num_outs;
 	int pin, ich, err;
 
-	if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) ||
-	    !(num_outs = uac_mixer_unit_bNrChannels(desc))) {
+	if (state->mixer->protocol == UAC_VERSION_3) {
+		err = get_cluster_channels_v3(state,
+				le16_to_cpu(desc->baSourceID[desc->bNrInPins]));
+		if (err < 0)
+			return err;
+		num_outs = err;
+	} else /* UAC_VERSION_1/2 */
+		num_outs = uac_mixer_unit_bNrChannels(desc);
+
+	if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) || !num_outs) {
 		usb_audio_err(state->chip,
 			      "invalid MIXER UNIT descriptor %d\n",
 			      unitid);
-- 
2.11.0
