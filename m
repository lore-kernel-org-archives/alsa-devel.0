From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: atom: Make some messages to
	debug level" to the asoc tree
Date: Tue, 29 Nov 2016 11:45:09 +0000
Message-ID: <E1cBgqT-0004MQ-2Z@debutante>
References: <20161128152640.29566-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 434F1267094
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 12:45:19 +0100 (CET)
In-Reply-To: <20161128152640.29566-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: atom: Make some messages to debug level

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 91197a9230e852eeefdb79b1bddc3cd9505d4248 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 28 Nov 2016 16:26:40 +0100
Subject: [PATCH] ASoC: Intel: atom: Make some messages to debug level

Intel sst driver spews lots of kernel messages in INFO level;
typically, it gives a kernel message at each time it allocates or
frees a stream, or at each time when a stream is started or stopped.
This will piles up quickly, and it's almost useless for normal users,
so let's hide them to KERN_DEBUG level.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
