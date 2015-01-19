From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 15/18] ALSA: aica: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:28 +0100
Message-ID: <1421665891-14475-16-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C412606ED
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 04A16ADA0
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:36 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
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

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sh/aica.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index f44dda610ed2..8212300088fc 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -343,11 +343,9 @@ static void spu_begin_dma(struct snd_pcm_substream *substream)
 		mod_timer(&dreamcastcard->timer, jiffies + 4);
 		return;
 	}
-	init_timer(&(dreamcastcard->timer));
-	dreamcastcard->timer.data = (unsigned long) substream;
-	dreamcastcard->timer.function = aica_period_elapsed;
-	dreamcastcard->timer.expires = jiffies + 4;
-	add_timer(&(dreamcastcard->timer));
+	setup_timer(&dreamcastcard->timer, aica_period_elapsed,
+		    (unsigned long) substream);
+	mod_timer(&dreamcastcard->timer, jiffies + 4);
 }
 
 static int snd_aicapcm_pcm_open(struct snd_pcm_substream
-- 
2.2.1
