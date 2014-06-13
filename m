From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 03/19] ASoC: Intel: mfld-pcm rename period
	callback arg
Date: Fri, 13 Jun 2014 18:03:52 +0530
Message-ID: <1402662848-24534-4-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0129D261737
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:32:51 +0200 (CEST)
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

The argument was called mad_substream which is no longer apt as older driver
is not used anymore so rename as arg

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |   10 +++++-----
 sound/soc/intel/sst-mfld-platform.h     |    4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 0d46005..4528946 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -192,9 +192,9 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream)
 	return ret_val;
 }
 
-static void sst_period_elapsed(void *mad_substream)
+static void sst_period_elapsed(void *arg)
 {
-	struct snd_pcm_substream *substream = mad_substream;
+	struct snd_pcm_substream *substream = arg;
 	struct sst_runtime_stream *stream;
 	int status;
 
@@ -218,7 +218,7 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 	pr_debug("setting buffer ptr param\n");
 	sst_set_stream_status(stream, SST_PLATFORM_INIT);
 	stream->stream_info.period_elapsed = sst_period_elapsed;
-	stream->stream_info.mad_substream = substream;
+	stream->stream_info.arg = substream;
 	stream->stream_info.buffer_ptr = 0;
 	stream->stream_info.sfreq = substream->runtime->rate;
 	ret_val = stream->ops->device_control(
@@ -255,7 +255,7 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 
 	stream->stream_info.str_id = 0;
 
-	stream->stream_info.mad_substream = substream;
+	stream->stream_info.arg = substream;
 	/* allocate memory for SST API set */
 	runtime->private_data = stream;
 
@@ -363,7 +363,7 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 		pr_debug("sst: Trigger Start\n");
 		str_cmd = SST_SND_START;
 		status = SST_PLATFORM_RUNNING;
-		stream->stream_info.mad_substream = substream;
+		stream->stream_info.arg = substream;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		pr_debug("sst: in stop\n");
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 6c5e7dc..6d929c7 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -39,8 +39,8 @@ extern struct sst_device *sst;
 
 struct pcm_stream_info {
 	int str_id;
-	void *mad_substream;
-	void (*period_elapsed) (void *mad_substream);
+	void *arg;
+	void (*period_elapsed) (void *arg);
 	unsigned long long buffer_ptr;
 	int sfreq;
 };
-- 
1.7.0.4
