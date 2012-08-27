From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 10/11] ALSA: usb-audio: add terminal/unit
 entities and links
Date: Tue, 28 Aug 2012 00:35:44 +0200
Message-ID: <503BF640.1030509@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id F1E3D265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:36:42 +0200 (CEST)
In-Reply-To: <503BF48E.1090100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the terminal/unit descriptors to create entities and links.

(This should be integrated with parse_audio_unit(), but that function
does not yet support all unit types.)

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/mixer.c |  278 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 278 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 4f40ba8..a5fa807 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -45,6 +45,7 @@
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/media.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/usb.h>
@@ -55,6 +56,7 @@
 #include <sound/control.h>
 #include <sound/hwdep.h>
 #include <sound/info.h>
+#include <sound/media.h>
 #include <sound/tlv.h>

 #include "usbaudio.h"
@@ -1969,6 +1971,278 @@ static int snd_usb_mixer_dev_free(struct snd_device *device)
 	return 0;
 }

+static void unit_name(struct media_entity_desc *entity,
+		      const u8 *desc, const char *prefix)
+{
+	/* TODO: read the terminal name from the device */
+	sprintf(entity->name, "%s%u", prefix, desc[3]);
+}
+
+static int input_terminal_get_desc(struct snd_card *card,
+				   void *private_data,
+				   struct media_entity_desc *desc)
+{
+	unit_name(desc, private_data, "IT");
+	desc->type = MEDIA_ENT_T_JACK;
+	return 0;
+}
+
+static int output_terminal_get_desc(struct snd_card *card,
+				    void *private_data,
+				    struct media_entity_desc *desc)
+{
+	unit_name(desc, private_data, "OT");
+	desc->type = MEDIA_ENT_T_JACK;
+	return 0;
+}
+
+static int mixer_unit_get_desc(struct snd_card *card,
+			       void *private_data,
+			       struct media_entity_desc *desc)
+{
+	unit_name(desc, private_data, "MU");
+	desc->type = MEDIA_ENT_T_ALSA_MIXER;
+	return 0;
+}
+
+static int selector_unit_get_desc(struct snd_card *card,
+				  void *private_data,
+				  struct media_entity_desc *desc)
+{
+	unit_name(desc, private_data, "SU");
+	desc->type = MEDIA_ENT_T_ALSA_SELECTOR;
+	return 0;
+}
+
+static int feature_unit_get_desc(struct snd_card *card,
+				 void *private_data,
+				 struct media_entity_desc *desc)
+{
+	unit_name(desc, private_data, "FU");
+	desc->type = MEDIA_ENT_T_ALSA_PROCESSING;
+	return 0;
+}
+
+static int processing_unit_get_desc(struct snd_card *card,
+				    void *private_data,
+				    struct media_entity_desc *desc)
+{
+	unit_name(desc, private_data, "PU");
+	desc->type = MEDIA_ENT_T_ALSA_PROCESSING;
+	return 0;
+}
+
+static int extension_unit_get_desc(struct snd_card *card,
+				   void *private_data,
+				   struct media_entity_desc *desc)
+{
+	unit_name(desc, private_data, "XU");
+	desc->type = MEDIA_ENT_T_ALSA_PROCESSING;
+	return 0;
+}
+
+static int effect_unit_v2_get_desc(struct snd_card *card,
+				   void *private_data,
+				   struct media_entity_desc *desc)
+{
+	unit_name(desc, private_data, "EU");
+	desc->type = MEDIA_ENT_T_ALSA_PROCESSING;
+	return 0;
+}
+
+static int src_v2_get_desc(struct snd_card *card,
+			   void *private_data,
+			   struct media_entity_desc *desc)
+{
+	unit_name(desc, private_data, "SRC");
+	desc->type = MEDIA_ENT_T_ALSA_PROCESSING;
+	return 0;
+}
+
+static int snd_usb_mixer_entity(struct mixer_build *state, const u8 *desc)
+{
+	snd_media_entity_get_desc_t get_desc = NULL;
+	unsigned int sinks = 0, sources = 0, source_ids_count = 0, i;
+	const u8 *source_ids = NULL;
+	u8 source_id = 0;
+	int err;
+
+	if (desc[0] < 4)
+		return 0;
+
+	if (state->mixer->protocol == UAC_VERSION_1) {
+		switch (desc[2]) {
+		case UAC_INPUT_TERMINAL:
+			if (desc[0] >= 6 &&
+			    desc[5] != (UAC_TERMINAL_STREAMING >> 8)) {
+				get_desc = &input_terminal_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC_OUTPUT_TERMINAL:
+			if (desc[0] >= 8) {
+				source_id = desc[7];
+				if (desc[5] != (UAC_TERMINAL_STREAMING >> 8))
+					get_desc = &output_terminal_get_desc;
+			}
+			break;
+		case UAC_MIXER_UNIT:
+			if (desc[0] >= 6) {
+				source_ids = &desc[5];
+				get_desc = &mixer_unit_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC_SELECTOR_UNIT:
+			if (desc[0] >= 6) {
+				source_ids = &desc[5];
+				get_desc = &selector_unit_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC_FEATURE_UNIT:
+			if (desc[0] >= 5) {
+				source_id = desc[4];
+				get_desc = &feature_unit_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC1_PROCESSING_UNIT:
+			if (desc[0] >= 8) {
+				source_ids = &desc[7];
+				get_desc = &processing_unit_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC1_EXTENSION_UNIT:
+			if (desc[0] >= 7 && desc[0] >= 7 + desc[6]) {
+				source_ids_count = desc[6];
+				source_ids = &desc[7];
+				get_desc = &extension_unit_get_desc;
+				sources = 1;
+			}
+			break;
+		}
+	} else {
+		switch (desc[2]) {
+		case UAC_INPUT_TERMINAL:
+			if (desc[0] >= 6 &&
+			    desc[5] != (UAC_TERMINAL_STREAMING >> 8)) {
+				get_desc = &input_terminal_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC_OUTPUT_TERMINAL:
+			if (desc[0] >= 8) {
+				source_id = desc[7];
+				if (desc[5] != (UAC_TERMINAL_STREAMING >> 8))
+					get_desc = &output_terminal_get_desc;
+			}
+			break;
+		case UAC_MIXER_UNIT:
+			if (desc[0] >= 5 && desc[0] >= 5 + desc[4]) {
+				source_ids_count = desc[4];
+				source_ids = &desc[5];
+				get_desc = &mixer_unit_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC_SELECTOR_UNIT:
+			if (desc[0] >= 5 && desc[0] >= 5 + desc[4]) {
+				source_ids_count = desc[4];
+				source_ids = &desc[5];
+				get_desc = &selector_unit_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC_FEATURE_UNIT:
+			if (desc[0] >= 5) {
+				source_id = desc[4];
+				get_desc = &feature_unit_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC2_EFFECT_UNIT:
+			if (desc[0] >= 7) {
+				source_id = desc[6];
+				get_desc = &effect_unit_v2_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC2_PROCESSING_UNIT_V2:
+			if (desc[0] >= 7 && desc[0] >= 7 + desc[6]) {
+				source_ids_count = desc[6];
+				source_ids = &desc[7];
+				get_desc = &processing_unit_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC2_EXTENSION_UNIT_V2:
+			if (desc[0] >= 7 && desc[0] >= 7 + desc[6]) {
+				source_ids_count = desc[6];
+				source_ids = &desc[7];
+				get_desc = &extension_unit_get_desc;
+				sources = 1;
+			}
+			break;
+		case UAC2_SAMPLE_RATE_CONVERTER:
+			if (desc[0] >= 5) {
+				source_id = desc[4];
+				get_desc = &src_v2_get_desc;
+				sources = 1;
+			}
+			break;
+		}
+	}
+
+	if (source_id != 0) {
+		err = snd_media_link_create(state->chip->card,
+					    source_id, 0, desc[3], 0);
+		if (err < 0)
+			return err;
+		sinks = 1;
+	}
+	else if (source_ids != NULL) {
+		if (source_ids_count == 0 &&
+		    source_ids + source_ids_count <= desc + desc[0])
+			source_ids_count = desc + desc[0] - source_ids;
+		for (i = 0; i < source_ids_count; i++) {
+			err = snd_media_link_create(state->chip->card,
+						    source_ids[i], 0,
+						    desc[3], i);
+			if (err < 0)
+				return err;
+		}
+		sinks = source_ids_count;
+	}
+
+	if (get_desc) {
+		err = snd_media_entity_create(state->chip->card, get_desc,
+					      desc[3], sinks, sources,
+					      (void *)desc);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int snd_usb_mixer_entities(struct mixer_build *state)
+{
+	void *p;
+	int err;
+
+	p = NULL;
+	while ((p = snd_usb_find_desc(state->mixer->hostif->extra,
+				      state->mixer->hostif->extralen,
+				      p, USB_DT_CS_INTERFACE)) != NULL) {
+		err = snd_usb_mixer_entity(state, p);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
 /*
  * create mixer controls
  *
@@ -1997,6 +2271,10 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 		}
 	}

+	err = snd_usb_mixer_entities(&state);
+	if (err < 0)
+		return err;
+
 	p = NULL;
 	while ((p = snd_usb_find_csint_desc(mixer->hostif->extra, mixer->hostif->extralen,
 					    p, UAC_OUTPUT_TERMINAL)) != NULL) {
