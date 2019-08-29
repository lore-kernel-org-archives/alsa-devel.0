From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix potential endless loop at
	applying quirks
Date: Thu, 29 Aug 2019 10:10:43 +0200
Message-ID: <20190829081043.18432-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E36CDF8983C
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 10:10:59 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 422A2AD35
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 08:10:58 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since the chained quirks via chained_before flag is applied before the
depth check, it may lead to the endless recursive calls, when the
chain were set up incorrectly.  Fix it by moving the depth check at
the beginning of the loop.

Fixes: 1f57825077dc ("ALSA: hda - Add chained_before flag to the fixup entry")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 8a134f750bae..2c6d2becfe1a 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -824,6 +824,8 @@ static void apply_fixup(struct hda_codec *codec, int id, int action, int depth)
 	while (id >= 0) {
 		const struct hda_fixup *fix = codec->fixup_list + id;
 
+		if (++depth > 10)
+			break;
 		if (fix->chained_before)
 			apply_fixup(codec, fix->chain_id, action, depth + 1);
 
@@ -863,8 +865,6 @@ static void apply_fixup(struct hda_codec *codec, int id, int action, int depth)
 		}
 		if (!fix->chained || fix->chained_before)
 			break;
-		if (++depth > 10)
-			break;
 		id = fix->chain_id;
 	}
 }
-- 
2.16.4
