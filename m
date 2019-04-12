From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: seq: Protect racy pool manipulation
	from OSS sequencer
Date: Fri, 12 Apr 2019 14:29:35 +0200
Message-ID: <20190412122935.4092-4-tiwai@suse.de>
References: <20190412122935.4092-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0248F8971F
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 14:29:37 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7C13EAD0A
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 12:29:36 +0000 (UTC)
In-Reply-To: <20190412122935.4092-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

OSS sequencer emulation still allows to queue and issue the events
that manipulate the client pool concurrently in a racy way.  This
patch serializes the access like the normal sequencer write / ioctl
via taking the client ioctl_mutex.  Since the access to the sequencer
client is done indirectly via a client id number, a new helper to
take/release the mutex is introduced.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/oss/seq_oss_device.h | 10 ++++++++--
 sound/core/seq/seq_clientmgr.c      | 40 ++++++++++++++++++++++++++++++++++---
 sound/core/seq/seq_clientmgr.h      |  4 ++++
 3 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_device.h b/sound/core/seq/oss/seq_oss_device.h
index 2d0e9eaf13aa..77eb1fe1155c 100644
--- a/sound/core/seq/oss/seq_oss_device.h
+++ b/sound/core/seq/oss/seq_oss_device.h
@@ -30,6 +30,7 @@
 #include <sound/rawmidi.h>
 #include <sound/seq_kernel.h>
 #include <sound/info.h>
+#include "../seq_clientmgr.h"
 
 /* max. applications */
 #define SNDRV_SEQ_OSS_MAX_CLIENTS	16
@@ -150,11 +151,16 @@ snd_seq_oss_dispatch(struct seq_oss_devinfo *dp, struct snd_seq_event *ev, int a
 	return snd_seq_kernel_client_dispatch(dp->cseq, ev, atomic, hop);
 }
 
-/* ioctl */
+/* ioctl for writeq */
 static inline int
 snd_seq_oss_control(struct seq_oss_devinfo *dp, unsigned int type, void *arg)
 {
-	return snd_seq_kernel_client_ctl(dp->cseq, type, arg);
+	int err;
+
+	snd_seq_client_ioctl_lock(dp->cseq);
+	err = snd_seq_kernel_client_ctl(dp->cseq, type, arg);
+	snd_seq_client_ioctl_unlock(dp->cseq);
+	return err;
 }
 
 /* fill the addresses in header */
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 0af5b1440b33..a5c9d59eb5b8 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -179,6 +179,36 @@ struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
 	return client;
 }
 
+/* Take refcount and perform ioctl_mutex lock on the given client;
+ * used only for OSS sequencer
+ * Unlock via snd_seq_client_ioctl_unlock() below
+ */
+bool snd_seq_client_ioctl_lock(int clientid)
+{
+	struct snd_seq_client *client;
+
+	client = snd_seq_client_use_ptr(clientid);
+	if (!client)
+		return false;
+	mutex_lock(&client->ioctl_mutex);
+	return true;
+}
+EXPORT_SYMBOL_GPL(snd_seq_client_ioctl_lock);
+
+/* Unlock and unref the given client; for OSS sequencer use only */
+void snd_seq_client_ioctl_unlock(int clientid)
+{
+	struct snd_seq_client *client;
+
+	client = snd_seq_client_use_ptr(clientid);
+	if (WARN_ON(!client))
+		return;
+	mutex_unlock(&client->ioctl_mutex);
+	snd_use_lock_free(&client->use_lock);
+	snd_seq_client_unlock(client);
+}
+EXPORT_SYMBOL_GPL(snd_seq_client_ioctl_unlock);
+
 static void usage_alloc(struct snd_seq_usage *res, int num)
 {
 	res->cur += num;
@@ -2247,11 +2277,15 @@ int snd_seq_kernel_client_enqueue(int client, struct snd_seq_event *ev,
 	if (cptr == NULL)
 		return -EINVAL;
 	
-	if (! cptr->accept_output)
+	if (!cptr->accept_output) {
 		result = -EPERM;
-	else /* send it */
+	} else { /* send it */
+		mutex_lock(&cptr->ioctl_mutex);
 		result = snd_seq_client_enqueue_event(cptr, ev, file, blocking,
-						      false, 0, NULL);
+						      false, 0,
+						      &cptr->ioctl_mutex);
+		mutex_unlock(&cptr->ioctl_mutex);
+	}
 
 	snd_seq_client_unlock(cptr);
 	return result;
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index 66ad3d547916..28a51dcc0190 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -97,6 +97,10 @@ int snd_seq_kernel_client_write_poll(int clientid, struct file *file, poll_table
 int snd_seq_client_notify_subscription(int client, int port,
 				       struct snd_seq_port_subscribe *info, int evtype);
 
+/* only for OSS sequencer */
+bool snd_seq_client_ioctl_lock(int clientid);
+void snd_seq_client_ioctl_unlock(int clientid);
+
 extern int seq_client_load[15];
 
 #endif
-- 
2.16.4
