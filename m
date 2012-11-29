From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: hda - Use standard sort function in
	hda_auto_parser.c
Date: Thu, 29 Nov 2012 16:21:27 +0100
Message-ID: <1354202489-12769-4-git-send-email-tiwai@suse.de>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F26822650D4
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:21:45 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D6457A398D
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 16:21:45 +0100 (CET)
In-Reply-To: <1354202489-12769-1-git-send-email-tiwai@suse.de>
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

Just refactoring, no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 106 ++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 59 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 90d5b39..91232db 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -11,6 +11,7 @@
 
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/sort.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -30,29 +31,30 @@ static int is_in_nid_list(hda_nid_t nid, const hda_nid_t *list)
 	return 0;
 }
 
+/* a pair of input pin and its sequence */
+struct auto_out_pin {
+	hda_nid_t pin;
+	short seq;
+};
+
+static int compare_seq(const void *ap, const void *bp)
+{
+	const struct auto_out_pin *a = ap;
+	const struct auto_out_pin *b = bp;
+	return (int)(a->seq - b->seq);
+}
 
 /*
  * Sort an associated group of pins according to their sequence numbers.
+ * then store it to a pin array.
  */
-static void sort_pins_by_sequence(hda_nid_t *pins, short *sequences,
+static void sort_pins_by_sequence(hda_nid_t *pins, struct auto_out_pin *list,
 				  int num_pins)
 {
-	int i, j;
-	short seq;
-	hda_nid_t nid;
-
-	for (i = 0; i < num_pins; i++) {
-		for (j = i + 1; j < num_pins; j++) {
-			if (sequences[i] > sequences[j]) {
-				seq = sequences[i];
-				sequences[i] = sequences[j];
-				sequences[j] = seq;
-				nid = pins[i];
-				pins[i] = pins[j];
-				pins[j] = nid;
-			}
-		}
-	}
+	int i;
+	sort(list, num_pins, sizeof(list[0]), compare_seq, NULL);
+	for (i = 0; i < num_pins; i++)
+		pins[i] = list[i].pin;
 }
 
 
@@ -67,21 +69,11 @@ static void add_auto_cfg_input_pin(struct auto_pin_cfg *cfg, hda_nid_t nid,
 	}
 }
 
-/* sort inputs in the order of AUTO_PIN_* type */
-static void sort_autocfg_input_pins(struct auto_pin_cfg *cfg)
+static int compare_input_type(const void *ap, const void *bp)
 {
-	int i, j;
-
-	for (i = 0; i < cfg->num_inputs; i++) {
-		for (j = i + 1; j < cfg->num_inputs; j++) {
-			if (cfg->inputs[i].type > cfg->inputs[j].type) {
-				struct auto_pin_cfg_item tmp;
-				tmp = cfg->inputs[i];
-				cfg->inputs[i] = cfg->inputs[j];
-				cfg->inputs[j] = tmp;
-			}
-		}
-	}
+	const struct auto_pin_cfg_item *a = ap;
+	const struct auto_pin_cfg_item *b = bp;
+	return (int)(a->type - b->type);
 }
 
 /* Reorder the surround channels
@@ -129,16 +121,16 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 {
 	hda_nid_t nid, end_nid;
 	short seq, assoc_line_out;
-	short sequences_line_out[ARRAY_SIZE(cfg->line_out_pins)];
-	short sequences_speaker[ARRAY_SIZE(cfg->speaker_pins)];
-	short sequences_hp[ARRAY_SIZE(cfg->hp_pins)];
+	struct auto_out_pin line_out[ARRAY_SIZE(cfg->line_out_pins)];
+	struct auto_out_pin speaker_out[ARRAY_SIZE(cfg->speaker_pins)];
+	struct auto_out_pin hp_out[ARRAY_SIZE(cfg->hp_pins)];
 	int i;
 
 	memset(cfg, 0, sizeof(*cfg));
 
-	memset(sequences_line_out, 0, sizeof(sequences_line_out));
-	memset(sequences_speaker, 0, sizeof(sequences_speaker));
-	memset(sequences_hp, 0, sizeof(sequences_hp));
+	memset(line_out, 0, sizeof(line_out));
+	memset(speaker_out, 0, sizeof(speaker_out));
+	memset(hp_out, 0, sizeof(hp_out));
 	assoc_line_out = 0;
 
 	end_nid = codec->start_nid + codec->num_nodes;
@@ -184,8 +176,8 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 				continue;
 			if (cfg->line_outs >= ARRAY_SIZE(cfg->line_out_pins))
 				continue;
-			cfg->line_out_pins[cfg->line_outs] = nid;
-			sequences_line_out[cfg->line_outs] = seq;
+			line_out[cfg->line_outs].pin = nid;
+			line_out[cfg->line_outs].seq = seq;
 			cfg->line_outs++;
 			break;
 		case AC_JACK_SPEAKER:
@@ -193,8 +185,8 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 			assoc = get_defcfg_association(def_conf);
 			if (cfg->speaker_outs >= ARRAY_SIZE(cfg->speaker_pins))
 				continue;
-			cfg->speaker_pins[cfg->speaker_outs] = nid;
-			sequences_speaker[cfg->speaker_outs] = (assoc << 4) | seq;
+			speaker_out[cfg->speaker_outs].pin = nid;
+			speaker_out[cfg->speaker_outs].seq = (assoc << 4) | seq;
 			cfg->speaker_outs++;
 			break;
 		case AC_JACK_HP_OUT:
@@ -202,8 +194,8 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 			assoc = get_defcfg_association(def_conf);
 			if (cfg->hp_outs >= ARRAY_SIZE(cfg->hp_pins))
 				continue;
-			cfg->hp_pins[cfg->hp_outs] = nid;
-			sequences_hp[cfg->hp_outs] = (assoc << 4) | seq;
+			hp_out[cfg->hp_outs].pin = nid;
+			hp_out[cfg->hp_outs].seq = (assoc << 4) | seq;
 			cfg->hp_outs++;
 			break;
 		case AC_JACK_MIC_IN:
@@ -248,34 +240,28 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 		int i = 0;
 		while (i < cfg->hp_outs) {
 			/* The real HPs should have the sequence 0x0f */
