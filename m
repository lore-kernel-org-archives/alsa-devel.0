From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 5/9] ASoC: hda: Add dsp loader ops
Date: Fri, 17 Apr 2015 18:46:03 +0530
Message-ID: <1429276567-29007-6-git-send-email-vinod.koul@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 73262260587
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:21:25 +0200 (CEST)
In-Reply-To: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

This will be assigned with the required bus io ops.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hda-sst-dsp.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/sound/soc-hda-sst-dsp.h b/include/sound/soc-hda-sst-dsp.h
index 4a89c3dda5ab..3d8b0c065002 100644
--- a/include/sound/soc-hda-sst-dsp.h
+++ b/include/sound/soc-hda-sst-dsp.h
@@ -138,12 +138,28 @@ struct ssth_window {
 	size_t w1_size;
 };
 
+struct ssth_dsp_loader_ops {
+	int (*init)(struct device *dev);
+	int (*prepare)(struct device *dev, unsigned int format,
+				unsigned int byte_size,
+				struct snd_dma_buffer *bufp);
+	void (*trigger)(struct device *dev, bool start);
+
+	void (*cleanup)(struct device *dev,
+				 struct snd_dma_buffer *dmab);
+	int (*alloc_dma_buf)(struct device *dev,
+		struct snd_dma_buffer *dmab, u32 size);
+	int (*free_dma_buf)(struct device *dev,
+		struct snd_dma_buffer *dmab);
+};
+
 struct ssth_lib {
 	struct device *dev;
 	struct ssth_ipc *ipc;
 	void __iomem *mmio_base;
 	struct ssth_window window;
 	int irq;
+	struct ssth_dsp_loader_ops  dsp_ops;
 	struct snd_dma_buffer dsp_fw_buf;
 	int sst_state;
 	struct mutex sst_lock;
-- 
1.7.9.5
