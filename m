From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: hda - add some small convenience
	functions to auto parser
Date: Thu, 11 Apr 2013 11:30:29 +0200
Message-ID: <1365672630-15411-3-git-send-email-david.henningsson@canonical.com>
References: <1365672630-15411-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A4BF266017
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

I never liked that we move our speaker and hp pins to line out
if there are not any line outs; but now that we do,
add some convenience functions to find hp and speaker pins even
if they have been moved.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index fe2ba7f..e941f60 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -94,4 +94,25 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 #define snd_hda_parse_pin_def_config(codec, cfg, ignore) \
 	snd_hda_parse_pin_defcfg(codec, cfg, ignore, 0)
 
+static inline int auto_cfg_hp_outs(const struct auto_pin_cfg *cfg)
+{
+	return (cfg->line_out_type == AUTO_PIN_HP_OUT) ?
+	       cfg->line_outs : cfg->hp_outs;
+}
+static inline const hda_nid_t *auto_cfg_hp_pins(const struct auto_pin_cfg *cfg)
+{
+	return (cfg->line_out_type == AUTO_PIN_HP_OUT) ?
+	       cfg->line_out_pins : cfg->hp_pins;
+}
+static inline int auto_cfg_speaker_outs(const struct auto_pin_cfg *cfg)
+{
+	return (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) ?
+	       cfg->line_outs : cfg->speaker_outs;
+}
+static inline const hda_nid_t *auto_cfg_speaker_pins(const struct auto_pin_cfg *cfg)
+{
+	return (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) ?
+	       cfg->line_out_pins : cfg->speaker_pins;
+}
+
 #endif /* __SOUND_HDA_AUTO_PARSER_H */
-- 
1.7.9.5
