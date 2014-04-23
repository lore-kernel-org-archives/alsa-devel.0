From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix audio crash due to race
	condition in stream deletion
Date: Wed, 23 Apr 2014 13:29:30 +0300
Message-ID: <1398248970-13991-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 17E07261696
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 12:29:43 +0200 (CEST)
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
Cc: Wenkai Du <wenkai.du@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Wenkai Du <wenkai.du@intel.com>

There is a race between sst_byt_stream_free() and sst_byt_get_stream()
if sst_byt_get_stream() called from sst_byt_irq_thread() context is
accessing the byt->stream_list while a stream is deleted from the list.

A stream is added to byt->stream_list in sst_byt_stream_new() and deleted in
sst_byt_stream_free(). sst_byt_get_stream() is always protected by
sst->spinlock, but the stream addition and deletion are not protected.

The patch adds spinlock to both stream addition and deletion.

[Jarkko: Same fix added to sst-haswell-ipc.c too]

Signed-off-by: Wenkai Du <wenkai.du@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-ipc.c | 8 ++++++++
 sound/soc/intel/sst-haswell-ipc.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index d0eaeee21be4..0d31dbbf4806 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -542,16 +542,20 @@ struct sst_byt_stream *sst_byt_stream_new(struct sst_byt *byt, int id,
 	void *data)
 {
 	struct sst_byt_stream *stream;
+	struct sst_dsp *sst = byt->dsp;
+	unsigned long flags;
 
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (stream == NULL)
 		return NULL;
 
+	spin_lock_irqsave(&sst->spinlock, flags);
 	list_add(&stream->node, &byt->stream_list);
 	stream->notify_position = notify_position;
 	stream->pdata = data;
 	stream->byt = byt;
 	stream->str_id = id;
+	spin_unlock_irqrestore(&sst->spinlock, flags);
 
 	return stream;
 }
@@ -630,6 +634,8 @@ int sst_byt_stream_free(struct sst_byt *byt, struct sst_byt_stream *stream)
 {
 	u64 header;
 	int ret = 0;
+	struct sst_dsp *sst = byt->dsp;
+	unsigned long flags;
 
 	if (!stream->commited)
 		goto out;
@@ -644,8 +650,10 @@ int sst_byt_stream_free(struct sst_byt *byt, struct sst_byt_stream *stream)
 
 	stream->commited = false;
 out:
+	spin_lock_irqsave(&sst->spinlock, flags);
 	list_del(&stream->node);
 	kfree(stream);
+	spin_unlock_irqrestore(&sst->spinlock, flags);
 
 	return ret;
 }
diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 50e4246d4b57..6c0b4f247a86 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1159,11 +1159,14 @@ struct sst_hsw_stream *sst_hsw_stream_new(struct sst_hsw *hsw, int id,
 	void *data)
 {
 	struct sst_hsw_stream *stream;
+	struct sst_dsp *sst = hsw->dsp;
+	unsigned long flags;
 
 	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
 	if (stream == NULL)
 		return NULL;
 
+	spin_lock_irqsave(&sst->spinlock, flags);
 	list_add(&stream->node, &hsw->stream_list);
 	stream->notify_position = notify_position;
 	stream->pdata = data;
@@ -1172,6 +1175,7 @@ struct sst_hsw_stream *sst_hsw_stream_new(struct sst_hsw *hsw, int id,
 
 	/* work to process notification messages */
 	INIT_WORK(&stream->notify_work, hsw_notification_work);
+	spin_unlock_irqrestore(&sst->spinlock, flags);
 
 	return stream;
 }
@@ -1180,6 +1184,8 @@ int sst_hsw_stream_free(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
 {
 	u32 header;
 	int ret = 0;
+	struct sst_dsp *sst = hsw->dsp;
+	unsigned long flags;
 
 	/* dont free DSP streams that are not commited */
 	if (!stream->commited)
@@ -1201,8 +1207,10 @@ int sst_hsw_stream_free(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
 	trace_hsw_stream_free_req(stream, &stream->free_req);
 
 out:
+	spin_lock_irqsave(&sst->spinlock, flags);
 	list_del(&stream->node);
 	kfree(stream);
+	spin_unlock_irqrestore(&sst->spinlock, flags);
 
 	return ret;
 }
-- 
1.9.2
