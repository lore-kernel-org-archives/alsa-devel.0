From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/10] ALSA: Limit the fallback card id string
	size
Date: Tue, 29 Oct 2013 17:00:26 +0100
Message-ID: <1383062433-9388-4-git-send-email-tiwai@suse.de>
References: <1383062433-9388-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C9E1E26109A
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9F86AA591F
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
In-Reply-To: <1383062433-9388-1-git-send-email-tiwai@suse.de>
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

When no proper id string is given, the driver tries to fall back to
copy the proc_root name string via strcpy(), but this might overflow
the fixed string size.  Let's use strlcpy().

Spotted by coverity CID 139008.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 01a89383a062..1351f22f651c 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -597,7 +597,7 @@ static void snd_card_set_id_no_lock(struct snd_card *card, const char *src,
 	/* last resort... */
 	snd_printk(KERN_ERR "unable to set card id (%s)\n", id);
 	if (card->proc_root->name)
-		strcpy(card->id, card->proc_root->name);
+		strlcpy(card->id, card->proc_root->name, sizeof(card->id));
 }
 
 /**
-- 
1.8.4.1
