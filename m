From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 14/20] sound/seq_oss*: remove snd_seq_oss_readq_wait()
Date: Wed, 2 Feb 2005 14:02:19 -0800
Message-ID: <20050202220219.GT2546@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6ABA7201
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2005 23:02:26 +0100 (MET)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j12M2LZW027957
	for <alsa-devel@alsa-project.org>; Wed, 2 Feb 2005 17:02:21 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j12M2KcP272462
	for <alsa-devel@alsa-project.org>; Wed, 2 Feb 2005 17:02:21 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j12M2K8u028906
	for <alsa-devel@alsa-project.org>; Wed, 2 Feb 2005 17:02:20 -0500
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, kernel-janitors@lists.osdl.org
List-Id: alsa-devel@alsa-project.org

Hello,

Please consider applying.

Description: Remove snd_seq_oss_readq_wait() which is called only once and is
simply a wrapper for a deprecated function. Remove snd_seq_oss_readq_wait()'s
prototype from the header file. Replace the one caller with direct wait-queue
usage. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.11-rc2-kj-v/sound/core/seq/oss/seq_oss_readq.h	2005-01-24 09:28:58.000000000 -0800
+++ 2.6.11-rc2-kj/sound/core/seq/oss/seq_oss_readq.h	2005-02-02 11:51:30.000000000 -0800
@@ -47,7 +47,6 @@ int snd_seq_oss_readq_puts(seq_oss_readq
 int snd_seq_oss_readq_put_event(seq_oss_readq_t *readq, evrec_t *ev);
 int snd_seq_oss_readq_put_timestamp(seq_oss_readq_t *readq, unsigned long curt, int seq_mode);
 int snd_seq_oss_readq_pick(seq_oss_readq_t *q, evrec_t *rec);
-void snd_seq_oss_readq_wait(seq_oss_readq_t *q);
 void snd_seq_oss_readq_free(seq_oss_readq_t *q);
 
 #define snd_seq_oss_readq_lock(q, flags) spin_lock_irqsave(&(q)->lock, flags)
--- 2.6.11-rc2-kj-v/sound/core/seq/oss/seq_oss_readq.c	2005-01-24 09:34:23.000000000 -0800
+++ 2.6.11-rc2-kj/sound/core/seq/oss/seq_oss_readq.c	2005-02-01 16:13:55.000000000 -0800
@@ -160,15 +160,6 @@ snd_seq_oss_readq_pick(seq_oss_readq_t *
 }
 
 /*
- * sleep until ready
- */
-void
-snd_seq_oss_readq_wait(seq_oss_readq_t *q)
-{
-	interruptible_sleep_on_timeout(&q->midi_sleep, q->pre_event_timeout);
-}
-
-/*
  * drain one record
  * caller must hold lock
  */
--- 2.6.11-rc2-kj-v/sound/core/seq/oss/seq_oss_rw.c	2005-01-24 09:28:58.000000000 -0800
+++ 2.6.11-rc2-kj/sound/core/seq/oss/seq_oss_rw.c	2005-02-01 16:13:40.000000000 -0800
@@ -28,6 +28,7 @@
 #include "seq_oss_event.h"
 #include "seq_oss_timer.h"
 #include "../seq_clientmgr.h"
+#include <linux/wait.h>
 
 
 /*
@@ -43,6 +44,7 @@ static int insert_queue(seq_oss_devinfo_
 int
 snd_seq_oss_read(seq_oss_devinfo_t *dp, char __user *buf, int count)
 {
+	DEFINE_WAIT(wait);
 	seq_oss_readq_t *readq = dp->readq;
 	int result = 0, err = 0;
 	int ev_len;
@@ -58,7 +60,9 @@ snd_seq_oss_read(seq_oss_devinfo_t *dp, 
 		if (err == -EAGAIN &&
 		    !is_nonblock_mode(dp->file_mode) && result == 0) {
 			snd_seq_oss_readq_unlock(readq, flags);
-			snd_seq_oss_readq_wait(readq);
+			prepare_to_wait(&readq->midi_sleep, &wait, TASK_INTERRUPTIBLE);
+			schedule_timeout(readq->pre_event_timeout);
+			finish_wait(&readq->midi_sleep, &wait);
 			snd_seq_oss_readq_lock(readq, flags);
 			if (signal_pending(current))
 				err = -ERESTARTSYS;


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
