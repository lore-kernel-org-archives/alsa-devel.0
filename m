From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Remove support for Intel MID
	DMA from firmware loader
Date: Wed, 18 Mar 2015 10:07:19 +0200
Message-ID: <1426666040-1727-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 084AB260481
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 09:07:30 +0100 (CET)
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
Cc: Jin Yao <yao.jin@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Intel MID DMA driver is going to be removed by the coming commit
36111da7838e ("dmaengine: intel-mid-dma: remove the driver") in spi.git
tree. Since there are no users for SST_DMA_TYPE_MID type the support for it
can be removed from here in advance.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-dsp.h      | 1 -
 sound/soc/intel/sst-firmware.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index f291e32f0077..3412474083ff 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -28,7 +28,6 @@
 
 /* Supported SST DMA Devices */
 #define SST_DMA_TYPE_DW		1
-#define SST_DMA_TYPE_MID	2
 
 /* autosuspend delay 5s*/
 #define SST_RUNTIME_SUSPEND_DELAY	(5 * 1000)
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 5e5800897da2..38881f1fb990 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -277,9 +277,6 @@ int sst_dma_new(struct sst_dsp *sst)
 	case SST_DMA_TYPE_DW:
 		dma_dev_name = "dw_dmac";
 		break;
-	case SST_DMA_TYPE_MID:
-		dma_dev_name = "Intel MID DMA";
-		break;
 	default:
 		dev_err(sst->dev, "error: invalid DMA engine %d\n",
 			sst->pdata->dma_engine);
-- 
2.1.4
