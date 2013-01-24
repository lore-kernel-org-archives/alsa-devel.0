From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/13] ALSA: hda - Add chained_before flag to
	the fixup entry
Date: Thu, 24 Jan 2013 18:37:53 +0100
Message-ID: <1359049082-5880-5-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AF84C2616F4
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id E7450A50F4
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:14 +0100 (CET)
In-Reply-To: <1359049082-5880-1-git-send-email-tiwai@suse.de>
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

Sometimes we want to call a fixup after applying other existing
fixups, but currently the fixup chain mechanism allows only the call
the others after the target fixup.  This patch adds a new flag,
chained_before, to struct hda_fixup, for allowing the chained call
before the current execution.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 18 +++++++++++-------
 sound/pci/hda/hda_local.h       |  3 ++-
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 0088bb0..96a05c4 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -696,20 +696,18 @@ static void set_pin_targets(struct hda_codec *codec,
 		snd_hda_set_pin_ctl_cache(codec, cfg->nid, cfg->val);
 }
 
-void snd_hda_apply_fixup(struct hda_codec *codec, int action)
+static void apply_fixup(struct hda_codec *codec, int id, int action, int depth)
 {
-	int id = codec->fixup_id;
 #ifdef CONFIG_SND_DEBUG_VERBOSE
 	const char *modelname = codec->fixup_name;
 #endif
-	int depth = 0;
-
-	if (!codec->fixup_list)
-		return;
 
 	while (id >= 0) {
 		const struct hda_fixup *fix = codec->fixup_list + id;
 
+		if (fix->chained_before)
+			apply_fixup(codec, fix->chain_id, action, depth + 1);
+
 		switch (fix->type) {
 		case HDA_FIXUP_PINS:
 			if (action != HDA_FIXUP_ACT_PRE_PROBE || !fix->v.pins)
@@ -749,13 +747,19 @@ void snd_hda_apply_fixup(struct hda_codec *codec, int action)
 				   codec->chip_name, fix->type);
 			break;
 		}
-		if (!fix->chained)
+		if (!fix->chained || fix->chained_before)
 			break;
 		if (++depth > 10)
 			break;
 		id = fix->chain_id;
 	}
 }
+
+void snd_hda_apply_fixup(struct hda_codec *codec, int action)
+{
+	if (codec->fixup_list)
+		apply_fixup(codec, codec->fixup_id, action, 0);
+}
 EXPORT_SYMBOL_HDA(snd_hda_apply_fixup);
 
 void snd_hda_pick_fixup(struct hda_codec *codec,
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index f92979c..2ff62dc 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -401,7 +401,8 @@ struct hda_model_fixup {
 
 struct hda_fixup {
 	int type;
-	bool chained;
+	bool chained:1;		/* call the chained fixup(s) after this */
+	bool chained_before:1;	/* call the chained fixup(s) before this */
 	int chain_id;
 	union {
 		const struct hda_pintbl *pins;
-- 
1.8.1.1
