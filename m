From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 08/19] ASoC: Intel: use common stream
	allocation method for compressed stream
Date: Fri, 13 Jun 2014 18:03:57 +0530
Message-ID: <1402662848-24534-9-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A9F20261A40
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:33:00 +0200 (CEST)
In-Reply-To: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

As added in previosu patch along with stream to piep conversion si required for
compressed audio too

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-compress.c |   11 ++++++++---
 sound/soc/intel/sst-mfld-platform.h          |    7 +++----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-compress.c b/sound/soc/intel/sst-mfld-platform-compress.c
index 02abd19..29c059c 100644
--- a/sound/soc/intel/sst-mfld-platform-compress.c
+++ b/sound/soc/intel/sst-mfld-platform-compress.c
@@ -100,14 +100,19 @@ static int sst_platform_compr_set_params(struct snd_compr_stream *cstream,
 	int retval;
 	struct snd_sst_params str_params;
 	struct sst_compress_cb cb;
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct sst_data *ctx = snd_soc_platform_get_drvdata(platform);
 
 	stream = cstream->runtime->private_data;
 	/* construct fw structure for this*/
 	memset(&str_params, 0, sizeof(str_params));
 
-	str_params.ops = STREAM_OPS_PLAYBACK;
-	str_params.stream_type = SST_STREAM_TYPE_MUSIC;
-	str_params.device_type = SND_SST_DEVICE_COMPRESS;
+	/* fill the device type and stream id to pass to SST driver */
+	retval = sst_fill_stream_params(cstream, ctx, &str_params, true);
+	pr_debug("compr_set_params: fill stream params ret_val = 0x%x\n", retval);
+	if (retval < 0)
+		return retval;
 
 	switch (params->codec.id) {
 	case SND_AUDIOCODEC_MP3: {
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 33891a8..9dc962f 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -149,8 +149,10 @@ struct sst_device {
 };
 
 struct sst_data;
-
 void sst_set_stream_status(struct sst_runtime_stream *stream, int state);
+int sst_fill_stream_params(void *substream, const struct sst_data *ctx,
+			   struct snd_sst_params *str_params, bool is_compress);
+
 struct sst_algo_int_control_v2 {
 	struct soc_mixer_control mc;
 	u16 module_id; /* module identifieer */
@@ -158,14 +160,11 @@ struct sst_algo_int_control_v2 {
 	u16 instance_id;
 	unsigned int value; /* Value received is stored here */
 };
-
 struct sst_data {
 	struct platform_device *pdev;
 	struct sst_platform_data *pdata;
 	struct mutex lock;
 };
-
 int sst_register_dsp(struct sst_device *sst);
 int sst_unregister_dsp(struct sst_device *sst);
-
 #endif
-- 
1.7.0.4
