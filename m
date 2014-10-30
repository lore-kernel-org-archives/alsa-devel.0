From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/4] ASoC: Intel: sst: load firmware using
	async callback
Date: Thu, 30 Oct 2014 16:20:56 +0530
Message-ID: <1414666259-4450-2-git-send-email-vinod.koul@intel.com>
References: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 65FBD260508
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:31:52 +0100 (CET)
In-Reply-To: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

We would like the DSP firmware to be available in driver as soon as possible. So
use the async callback in driver to probe to load the firmware as soon as
usermode is up

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 05aba24..ff0ff9f 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -364,6 +364,21 @@ static int intel_sst_probe(struct pci_dev *pci,
 
 
 	sst_set_fw_state_locked(sst_drv_ctx, SST_RESET);
+	snprintf(sst_drv_ctx->firmware_name, sizeof(sst_drv_ctx->firmware_name),
+			"%s%04x%s", "fw_sst_",
+			sst_drv_ctx->dev_id, ".bin");
+	dev_dbg(sst_drv_ctx->dev,
+		"Requesting FW %s now...\n", sst_drv_ctx->firmware_name);
+	ret = request_firmware_nowait(THIS_MODULE, 1,
+			sst_drv_ctx->firmware_name, sst_drv_ctx->dev,
+			GFP_KERNEL, sst_drv_ctx, sst_firmware_load_cb);
+
+	if (ret) {
+		dev_err(sst_drv_ctx->dev,
+			"Firmware load failed with error: %d\n", ret);
+		goto do_release_regions;
+	}
+
 	sst_drv_ctx->irq_num = pci->irq;
 	/* Register the ISR */
 	ret = devm_request_threaded_irq(&pci->dev, pci->irq,
-- 
1.7.0.4
