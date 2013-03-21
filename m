From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 1/2] ALSA: hda - Introduce "Headset Mic" name
Date: Thu, 21 Mar 2013 12:16:29 +0100
Message-ID: <1363864590-8751-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B3DD7265E66
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 12:16:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Headset mic jacks, i e TRRS style jacks with Headphone Left,
Headphone Right, Mic and GND signals, are becoming increasingly
common and are now being shipped by several manufacturers.

Unfortunately, the HDA specification does not give us any hint
of whether a Mic pin belongs to such a jack or not, but it would
still be helpful for the user to know (especially if there is one
TRS Mic jack and one TRRS headset jack).

This new fixup causes the first (non-dock, non-internal) mic to
be a headset mic jack. The algorithm can be later refined if needed.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c |   24 ++++++++++++++++++++++--
 sound/pci/hda/hda_auto_parser.h |    2 ++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index a3ea76a..6b173b3 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -260,6 +260,22 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 		}
 	}
 
+	/* Take first mic to be a headset mic pin */
+	if (cond_flags & HDA_PINCFG_HEADSET_MIC) {
+		for (i = 0; i < cfg->num_inputs; i++) {
+			int attr;
+			unsigned int def_conf;
+			if (cfg->inputs[i].type != AUTO_PIN_MIC)
+				continue;
+			def_conf = snd_hda_codec_get_pincfg(codec, cfg->inputs[i].pin);
+			attr = snd_hda_get_input_pin_attr(def_conf);
+			if (attr <= INPUT_PIN_ATTR_DOCK)
+				continue;
+			cfg->inputs[i].is_headset_mic = 1;
+			break;
+		}
+	}
+
 	/* FIX-UP:
 	 * If no line-out is defined but multiple HPs are found,
 	 * some of them might be the real line-outs.
@@ -388,6 +404,7 @@ EXPORT_SYMBOL_HDA(snd_hda_get_input_pin_attr);
  */
 
 static const char *hda_get_input_pin_label(struct hda_codec *codec,
+					   const struct auto_pin_cfg_item *item,
 					   hda_nid_t pin, bool check_location)
 {
 	unsigned int def_conf;
@@ -400,6 +417,8 @@ static const char *hda_get_input_pin_label(struct hda_codec *codec,
 
 	switch (get_defcfg_device(def_conf)) {
 	case AC_JACK_MIC_IN:
+		if (item && item->is_headset_mic)
+			return "Headset Mic";
 		if (!check_location)
 			return "Mic";
 		attr = snd_hda_get_input_pin_attr(def_conf);
@@ -480,7 +499,8 @@ const char *hda_get_autocfg_input_label(struct hda_codec *codec,
 		has_multiple_pins = 1;
 	if (has_multiple_pins && type == AUTO_PIN_MIC)
 		has_multiple_pins &= check_mic_location_need(codec, cfg, input);
-	return hda_get_input_pin_label(codec, cfg->inputs[input].pin,
+	return hda_get_input_pin_label(codec, &cfg->inputs[input],
+				       cfg->inputs[input].pin,
 				       has_multiple_pins);
 }
 EXPORT_SYMBOL_HDA(hda_get_autocfg_input_label);
@@ -649,7 +669,7 @@ int snd_hda_get_pin_label(struct hda_codec *codec, hda_nid_t nid,
 			}
 		}
 		if (!name)
-			name = hda_get_input_pin_label(codec, nid, true);
+			name = hda_get_input_pin_label(codec, NULL, nid, true);
 		break;
 	}
 	if (!name)
diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index f748071..c7826ce 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -36,6 +36,7 @@ enum {
 struct auto_pin_cfg_item {
 	hda_nid_t pin;
 	int type;
+	unsigned int is_headset_mic:1;
 };
 
 struct auto_pin_cfg;
@@ -80,6 +81,7 @@ struct auto_pin_cfg {
 /* bit-flags for snd_hda_parse_pin_def_config() behavior */
 #define HDA_PINCFG_NO_HP_FIXUP	(1 << 0) /* no HP-split */
 #define HDA_PINCFG_NO_LO_FIXUP	(1 << 1) /* don't take other outs as LO */
+#define HDA_PINCFG_HEADSET_MIC  (1 << 2) /* Take first mic as headset mic */
 
 int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 			     struct auto_pin_cfg *cfg,
-- 
1.7.9.5
