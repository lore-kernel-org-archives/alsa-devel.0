From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 8/9] ASoC: hda: Add for CL DMA interrupt handling
Date: Fri, 17 Apr 2015 18:46:06 +0530
Message-ID: <1429276567-29007-9-git-send-email-vinod.koul@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B17F26582D
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:21:33 +0200 (CEST)
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

DSP handles the Code Loader DMA interrupt.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hda-sst-dsp.h       |    1 +
 sound/soc/hda/intel/soc-hda-sst-dsp.c |    7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/sound/soc-hda-sst-dsp.h b/include/sound/soc-hda-sst-dsp.h
index 4549d6df2ed2..9adeb49cf126 100644
--- a/include/sound/soc-hda-sst-dsp.h
+++ b/include/sound/soc-hda-sst-dsp.h
@@ -261,5 +261,6 @@ int ssth_disable_dsp_core(struct ssth_lib  *ctx);
 bool ssth_dsp_is_running(struct ssth_lib *ctx);
 int ssth_cl_dma_prepare(struct ssth_lib *ctx);
 void ssth_process_cl_dma(struct work_struct *work);
+void ssth_cldma_int_disable(struct ssth_lib *ctx);
 
 #endif /*__HDA_SST_DSP_H__*/
diff --git a/sound/soc/hda/intel/soc-hda-sst-dsp.c b/sound/soc/hda/intel/soc-hda-sst-dsp.c
index 6285a6772e73..b133c63a0c20 100644
--- a/sound/soc/hda/intel/soc-hda-sst-dsp.c
+++ b/sound/soc/hda/intel/soc-hda-sst-dsp.c
@@ -423,6 +423,13 @@ static irqreturn_t ssth_interrupt(int irq, void *dev_id)
 		result = IRQ_HANDLED;
 	}
 
+	if (val & ADSPIS_CL_DMA) {
+		ssth_cldma_int_disable(ctx);
+		queue_work(ctx->intr_wq, &ctx->cl_dma_process_work);
+		result = IRQ_HANDLED;
+	}
+
+
 	spin_unlock(&ctx->reg_lock);
 	return result;
 }
-- 
1.7.9.5
