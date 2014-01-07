From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - firmware patch code cleanup
Date: Tue,  7 Jan 2014 18:22:28 +0100
Message-ID: <1389115349-20603-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A9368265087
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:22:29 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A6F6FAC3C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 17:22:29 +0000 (UTC)
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

Just a code refactoring: the need_codec flag in hda_patch_item struct
can be removed by checking the current mode instead.  No functional
change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_hwdep.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 0ec6fb1e9846..79b3dd0d4dd8 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -763,19 +763,18 @@ DEFINE_PARSE_ID_MODE(revision_id);
 struct hda_patch_item {
 	const char *tag;
 	void (*parser)(char *buf, struct hda_bus *bus, struct hda_codec **retc);
-	int need_codec;
 };
 
 static struct hda_patch_item patch_items[NUM_LINE_MODES] = {
-	[LINE_MODE_CODEC] = { "[codec]", parse_codec_mode, 0 },
-	[LINE_MODE_MODEL] = { "[model]", parse_model_mode, 1 },
-	[LINE_MODE_VERB] = { "[verb]", parse_verb_mode, 1 },
-	[LINE_MODE_PINCFG] = { "[pincfg]", parse_pincfg_mode, 1 },
-	[LINE_MODE_HINT] = { "[hint]", parse_hint_mode, 1 },
-	[LINE_MODE_VENDOR_ID] = { "[vendor_id]", parse_vendor_id_mode, 1 },
-	[LINE_MODE_SUBSYSTEM_ID] = { "[subsystem_id]", parse_subsystem_id_mode, 1 },
-	[LINE_MODE_REVISION_ID] = { "[revision_id]", parse_revision_id_mode, 1 },
-	[LINE_MODE_CHIP_NAME] = { "[chip_name]", parse_chip_name_mode, 1 },
+	[LINE_MODE_CODEC] = { "[codec]", parse_codec_mode },
+	[LINE_MODE_MODEL] = { "[model]", parse_model_mode },
+	[LINE_MODE_VERB] = { "[verb]", parse_verb_mode },
+	[LINE_MODE_PINCFG] = { "[pincfg]", parse_pincfg_mode },
+	[LINE_MODE_HINT] = { "[hint]", parse_hint_mode },
+	[LINE_MODE_VENDOR_ID] = { "[vendor_id]", parse_vendor_id_mode },
+	[LINE_MODE_SUBSYSTEM_ID] = { "[subsystem_id]", parse_subsystem_id_mode },
+	[LINE_MODE_REVISION_ID] = { "[revision_id]", parse_revision_id_mode },
+	[LINE_MODE_CHIP_NAME] = { "[chip_name]", parse_chip_name_mode },
 };
 
 /* check the line starting with '[' -- change the parser mode accodingly */
@@ -846,7 +845,7 @@ int snd_hda_load_patch(struct hda_bus *bus, size_t fw_size, const void *fw_buf)
 		if (*buf == '[')
 			line_mode = parse_line_mode(buf, bus);
 		else if (patch_items[line_mode].parser &&
-			 (codec || !patch_items[line_mode].need_codec))
+			 (codec || line_mode <= LINE_MODE_CODEC))
 			patch_items[line_mode].parser(buf, bus, &codec);
 	}
 	return 0;
-- 
1.8.5.2
