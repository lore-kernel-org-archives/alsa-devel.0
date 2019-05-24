From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/5] ASoC: SOF: force end-of-file for debugfs
	trace at suspend
Date: Fri, 24 May 2019 14:23:06 -0500
Message-ID: <20190524192309.6359-3-pierre-louis.bossart@linux.intel.com>
References: <20190524192309.6359-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91FC3F8962F
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 21:23:20 +0200 (CEST)
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

Current trace implementation gets out of sync when sof device
is put to suspend. The debugfs file handle is kept open, but
firmware will reset its state. After resume, debugfs client's
read offset will not be synchronized to firmware and this may
result in traces read in incorrect order and/or stale data being
read after resume.

Add logic to signal end-of-file to read() when firmware tracing
has ended, and all trace data has been read. This allows debugfs
client to capture all trace data, and reopen the trace file to
ensure proper synchronization with firmware after reopening
the node.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-priv.h |  2 ++
 sound/soc/sof/trace.c    | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 1e85d6f9c5c3..01a6219c326b 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -417,6 +417,8 @@ struct snd_sof_dev {
 	u32 host_offset;
 	u32 dtrace_is_enabled;
 	u32 dtrace_error;
+	u32 dtrace_draining;
+
 	u32 msi_enabled;
 
 	void *private;			/* core does not touch this */
diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
index a2d89d295f0f..b02520f8e595 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -43,6 +43,15 @@ static size_t sof_wait_trace_avail(struct snd_sof_dev *sdev,
 	if (ret)
 		return ret;
 
+	if (!sdev->dtrace_is_enabled && sdev->dtrace_draining) {
+		/*
+		 * tracing has ended and all traces have been
+		 * read by client, return EOF
+		 */
+		sdev->dtrace_draining = false;
+		return 0;
+	}
+
 	/* wait for available trace data from FW */
 	init_waitqueue_entry(&wait, current);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -104,10 +113,23 @@ static ssize_t sof_dfsentry_trace_read(struct file *file, char __user *buffer,
 	return count;
 }
 
+static int sof_dfsentry_trace_release(struct inode *inode, struct file *file)
+{
+	struct snd_sof_dfsentry *dfse = inode->i_private;
+	struct snd_sof_dev *sdev = dfse->sdev;
+
+	/* avoid duplicate traces at next open */
+	if (!sdev->dtrace_is_enabled)
+		sdev->host_offset = 0;
+
+	return 0;
+}
+
 static const struct file_operations sof_dfs_trace_fops = {
 	.open = simple_open,
 	.read = sof_dfsentry_trace_read,
 	.llseek = default_llseek,
+	.release = sof_dfsentry_trace_release,
 };
 
 static int trace_debugfs_create(struct snd_sof_dev *sdev)
@@ -155,6 +177,7 @@ int snd_sof_init_trace_ipc(struct snd_sof_dev *sdev)
 	params.stream_tag = 0;
 
 	sdev->host_offset = 0;
+	sdev->dtrace_draining = false;
 
 	ret = snd_sof_dma_trace_init(sdev, &params.stream_tag);
 	if (ret < 0) {
@@ -291,6 +314,8 @@ void snd_sof_release_trace(struct snd_sof_dev *sdev)
 			"error: fail in snd_sof_dma_trace_release %d\n", ret);
 
 	sdev->dtrace_is_enabled = false;
+	sdev->dtrace_draining = true;
+	wake_up(&sdev->trace_sleep);
 }
 EXPORT_SYMBOL(snd_sof_release_trace);
 
-- 
2.20.1
