From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/8] ASoC: Intel: add dmabuffer to common
	sst_dsp
Date: Fri, 11 Mar 2016 10:12:52 +0530
Message-ID: <1457671376-18667-5-git-send-email-vinod.koul@intel.com>
References: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 020E92606A9
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 05:39:00 +0100 (CET)
In-Reply-To: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, GuruprasadX Pawse <guruprasadx.pawse@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Broxton uses HDA DMA so needs to keep dmab in the driver context
so add it

Signed-off-by: GuruprasadX Pawse <guruprasadx.pawse@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-dsp-priv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 81aa1ed64201..97dc1ae05e69 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -317,6 +317,7 @@ struct sst_dsp {
 	struct skl_cl_dev cl_dev;
 	u32 intr_status;
 	const struct firmware *fw;
+	struct snd_dma_buffer dmab;
 };
 
 /* Size optimised DRAM/IRAM memcpy */
-- 
1.9.1
