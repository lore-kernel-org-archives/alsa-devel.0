From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCHv2] ASoC: Intel: Fix Baytrail SST DSP firmware
	loading
Date: Tue, 13 May 2014 15:46:06 +0300
Message-ID: <1399985166-29055-1-git-send-email-jarkko.nikula@linux.intel.com>
References: <20140513105352.GG12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DE992654BC
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 14:46:30 +0200 (CEST)
In-Reply-To: <20140513105352.GG12304@sirena.org.uk>
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

Commit 10df350977b1 ("ASoC: Intel: Fix Audio DSP usage when IOMMU is
enabled.") caused following regression in Baytrail SST:

baytrail-pcm-audio baytrail-pcm-audio: error: DMA alloc failed
baytrail-pcm-audio baytrail-pcm-audio: error: failed to load firmware

Fix this by calling dma_coerce_mask_and_coherent() in sst_byt_init() with
the same dma_dev device what is now used in sst_fw_new() when allocating the
DMA buffer.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
For fix/intel branch.
---
 sound/soc/intel/sst-baytrail-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-baytrail-dsp.c b/sound/soc/intel/sst-baytrail-dsp.c
index a50bf7fc0e3a..adf0aca5aca6 100644
--- a/sound/soc/intel/sst-baytrail-dsp.c
+++ b/sound/soc/intel/sst-baytrail-dsp.c
@@ -324,7 +324,7 @@ static int sst_byt_init(struct sst_dsp *sst, struct sst_pdata *pdata)
 	memcpy_toio(sst->addr.lpe + SST_BYT_MAILBOX_OFFSET,
 	       &pdata->fw_base, sizeof(u32));
 
-	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	ret = dma_coerce_mask_and_coherent(sst->dma_dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-- 
2.0.0.rc0
