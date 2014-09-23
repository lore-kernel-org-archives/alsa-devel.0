From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - Sort input pins depending on
	amp caps
Date: Tue, 23 Sep 2014 10:38:18 +0200
Message-ID: <1411461498-11837-2-git-send-email-david.henningsson@canonical.com>
References: <1411461498-11837-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D012265342
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 10:38:23 +0200 (CEST)
In-Reply-To: <1411461498-11837-1-git-send-email-david.henningsson@canonical.com>
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

If one input has a boost and another one has not, and they're equal
otherwise, it's more likely you want to use the input with the boost
as your primary input.

See hda-emu.git/codecs/canonical/cx20590-lenovo-20b2z00bus-ccert-201305-13496
for an example.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c | 21 ++++++++++++++-------
 sound/pci/hda/hda_auto_parser.h |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 51dea49..fcc5e47 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -57,12 +57,14 @@ static void sort_pins_by_sequence(hda_nid_t *pins, struct auto_out_pin *list,
 
 
 /* add the found input-pin to the cfg->inputs[] table */
-static void add_auto_cfg_input_pin(struct auto_pin_cfg *cfg, hda_nid_t nid,
-				   int type)
+static void add_auto_cfg_input_pin(struct hda_codec *codec, struct auto_pin_cfg *cfg,
+				   hda_nid_t nid, int type)
 {
 	if (cfg->num_inputs < AUTO_CFG_MAX_INS) {
 		cfg->inputs[cfg->num_inputs].pin = nid;
 		cfg->inputs[cfg->num_inputs].type = type;
+		cfg->inputs[cfg->num_inputs].has_boost_on_pin =
+			nid_has_volume(codec, nid, HDA_INPUT);
 		cfg->num_inputs++;
 	}
 }
@@ -71,7 +73,12 @@ static int compare_input_type(const void *ap, const void *bp)
 {
 	const struct auto_pin_cfg_item *a = ap;
 	const struct auto_pin_cfg_item *b = bp;
-	return (int)(a->type - b->type);
+	if (a->type != b->type)
+		return (int)(a->type - b->type);
+
+	/* In case one has boost and the other one has not,
+	   pick the one with boost first. */
+	return (int)(b->has_boost_on_pin - a->has_boost_on_pin);
 }
 
 /* Reorder the surround channels
@@ -268,16 +275,16 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 			cfg->hp_outs++;
 			break;
 		case AC_JACK_MIC_IN:
-			add_auto_cfg_input_pin(cfg, nid, AUTO_PIN_MIC);
+			add_auto_cfg_input_pin(codec, cfg, nid, AUTO_PIN_MIC);
 			break;
 		case AC_JACK_LINE_IN:
-			add_auto_cfg_input_pin(cfg, nid, AUTO_PIN_LINE_IN);
+			add_auto_cfg_input_pin(codec, cfg, nid, AUTO_PIN_LINE_IN);
 			break;
 		case AC_JACK_CD:
-			add_auto_cfg_input_pin(cfg, nid, AUTO_PIN_CD);
+			add_auto_cfg_input_pin(codec, cfg, nid, AUTO_PIN_CD);
 			break;
 		case AC_JACK_AUX:
-			add_auto_cfg_input_pin(cfg, nid, AUTO_PIN_AUX);
+			add_auto_cfg_input_pin(codec, cfg, nid, AUTO_PIN_AUX);
 			break;
 		case AC_JACK_SPDIF_OUT:
 		case AC_JACK_DIG_OTHER_OUT:
diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index e941f60..2b8e29f 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -38,6 +38,7 @@ struct auto_pin_cfg_item {
 	int type;
 	unsigned int is_headset_mic:1;
 	unsigned int is_headphone_mic:1; /* Mic-only in headphone jack */
+	unsigned int has_boost_on_pin:1;
 };
 
 struct auto_pin_cfg;
-- 
1.9.1
