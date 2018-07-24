From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/6] ASoC: Intel: common: make sst_dma
	functions static
Date: Tue, 24 Jul 2018 16:12:46 -0500
Message-ID: <20180724211248.29427-5-pierre-louis.bossart@linux.intel.com>
References: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B0343267727
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 23:13:00 +0200 (CEST)
In-Reply-To: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

sst_dma_new and sst_dma_free are not used in any other file and don't
have a prototype. Move to static functions and remove
EXPORT_SYMBOL_GPL statement.

Reported by sparse warnings.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/sst-firmware.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 657afc02f1c4..11041aedea31 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -270,7 +270,7 @@ void sst_dsp_dma_put_channel(struct sst_dsp *dsp)
 }
 EXPORT_SYMBOL_GPL(sst_dsp_dma_put_channel);
 
-int sst_dma_new(struct sst_dsp *sst)
+static int sst_dma_new(struct sst_dsp *sst)
 {
 	struct sst_pdata *sst_pdata = sst->pdata;
 	struct sst_dma *dma;
@@ -320,9 +320,8 @@ int sst_dma_new(struct sst_dsp *sst)
 	devm_kfree(sst->dev, dma);
 	return ret;
 }
-EXPORT_SYMBOL(sst_dma_new);
 
-void sst_dma_free(struct sst_dma *dma)
+static void sst_dma_free(struct sst_dma *dma)
 {
 
 	if (dma == NULL)
@@ -335,7 +334,6 @@ void sst_dma_free(struct sst_dma *dma)
 		dw_remove(dma->chip);
 
 }
-EXPORT_SYMBOL(sst_dma_free);
 
 /* create new generic firmware object */
 struct sst_fw *sst_fw_new(struct sst_dsp *dsp, 
-- 
2.14.1
