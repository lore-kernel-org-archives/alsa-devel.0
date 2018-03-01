From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sst: Add sst_realloc_stream()
	function" to the asoc tree
Date: Thu, 01 Mar 2018 18:07:12 +0000
Message-ID: <E1erSbo-0005wc-2D@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C623267B53
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:07:14 +0100 (CET)
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

   ASoC: Intel: sst: Add sst_realloc_stream() function

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

>From 473858cad1ea3d4e6c287bad23961cd5fb7382d9 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 18 Feb 2018 23:01:42 +0100
Subject: [PATCH] ASoC: Intel: sst: Add sst_realloc_stream() function

Move the struct snd_sst_alloc_mrfld alloc parameters from the stack
into struct stream_info and add a new sst_realloc_stream() function which
can re-alloc a stream with the same parameters as before.

This is a preparation patch for fixing suspend/resume issues with some
SST / DSP firmware versions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst.h        |  3 ++
 sound/soc/intel/atom/sst/sst_stream.c | 88 +++++++++++++++++++++--------------
 2 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index f4fd442080b2..a357cd615b59 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -180,6 +180,7 @@ struct sst_block {
  * @status : stream current state
  * @prev : stream prev state
  * @lock : stream mutex for protecting state
+ * @alloc_param : parameters used for stream (re-)allocation
  * @pcm_substream : PCM substream
  * @period_elapsed : PCM period elapsed callback
  * @sfreq : stream sampling freq
@@ -189,6 +190,7 @@ struct stream_info {
 	unsigned int		status;
 	unsigned int		prev;
 	struct mutex		lock;
+	struct snd_sst_alloc_mrfld alloc_param;
 
 	void			*pcm_substream;
 	void (*period_elapsed)(void *pcm_substream);
@@ -429,6 +431,7 @@ struct intel_sst_ops {
 	void (*post_download)(struct intel_sst_drv *sst);
 };
 
+int sst_realloc_stream(struct intel_sst_drv *sst_drv_ctx, int str_id);
 int sst_pause_stream(struct intel_sst_drv *sst_drv_ctx, int id);
 int sst_resume_stream(struct intel_sst_drv *sst_drv_ctx, int id);
 int sst_drop_stream(struct intel_sst_drv *sst_drv_ctx, int id);
diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index 7cf5dd1993bc..fcedaa237505 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -35,29 +35,31 @@
 
 int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 {
-	struct snd_sst_alloc_mrfld alloc_param;
+	struct snd_pcm_params *pcm_params;
 	struct snd_sst_params *str_params;
 	struct snd_sst_tstamp fw_tstamp;
 	struct stream_info *str_info;
-	struct snd_sst_alloc_response *response;
-	unsigned int str_id, pipe_id, task_id;
-	int i, num_ch, ret = 0;
-	void *data = NULL;
+	int i, num_ch, str_id;
 
 	dev_dbg(sst_drv_ctx->dev, "Enter\n");
 
 	str_params = (struct snd_sst_params *)params;
-	memset(&alloc_param, 0, sizeof(alloc_param));
-	alloc_param.operation = str_params->ops;
-	alloc_param.codec_type = str_params->codec;
-	alloc_param.sg_count = str_params->aparams.sg_count;
-	alloc_param.ring_buf_info[0].addr =
+	str_id = str_params->stream_id;
+	str_info = get_stream_info(sst_drv_ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
+
+	memset(&str_info->alloc_param, 0, sizeof(str_info->alloc_param));
+	str_info->alloc_param.operation = str_params->ops;
+	str_info->alloc_param.codec_type = str_params->codec;
+	str_info->alloc_param.sg_count = str_params->aparams.sg_count;
+	str_info->alloc_param.ring_buf_info[0].addr =
 		str_params->aparams.ring_buf_info[0].addr;
-	alloc_param.ring_buf_info[0].size =
+	str_info->alloc_param.ring_buf_info[0].size =
 		str_params->aparams.ring_buf_info[0].size;
-	alloc_param.frag_size = str_params->aparams.frag_size;
+	str_info->alloc_param.frag_size = str_params->aparams.frag_size;
 
-	memcpy(&alloc_param.codec_params, &str_params->sparams,
+	memcpy(&str_info->alloc_param.codec_params, &str_params->sparams,
 			sizeof(struct snd_sst_stream_params));
 
 	/*
@@ -67,46 +69,62 @@ int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 	 * Currently hardcoding as per FW reqm.
 	 */
 	num_ch = sst_get_num_channel(str_params);
+	pcm_params = &str_info->alloc_param.codec_params.uc.pcm_params;
 	for (i = 0; i < 8; i++) {
 		if (i < num_ch)
-			alloc_param.codec_params.uc.pcm_params.channel_map[i] = i;
+			pcm_params->channel_map[i] = i;
 		else
-			alloc_param.codec_params.uc.pcm_params.channel_map[i] = 0xFF;
+			pcm_params->channel_map[i] = 0xff;
 	}
 
-	str_id = str_params->stream_id;
-	str_info = get_stream_info(sst_drv_ctx, str_id);
-	if (str_info == NULL) {
-		dev_err(sst_drv_ctx->dev, "get stream info returned null\n");
-		return -EINVAL;
-	}
-
-	pipe_id = str_params->device_type;
-	task_id = str_params->task;
 	sst_drv_ctx->streams[str_id].status = STREAM_INIT;
 	sst_drv_ctx->streams[str_id].prev = STREAM_UN_INIT;
-	sst_drv_ctx->streams[str_id].pipe_id = pipe_id;
-	sst_drv_ctx->streams[str_id].task_id = task_id;
+	sst_drv_ctx->streams[str_id].pipe_id = str_params->device_type;
+	sst_drv_ctx->streams[str_id].task_id = str_params->task;
 	sst_drv_ctx->streams[str_id].num_ch = num_ch;
 
 	if (sst_drv_ctx->info.lpe_viewpt_rqd)
-		alloc_param.ts = sst_drv_ctx->info.mailbox_start +
+		str_info->alloc_param.ts = sst_drv_ctx->info.mailbox_start +
 			sst_drv_ctx->tstamp + (str_id * sizeof(fw_tstamp));
 	else
-		alloc_param.ts = sst_drv_ctx->mailbox_add +
+		str_info->alloc_param.ts = sst_drv_ctx->mailbox_add +
 			sst_drv_ctx->tstamp + (str_id * sizeof(fw_tstamp));
 
 	dev_dbg(sst_drv_ctx->dev, "alloc tstamp location = 0x%x\n",
-			alloc_param.ts);
+			str_info->alloc_param.ts);
 	dev_dbg(sst_drv_ctx->dev, "assigned pipe id 0x%x to task %d\n",
-			pipe_id, task_id);
+			str_info->pipe_id, str_info->task_id);
+
+	return sst_realloc_stream(sst_drv_ctx, str_id);
+}
+
+/**
+ * sst_realloc_stream - Send msg for (re-)allocating a stream using the
+ * @sst_drv_ctx  intel_sst_drv context pointer
+ * @str_id:	 stream ID
+ *
+ * Send a msg for (re-)allocating a stream using the parameters previously
+ * passed to sst_alloc_stream_mrfld() for the same stream ID.
+ * Return: 0 or negative errno value.
+ */
+int sst_realloc_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
+{
+	struct snd_sst_alloc_response *response;
+	struct stream_info *str_info;
+	void *data = NULL;
+	int ret;
+
+	str_info = get_stream_info(sst_drv_ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
 
-	/* allocate device type context */
 	dev_dbg(sst_drv_ctx->dev, "Alloc for str %d pipe %#x\n",
-			str_id, pipe_id);
-	ret = sst_prepare_and_post_msg(sst_drv_ctx, task_id, IPC_CMD,
-			IPC_IA_ALLOC_STREAM_MRFLD, pipe_id, sizeof(alloc_param),
-			&alloc_param, &data, true, true, false, true);
+		str_id, str_info->pipe_id);
+
+	ret = sst_prepare_and_post_msg(sst_drv_ctx, str_info->task_id, IPC_CMD,
+			IPC_IA_ALLOC_STREAM_MRFLD, str_info->pipe_id,
+			sizeof(str_info->alloc_param), &str_info->alloc_param,
+			&data, true, true, false, true);
 
 	if (ret < 0) {
 		dev_err(sst_drv_ctx->dev, "FW alloc failed ret %d\n", ret);
-- 
2.16.2
