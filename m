From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 3/7] ASoC: Intel: Pass stream start position to
	sst_byt_stream_start()
Date: Thu,  8 May 2014 16:07:23 +0300
Message-ID: <1399554447-16297-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1984426546F
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

Stream start position will be needed in resume code. Prepare for it by
adding start offset argument to sst_byt_stream_start().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-ipc.c | 5 +++--
 sound/soc/intel/sst-baytrail-ipc.h | 3 ++-
 sound/soc/intel/sst-baytrail-pcm.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index 69fdf5c70ea4..8941ff2f4b78 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -671,7 +671,8 @@ static int sst_byt_stream_operations(struct sst_byt *byt, int type,
 }
 
 /* stream ALSA trigger operations */
-int sst_byt_stream_start(struct sst_byt *byt, struct sst_byt_stream *stream)
+int sst_byt_stream_start(struct sst_byt *byt, struct sst_byt_stream *stream,
+			 u32 start_offset)
 {
 	struct sst_byt_start_stream_params start_stream;
 	void *tx_msg;
@@ -679,7 +680,7 @@ int sst_byt_stream_start(struct sst_byt *byt, struct sst_byt_stream *stream)
 	u64 header;
 	int ret;
 
-	start_stream.byte_offset = 0;
+	start_stream.byte_offset = start_offset;
 	header = sst_byt_header(IPC_IA_START_STREAM,
 				sizeof(start_stream) + sizeof(u32),
 				true, stream->str_id);
diff --git a/sound/soc/intel/sst-baytrail-ipc.h b/sound/soc/intel/sst-baytrail-ipc.h
index f172b6440fa9..b643d9892f60 100644
--- a/sound/soc/intel/sst-baytrail-ipc.h
+++ b/sound/soc/intel/sst-baytrail-ipc.h
@@ -53,7 +53,8 @@ int sst_byt_stream_commit(struct sst_byt *byt, struct sst_byt_stream *stream);
 int sst_byt_stream_free(struct sst_byt *byt, struct sst_byt_stream *stream);
 
 /* stream ALSA trigger operations */
-int sst_byt_stream_start(struct sst_byt *byt, struct sst_byt_stream *stream);
+int sst_byt_stream_start(struct sst_byt *byt, struct sst_byt_stream *stream,
+			 u32 start_offset);
 int sst_byt_stream_stop(struct sst_byt *byt, struct sst_byt_stream *stream);
 int sst_byt_stream_pause(struct sst_byt *byt, struct sst_byt_stream *stream);
 int sst_byt_stream_resume(struct sst_byt *byt, struct sst_byt_stream *stream);
diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index b8a89e9f753d..e2c2540ffff4 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -145,7 +145,7 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		sst_byt_stream_start(byt, pcm_data->stream);
+		sst_byt_stream_start(byt, pcm_data->stream, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-- 
2.0.0.rc0
