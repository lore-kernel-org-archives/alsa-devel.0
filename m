From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: timer: fix wrong comment to refer to
	'SNDRV_TIMER_PSFLG_*'
Date: Sat, 29 Sep 2018 23:20:51 +0900
Message-ID: <20180929142051.25570-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 39D2B2678CE
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2018 16:20:59 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id z3-v6so6441055pgv.8
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2018 07:20:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA timer core has a comment referring to 'SNDRV_MIXER_PSFLG_*' in
a definition of 'struct snd_timer_params' of UAPI header. I can see
this in initial state of ALSA timer core, at least in
'alsa-driver-0.4.0.tar.gz'.

This commit fixes the comment.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/uapi/sound/asound.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index ed0a120d4f08..404d4b9ffe76 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -752,7 +752,7 @@ struct snd_timer_info {
 #define SNDRV_TIMER_PSFLG_EARLY_EVENT	(1<<2)	/* write early event to the poll queue */
 
 struct snd_timer_params {
-	unsigned int flags;		/* flags - SNDRV_MIXER_PSFLG_* */
+	unsigned int flags;		/* flags - SNDRV_TIMER_PSFLG_* */
 	unsigned int ticks;		/* requested resolution in ticks */
 	unsigned int queue_size;	/* total size of queue (32-1024) */
 	unsigned int reserved0;		/* reserved, was: failure locations */
-- 
2.17.1
