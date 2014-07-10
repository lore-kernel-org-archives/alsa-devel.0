From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 09/13] ASoC: Intel: mfld-pcm: add control
	for powering up/down dsp
Date: Thu, 10 Jul 2014 10:14:53 +0530
Message-ID: <1404967497-22537-10-git-send-email-subhransu.s.prusty@intel.com>
References: <1404967497-22537-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CE6DA2651F2
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 07:06:37 +0200 (CEST)
In-Reply-To: <1404967497-22537-1-git-send-email-subhransu.s.prusty@intel.com>
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
index eed4d2f080f6..2fb079c6a931 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -292,6 +292,16 @@ static int sst_platform_init_stream(struct snd_pcm_substream *substream)
 	return ret_val;
 
 }
+
+static inline int power_up_sst(struct sst_runtime_stream *sst)
+{
+	return sst->ops->power(true);
+}
+
+static inline int power_down_sst(struct sst_runtime_stream *sst)
+{
+	return sst->ops->power(false);
+}
 /* end -- helper functions */
 
 static int sst_media_open(struct snd_pcm_substream *substream,
@@ -323,6 +333,8 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 	/* allocate memory for SST API set */
 	runtime->private_data = stream;
 
+	power_up_sst(stream);
+
 	/* Make sure, that the period size is always even */
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
 			   SNDRV_PCM_HW_PARAM_PERIODS, 2);
@@ -342,6 +354,8 @@ static void sst_media_close(struct snd_pcm_substream *substream,
 	int ret_val = 0, str_id;
 
 	stream = substream->runtime->private_data;
+	power_down_sst(stream);
+
 	str_id = stream->stream_info.str_id;
 	if (str_id)
 		ret_val = stream->ops->close(str_id);
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index fc703d8c1485..1dc6092c189d 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -134,6 +134,7 @@ struct sst_ops {
 	int (*device_control) (int cmd, void *arg);
 	int (*set_generic_params)(enum sst_controls cmd, void *arg);
 	int (*close) (unsigned int str_id);
+	int (*power)(bool state);
 };
 
 struct sst_runtime_stream {
-- 
1.9.0
