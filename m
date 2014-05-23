From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: Remove deprecated snd_card_create()
Date: Fri, 23 May 2014 09:58:57 +0200
Message-ID: <1400831937-8557-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 45D54265677
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 09:58:58 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 182B9AD03
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 07:58:57 +0000 (UTC)
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

Now all calls have been fixed, let's get rid of the old definition.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index d3f5f818e0b9..eedda2cdfe57 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -282,13 +282,6 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 		 struct module *module, int extra_size,
 		 struct snd_card **card_ret);
 
-static inline int __deprecated
-snd_card_create(int idx, const char *id, struct module *module, int extra_size,
-		struct snd_card **ret)
-{
-	return snd_card_new(NULL, idx, id, module, extra_size, ret);
-}
-
 int snd_card_disconnect(struct snd_card *card);
 int snd_card_free(struct snd_card *card);
 int snd_card_free_when_closed(struct snd_card *card);
-- 
1.9.3
