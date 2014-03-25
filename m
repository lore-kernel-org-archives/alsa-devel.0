From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Inform the unexpectedly ignored
	pins by auto-parser
Date: Tue, 25 Mar 2014 10:04:40 +0100
Message-ID: <1395738280-8021-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 973E62625D7
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 10:04:42 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 51911AC91
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 09:04:41 +0000 (UTC)
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

The auto-parser may ignore some pins that could be valid when they
don't match with the assumption or if there are way too many pins
assigned to the same output type.  So far, such a pin has been
silently ignored, but it's better to leave a message, which would help
for debugging and understanding the problem.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 8de7cfa460b9..90d2fda6c8f9 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -227,10 +227,18 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 				continue;
 			if (!assoc_line_out)
 				assoc_line_out = assoc;
-			else if (assoc_line_out != assoc)
+			else if (assoc_line_out != assoc) {
+				codec_info(codec,
+					   "ignore pin 0x%x with mismatching assoc# 0x%x vs 0x%x\n",
+					   nid, assoc, assoc_line_out);
 				continue;
-			if (cfg->line_outs >= ARRAY_SIZE(cfg->line_out_pins))
+			}
+			if (cfg->line_outs >= ARRAY_SIZE(cfg->line_out_pins)) {
+				codec_info(codec,
+					   "ignore pin 0x%x, too many assigned pins\n",
+					   nid);
 				continue;
+			}
 			line_out[cfg->line_outs].pin = nid;
 			line_out[cfg->line_outs].seq = seq;
 			cfg->line_outs++;
@@ -238,8 +246,12 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 		case AC_JACK_SPEAKER:
 			seq = get_defcfg_sequence(def_conf);
 			assoc = get_defcfg_association(def_conf);
-			if (cfg->speaker_outs >= ARRAY_SIZE(cfg->speaker_pins))
+			if (cfg->speaker_outs >= ARRAY_SIZE(cfg->speaker_pins)) {
+				codec_info(codec,
+					   "ignore pin 0x%x, too many assigned pins\n",
+					   nid);
 				continue;
+			}
 			speaker_out[cfg->speaker_outs].pin = nid;
 			speaker_out[cfg->speaker_outs].seq = (assoc << 4) | seq;
 			cfg->speaker_outs++;
@@ -247,8 +259,12 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 		case AC_JACK_HP_OUT:
 			seq = get_defcfg_sequence(def_conf);
 			assoc = get_defcfg_association(def_conf);
-			if (cfg->hp_outs >= ARRAY_SIZE(cfg->hp_pins))
+			if (cfg->hp_outs >= ARRAY_SIZE(cfg->hp_pins)) {
+				codec_info(codec,
+					   "ignore pin 0x%x, too many assigned pins\n",
+					   nid);
 				continue;
+			}
 			hp_out[cfg->hp_outs].pin = nid;
 			hp_out[cfg->hp_outs].seq = (assoc << 4) | seq;
 			cfg->hp_outs++;
@@ -267,8 +283,12 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 			break;
 		case AC_JACK_SPDIF_OUT:
 		case AC_JACK_DIG_OTHER_OUT:
-			if (cfg->dig_outs >= ARRAY_SIZE(cfg->dig_out_pins))
+			if (cfg->dig_outs >= ARRAY_SIZE(cfg->dig_out_pins)) {
+				codec_info(codec,
+					   "ignore pin 0x%x, too many assigned pins\n",
+					   nid);
 				continue;
+			}
 			cfg->dig_out_pins[cfg->dig_outs] = nid;
 			cfg->dig_out_type[cfg->dig_outs] =
 				(loc == AC_JACK_LOC_HDMI) ?
-- 
1.9.1
