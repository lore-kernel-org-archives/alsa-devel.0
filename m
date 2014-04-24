From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Cancel hsw_notification_work
	before freeing the stream
Date: Thu, 24 Apr 2014 10:34:36 +0300
Message-ID: <1398324876-901-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 411EB2610CF
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 09:35:13 +0200 (CEST)
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
Cc: Wenkai Du <wenkai.du@intel.com>, Derek Basehore <dbasehore@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

I suppose there is a possibility that hsw_notification_work() may run after
sst_hsw_stream_free() which can lead to a kernel crash since struct
sst_hsw_stream is freed at that point and
stream = container_of(work, struct sst_hsw_stream, notify_work) is not valid
when hsw_notification_work() is run.

Reported-by: Derek Basehore <dbasehore@chromium.org>
Reported-by: Wenkai Du <wenkai.du@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
Untested, I don't have at the moment Haswell to test this and Liam hasn't
seen this patch yet so ack/tested-by from him might be good to have :-)
---
 sound/soc/intel/sst-haswell-ipc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 6c0b4f247a86..5bcf5963a0ba 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1207,6 +1207,7 @@ int sst_hsw_stream_free(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
 	trace_hsw_stream_free_req(stream, &stream->free_req);
 
 out:
+	cancel_work_sync(&stream->notify_work);
 	spin_lock_irqsave(&sst->spinlock, flags);
 	list_del(&stream->node);
 	kfree(stream);
-- 
1.9.2
