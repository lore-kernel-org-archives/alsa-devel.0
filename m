From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 1/5] ALSA: usb-audio: Add support for Selector Units in UAC3
Date: Wed, 11 Jul 2018 13:37:51 +0100
Message-ID: <20180711123755.27182-2-jorge.sanjuan@codethink.co.uk>
References: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711123755.27182-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch add support for Selector Units and Clock Selector Units
defined in the new UAC3 spec.

Selector Units play a really important role in the new UAC3 spec as
Processing Units do not define an on/off switch control anymore.
This forces topology designers to add bypass paths in the topology
to enable/dissable the Processing Units.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 54 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ca963e94ec03..a51f2320a3dd 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -940,6 +940,19 @@ static int check_input_term(struct mixer_build *state, int id,
 
 				return 0;
 			}
+			case UAC3_SELECTOR_UNIT:
+			case UAC3_CLOCK_SELECTOR: {
+				struct uac_selector_unit_descriptor *d = p1;
+				/* call recursively to retrieve the channel info */
+				err = check_input_term(state, d->baSourceID[0], term);
+				if (err < 0)
+					return err;
+				term->type = d->bDescriptorSubtype << 16; /* virtual type */
+				term->id = id;
+				term->name = 0; /* TODO: UAC3 Class-specific strings */
+
+				return 0;
+			}
 			default:
 				return -ENODEV;
 			}
@@ -2509,11 +2522,20 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	cval->res = 1;
 	cval->initialized = 1;
 
-	if (state->mixer->protocol == UAC_VERSION_1)
+	switch (state->mixer->protocol) {
+	case UAC_VERSION_1:
+	default:
 		cval->control = 0;
-	else /* UAC_VERSION_2 */
-		cval->control = (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR) ?
-			UAC2_CX_CLOCK_SELECTOR : UAC2_SU_SELECTOR;
+		break;
+	case UAC_VERSION_2:
+	case UAC_VERSION_3:
+		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR ||
+		    desc->bDescriptorSubtype == UAC3_CLOCK_SELECTOR)
+			cval->control = UAC2_CX_CLOCK_SELECTOR;
+		else /* UAC2/3_SELECTOR_UNIT */
+			cval->control = UAC2_SU_SELECTOR;
+		break;
+	}
 
 	namelist = kmalloc_array(desc->bNrInPins, sizeof(char *), GFP_KERNEL);
 	if (!namelist) {
@@ -2555,12 +2577,22 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 	len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
 	if (!len) {
 		/* no mapping ? */
+		switch (state->mixer->protocol) {
+		case UAC_VERSION_1:
+		case UAC_VERSION_2:
+		default:
 		/* if iSelector is given, use it */
-		nameid = uac_selector_unit_iSelector(desc);
-		if (nameid)
-			len = snd_usb_copy_string_desc(state->chip, nameid,
-						       kctl->id.name,
-						       sizeof(kctl->id.name));
+			nameid = uac_selector_unit_iSelector(desc);
+			if (nameid)
+				len = snd_usb_copy_string_desc(state->chip,
+							nameid, kctl->id.name,
+							sizeof(kctl->id.name));
+			break;
+		case UAC_VERSION_3:
+			/* TODO: Class-Specific strings not yet supported */
+			break;
+		}
+
 		/* ... or pick up the terminal name at next */
 		if (!len)
 			len = get_term_name(state->chip, &state->oterm,
@@ -2570,7 +2602,8 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
 			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
 
 		/* and add the proper suffix */
-		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR)
+		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR ||
+		    desc->bDescriptorSubtype == UAC3_CLOCK_SELECTOR)
 			append_ctl_name(kctl, " Clock Source");
 		else if ((state->oterm.type & 0xff00) == 0x0100)
 			append_ctl_name(kctl, " Capture Source");
@@ -2641,6 +2674,7 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 			return parse_audio_mixer_unit(state, unitid, p1);
 		case UAC3_CLOCK_SOURCE:
 			return parse_clock_source_unit(state, unitid, p1);
+		case UAC3_SELECTOR_UNIT:
 		case UAC3_CLOCK_SELECTOR:
 			return parse_audio_selector_unit(state, unitid, p1);
 		case UAC3_FEATURE_UNIT:
-- 
2.11.0
