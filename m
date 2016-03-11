From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/8] ASoC: Intel: Skylake: Move module id
	defines
Date: Fri, 11 Mar 2016 10:12:49 +0530
Message-ID: <1457671376-18667-2-git-send-email-vinod.koul@intel.com>
References: <1457671376-18667-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 05FC42606A9
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 05:38:54 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The module ID defines are common to other platforms so can be
reused if moved to a common driver header so move it

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.h | 4 ++++
 sound/soc/intel/skylake/skl-sst.c     | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.h b/sound/soc/intel/skylake/skl-sst-dsp.h
index cbb40751c37e..a82c3de1a228 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.h
+++ b/sound/soc/intel/skylake/skl-sst-dsp.h
@@ -53,6 +53,10 @@ struct sst_dsp_device;
 /* HIPCT */
 #define SKL_ADSP_REG_HIPCT_BUSY		BIT(31)
 
+/* FW base IDs */
+#define SKL_INSTANCE_ID			0
+#define SKL_BASE_FW_MODULE_ID		0
+
 /* Intel HD Audio SRAM Window 1 */
 #define SKL_ADSP_SRAM1_BASE		0xA000
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index e26f4746afb7..348a734f8e24 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -35,9 +35,6 @@
 #define SKL_ADSP_FW_STATUS	SKL_ADSP_SRAM0_BASE
 #define SKL_ADSP_ERROR_CODE	(SKL_ADSP_FW_STATUS + 0x4)
 
-#define SKL_INSTANCE_ID		0
-#define SKL_BASE_FW_MODULE_ID	0
-
 #define SKL_NUM_MODULES		1
 
 static bool skl_check_fw_status(struct sst_dsp *ctx, u32 status)
-- 
1.9.1
