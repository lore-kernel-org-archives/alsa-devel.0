From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Add sanity check for user-space
	pointer delivery
Date: Tue, 10 Oct 2017 13:44:39 +0200
Message-ID: <20171010114439.10480-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 85FB126723C
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 13:44:45 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 597F6ACC1
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 11:44:44 +0000 (UTC)
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

The sequencer event may contain a user-space pointer with its
SNDRV_SEQ_EXT_USRPTR bit, and we assure that its delivery is limited
with non-atomic mode.  Otherwise the copy_from_user() may hit the
fault and cause a problem.  Although the core code doesn't set such a
flag (only set at snd_seq_write()), any wild driver may set it
mistakenly and lead to an unexpected crash.

This patch adds a sanity check of such events at the delivery core
code to filter out the invalid invocation in the atomic mode.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 6c9cba2166d9..84759d9c54bf 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -802,6 +802,10 @@ static int snd_seq_deliver_event(struct snd_seq_client *client, struct snd_seq_e
 		return -EMLINK;
 	}
 
+	if (snd_seq_ev_is_variable(event) &&
+	    snd_BUG_ON(atomic && (event->data.ext.len & SNDRV_SEQ_EXT_USRPTR)))
+		return -EINVAL;
+
 	if (event->queue == SNDRV_SEQ_ADDRESS_SUBSCRIBERS ||
 	    event->dest.client == SNDRV_SEQ_ADDRESS_SUBSCRIBERS)
 		result = deliver_to_subscribers(client, event, atomic, hop);
-- 
2.14.2
