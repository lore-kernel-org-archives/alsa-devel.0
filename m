From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: Intel: atom: Make some messages to debug
	level
Date: Mon, 28 Nov 2016 16:26:40 +0100
Message-ID: <20161128152640.29566-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DFDA266E65
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 16:26:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Intel sst driver spews lots of kernel messages in INFO level;
typically, it gives a kernel message at each time it allocates or
frees a stream, or at each time when a stream is started or stopped.
This will piles up quickly, and it's almost useless for normal users,
so let's hide them to KERN_DEBUG level.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 sound/soc/intel/atom/sst/sst_stream.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 0838478c4c3f..c7b3cbf92faf 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -937,7 +937,7 @@ int send_ssp_cmd(struct snd_soc_dai *dai, const char *id, bool enable)
 	struct sst_data *drv = snd_soc_dai_get_drvdata(dai);
 	int ssp_id;
 
-	dev_info(dai->dev, "Enter: enable=%d port_name=%s\n", enable, id);
+	dev_dbg(dai->dev, "Enter: enable=%d port_name=%s\n", enable, id);
 
 	if (strcmp(id, "ssp0-port") == 0)
 		ssp_id = SSP_MODEM;
diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index 4ccc80e5e8cc..51bdeeecb7c8 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -104,7 +104,7 @@ int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 	sst_init_stream(&sst_drv_ctx->streams[str_id], alloc_param.codec_type,
 			str_id, alloc_param.operation, 0);
 
-	dev_info(sst_drv_ctx->dev, "Alloc for str %d pipe %#x\n",
+	dev_dbg(sst_drv_ctx->dev, "Alloc for str %d pipe %#x\n",
 			str_id, pipe_id);
 	ret = sst_prepare_and_post_msg(sst_drv_ctx, task_id, IPC_CMD,
 			IPC_IA_ALLOC_STREAM_MRFLD, pipe_id, sizeof(alloc_param),
@@ -415,7 +415,7 @@ int sst_free_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
 		str_info->status = STREAM_UN_INIT;
 		mutex_unlock(&str_info->lock);
 
-		dev_info(sst_drv_ctx->dev, "Free for str %d pipe %#x\n",
+		dev_dbg(sst_drv_ctx->dev, "Free for str %d pipe %#x\n",
 				str_id, str_info->pipe_id);
 		retval = sst_prepare_and_post_msg(sst_drv_ctx, str_info->task_id, IPC_CMD,
 				IPC_IA_FREE_STREAM_MRFLD, str_info->pipe_id, 0,
-- 
2.10.2
