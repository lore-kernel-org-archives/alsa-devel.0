From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/6] ASoC: Intel: Skylake: Freeup properly on
	skl_dsp_free
Date: Tue, 15 Mar 2016 15:27:13 +0530
Message-ID: <1458035836-1843-4-git-send-email-vinod.koul@intel.com>
References: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AF122654D9
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:53:12 +0100 (CET)
In-Reply-To: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

We are supposed to freeup the Code loader DMA allocation and
ensure all interrupts are disabled before we disable dsp cores.
So invoke these to ensure DSP shuts down properly.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index a5267e8a96e0..2962ef22fc84 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -336,6 +336,11 @@ void skl_dsp_free(struct sst_dsp *dsp)
 	skl_ipc_int_disable(dsp);
 
 	free_irq(dsp->irq, dsp);
+	dsp->cl_dev.ops.cl_cleanup_controller(dsp);
+	skl_cldma_int_disable(dsp);
+	skl_ipc_op_int_disable(dsp);
+	skl_ipc_int_disable(dsp);
+
 	skl_dsp_disable_core(dsp);
 }
 EXPORT_SYMBOL_GPL(skl_dsp_free);
-- 
1.9.1
