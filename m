From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: remove misleading DMA error
	messages on Baytrail platforms
Date: Fri, 20 Mar 2015 15:31:34 -0500
Message-ID: <1426883494-13640-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 09E5426506E
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 21:31:43 +0100 (CET)
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
Cc: broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

During probe, the Baytrail audio driver reports errors such as:

[44.172040] baytrail-pcm-audio baytrail-pcm-audio: error: invalid DMA engine 0
[44.172137] baytrail-pcm-audio baytrail-pcm-audio: sst_dma_new failed

Those error messages are misleading, there is no error since the DMA
is explicitly not configured for Baytrail.
Add a test to remove DMA error checks when DMA is not configured
and return silently.

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
With Mark in cc: this time, sorry for the noise.

 sound/soc/intel/sst-acpi.c     | 1 +
 sound/soc/intel/sst-dsp.h      | 1 +
 sound/soc/intel/sst-firmware.c | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/sound/soc/intel/sst-acpi.c b/sound/soc/intel/sst-acpi.c
index b3d8456..42f293f 100644
--- a/sound/soc/intel/sst-acpi.c
+++ b/sound/soc/intel/sst-acpi.c
@@ -142,6 +142,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	sst_acpi->desc = desc;
 	sst_acpi->mach = mach;
 
+	sst_pdata->resindex_dma_base = desc->resindex_dma_base;
 	if (desc->resindex_dma_base >= 0) {
 		sst_pdata->dma_engine = desc->dma_engine;
 		sst_pdata->dma_base = desc->resindex_dma_base;
diff --git a/sound/soc/intel/sst-dsp.h b/sound/soc/intel/sst-dsp.h
index f291e32..148d8c5 100644
--- a/sound/soc/intel/sst-dsp.h
+++ b/sound/soc/intel/sst-dsp.h
@@ -206,6 +206,7 @@ struct sst_pdata {
 	const struct firmware *fw;
 
 	/* DMA */
+	int resindex_dma_base; /* other fields invalid if equals to -1 */
 	u32 dma_base;
 	u32 dma_size;
 	int dma_engine;
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 5f71ef6..4a993d1 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -271,6 +271,10 @@ int sst_dma_new(struct sst_dsp *sst)
 	const char *dma_dev_name;
 	int ret = 0;
 
+	if (sst->pdata->resindex_dma_base == -1)
+		/* DMA is not used, return and squelsh error messages */
+		return 0;
+
 	/* configure the correct platform data for whatever DMA engine
 	* is attached to the ADSP IP. */
 	switch (sst->pdata->dma_engine) {
-- 
1.9.1
