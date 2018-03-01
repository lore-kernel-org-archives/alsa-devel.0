From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: Remove unnecessary
	sst_init_stream() function" to the asoc tree
Date: Thu, 01 Mar 2018 18:07:16 +0000
Message-ID: <E1erSbs-0005y6-EB@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B5AD4267B5D
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:07:18 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sst: Remove unnecessary sst_init_stream() function

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 8cf732bbd8d6bc9a28ac48c7bac0ccc9f55cb151 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 18 Feb 2018 23:01:40 +0100
Subject: [PATCH] ASoC: Intel: sst: Remove unnecessary sst_init_stream()
 function

sst_init_stream() has only one caller and all its function arguments are
unused. Inline it on the one call site and remove it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.h        | 2 --
 sound/soc/intel/atom/sst/sst_pvt.c    | 7 -------
 sound/soc/intel/atom/sst/sst_stream.c | 5 ++---
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 1f3107909044..164b0f674c20 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -494,8 +494,6 @@ int sst_prepare_and_post_msg(struct intel_sst_drv *sst,
 
 void sst_process_pending_msg(struct work_struct *work);
 int sst_assign_pvt_id(struct intel_sst_drv *sst_drv_ctx);
-void sst_init_stream(struct stream_info *stream,
-		int codec, int sst_id, int ops, u8 slot);
 int sst_validate_strid(struct intel_sst_drv *sst_drv_ctx, int str_id);
 struct stream_info *get_stream_info(struct intel_sst_drv *sst_drv_ctx,
 		int str_id);
diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index d7d38b0f68db..af93244b4868 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -360,13 +360,6 @@ int sst_assign_pvt_id(struct intel_sst_drv *drv)
 	return local;
 }
 
-void sst_init_stream(struct stream_info *stream,
-		int codec, int sst_id, int ops, u8 slot)
-{
-	stream->status = STREAM_INIT;
-	stream->prev = STREAM_UN_INIT;
-}
-
 int sst_validate_strid(
 		struct intel_sst_drv *sst_drv_ctx, int str_id)
 {
diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index b082b0922a7a..7cf5dd1993bc 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -83,6 +83,8 @@ int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 
 	pipe_id = str_params->device_type;
 	task_id = str_params->task;
+	sst_drv_ctx->streams[str_id].status = STREAM_INIT;
+	sst_drv_ctx->streams[str_id].prev = STREAM_UN_INIT;
 	sst_drv_ctx->streams[str_id].pipe_id = pipe_id;
 	sst_drv_ctx->streams[str_id].task_id = task_id;
 	sst_drv_ctx->streams[str_id].num_ch = num_ch;
@@ -100,9 +102,6 @@ int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 			pipe_id, task_id);
 
 	/* allocate device type context */
-	sst_init_stream(&sst_drv_ctx->streams[str_id], alloc_param.codec_type,
-			str_id, alloc_param.operation, 0);
-
 	dev_dbg(sst_drv_ctx->dev, "Alloc for str %d pipe %#x\n",
 			str_id, pipe_id);
 	ret = sst_prepare_and_post_msg(sst_drv_ctx, task_id, IPC_CMD,
-- 
2.16.2
