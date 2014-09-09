From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v6 04/10] ASoC: Intel: mfld-pcm: add control
	for powering up/down dsp
Date: Tue,  9 Sep 2014 15:11:27 +0530
Message-ID: <1410255693-6958-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 70F95265087
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 12:04:26 +0200 (CEST)
In-Reply-To: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

When we have PCM (FE/BE) opened or DAPM widgets triggered we need power
up/down DSP accordingly. The DSP will do ref count of these requests
i.e. link these runtime_get/put calls of DSP

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 16 ++++++++++++++++
 sound/soc/intel/sst-mfld-platform.h     |  1 +
 2 files changed, 17 insertions(+)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 9906b7c..6f5edd6 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -322,6 +322,16 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 
 }
 
+static int power_up_sst(struct sst_runtime_stream *stream)
+{
+	return stream->ops->power(sst->dev, true);
+}
+
+static void power_down_sst(struct sst_runtime_stream *stream)
+{
+	stream->ops->power(sst->dev, false);
+}
+
 static int sst_media_open(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -351,6 +361,10 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 	/* allocate memory for SST API set */
 	runtime->private_data = stream;
 
+	ret_val = power_up_sst(stream);
+	if (ret_val < 0)
+		return ret_val;
+
 	/* Make sure, that the period size is always even */
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
 			   SNDRV_PCM_HW_PARAM_PERIODS, 2);
@@ -370,6 +384,8 @@ static void sst_media_close(struct snd_pcm_substream *substream,
 	int ret_val = 0, str_id;
 
 	stream = substream->runtime->private_data;
+	power_down_sst(stream);
+
 	str_id = stream->stream_info.str_id;
 	if (str_id)
 		ret_val = stream->ops->close(sst->dev, str_id);
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 7092ee3..bf2b6d4 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -129,6 +129,7 @@ struct sst_ops {
 	int (*stream_read_tstamp) (struct device *dev, struct pcm_stream_info *str_info);
 	int (*send_byte_stream)(struct device *dev, struct snd_sst_bytes_v2 *bytes);
 	int (*close) (struct device *dev, unsigned int str_id);
+	int (*power)(struct device *dev, bool state);
 };
 
 struct sst_runtime_stream {
-- 
1.9.0
