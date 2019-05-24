From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/5] ASoC: SOF: trace: remove code duplication
	in sof_wait_trace_avail()
Date: Fri, 24 May 2019 14:23:05 -0500
Message-ID: <20190524192309.6359-2-pierre-louis.bossart@linux.intel.com>
References: <20190524192309.6359-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4CA9F89625
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 21:23:19 +0200 (CEST)
In-Reply-To: <20190524192309.6359-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Move duplicated code in sof_wait_trace_avail() to a helper function.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/trace.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
index d588e4b70fad..a2d89d295f0f 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -13,10 +13,9 @@
 #include "sof-priv.h"
 #include "ops.h"
 
-static size_t sof_wait_trace_avail(struct snd_sof_dev *sdev,
-				   loff_t pos, size_t buffer_size)
+static size_t sof_trace_avail(struct snd_sof_dev *sdev,
+			      loff_t pos, size_t buffer_size)
 {
-	wait_queue_entry_t wait;
 	loff_t host_offset = READ_ONCE(sdev->host_offset);
 
 	/*
@@ -31,6 +30,19 @@ static size_t sof_wait_trace_avail(struct snd_sof_dev *sdev,
 	if (host_offset > pos)
 		return host_offset - pos;
 
+	return 0;
+}
+
+static size_t sof_wait_trace_avail(struct snd_sof_dev *sdev,
+				   loff_t pos, size_t buffer_size)
+{
+	wait_queue_entry_t wait;
+	size_t ret = sof_trace_avail(sdev, pos, buffer_size);
+
+	/* data immediately available */
+	if (ret)
+		return ret;
+
 	/* wait for available trace data from FW */
 	init_waitqueue_entry(&wait, current);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -42,12 +54,7 @@ static size_t sof_wait_trace_avail(struct snd_sof_dev *sdev,
 	}
 	remove_wait_queue(&sdev->trace_sleep, &wait);
 
-	/* return bytes available for copy */
-	host_offset = READ_ONCE(sdev->host_offset);
-	if (host_offset < pos)
-		return buffer_size - pos;
-
-	return host_offset - pos;
+	return sof_trace_avail(sdev, pos, buffer_size);
 }
 
 static ssize_t sof_dfsentry_trace_read(struct file *file, char __user *buffer,
-- 
2.20.1
