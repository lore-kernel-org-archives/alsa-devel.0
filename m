From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Correct unlock sequence at
	snd_seq_client_ioctl_unlock()
Date: Mon, 15 Apr 2019 11:31:05 +0200
Message-ID: <20190415093105.23965-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2622F80CAB
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2019 11:31:08 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The doubly unlock sequence at snd_seq_client_ioctl_unlock() is tricky.
I took a direct unref call since I thought it would avoid
misunderstanding, but rather this seems more confusing.  Let's use
snd_seq_client_unlock() consistently even if they look strange to be
called twice, and add more comments for avoiding reader's confusion.

Fixes: 6b580f523172 ("ALSA: seq: Protect racy pool manipulation from OSS sequencer")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 3acd80e718f2..c0227a672442 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -191,6 +191,7 @@ bool snd_seq_client_ioctl_lock(int clientid)
 	if (!client)
 		return false;
 	mutex_lock(&client->ioctl_mutex);
+	/* The client isn't unrefed here; see snd_seq_client_ioctl_unlock() */
 	return true;
 }
 EXPORT_SYMBOL_GPL(snd_seq_client_ioctl_lock);
@@ -204,7 +205,11 @@ void snd_seq_client_ioctl_unlock(int clientid)
 	if (WARN_ON(!client))
 		return;
 	mutex_unlock(&client->ioctl_mutex);
-	snd_use_lock_free(&client->use_lock);
+	/* The doubly unrefs below are intentional; the first one releases the
+	 * leftover from snd_seq_client_ioctl_lock() above, and the second one
+	 * is for releasing snd_seq_client_use_ptr() in this function
+	 */
+	snd_seq_client_unlock(client);
 	snd_seq_client_unlock(client);
 }
 EXPORT_SYMBOL_GPL(snd_seq_client_ioctl_unlock);
-- 
2.16.4
