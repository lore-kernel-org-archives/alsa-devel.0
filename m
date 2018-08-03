From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: seq_oss: Mark expected switch fall-through
Date: Fri, 3 Aug 2018 15:53:54 -0500
Message-ID: <20180803205354.GA27883@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/core/seq/oss/seq_oss_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/oss/seq_oss_timer.c b/sound/core/seq/oss/seq_oss_timer.c
index 4f24ea9..ba127c2 100644
--- a/sound/core/seq/oss/seq_oss_timer.c
+++ b/sound/core/seq/oss/seq_oss_timer.c
@@ -92,7 +92,7 @@ snd_seq_oss_process_timer_event(struct seq_oss_timer *rec, union evrec *ev)
 		case TMR_WAIT_REL:
 			parm += rec->cur_tick;
 			rec->realtime = 0;
-			/* continue to next */
+			/* fall through and continue to next */
 		case TMR_WAIT_ABS:
 			if (parm == 0) {
 				rec->realtime = 1;
-- 
2.7.4
