From: Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH] Provide card number / PID via sequencer client
	info
Date: Sat, 13 Feb 2016 14:42:17 +0100
Message-ID: <1455370937-501-3-git-send-email-martin@mail.zuhause>
References: <1455370937-501-1-git-send-email-martin@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe03-1.mx.upcmail.net
 (vie01a-dmta-pe03-1.mx.upcmail.net [62.179.121.160])
 by alsa0.perex.cz (Postfix) with ESMTP id AE3E22605FF
 for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2016 14:42:26 +0100 (CET)
Received: from [172.31.216.43] (helo=vie01a-pemc-psmtp-pe01)
 by vie01a-dmta-pe03.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <martin.koegler@chello.at>) id 1aUaSw-0000VR-Kn
 for alsa-devel@alsa-project.org; Sat, 13 Feb 2016 14:42:26 +0100
In-Reply-To: <1455370937-501-1-git-send-email-martin@mail.zuhause>
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
Cc: Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org

From: Martin Koegler <martin.koegler@chello.at>

rawmidi devices expose the card number via IOCTLs, which allows to
find the corresponding device in sysfs.

The sequencer provides no identifing data. Chromium works around this
issue by scanning rawmidi as well as sequencer devices and matching
them by using assumtions, how the kernel register sequencer devices.

This changes adds support for exposing the card number for kernel clients
as well as the PID for user client.

The minor of the API version is changed to distinguish between the zero
initialised reserved field and card number 0.

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 include/uapi/sound/asequencer.h |  5 +++--
 sound/core/seq/seq_clientmgr.c  | 18 ++++++++++++++++++
 sound/core/seq/seq_clientmgr.h  |  2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index 5a5fa49..4726579 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -25,7 +25,7 @@
 #include <sound/asound.h>
 
 /** version of the sequencer */
-#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 1)
+#define SNDRV_SEQ_VERSION SNDRV_PROTOCOL_VERSION (1, 0, 2)
 
 /**
  * definition of sequencer event types
@@ -357,7 +357,8 @@ struct snd_seq_client_info {
 	unsigned char event_filter[32];	/* event filter bitmap */
 	int num_ports;			/* RO: number of ports */
 	int event_lost;			/* number of lost events */
-	char reserved[64];		/* for future use */
+	int owner;			/* RO: card number[kernel] / PID[user] */
+	char reserved[64 - sizeof(int)]; /* for future use */
 };
 
 
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 58e79e0..ac07ab7 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -364,6 +364,7 @@ static int snd_seq_open(struct inode *inode, struct file *file)
 	/* fill client data */
 	user->file = file;
 	sprintf(client->name, "Client-%d", c);
+	client->data.user.owner = get_pid(task_pid(current));
 
 	/* make others aware this new client */
 	snd_seq_system_client_ev_client_start(c);
@@ -380,6 +381,7 @@ static int snd_seq_release(struct inode *inode, struct file *file)
 		seq_free_client(client);
 		if (client->data.user.fifo)
 			snd_seq_fifo_delete(&client->data.user.fifo);
+		put_pid(client->data.user.owner);
 		kfree(client);
 	}
 
@@ -1197,6 +1199,21 @@ static void get_client_info(struct snd_seq_client *cptr,
 	info->event_lost = cptr->event_lost;
 	memcpy(info->event_filter, cptr->event_filter, 32);
 	info->num_ports = cptr->num_ports;
+
+	switch (cptr->type) {
+	case USER_CLIENT:
+		info->owner = pid_vnr(cptr->data.user.owner);
+		break;
+
+	case KERNEL_CLIENT:
+		info->owner = cptr->data.kernel.card ? cptr->data.kernel.card->number : -1;
+		break;
+
+	default:
+		info->owner = -1;
+		break;
+	}
+
 	memset(info->reserved, 0, sizeof(info->reserved));
 }
 
@@ -2271,6 +2288,7 @@ int snd_seq_create_kernel_client(struct snd_card *card, int client_index,
 
 	client->accept_input = 1;
 	client->accept_output = 1;
+	client->data.kernel.card = card;
 		
 	va_start(args, name_fmt);
 	vsnprintf(client->name, sizeof(client->name), name_fmt, args);
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index 20f0a72..031462e 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -33,6 +33,7 @@
 struct snd_seq_user_client {
 	struct file *file;	/* file struct of client */
 	/* ... */
+	struct pid* owner;
 	
 	/* fifo */
 	struct snd_seq_fifo *fifo;	/* queue for incoming events */
@@ -41,6 +42,7 @@ struct snd_seq_user_client {
 
 struct snd_seq_kernel_client {
 	/* ... */
+	struct snd_card* card;
 };
 
 
-- 
2.1.4
