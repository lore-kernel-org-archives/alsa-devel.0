From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/7] ASoC: Intel: Simplify Baytrail stream
	control IPC construction
Date: Thu,  8 May 2014 16:07:22 +0300
Message-ID: <1399554447-16297-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FCE62652E1
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 15:08:25 +0200 (CEST)
In-Reply-To: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Baytrail ADSP stream IPC simplifies a little by moving IPC_IA_START_STREAM
construction and sending directly into sst_byt_stream_start() from
sst_byt_stream_operations(). This is because IPC_IA_START_STREAM is only
stream IPC with extra message data so this move saves a few code lines.

Main motivation for this is to prepare for passing stream start position
to sst_byt_stream_start() which will be needed in resume code.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-ipc.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index 0d31dbbf4806..69fdf5c70ea4 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -661,36 +661,32 @@ out:
 static int sst_byt_stream_operations(struct sst_byt *byt, int type,
 				     int stream_id, int wait)
 {
-	struct sst_byt_start_stream_params start_stream;
 	u64 header;
-	void *tx_msg = NULL;
-	size_t size = 0;
-
-	if (type != IPC_IA_START_STREAM) {
-		header = sst_byt_header(type, 0, false, stream_id);
-	} else {
-		start_stream.byte_offset = 0;
-		header = sst_byt_header(IPC_IA_START_STREAM,
-					sizeof(start_stream) + sizeof(u32),
-					true, stream_id);
-		tx_msg = &start_stream;
-		size = sizeof(start_stream);
-	}
 
+	header = sst_byt_header(type, 0, false, stream_id);
 	if (wait)
-		return sst_byt_ipc_tx_msg_wait(byt, header,
-					       tx_msg, size, NULL, 0);
+		return sst_byt_ipc_tx_msg_wait(byt, header, NULL, 0, NULL, 0);
 	else
-		return sst_byt_ipc_tx_msg_nowait(byt, header, tx_msg, size);
+		return sst_byt_ipc_tx_msg_nowait(byt, header, NULL, 0);
 }
 
 /* stream ALSA trigger operations */
 int sst_byt_stream_start(struct sst_byt *byt, struct sst_byt_stream *stream)
 {
+	struct sst_byt_start_stream_params start_stream;
+	void *tx_msg;
+	size_t size;
+	u64 header;
 	int ret;
 
-	ret = sst_byt_stream_operations(byt, IPC_IA_START_STREAM,
-					stream->str_id, 0);
+	start_stream.byte_offset = 0;
+	header = sst_byt_header(IPC_IA_START_STREAM,
+				sizeof(start_stream) + sizeof(u32),
+				true, stream->str_id);
+	tx_msg = &start_stream;
+	size = sizeof(start_stream);
+
+	ret = sst_byt_ipc_tx_msg_nowait(byt, header, tx_msg, size);
 	if (ret < 0)
 		dev_err(byt->dev, "ipc: error failed to start stream %d\n",
 			stream->str_id);
-- 
2.0.0.rc0
