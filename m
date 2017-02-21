From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH] sound: convert snd_seq_subscribers.ref_count from atomic_t to refcount_t
Date: Tue, 21 Feb 2017 17:27:10 +0200
Message-ID: <1487690830-30277-1-git-send-email-elena.reshetova@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, peterz@infradead.org, gregkh@linuxfoundation.org, perex@perex.cz, tiwai@suse.com, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Kees Cook <keescook@chromium.org>, David Windsor <dwindsor@gmail.com>
List-Id: alsa-devel@alsa-project.org

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 sound/core/seq/seq_clientmgr.c | 2 +-
 sound/core/seq/seq_ports.c     | 7 +++----
 sound/core/seq/seq_ports.h     | 3 ++-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 4c93520..3440f76 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -666,7 +666,7 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
 		down_read(&grp->list_mutex);
 	list_for_each_entry(subs, &grp->list_head, src_list) {
 		/* both ports ready? */
-		if (atomic_read(&subs->ref_count) != 2)
+		if (refcount_read(&subs->ref_count) != 2)
 			continue;
 		event->dest = subs->info.dest;
 		if (subs->info.flags & SNDRV_SEQ_PORT_SUBS_TIMESTAMP)
diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index fe686ee..1ca896b 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -241,7 +241,7 @@ static void clear_subscriber_list(struct snd_seq_client *client,
 			 * we decrease the counter, and when both ports are deleted
 			 * remove the subscriber info
 			 */
-			if (atomic_dec_and_test(&subs->ref_count))
+			if (refcount_dec_and_test(&subs->ref_count))
 				kfree(subs);
 			continue;
 		}
@@ -520,7 +520,6 @@ static int check_and_subscribe_port(struct snd_seq_client *client,
 	else
 		list_add_tail(&subs->dest_list, &grp->list_head);
 	grp->exclusive = exclusive;
-	atomic_inc(&subs->ref_count);
 	write_unlock_irq(&grp->list_lock);
 	err = 0;
 
@@ -570,7 +569,6 @@ int snd_seq_port_connect(struct snd_seq_client *connector,
 		return -ENOMEM;
 
 	subs->info = *info;
-	atomic_set(&subs->ref_count, 0);
 	INIT_LIST_HEAD(&subs->src_list);
 	INIT_LIST_HEAD(&subs->dest_list);
 
@@ -587,6 +585,7 @@ int snd_seq_port_connect(struct snd_seq_client *connector,
 	if (err < 0)
 		goto error_dest;
 
+	refcount_set(&subs->ref_count, 2);
 	return 0;
 
  error_dest:
@@ -613,7 +612,7 @@ int snd_seq_port_disconnect(struct snd_seq_client *connector,
 	/* look for the connection */
 	list_for_each_entry(subs, &src->list_head, src_list) {
 		if (match_subs_info(info, &subs->info)) {
-			atomic_dec(&subs->ref_count); /* mark as not ready */
+			refcount_dec(&subs->ref_count); /* mark as not ready */
 			err = 0;
 			break;
 		}
diff --git a/sound/core/seq/seq_ports.h b/sound/core/seq/seq_ports.h
index 26bd71f..d09e396 100644
--- a/sound/core/seq/seq_ports.h
+++ b/sound/core/seq/seq_ports.h
@@ -21,6 +21,7 @@
 #ifndef __SND_SEQ_PORTS_H
 #define __SND_SEQ_PORTS_H
 
+#include <linux/refcount.h>
 #include <sound/seq_kernel.h>
 #include "seq_lock.h"
 
@@ -44,7 +45,7 @@ struct snd_seq_subscribers {
 	struct snd_seq_port_subscribe info;	/* additional info */
 	struct list_head src_list;	/* link of sources */
 	struct list_head dest_list;	/* link of destinations */
-	atomic_t ref_count;
+	refcount_t ref_count;
 };
 
 struct snd_seq_port_subs_info {
-- 
2.7.4
