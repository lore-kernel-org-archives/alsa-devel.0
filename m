From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - Add fixup_forced flag
Date: Fri, 16 May 2014 12:38:31 +0200
Message-ID: <1400236712-5027-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 58BA52619E5
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 12:38:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, hui.wang@canonical.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The "fixup_forced" flag will indicate whether a specific fixup
(or nofixup) has been set by the user, to override the driver's
default.
This flag will help future patches.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c | 9 ++++++---
 sound/pci/hda/hda_codec.h       | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 90d2fda..36961ab 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -852,15 +852,17 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 	if (codec->modelname && !strcmp(codec->modelname, "nofixup")) {
 		codec->fixup_list = NULL;
 		codec->fixup_id = -1;
+		codec->fixup_forced = 1;
 		return;
 	}
 
 	if (codec->modelname && models) {
 		while (models->name) {
 			if (!strcmp(codec->modelname, models->name)) {
-				id = models->id;
-				name = models->name;
-				break;
+				codec->fixup_id = models->id;
+				codec->fixup_name = models->name;
+				codec->fixup_forced = 1;
+				return;
 			}
 			models++;
 		}
@@ -889,6 +891,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 		}
 	}
 
+	codec->fixup_forced = 0;
 	codec->fixup_id = id;
 	if (id >= 0) {
 		codec->fixup_list = fixlist;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index a423313..5825aa1 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -402,6 +402,7 @@ struct hda_codec {
 
 	/* fix-up list */
 	int fixup_id;
+	unsigned int fixup_forced:1; /* fixup explicitly set by user */
 	const struct hda_fixup *fixup_list;
 	const char *fixup_name;
 
-- 
1.9.1
