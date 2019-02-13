From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 12/20] ASoC: SOF: Intel: Add Intel specific
	HDA trace operations
Date: Wed, 13 Feb 2019 16:08:39 -0600
Message-ID: <20190213220847.10567-13-pierre-louis.bossart@linux.intel.com>
References: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add trace operations for Intel based HDA DSPs

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-trace.c | 98 +++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 sound/soc/sof/intel/hda-trace.c

diff --git a/sound/soc/sof/intel/hda-trace.c b/sound/soc/sof/intel/hda-trace.c
new file mode 100644
index 000000000000..6fd77d511118
--- /dev/null
+++ b/sound/soc/sof/intel/hda-trace.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Authors: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//	    Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
+//	    Rander Wang <rander.wang@intel.com>
+//          Keyon Jie <yang.jie@linux.intel.com>
+//
+
+/*
+ * Hardware interface for generic Intel audio DSP HDA IP
+ */
+
+#include <sound/hdaudio_ext.h>
+#include "../ops.h"
+#include "hda.h"
+
+static int hda_dsp_trace_prepare(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hda =
+		(struct sof_intel_hda_dev *)sdev->pdata->hw_pdata;
+	struct hdac_ext_stream *stream = hda->dtrace_stream;
+	struct hdac_stream *hstream = &stream->hstream;
+	struct snd_dma_buffer *dmab = &sdev->dmatb;
+	int ret;
+
+	hstream->period_bytes = 0;/* initialize period_bytes */
+	hstream->bufsize = sdev->dmatb.bytes;
+
+	ret = hda_dsp_stream_hw_params(sdev, stream, dmab, NULL);
+	if (ret < 0)
+		dev_err(sdev->dev, "error: hdac prepare failed: %x\n", ret);
+
+	return ret;
+}
+
+int hda_dsp_trace_init(struct snd_sof_dev *sdev, u32 *stream_tag)
+{
+	struct sof_intel_hda_dev *hda =
+		(struct sof_intel_hda_dev *)sdev->pdata->hw_pdata;
+	int ret;
+
+	hda->dtrace_stream = hda_dsp_stream_get(sdev,
+						SNDRV_PCM_STREAM_CAPTURE);
+
+	if (!hda->dtrace_stream) {
+		dev_err(sdev->dev,
+			"error: no available capture stream for DMA trace\n");
+		return -ENODEV;
+	}
+
+	*stream_tag = hda->dtrace_stream->hstream.stream_tag;
+
+	/*
+	 * initialize capture stream, set BDL address and return corresponding
+	 * stream tag which will be sent to the firmware by IPC message.
+	 */
+	ret = hda_dsp_trace_prepare(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: hdac trace init failed: %x\n", ret);
+		hda_dsp_stream_put(sdev, SNDRV_PCM_STREAM_CAPTURE, *stream_tag);
+		hda->dtrace_stream = NULL;
+		*stream_tag = 0;
+	}
+
+	return ret;
+}
+
+int hda_dsp_trace_release(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hda =
+		(struct sof_intel_hda_dev *)sdev->pdata->hw_pdata;
+	struct hdac_stream *hstream;
+
+	if (hda->dtrace_stream) {
+		hstream = &hda->dtrace_stream->hstream;
+		hda_dsp_stream_put(sdev,
+				   SNDRV_PCM_STREAM_CAPTURE,
+				   hstream->stream_tag);
+		hda->dtrace_stream = NULL;
+		return 0;
+	}
+
+	dev_dbg(sdev->dev, "DMA trace stream is not opened!\n");
+	return -ENODEV;
+}
+
+int hda_dsp_trace_trigger(struct snd_sof_dev *sdev, int cmd)
+{
+	struct sof_intel_hda_dev *hda =
+		(struct sof_intel_hda_dev *)sdev->pdata->hw_pdata;
+
+	return hda_dsp_stream_trigger(sdev, hda->dtrace_stream, cmd);
+}
-- 
2.17.1
