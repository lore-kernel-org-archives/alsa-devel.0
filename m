From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Add NULL checks for the stream
	pointer
Date: Tue,  6 Jan 2015 23:04:07 +0800
Message-ID: <1420556647-17270-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CEF382604FC
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 16:02:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

We should not send IPC stream commands to FW when the stream is
NULL, dereference the NULL pointer may also occur without precheck.
Here add NULL pointer checks for these stream APIs.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/sst-haswell-ipc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 57d6e89..3fd9838 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -1233,6 +1233,9 @@ int sst_hsw_stream_free(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
 	struct sst_dsp *sst = hsw->dsp;
 	unsigned long flags;
 
+	if (!stream)
+		return 0;
+
 	/* dont free DSP streams that are not commited */
 	if (!stream->commited)
 		goto out;
@@ -1420,6 +1423,9 @@ int sst_hsw_stream_commit(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
 	u32 header;
 	int ret;
 
+	if (stream->commited)
+		return 0;
+
 	trace_ipc_request("stream alloc", stream->host_id);
 
 	header = IPC_GLB_TYPE(IPC_GLB_ALLOCATE_STREAM);
@@ -1548,6 +1554,9 @@ int sst_hsw_stream_pause(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
 {
 	int ret;
 
+	if (!stream)
+		return 0;
+
 	trace_ipc_request("stream pause", stream->reply.stream_hw_id);
 
 	ret = sst_hsw_stream_operations(hsw, IPC_STR_PAUSE,
@@ -1564,6 +1573,9 @@ int sst_hsw_stream_resume(struct sst_hsw *hsw, struct sst_hsw_stream *stream,
 {
 	int ret;
 
+	if (!stream)
+		return 0;
+
 	trace_ipc_request("stream resume", stream->reply.stream_hw_id);
 
 	ret = sst_hsw_stream_operations(hsw, IPC_STR_RESUME,
@@ -1579,6 +1591,9 @@ int sst_hsw_stream_reset(struct sst_hsw *hsw, struct sst_hsw_stream *stream)
 {
 	int ret, tries = 10;
 
+	if (!stream)
+		return 0;
+
 	/* dont reset streams that are not commited */
 	if (!stream->commited)
 		return 0;
-- 
1.9.1
