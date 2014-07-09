From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/7] ASoC: Intel: sst: load firmware using
	async callback
Date: Wed,  9 Jul 2014 14:57:54 +0530
Message-ID: <1404898076-1882-7-git-send-email-vinod.koul@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 066F0264FF9
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 11:30:24 +0200 (CEST)
In-Reply-To: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

We would like the DSP firmware to be availble in driver as soon as possible. So
use the async callback in driver to probe to load the firmware as soon as
usermode is up

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index cb9863c..ae1f0eb 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -224,6 +224,22 @@ int sst_alloc_drv_context(struct device *dev)
 	return 0;
 }
 
+int sst_request_firmware_async(struct intel_sst_drv *ctx)
+{
+	int ret = 0;
+
+	snprintf(ctx->firmware_name, sizeof(ctx->firmware_name),
+			"%s%04x%s", "fw_sst_",
+			ctx->pci_id, ".bin");
+	pr_debug("Requesting FW %s now...\n", ctx->firmware_name);
+
+	ret = request_firmware_nowait(THIS_MODULE, 1, ctx->firmware_name,
+			ctx->dev, GFP_KERNEL, ctx, sst_firmware_load_cb);
+	if (ret)
+		pr_err("could not load firmware %s error %d\n", ctx->firmware_name, ret);
+
+	return ret;
+}
 /*
 * intel_sst_probe - PCI probe function
 *
@@ -293,6 +309,11 @@ static int intel_sst_probe(struct pci_dev *pci,
 		mutex_init(&stream->lock);
 	}
 
+	ret = sst_request_firmware_async(sst_drv_ctx);
+	if (ret) {
+		pr_err("Firmware download failed:%d\n", ret);
+		goto do_free_mem;
+	}
 	/* Init the device */
 	ret = pci_enable_device(pci);
 	if (ret) {
-- 
1.7.0.4
