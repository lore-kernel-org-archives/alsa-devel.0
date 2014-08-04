From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v4 07/12] ASoC: Intel: mfld-pcm: add control for
	powering up/down dsp
Date: Mon,  4 Aug 2014 15:15:58 +0530
Message-ID: <1407145563-1303-8-git-send-email-subhransu.s.prusty@intel.com>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B7DAC26087E
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 12:07:40 +0200 (CEST)
In-Reply-To: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
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

When we have PCM (FE/BE) opened or DAPM widgets triggered we need power up/down
DSP accordingly. The DSP will do ref count of these requests i.e. link these
runtime_get/put calls of DSP

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 14 ++++++++++++++
 sound/soc/intel/sst-mfld-platform.h     |  1 +
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index c71893ce3d93..60ee6ad4b626 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -292,6 +292,16 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 
 }
 
+static inline int power_up_sst(struct sst_runtime_stream *stream)
+{
+	return stream->ops->power(sst->dev, true);
+}
+
+static inline int power_down_sst(struct sst_runtime_stream *stream)
+{
+	return stream->ops->power(sst->dev, false);
+}
+
 static int sst_media_open(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
@@ -321,6 +331,8 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 	/* allocate memory for SST API set */
 	runtime->private_data = stream;
 
+	power_up_sst(stream);
+
 	/* Make sure, that the period size is always even */
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
 			   SNDRV_PCM_HW_PARAM_PERIODS, 2);
@@ -340,6 +352,8 @@ static void sst_media_close(struct snd_pcm_substream *substream,
 	int ret_val = 0, str_id;
 
 	stream = substream->runtime->private_data;
+	power_down_sst(stream);
+
 	str_id = stream->stream_info.str_id;
 	if (str_id)
 		ret_val = stream->ops->close(sst->dev, str_id);
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index faaba10c1dff..1f42b9ce5554 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -122,6 +122,7 @@ struct sst_ops {
 	int (*stream_read_tstamp) (struct device *dev, struct pcm_stream_info *str_info);
 	int (*send_byte_stream)(struct device *dev, struct snd_sst_bytes_v2 *bytes);
 	int (*close) (struct device *dev, unsigned int str_id);
+	int (*power)(struct device *dev, bool state);
 };
 
 struct sst_runtime_stream {
-- 
1.9.0
