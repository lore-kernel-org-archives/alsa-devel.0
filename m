From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 5/7] ALSA: seq: Adjust 16 function calls together with a
 variable assignment
Date: Tue, 24 Jan 2017 11:25:14 +0100
Message-ID: <c3f73d40-c9dc-2682-0b94-f997763aaf7b@users.sourceforge.net>
References: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Martin Koegler <martin.koegler@chello.at>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Jan 2017 09:44:22 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/seq/seq_clientmgr.c | 52 ++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index b9518e7cb623..519968841ccc 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -400,7 +400,11 @@ static ssize_t snd_seq_read(struct file *file, char __user *buf, size_t count,
 	if (snd_BUG_ON(!client))
 		return -ENXIO;
 
-	if (!client->accept_input || (fifo = client->data.user.fifo) == NULL)
+	if (!client->accept_input)
+		return -ENXIO;
+
+	fifo = client->data.user.fifo;
+	if (!fifo)
 		return -ENXIO;
 
 	if (atomic_read(&fifo->overflow) > 0) {
@@ -419,9 +423,9 @@ static ssize_t snd_seq_read(struct file *file, char __user *buf, size_t count,
 		int nonblock;
 
 		nonblock = (file->f_flags & O_NONBLOCK) || result > 0;
-		if ((err = snd_seq_fifo_cell_out(fifo, &cell, nonblock)) < 0) {
+		err = snd_seq_fifo_cell_out(fifo, &cell, nonblock);
+		if (err < 0)
 			break;
-		}
 		if (snd_seq_ev_is_variable(&cell->event)) {
 			struct snd_seq_event tmpev;
 			tmpev = cell->event;
@@ -948,7 +952,8 @@ static int snd_seq_client_enqueue_event(struct snd_seq_client *client,
 		return err;
 
 	/* we got a cell. enqueue it. */
-	if ((err = snd_seq_enqueue_event(cell, atomic, hop)) < 0) {
+	err = snd_seq_enqueue_event(cell, atomic, hop);
+	if (err < 0) {
 		snd_seq_cell_free(cell);
 		return err;
 	}
@@ -1273,7 +1278,8 @@ static int snd_seq_ioctl_create_port(struct snd_seq_client *client, void *arg)
 		return -EINVAL;
 	}
 	if (client->type == KERNEL_CLIENT) {
-		if ((callback = info->kernel) != NULL) {
+		callback = info->kernel;
+		if (callback) {
 			if (callback->owner)
 				port->owner = callback->owner;
 			port->private_data = callback->private_data;
@@ -1426,13 +1432,17 @@ static int snd_seq_ioctl_subscribe_port(struct snd_seq_client *client,
 	struct snd_seq_client *receiver, *sender;
 	struct snd_seq_client_port *sport, *dport;
 
-	if ((receiver = snd_seq_client_use_ptr(subs->dest.client)) == NULL)
+	receiver = snd_seq_client_use_ptr(subs->dest.client);
+	if (!receiver)
 		goto exit;
-	if ((sender = snd_seq_client_use_ptr(subs->sender.client)) == NULL)
+	sender = snd_seq_client_use_ptr(subs->sender.client);
+	if (!sender)
 		goto unlock_receiver;
-	if ((sport = snd_seq_port_use_ptr(sender, subs->sender.port)) == NULL)
+	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
+	if (!sport)
 		goto unlock_sender;
-	if ((dport = snd_seq_port_use_ptr(receiver, subs->dest.port)) == NULL)
+	dport = snd_seq_port_use_ptr(receiver, subs->dest.port);
+	if (!dport)
 		goto unlock_sport;
 
 	result = check_subscription_permission(client, sport, dport, subs);
@@ -1468,13 +1478,17 @@ static int snd_seq_ioctl_unsubscribe_port(struct snd_seq_client *client,
 	struct snd_seq_client *receiver, *sender;
 	struct snd_seq_client_port *sport, *dport;
 
-	if ((receiver = snd_seq_client_use_ptr(subs->dest.client)) == NULL)
+	receiver = snd_seq_client_use_ptr(subs->dest.client);
+	if (!receiver)
 		goto exit;
-	if ((sender = snd_seq_client_use_ptr(subs->sender.client)) == NULL)
+	sender = snd_seq_client_use_ptr(subs->sender.client);
+	if (!sender)
 		goto unlock_receiver;
-	if ((sport = snd_seq_port_use_ptr(sender, subs->sender.port)) == NULL)
+	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
+	if (!sport)
 		goto unlock_sender;
-	if ((dport = snd_seq_port_use_ptr(receiver, subs->dest.port)) == NULL)
+	dport = snd_seq_port_use_ptr(receiver, subs->dest.port);
+	if (!dport)
 		goto unlock_sport;
 
 	result = check_subscription_permission(client, sport, dport, subs);
@@ -1896,9 +1910,11 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 	struct snd_seq_client_port *sport;
 	struct snd_seq_subscribers *p;
 
-	if ((sender = snd_seq_client_use_ptr(subs->sender.client)) == NULL)
+	sender = snd_seq_client_use_ptr(subs->sender.client);
+	if (!sender)
 		goto exit;
-	if ((sport = snd_seq_port_use_ptr(sender, subs->sender.port)) == NULL)
+	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
+	if (!sport)
 		goto unlock_client;
 	p = snd_seq_port_get_subscription(&sport->c_src, &subs->dest);
 	if (p) {
@@ -1928,9 +1944,11 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client, void *arg)
 	struct list_head *p;
 	int i;
 
-	if ((cptr = snd_seq_client_use_ptr(subs->root.client)) == NULL)
+	cptr = snd_seq_client_use_ptr(subs->root.client);
+	if (!cptr)
 		goto exit;
-	if ((port = snd_seq_port_use_ptr(cptr, subs->root.port)) == NULL)
+	port = snd_seq_port_use_ptr(cptr, subs->root.port);
+	if (!port)
 		goto unlock_client;
 
 	switch (subs->type) {
-- 
2.11.0
