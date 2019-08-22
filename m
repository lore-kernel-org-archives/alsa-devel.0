Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9390BF8036E
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 09:32:10 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 29F6FAFF4
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 07:32:09 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 22 Aug 2019 09:32:05 +0200
Message-Id: <20190822073207.8696-4-tiwai@suse.de>
In-Reply-To: <20190822073207.8696-1-tiwai@suse.de>
References: <20190822073207.8696-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 2/4] ALSA: usb-audio: Simplify
	parse_audio_unit()
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-ID: <alsa-devel@alsa-project.org>

Minor code refactoring by combining the UAC version and the type in
the switch-case flow, so that we reduce the indentation and
redundancy.  One good bonus is that the duplicated definition of the
same type value (e.g. UAC2_EFFECT_UNIT) can be handled more cleanly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 95 +++++++++++++++++++++++--------------------------------
 1 file changed, 39 insertions(+), 56 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index b4be226e07f3..2628697353bb 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2780,62 +2780,45 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 		return 0; /* skip invalid unit */
 	}
 
-	if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
-		switch (p1[2]) {
-		case UAC_INPUT_TERMINAL:
-			return parse_audio_input_terminal(state, unitid, p1);
-		case UAC_MIXER_UNIT:
-			return parse_audio_mixer_unit(state, unitid, p1);
-		case UAC2_CLOCK_SOURCE:
-			return parse_clock_source_unit(state, unitid, p1);
-		case UAC_SELECTOR_UNIT:
-		case UAC2_CLOCK_SELECTOR:
-			return parse_audio_selector_unit(state, unitid, p1);
-		case UAC_FEATURE_UNIT:
-			return parse_audio_feature_unit(state, unitid, p1);
-		case UAC1_PROCESSING_UNIT:
-		/*   UAC2_EFFECT_UNIT has the same value */
-			if (protocol == UAC_VERSION_1)
-				return parse_audio_processing_unit(state, unitid, p1);
-			else
-				return 0; /* FIXME - effect units not implemented yet */
-		case UAC1_EXTENSION_UNIT:
-		/*   UAC2_PROCESSING_UNIT_V2 has the same value */
-			if (protocol == UAC_VERSION_1)
-				return parse_audio_extension_unit(state, unitid, p1);
-			else /* UAC_VERSION_2 */
-				return parse_audio_processing_unit(state, unitid, p1);
-		case UAC2_EXTENSION_UNIT_V2:
-			return parse_audio_extension_unit(state, unitid, p1);
-		default:
-			usb_audio_err(state->chip,
-				"unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
-			return -EINVAL;
-		}
-	} else { /* UAC_VERSION_3 */
-		switch (p1[2]) {
-		case UAC_INPUT_TERMINAL:
-			return parse_audio_input_terminal(state, unitid, p1);
-		case UAC3_MIXER_UNIT:
-			return parse_audio_mixer_unit(state, unitid, p1);
-		case UAC3_CLOCK_SOURCE:
-			return parse_clock_source_unit(state, unitid, p1);
-		case UAC3_SELECTOR_UNIT:
-		case UAC3_CLOCK_SELECTOR:
-			return parse_audio_selector_unit(state, unitid, p1);
-		case UAC3_FEATURE_UNIT:
-			return parse_audio_feature_unit(state, unitid, p1);
-		case UAC3_EFFECT_UNIT:
-			return 0; /* FIXME - effect units not implemented yet */
-		case UAC3_PROCESSING_UNIT:
-			return parse_audio_processing_unit(state, unitid, p1);
-		case UAC3_EXTENSION_UNIT:
-			return parse_audio_extension_unit(state, unitid, p1);
-		default:
-			usb_audio_err(state->chip,
-				"unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
-			return -EINVAL;
-		}
+#define PTYPE(a, b)	((a) << 8 | (b))
+	switch (PTYPE(protocol, p1[2])) {
+	case PTYPE(UAC_VERSION_1, UAC_INPUT_TERMINAL):
+	case PTYPE(UAC_VERSION_2, UAC_INPUT_TERMINAL):
+	case PTYPE(UAC_VERSION_3, UAC_INPUT_TERMINAL):
+		return parse_audio_input_terminal(state, unitid, p1);
+	case PTYPE(UAC_VERSION_1, UAC_MIXER_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC_MIXER_UNIT):
+	case PTYPE(UAC_VERSION_3, UAC3_MIXER_UNIT):
+		return parse_audio_mixer_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_2, UAC2_CLOCK_SOURCE):
+	case PTYPE(UAC_VERSION_3, UAC3_CLOCK_SOURCE):
+		return parse_clock_source_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_1, UAC_SELECTOR_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC_SELECTOR_UNIT):
+	case PTYPE(UAC_VERSION_3, UAC3_SELECTOR_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC2_CLOCK_SELECTOR):
+	case PTYPE(UAC_VERSION_3, UAC3_CLOCK_SELECTOR):
+		return parse_audio_selector_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_1, UAC_FEATURE_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC_FEATURE_UNIT):
+	case PTYPE(UAC_VERSION_3, UAC3_FEATURE_UNIT):
+		return parse_audio_feature_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_1, UAC1_PROCESSING_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC2_PROCESSING_UNIT_V2):
+	case PTYPE(UAC_VERSION_3, UAC3_PROCESSING_UNIT):
+		return parse_audio_processing_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_1, UAC1_EXTENSION_UNIT):
+	case PTYPE(UAC_VERSION_2, UAC2_EXTENSION_UNIT_V2):
+	case PTYPE(UAC_VERSION_3, UAC3_EXTENSION_UNIT):
+		return parse_audio_extension_unit(state, unitid, p1);
+	case PTYPE(UAC_VERSION_2, UAC2_EFFECT_UNIT):
+	case PTYPE(UAC_VERSION_3, UAC3_EFFECT_UNIT):
+		return 0; /* FIXME - effect units not implemented yet */
+	default:
+		usb_audio_err(state->chip,
+			      "unit %u: unexpected type 0x%02x\n",
+			      unitid, p1[2]);
+		return -EINVAL;
 	}
 }
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
