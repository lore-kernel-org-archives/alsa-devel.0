From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 1/3] Revert "ASoC: Intel: rename pcm dias to
	media dai"
Date: Thu, 15 May 2014 21:38:15 +0530
Message-ID: <1400170097-7653-2-git-send-email-vinod.koul@intel.com>
References: <1400170097-7653-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 26E33261B11
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 18:23:27 +0200 (CEST)
In-Reply-To: <1400170097-7653-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This reverts commit 0cac6fc3eb5218fe40d1c2910abc643ab21d9f19.
This comiit was dropped from rev2 and would not be required as it renames the
platform ops as well which is not required.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |   38 +++++++++++++++---------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 72d0fae..d0bc328 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -95,7 +95,7 @@ static struct snd_pcm_hardware sst_platform_pcm_hw = {
 /* MFLD - MSIC */
 static struct snd_soc_dai_driver sst_platform_dai[] = {
 {
-	.name = "media-cpu-dai",
+	.name = "Headset-cpu-dai",
 	.id = 0,
 	.playback = {
 		.channels_min = SST_STEREO,
@@ -231,13 +231,13 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 }
 /* end -- helper functions */
 
-static int sst_platform_media_open(struct snd_pcm_substream *substream)
+static int sst_platform_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct sst_runtime_stream *stream;
 	int ret_val;
 
-	pr_debug("sst_platform_media_open called\n");
+	pr_debug("sst_platform_open called\n");
 
 	snd_soc_set_runtime_hwparams(substream, &sst_platform_pcm_hw);
 	ret_val = snd_pcm_hw_constraint_integer(runtime,
@@ -275,12 +275,12 @@ static int sst_platform_media_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int sst_platform_media_close(struct snd_pcm_substream *substream)
+static int sst_platform_close(struct snd_pcm_substream *substream)
 {
 	struct sst_runtime_stream *stream;
 	int ret_val = 0, str_id;
 
-	pr_debug("sst_platform_media_close called\n");
+	pr_debug("sst_platform_close called\n");
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (str_id)
@@ -290,12 +290,12 @@ static int sst_platform_media_close(struct snd_pcm_substream *substream)
 	return ret_val;
 }
 
-static int sst_platform_pcm_media_prepare(struct snd_pcm_substream *substream)
+static int sst_platform_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct sst_runtime_stream *stream;
 	int ret_val = 0, str_id;
 
-	pr_debug("sst_platform_pcm_media_prepare called\n");
+	pr_debug("sst_platform_pcm_prepare called\n");
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	if (stream->stream_info.str_id) {
@@ -317,14 +317,14 @@ static int sst_platform_pcm_media_prepare(struct snd_pcm_substream *substream)
 	return ret_val;
 }
 
-static int sst_platform_pcm_media_trigger(struct snd_pcm_substream *substream,
+static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
 	int ret_val = 0, str_id;
 	struct sst_runtime_stream *stream;
 	int str_cmd, status;
 
-	pr_debug("sst_platform_pcm_media_trigger called\n");
+	pr_debug("sst_platform_pcm_trigger called\n");
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	switch (cmd) {
@@ -360,7 +360,7 @@ static int sst_platform_pcm_media_trigger(struct snd_pcm_substream *substream,
 }
 
 
-static snd_pcm_uframes_t sst_platform_pcm_media_pointer
+static snd_pcm_uframes_t sst_platform_pcm_pointer
 			(struct snd_pcm_substream *substream)
 {
 	struct sst_runtime_stream *stream;
@@ -381,7 +381,7 @@ static snd_pcm_uframes_t sst_platform_pcm_media_pointer
 	return stream->stream_info.buffer_ptr;
 }
 
-static int sst_platform_pcm_media_hw_params(struct snd_pcm_substream *substream,
+static int sst_platform_pcm_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
 	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
@@ -390,20 +390,20 @@ static int sst_platform_pcm_media_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int sst_platform_pcm_media_hw_free(struct snd_pcm_substream *substream)
+static int sst_platform_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	return snd_pcm_lib_free_pages(substream);
 }
 
 static struct snd_pcm_ops sst_platform_ops = {
-	.open = sst_platform_media_open,
-	.close = sst_platform_media_close,
+	.open = sst_platform_open,
+	.close = sst_platform_close,
 	.ioctl = snd_pcm_lib_ioctl,
-	.prepare = sst_platform_pcm_media_prepare,
-	.trigger = sst_platform_pcm_media_trigger,
-	.pointer = sst_platform_pcm_media_pointer,
-	.hw_params = sst_platform_pcm_media_hw_params,
-	.hw_free = sst_platform_pcm_media_hw_free,
+	.prepare = sst_platform_pcm_prepare,
+	.trigger = sst_platform_pcm_trigger,
+	.pointer = sst_platform_pcm_pointer,
+	.hw_params = sst_platform_pcm_hw_params,
+	.hw_free = sst_platform_pcm_hw_free,
 };
 
 static void sst_pcm_free(struct snd_pcm *pcm)
-- 
1.7.0.4
