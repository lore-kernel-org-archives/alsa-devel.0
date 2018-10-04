From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: seq: oss: Use the standard
	fall-through annotation
Date: Thu,  4 Oct 2018 20:12:32 +0200
Message-ID: <20181004181234.21152-4-tiwai@suse.de>
References: <20181004181234.21152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 86E0C26783D
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:12:36 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0A753B046
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 18:12:36 +0000 (UTC)
In-Reply-To: <20181004181234.21152-1-tiwai@suse.de>
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

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, replace with the standard "fall through" annotation.
Unfortunately gcc doesn't understand a chattier text.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/oss/seq_oss_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/oss/seq_oss_timer.c b/sound/core/seq/oss/seq_oss_timer.c
index ba127c22539a..0778d28421da 100644
--- a/sound/core/seq/oss/seq_oss_timer.c
+++ b/sound/core/seq/oss/seq_oss_timer.c
@@ -92,7 +92,7 @@ snd_seq_oss_process_timer_event(struct seq_oss_timer *rec, union evrec *ev)
 		case TMR_WAIT_REL:
 			parm += rec->cur_tick;
 			rec->realtime = 0;
-			/* fall through and continue to next */
+			/* fall through */
 		case TMR_WAIT_ABS:
 			if (parm == 0) {
 				rec->realtime = 1;
-- 
2.18.0
