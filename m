From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: Intel: Bsw: Read sst DSP DMA pointer
	after period elapse occurs
Date: Sun, 16 Aug 2015 23:12:25 -0700
Message-ID: <1439791945-106012-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CA6E026053D
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 08:13:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, dinesh.mirche@intel.com, denny.iriawan@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

We should not read sst hw_ptr and pcm_delay in sst_platform_pcm_pointer
Since it will be ricky if sst_platform_pcm_pointer is called while dsp
is updating the timestamp.Now read sst hw_ptr after period elapse
interrupt occurs.

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 683e501..d58230b 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -263,17 +263,27 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
 static void sst_period_elapsed(void *arg)
 {
 	struct snd_pcm_substream *substream = arg;
+	struct snd_soc_pcm_runtime *rtd;
 	struct sst_runtime_stream *stream;
+	struct pcm_stream_info *str_info;
 	int status;
+	int ret_val;
 
 	if (!substream || !substream->runtime)
 		return;
+	rtd = substream->private_data;
 	stream = substream->runtime->private_data;
 	if (!stream)
 		return;
 	status = sst_get_stream_status(stream);
 	if (status != SST_PLATFORM_RUNNING)
 		return;
+	str_info = &stream->stream_info;
+	ret_val = stream->ops->stream_read_tstamp(sst->dev, str_info);
+	if (ret_val) {
+		dev_err(rtd->dev, "sst: err code = %d\n", ret_val);
+		return;
+	}
 	snd_pcm_period_elapsed(substream);
 }
 
@@ -660,20 +670,14 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 			(struct snd_pcm_substream *substream)
 {
 	struct sst_runtime_stream *stream;
-	int ret_val, status;
+	int status;
 	struct pcm_stream_info *str_info;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
 	stream = substream->runtime->private_data;
 	status = sst_get_stream_status(stream);
 	if (status == SST_PLATFORM_INIT)
 		return 0;
 	str_info = &stream->stream_info;
-	ret_val = stream->ops->stream_read_tstamp(sst->dev, str_info);
-	if (ret_val) {
-		dev_err(rtd->dev, "sst: error code = %d\n", ret_val);
-		return ret_val;
-	}
 	substream->runtime->delay = str_info->pcm_delay;
 	return str_info->buffer_ptr;
 }
-- 
1.7.9.5
