From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix usage of "model" module
	parameter
Date: Thu, 19 Jun 2014 22:07:19 +0200
Message-ID: <1403208439-5184-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9432C2607C8
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 22:07:21 +0200 (CEST)
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
Cc: David Henningsson <david.henningsson@canonical.com>, kent.baxley@canonical.com
List-Id: alsa-devel@alsa-project.org

A recent refactoring broke the possibility to manually specify
model name as a module parameter. This patch restores the desired
functionality.

Reported-by: Kent Baxley <kent.baxley@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index b684c6e..dabe419 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -898,6 +898,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
 			if (!strcmp(codec->modelname, models->name)) {
 				codec->fixup_id = models->id;
 				codec->fixup_name = models->name;
+				codec->fixup_list = fixlist;
 				codec->fixup_forced = 1;
 				return;
 			}
-- 
1.9.1
