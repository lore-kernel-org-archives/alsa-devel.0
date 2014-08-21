From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 09/11] ASoC: Intel: sst: load firmware using async
	callback
Date: Thu, 21 Aug 2014 18:20:48 +0530
Message-ID: <1408625450-32315-10-git-send-email-subhransu.s.prusty@intel.com>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 45FB82651E3
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 15:13:11 +0200 (CEST)
In-Reply-To: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

We would like the DSP firmware to be available in driver as soon as possible. So
use the async callback in driver to probe to load the firmware as soon as
usermode is up

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst/sst.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 2712e6cf99a9..3b31c5823662 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -377,6 +377,19 @@ static int intel_sst_probe(struct pci_dev *pci,
 
 
 	sst_set_fw_state_locked(sst_drv_ctx, SST_RESET);
+	snprintf(sst_drv_ctx->firmware_name, sizeof(sst_drv_ctx->firmware_name),
+			"%s%04x%s", "fw_sst_",
+			sst_drv_ctx->pci_id, ".bin");
+	pr_debug("Requesting FW %s now...\n", sst_drv_ctx->firmware_name);
+	ret = request_firmware_nowait(THIS_MODULE, 1,
+			sst_drv_ctx->firmware_name, sst_drv_ctx->dev,
+			GFP_KERNEL, sst_drv_ctx, sst_firmware_load_cb);
+
+	if (ret) {
+		pr_err("Firmware load failed with error: %d\n", ret);
+		goto do_unmap_dram;
+	}
+
 	sst_drv_ctx->irq_num = pci->irq;
 	/* Register the ISR */
 	ret = devm_request_threaded_irq(&pci->dev, pci->irq,
-- 
1.9.0
