From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 15/20] sound/seq_oss_writeq: remove interruptible_sleep_on_timeout() usage
Date: Wed, 2 Feb 2005 14:03:44 -0800
Message-ID: <20050202220344.GU2546__3855.9096087285$1107382088$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.131])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3E963201
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2005 23:04:07 +0100 (MET)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j12M41CO533030
	for <alsa-devel@alsa-project.org>; Wed, 2 Feb 2005 17:04:05 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j12M3k8D456696
	for <alsa-devel@alsa-project.org>; Wed, 2 Feb 2005 15:04:01 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j12M3j6p004571
	for <alsa-devel@alsa-project.org>; Wed, 2 Feb 2005 15:03:46 -0700
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

Description: Remove deprecated interruptible_sleep_on_timeout() function call
and replace with direct wait-queue usage. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/sound/core/seq/oss/seq_oss_writeq.c	2005-01-24 09:28:58.000000000 -0800
+++ 2.6.11-rc2-kj/sound/core/seq/oss/seq_oss_writeq.c	2005-02-01 16:15:50.000000000 -0800
@@ -26,6 +26,7 @@
 #include <sound/seq_oss_legacy.h>
 #include "../seq_lock.h"
 #include "../seq_clientmgr.h"
+#include <linux/wait.h>
 
 
 /*
@@ -89,6 +90,7 @@ snd_seq_oss_writeq_clear(seq_oss_writeq_
 int
 snd_seq_oss_writeq_sync(seq_oss_writeq_t *q)
 {
+	DEFINE_WAIT(wait);
 	seq_oss_devinfo_t *dp = q->dp;
 	abstime_t time;
 	unsigned long flags;
@@ -123,7 +125,9 @@ snd_seq_oss_writeq_sync(seq_oss_writeq_t
 		
 	/* wait for echo event */
 	spin_unlock(&q->sync_lock);
-	interruptible_sleep_on_timeout(&q->sync_sleep, HZ);
+	prepare_to_wait(&q->sync_sleep, &wait, TASK_INTERRUPTIBLE);
+	schedule_timeout(HZ);
+	finish_wait(&q->sync_sleep, &wait);
 	spin_lock(&q->sync_lock);
 	if (signal_pending(current)) {
 		/* interrupted - return 0 to finish sync */


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
