From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/7] ASoC: Intel: Skylake: Add dsp loader ops
Date: Fri, 10 Jul 2015 22:18:39 +0530
Message-ID: <1436546926-17263-2-git-send-email-vinod.koul@intel.com>
References: <1436546926-17263-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 11D8B26660B
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 18:47:01 +0200 (CEST)
In-Reply-To: <1436546926-17263-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

The ops is initialized during the dsp registration and used for the
allocating dma buffers.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index cdfca9be4120..c2d28781309a 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -16,6 +16,8 @@
 #ifndef __SKL_SST_DSP_H__
 #define __SKL_SST_DSP_H__
 
+#include <sound/memalloc.h>
+
 struct sst_dsp_device;
 
 /* Intel HD Audio General DSP Registers */
@@ -104,6 +106,13 @@ struct skl_dsp_fw_ops {
 	int (*set_state_D3)(struct sst_dsp *ctx);
 };
 
+struct skl_dsp_loader_ops {
+	int (*alloc_dma_buf)(struct device *dev,
+		struct snd_dma_buffer *dmab, size_t size);
+	int (*free_dma_buf)(struct device *dev,
+		struct snd_dma_buffer *dmab);
+};
+
 void skl_dsp_set_state_locked(struct sst_dsp *ctx, int state);
 struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
 		struct sst_dsp_device *sst_dev, int irq);
-- 
1.9.1
