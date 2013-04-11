From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/3] ALSA: hda - allow "Headphone Mic" parser
	flag
Date: Thu, 11 Apr 2013 11:30:28 +0200
Message-ID: <1365672630-15411-2-git-send-email-david.henningsson@canonical.com>
References: <1365672630-15411-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 61A20266014
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 11:30:24 +0200 (CEST)
In-Reply-To: <1365672630-15411-1-git-send-email-david.henningsson@canonical.com>
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

This allows a specific mic to get the "Headphone Mic" name, in addition
to the existing "Headset Mic" name.

Also, it allows for a special mark: if the sequence number is set
to 0xc, that's an indication to prefer it for headset mic, and if it's
set to 0xd, that's an indication to prefer it for headphone mic.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c |   68 ++++++++++++++++++++++++++++++++-------
 sound/pci/hda/hda_auto_parser.h |    8 +++--
 sound/pci/hda/hda_generic.c     |    1 +
 3 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 6b173b3..7c11d46 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -119,6 +119,32 @@ static bool check_pincap_validity(struct hda_codec *codec, hda_nid_t pin,
 	}
 }
 
+static bool can_be_headset_mic(struct hda_codec *codec,
+			       struct auto_pin_cfg_item *item,
+			       int seq_number)
+{
+	int attr;
+	unsigned int def_conf;
+	if (item->type != AUTO_PIN_MIC)
+		return false;
+
+	if (item->is_headset_mic || item->is_headphone_mic)
+		return false; /* Already assigned */
+
+	def_conf = snd_hda_codec_get_pincfg(codec, item->pin);
+	attr = snd_hda_get_input_pin_attr(def_conf);
+	if (attr <= INPUT_PIN_ATTR_DOCK)
+		return false;
+
+	if (seq_number >= 0) {
+		int seq = get_defcfg_sequence(def_conf);
+		if (seq != seq_number)
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * Parse all pin widgets and store the useful pin nids to cfg
  *
@@ -260,20 +286,36 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 		}
 	}
 
-	/* Take first mic to be a headset mic pin */
-	if (cond_flags & HDA_PINCFG_HEADSET_MIC) {
-		for (i = 0; i < cfg->num_inputs; i++) {
-			int attr;
-			unsigned int def_conf;
-			if (cfg->inputs[i].type != AUTO_PIN_MIC)
-				continue;
-			def_conf = snd_hda_codec_get_pincfg(codec, cfg->inputs[i].pin);
-			attr = snd_hda_get_input_pin_attr(def_conf);
-			if (attr <= INPUT_PIN_ATTR_DOCK)
+	/* Find a pin that could be a headset or headphone mic */
+	if (cond_flags & HDA_PINCFG_HEADSET_MIC || cond_flags & HDA_PINCFG_HEADPHONE_MIC) {
+		bool hsmic = !!(cond_flags & HDA_PINCFG_HEADSET_MIC);
+		bool hpmic = !!(cond_flags & HDA_PINCFG_HEADPHONE_MIC);
+		for (i = 0; (hsmic || hpmic) && (i < cfg->num_inputs); i++)
+			if (hsmic && can_be_headset_mic(codec, &cfg->inputs[i], 0xc)) {
+				cfg->inputs[i].is_headset_mic = 1;
+				hsmic = false;
+			} else if (hpmic && can_be_headset_mic(codec, &cfg->inputs[i], 0xd)) {
+				cfg->inputs[i].is_headphone_mic = 1;
+				hpmic = false;
+			}
+
+		/* If we didn't find our sequence number mark, fall back to any sequence number */
+		for (i = 0; (hsmic || hpmic) && (i < cfg->num_inputs); i++) {
+			if (!can_be_headset_mic(codec, &cfg->inputs[i], -1))
 				continue;
-			cfg->inputs[i].is_headset_mic = 1;
-			break;
+			if (hsmic) {
+				cfg->inputs[i].is_headset_mic = 1;
+				hsmic = false;
+			} else if (hpmic) {
+				cfg->inputs[i].is_headphone_mic = 1;
+				hpmic = false;
+			}
 		}
+
+		if (hsmic)
+			snd_printdd("Told to look for a headset mic, but didn't find any.\n");
+		if (hpmic)
+			snd_printdd("Told to look for a headphone mic, but didn't find any.\n");
 	}
 
 	/* FIX-UP:
@@ -419,6 +461,8 @@ static const char *hda_get_input_pin_label(struct hda_codec *codec,
 	case AC_JACK_MIC_IN:
 		if (item && item->is_headset_mic)
 			return "Headset Mic";
+		if (item && item->is_headphone_mic)
+			return "Headphone Mic";
 		if (!check_location)
 			return "Mic";
 		attr = snd_hda_get_input_pin_attr(def_conf);
diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index c7826ce..fe2ba7f 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -37,6 +37,7 @@ struct auto_pin_cfg_item {
 	hda_nid_t pin;
 	int type;
 	unsigned int is_headset_mic:1;
+	unsigned int is_headphone_mic:1; /* Mic-only in headphone jack */
 };
 
 struct auto_pin_cfg;
@@ -79,9 +80,10 @@ struct auto_pin_cfg {
 };
 
 /* bit-flags for snd_hda_parse_pin_def_config() behavior */
-#define HDA_PINCFG_NO_HP_FIXUP	(1 << 0) /* no HP-split */
-#define HDA_PINCFG_NO_LO_FIXUP	(1 << 1) /* don't take other outs as LO */
-#define HDA_PINCFG_HEADSET_MIC  (1 << 2) /* Take first mic as headset mic */
+#define HDA_PINCFG_NO_HP_FIXUP   (1 << 0) /* no HP-split */
+#define HDA_PINCFG_NO_LO_FIXUP   (1 << 1) /* don't take other outs as LO */
+#define HDA_PINCFG_HEADSET_MIC   (1 << 2) /* Try to find headset mic; mark seq number as 0xc to trigger */
+#define HDA_PINCFG_HEADPHONE_MIC (1 << 3) /* Try to find headphone mic; mark seq number as 0xd to trigger */
 
 int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 			     struct auto_pin_cfg *cfg,
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 8299e40..d7a8eb3 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2333,6 +2333,7 @@ static int create_hp_mic(struct hda_codec *codec)
 
 	cfg->inputs[cfg->num_inputs].pin = nid;
 	cfg->inputs[cfg->num_inputs].type = AUTO_PIN_MIC;
+	cfg->inputs[cfg->num_inputs].is_headphone_mic = 1;
 	cfg->num_inputs++;
 	spec->hp_mic = 1;
 	spec->hp_mic_pin = nid;
-- 
1.7.9.5
