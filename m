From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Remove vague commit about
	slave DMA config from firmware loader
Date: Wed, 18 Mar 2015 10:07:20 +0200
Message-ID: <1426666040-1727-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1426666040-1727-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 36E222604A1
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 09:07:32 +0100 (CET)
In-Reply-To: <1426666040-1727-1-git-send-email-jarkko.nikula@linux.intel.com>
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

Intel MID DMA driver is going to be removed, commit should be a few lines
down near to dmaengine_slave_config() call in order to not confuse and at
quick look Synopsys DesignWare does seem to use some of the slave config
structure fields (see drivers/dma/dw/core.c: dwc_config()).

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-firmware.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 38881f1fb990..b5659ecb80de 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -221,8 +221,6 @@ int sst_dsp_dma_get_channel(struct sst_dsp *dsp, int chan_id)
 	dma_cap_mask_t mask;
 	int ret;
 
-	/* The Intel MID DMA engine driver needs the slave config set but
-	 * Synopsis DMA engine driver safely ignores the slave config */
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 	dma_cap_set(DMA_MEMCPY, mask);
-- 
2.1.4
