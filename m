From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: seq: Clear client entry before
	deleting else at closing
Date: Fri,  9 Mar 2018 23:24:10 +0100
Message-ID: <20180309222410.2390-2-tiwai@suse.de>
References: <20180309222410.2390-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BCD44266D7D
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 23:24:14 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CA821ABD0
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 22:24:12 +0000 (UTC)
In-Reply-To: <20180309222410.2390-1-tiwai@suse.de>
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

When releasing a client, we need to clear the clienttab[] entry at
first, then call snd_seq_queue_client_leave().  Otherwise, the
in-flight cell in the queue might be picked up by the timer interrupt
via snd_seq_check_queue() before calling snd_seq_queue_client_leave(),
and it's delivered to another queue while the client is clearing
queues.  This may eventually result in an uncleared cell remaining in
a queue, and the later snd_seq_pool_delete() may need to wait for a
long time until the event gets really processed.

By moving the clienttab[] clearance at the beginning of release, any
event delivery of a cell belonging to this client will fail at a later
point, since snd_seq_client_ptr() returns NULL.  Thus the cell that
was picked up by the timer interrupt will be returned immediately
without further delivery, and the long stall of snd_seq_delete_pool()
can be avoided, too.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 918338dea5b9..61a07fe34cd2 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -255,12 +255,12 @@ static int seq_free_client1(struct snd_seq_client *client)
 
 	if (!client)
 		return 0;
-	snd_seq_delete_all_ports(client);
-	snd_seq_queue_client_leave(client->number);
 	spin_lock_irqsave(&clients_lock, flags);
 	clienttablock[client->number] = 1;
 	clienttab[client->number] = NULL;
 	spin_unlock_irqrestore(&clients_lock, flags);
+	snd_seq_delete_all_ports(client);
+	snd_seq_queue_client_leave(client->number);
 	snd_use_lock_sync(&client->use_lock);
 	snd_seq_queue_client_termination(client->number);
 	if (client->pool)
-- 
2.15.0
