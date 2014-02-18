From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Add GFP_KERNEL flag to
	firmware DMA buffer.
Date: Tue, 18 Feb 2014 10:41:50 +0000
Message-ID: <1392720110-4278-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1392720110-4278-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1264B265164
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 11:42:13 +0100 (CET)
In-Reply-To: <1392720110-4278-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add GFP_KERNEL when allocating firmware DMA buffer.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index b6f9b5e..31cd154 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -65,7 +65,7 @@ struct sst_fw *sst_fw_new(struct sst_dsp *dsp,
 
 	/* allocate DMA buffer to store FW data */
 	sst_fw->dma_buf = dma_alloc_coherent(dsp->dev, sst_fw->size,
-				&sst_fw->dmable_fw_paddr, GFP_DMA);
+				&sst_fw->dmable_fw_paddr, GFP_DMA | GFP_KERNEL);
 	if (!sst_fw->dma_buf) {
 		dev_err(dsp->dev, "error: DMA alloc failed\n");
 		kfree(sst_fw);
-- 
1.8.3.2
