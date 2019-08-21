From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 5/5] ASoC: SOF: Intel: add support for SoundWire suspend/resume
Date: Wed, 21 Aug 2019 15:17:20 -0500
Message-ID: <20190821201720.17768-6-pierre-louis.bossart@linux.intel.com>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, YueHaibing <yuehaibing@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, Pan Xiuli <xiuli.pan@linux.intel.com>, Fred Oh <fr>
List-Id: alsa-devel@alsa-project.org

Somehow the core0 needs to be on to set-up the interrupts and power-up
the SoundWire IP.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 11 +++++++++++
 sound/soc/sof/intel/hda.c     |  2 +-
 sound/soc/sof/intel/hda.h     |  5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index fb55a3c5afd0..e1ade59ac6e1 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -374,6 +374,17 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 	hda_dsp_ctrl_ppcap_enable(sdev, true);
 	hda_dsp_ctrl_ppcap_int_enable(sdev, true);
 
+#if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)
+	/* need to power-up core before setting-up capabilities */
+	ret = hda_dsp_core_power_up(sdev, HDA_DSP_CORE_MASK(0));
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: could not power-up DSP subsystem\n");
+		return ret;
+	}
+
+	hda_sdw_int_enable(sdev, true);
+#endif
+
 	return 0;
 }
 
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 1e84ea9e6fce..09aa0cfa6099 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -39,7 +39,7 @@
 
 #if IS_ENABLED(CONFIG_SOUNDWIRE_INTEL)
 
-static void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
+void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
 {
 	if (enable)
 		snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR,
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 48e09b7daf0a..de71c92b2f39 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -591,6 +591,11 @@ int hda_dsp_trace_init(struct snd_sof_dev *sdev, u32 *stream_tag);
 int hda_dsp_trace_release(struct snd_sof_dev *sdev);
 int hda_dsp_trace_trigger(struct snd_sof_dev *sdev, int cmd);
 
+/*
+ * SoundWire support
+ */
+void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable);
+
 /* common dai driver */
 extern struct snd_soc_dai_driver skl_dai[];
 
-- 
2.20.1
