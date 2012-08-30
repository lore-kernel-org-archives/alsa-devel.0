From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 3/3] ASoC: mid-x86 - implement buffer query in
	sst_platform driver
Date: Fri, 31 Aug 2012 00:42:38 +0530
Message-ID: <1346353958-7746-4-git-send-email-vinod.koul@linux.intel.com>
References: <1346353958-7746-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 39E822662CA
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 21:05:40 +0200 (CEST)
In-Reply-To: <1346353958-7746-1-git-send-email-vinod.koul@linux.intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/soc/mid-x86/sst_platform.c |   23 +++++++++++++++++++++++
 sound/soc/mid-x86/sst_platform.h |    4 +++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index a263cbe..ec8773f 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -424,6 +424,28 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
 	return stream->stream_info.buffer_ptr;
 }
 
+static snd_pcm_sframes_t sst_platform_pcm_buffer(
+		struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct sst_runtime_stream *stream;
+	int ret_val, status;
+	struct pcm_stream_info *str_info;
+
+	stream = substream->runtime->private_data;
+	status = sst_get_stream_status(stream);
+	if (status == SST_PLATFORM_INIT)
+		return 0;
+	str_info = &stream->stream_info;
+	ret_val = stream->ops->device_control(
+				SST_SND_BUFFER_DELTA, str_info);
+	if (ret_val) {
+		pr_err("sst: error code = %d\n", ret_val);
+		return ret_val;
+	}
+	return stream->stream_info.buffer_delta;
+}
+
 static int sst_platform_pcm_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
@@ -669,6 +691,7 @@ static struct snd_soc_platform_driver sst_soc_platform_drv = {
 	.compr_ops	= &sst_platform_compr_ops,
 	.pcm_new	= sst_pcm_new,
 	.pcm_free	= sst_pcm_free,
+	.buffer		= sst_platform_pcm_buffer,
 };
 
 static int sst_platform_probe(struct platform_device *pdev)
diff --git a/sound/soc/mid-x86/sst_platform.h b/sound/soc/mid-x86/sst_platform.h
index d61c5d5..300b45f 100644
--- a/sound/soc/mid-x86/sst_platform.h
+++ b/sound/soc/mid-x86/sst_platform.h
@@ -50,6 +50,7 @@ struct pcm_stream_info {
 	void *mad_substream;
 	void (*period_elapsed) (void *mad_substream);
 	unsigned long long buffer_ptr;
+	unsigned long long buffer_delta;
 	int sfreq;
 };
 
@@ -70,7 +71,8 @@ enum sst_controls {
 	SST_SND_BUFFER_POINTER =	0x05,
 	SST_SND_STREAM_INIT =		0x06,
 	SST_SND_START	 =		0x07,
-	SST_MAX_CONTROLS =		0x07,
+	SST_SND_BUFFER_DELTA =		0x08,
+	SST_MAX_CONTROLS =		0x08,
 };
 
 enum sst_stream_ops {
-- 
1.7.9.5
