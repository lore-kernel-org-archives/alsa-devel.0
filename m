From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 4/7] ASoC: Intel: Move Baytrail extended fw
	address saving to sst_byt_boot()
Date: Thu,  8 May 2014 16:07:24 +0300
Message-ID: <1399554447-16297-5-git-send-email-jarkko.nikula@linux.intel.com>
References: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A6F8B265473
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 15:08:26 +0200 (CEST)
In-Reply-To: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

We have to save the physical address of extended firmware block in the
beginning of mailbox every time when we boot the DSP firmware since that
mailbox address is re-used after DSP firmware is running. Otherwise DSP
firmware will get bogus extended firmware block address during next DSP
boot.

Currently this is not problem but becomes when DSP runtime rebooting is
implemented. Prepare for that by moving extended firmware address saving
from sst_byt_init() to sst_byt_boot().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-dsp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-dsp.c b/sound/soc/intel/sst-baytrail-dsp.c
index a50bf7fc0e3a..4a5d489e520b 100644
--- a/sound/soc/intel/sst-baytrail-dsp.c
+++ b/sound/soc/intel/sst-baytrail-dsp.c
@@ -214,6 +214,13 @@ static void sst_byt_boot(struct sst_dsp *sst)
 {
 	int tries = 10;
 
+	/*
+	 * save the physical address of extended firmware block in the first
+	 * 4 bytes of the mailbox
+	 */
+	memcpy_toio(sst->addr.lpe + SST_BYT_MAILBOX_OFFSET,
+	       &sst->pdata->fw_base, sizeof(u32));
+
 	/* release stall and wait to unstall */
 	sst_dsp_shim_update_bits64(sst, SST_CSR, SST_BYT_CSR_STALL, 0x0);
 	while (tries--) {
@@ -317,13 +324,6 @@ static int sst_byt_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 		return ret;
 	}
 
-	/*
-	 * save the physical address of extended firmware block in the first
-	 * 4 bytes of the mailbox
-	 */
-	memcpy_toio(sst->addr.lpe + SST_BYT_MAILBOX_OFFSET,
-	       &pdata->fw_base, sizeof(u32));
-
 	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
-- 
2.0.0.rc0
