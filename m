From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Remove superfluous
	snd_seq_queue_client_leave_cells() call
Date: Thu,  8 Mar 2018 12:07:41 +0100
Message-ID: <20180308110741.23573-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C217326705A
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 12:07:42 +0100 (CET)
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
Cc: Miroslav Benes <mbenes@suse.cz>, =?UTF-8?q?=E8=8C=83=E9=BE=99=E9=A3=9E?= <long7573@126.com>, Nicolai Stange <nstange@suse.de>
List-Id: alsa-devel@alsa-project.org

With the previous two fixes for the write / ioctl races:
  ALSA: seq: Don't allow resizing pool in use
  ALSA: seq: More protection for concurrent write and ioctl races
the cells aren't any longer in queues at the point calling
snd_seq_pool_done() in snd_seq_ioctl_set_client_pool().  Hence the
function call snd_seq_queue_client_leave_cells() can be dropped safely
from there.

Suggested-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 1b62421dadd1..918338dea5b9 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1846,7 +1846,6 @@ static int snd_seq_ioctl_set_client_pool(struct snd_seq_client *client,
 				return -EBUSY;
 			/* remove all existing cells */
 			snd_seq_pool_mark_closing(client->pool);
-			snd_seq_queue_client_leave_cells(client->number);
 			snd_seq_pool_done(client->pool);
 		}
 		client->pool->size = info->output_pool;
-- 
2.16.2
