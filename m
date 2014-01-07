From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Add consistent tag names for
	firmware patch
Date: Tue,  7 Jan 2014 18:22:29 +0100
Message-ID: <1389115349-20603-2-git-send-email-tiwai@suse.de>
References: <1389115349-20603-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AA25E2650F2
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:22:29 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A89C6AC3F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 17:22:29 +0000 (UTC)
In-Reply-To: <1389115349-20603-1-git-send-email-tiwai@suse.de>
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

Some tags used in the firmware patch file are inconsistent with hwdep
sysfs file names, such as, the firmware patch takes [hint] tag while
sysfs file is */hints.  This makes even me referring back to the
document often.  Let's provide the same tag names as sysfs for
reducing confusions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_hwdep.c | 51 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 79b3dd0d4dd8..72d8389fb399 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -762,19 +762,50 @@ DEFINE_PARSE_ID_MODE(revision_id);
 
 struct hda_patch_item {
 	const char *tag;
+	const char *alias;
 	void (*parser)(char *buf, struct hda_bus *bus, struct hda_codec **retc);
 };
 
 static struct hda_patch_item patch_items[NUM_LINE_MODES] = {
-	[LINE_MODE_CODEC] = { "[codec]", parse_codec_mode },
-	[LINE_MODE_MODEL] = { "[model]", parse_model_mode },
-	[LINE_MODE_VERB] = { "[verb]", parse_verb_mode },
-	[LINE_MODE_PINCFG] = { "[pincfg]", parse_pincfg_mode },
-	[LINE_MODE_HINT] = { "[hint]", parse_hint_mode },
-	[LINE_MODE_VENDOR_ID] = { "[vendor_id]", parse_vendor_id_mode },
-	[LINE_MODE_SUBSYSTEM_ID] = { "[subsystem_id]", parse_subsystem_id_mode },
-	[LINE_MODE_REVISION_ID] = { "[revision_id]", parse_revision_id_mode },
-	[LINE_MODE_CHIP_NAME] = { "[chip_name]", parse_chip_name_mode },
+	[LINE_MODE_CODEC] = {
+		.tag = "[codec]",
+		.parser = parse_codec_mode,
+	},
+	[LINE_MODE_MODEL] = {
+		.tag = "[model]",
+		.parser = parse_model_mode,
+	},
+	[LINE_MODE_VERB] = {
+		.tag = "[verb]",
+		.alias = "[init_verbs]",
+		.parser = parse_verb_mode,
+	},
+	[LINE_MODE_PINCFG] = {
+		.tag = "[pincfg]",
+		.alias = "[user_pin_configs]",
+		.parser = parse_pincfg_mode,
+	},
+	[LINE_MODE_HINT] = {
+		.tag = "[hint]",
+		.alias = "[hints]",
+		.parser = parse_hint_mode
+	},
+	[LINE_MODE_VENDOR_ID] = {
+		.tag = "[vendor_id]",
+		.parser = parse_vendor_id_mode,
+	},
+	[LINE_MODE_SUBSYSTEM_ID] = {
+		.tag = "[subsystem_id]",
+		.parser = parse_subsystem_id_mode,
+	},
+	[LINE_MODE_REVISION_ID] = {
+		.tag = "[revision_id]",
+		.parser = parse_revision_id_mode,
+	},
+	[LINE_MODE_CHIP_NAME] = {
+		.tag = "[chip_name]",
+		.parser = parse_chip_name_mode,
+	},
 };
 
 /* check the line starting with '[' -- change the parser mode accodingly */
@@ -786,6 +817,8 @@ static int parse_line_mode(char *buf, struct hda_bus *bus)
 			continue;
 		if (strmatch(buf, patch_items[i].tag))
 			return i;
+		if (patch_items[i].alias && strmatch(buf, patch_items[i].alias))
+			return i;
 	}
 	return LINE_MODE_NONE;
 }
-- 
1.8.5.2
