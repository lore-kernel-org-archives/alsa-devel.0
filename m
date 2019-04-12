From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v5 03/21] ASoC: SOF: Intel: Add legacy IPC
	support
Date: Fri, 12 Apr 2019 11:08:46 -0500
Message-ID: <20190412160904.30418-4-pierre-louis.bossart@linux.intel.com>
References: <20190412160904.30418-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190412160904.30418-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, Alan Cox <alan@linux.intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Add IPC support required for devices introduced before Skylake
(Merrifield, baytrail, CherryTrail, Haswell, Broadwell)

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/intel-ipc.c | 92 +++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 sound/soc/sof/intel/intel-ipc.c

diff --git a/sound/soc/sof/intel/intel-ipc.c b/sound/soc/sof/intel/intel-ipc.c
new file mode 100644
index 000000000000..4edd92151fd5
--- /dev/null
+++ b/sound/soc/sof/intel/intel-ipc.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2019 Intel Corporation. All rights reserved.
+//
+// Authors: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
+
+/* Intel-specific SOF IPC code */
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <sound/pcm.h>
+#include <sound/sof/stream.h>
+
+#include "../ops.h"
+#include "../sof-priv.h"
+
+struct intel_stream {
+	size_t posn_offset;
+};
+
+/* Mailbox-based Intel IPC implementation */
+void intel_ipc_msg_data(struct snd_sof_dev *sdev,
+			struct snd_pcm_substream *substream,
+			void *p, size_t sz)
+{
+	if (!substream || !sdev->stream_box.size) {
+		sof_mailbox_read(sdev, sdev->dsp_box.offset, p, sz);
+	} else {
+		struct intel_stream *stream = substream->runtime->private_data;
+
+		/* The stream might already be closed */
+		if (stream)
+			sof_mailbox_read(sdev, stream->posn_offset, p, sz);
+	}
+}
+EXPORT_SYMBOL(intel_ipc_msg_data);
+
+int intel_ipc_pcm_params(struct snd_sof_dev *sdev,
+			 struct snd_pcm_substream *substream,
+			 const struct sof_ipc_pcm_params_reply *reply)
+{
+	struct intel_stream *stream = substream->runtime->private_data;
+	size_t posn_offset = reply->posn_offset;
+
+	/* check if offset is overflow or it is not aligned */
+	if (posn_offset > sdev->stream_box.size ||
+	    posn_offset % sizeof(struct sof_ipc_stream_posn) != 0)
+		return -EINVAL;
+
+	stream->posn_offset = sdev->stream_box.offset + posn_offset;
+
+	dev_dbg(sdev->dev, "pcm: stream dir %d, posn mailbox offset is %zu",
+		substream->stream, stream->posn_offset);
+
+	return 0;
+}
+EXPORT_SYMBOL(intel_ipc_pcm_params);
+
+int intel_pcm_open(struct snd_sof_dev *sdev,
+		   struct snd_pcm_substream *substream)
+{
+	struct intel_stream *stream = kmalloc(sizeof(*stream), GFP_KERNEL);
+
+	if (!stream)
+		return -ENOMEM;
+
+	/* binding pcm substream to hda stream */
+	substream->runtime->private_data = stream;
+
+	return 0;
+}
+EXPORT_SYMBOL(intel_pcm_open);
+
+int intel_pcm_close(struct snd_sof_dev *sdev,
+		    struct snd_pcm_substream *substream)
+{
+	struct intel_stream *stream = substream->runtime->private_data;
+
+	substream->runtime->private_data = NULL;
+	kfree(stream);
+
+	return 0;
+}
+EXPORT_SYMBOL(intel_pcm_close);
+
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.17.1
