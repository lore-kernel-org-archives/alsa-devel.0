From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/18] ALSA: timer: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:14 +0100
Message-ID: <1421665891-14475-2-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 375DD2606D8
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D367FABFC
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:35 +0000 (UTC)
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
 sound/core/timer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 777a45e08e53..a44235555896 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1030,9 +1030,7 @@ static int snd_timer_register_system(void)
 		snd_timer_free(timer);
 		return -ENOMEM;
 	}
-	init_timer(&priv->tlist);
-	priv->tlist.function = snd_timer_s_function;
-	priv->tlist.data = (unsigned long) timer;
+	setup_timer(&priv->tlist, snd_timer_s_function, (unsigned long) timer);
 	timer->private_data = priv;
 	timer->private_free = snd_timer_free_system;
 	return snd_timer_global_register(timer);
-- 
2.2.1
