From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Drop unused fields from struct
	hda_codec_preset
Date: Thu, 28 May 2015 15:20:57 +0200
Message-ID: <1432819257-23023-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F350265E28
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 15:21:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 14F28ADD0
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 13:21:00 +0000 (UTC)
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

It's very unlikely that we'd need these fields out of sudden.
Let's drop them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_bind.c  | 10 +---------
 sound/pci/hda/hda_codec.h |  4 ----
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 00aa31c5f08e..d5ac25cc7fee 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -27,15 +27,7 @@ static int hda_codec_match(struct hdac_device *dev, struct hdac_driver *drv)
 	u32 id = codec->probe_id ? codec->probe_id : codec->core.vendor_id;
 
 	for (preset = driver->preset; preset->id; preset++) {
-		u32 mask = preset->mask;
-
-		if (preset->afg && preset->afg != codec->core.afg)
-			continue;
-		if (preset->mfg && preset->mfg != codec->core.mfg)
-			continue;
-		if (!mask)
-			mask = ~0;
-		if (preset->id == (id & mask) &&
+		if (preset->id == id &&
 		    (!preset->rev || preset->rev == codec->core.revision_id)) {
 			codec->preset = preset;
 			return 1;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index ed7e9cfd699a..6c572588f7e5 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -82,11 +82,7 @@ struct hda_bus {
  */
 struct hda_codec_preset {
 	unsigned int id;
-	unsigned int mask;
-	unsigned int subs;
-	unsigned int subs_mask;
 	unsigned int rev;
-	hda_nid_t afg, mfg;
 	const char *name;
 	int (*patch)(struct hda_codec *codec);
 };
-- 
2.4.2