-			if ((sequences_hp[i] & 0x0f) == 0x0f) {
+			if ((hp_out[i].seq & 0x0f) == 0x0f) {
 				i++;
 				continue;
 			}
 			/* Move it to the line-out table */
-			cfg->line_out_pins[cfg->line_outs] = cfg->hp_pins[i];
-			sequences_line_out[cfg->line_outs] = sequences_hp[i];
-			cfg->line_outs++;
+			line_out[cfg->line_outs++] = hp_out[i];
 			cfg->hp_outs--;
-			memmove(cfg->hp_pins + i, cfg->hp_pins + i + 1,
-				sizeof(cfg->hp_pins[0]) * (cfg->hp_outs - i));
-			memmove(sequences_hp + i, sequences_hp + i + 1,
-				sizeof(sequences_hp[0]) * (cfg->hp_outs - i));
+			memmove(hp_out + i, hp_out + i + 1,
+				sizeof(hp_out[0]) * (cfg->hp_outs - i));
 		}
-		memset(cfg->hp_pins + cfg->hp_outs, 0,
-		       sizeof(hda_nid_t) * (AUTO_CFG_MAX_OUTS - cfg->hp_outs));
+		memset(hp_out + cfg->hp_outs, 0,
+		       sizeof(hp_out[0]) * (AUTO_CFG_MAX_OUTS - cfg->hp_outs));
 		if (!cfg->hp_outs)
 			cfg->line_out_type = AUTO_PIN_HP_OUT;
 
 	}
 
 	/* sort by sequence */
-	sort_pins_by_sequence(cfg->line_out_pins, sequences_line_out,
-			      cfg->line_outs);
-	sort_pins_by_sequence(cfg->speaker_pins, sequences_speaker,
+	sort_pins_by_sequence(cfg->line_out_pins, line_out, cfg->line_outs);
+	sort_pins_by_sequence(cfg->speaker_pins, speaker_out,
 			      cfg->speaker_outs);
-	sort_pins_by_sequence(cfg->hp_pins, sequences_hp,
-			      cfg->hp_outs);
+	sort_pins_by_sequence(cfg->hp_pins, hp_out, cfg->hp_outs);
 
 	/*
 	 * FIX-UP: if no line-outs are detected, try to use speaker or HP pin
@@ -304,7 +290,9 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 	reorder_outputs(cfg->hp_outs, cfg->hp_pins);
 	reorder_outputs(cfg->speaker_outs, cfg->speaker_pins);
 
-	sort_autocfg_input_pins(cfg);
+	/* sort inputs in the order of AUTO_PIN_* type */
+	sort(cfg->inputs, cfg->num_inputs, sizeof(cfg->inputs[0]),
+	     compare_input_type, NULL);
 
 	/*
 	 * debug prints of the parsed results
-- 
1.8.0.1
