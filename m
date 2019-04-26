From: Ross Zwisler <zwisler@chromium.org>
Subject: [PATCH] ASoC: Intel: avoid Oops if DMA setup fails
Date: Fri, 26 Apr 2019 10:47:40 -0600
Message-ID: <20190426164740.211139-1-zwisler@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ross Zwisler <zwisler@google.com>, Jaroslav Kysela <perex@perex.cz>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently in sst_dsp_new() if we get an error return from sst_dma_new()
we just print an error message and then still complete the function
successfully.  This means that we are trying to run without sst->dma
properly set up, which will result in NULL pointer dereference when
sst->dma is later used.  This was happening for me in
sst_dsp_dma_get_channel():

        struct sst_dma *dma = dsp->dma;
	...
        dma->ch = dma_request_channel(mask, dma_chan_filter, dsp);

This resulted in:

   BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
   IP: sst_dsp_dma_get_channel+0x4f/0x125 [snd_soc_sst_firmware]

Fix this by adding proper error handling for the case where we fail to
set up DMA.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Cc: stable@vger.kernel.org
---
 sound/soc/intel/common/sst-firmware.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 1e067504b6043..9be3a793a55e3 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -1251,11 +1251,15 @@ struct sst_dsp *sst_dsp_new(struct device *dev,
 		goto irq_err;
 
 	err = sst_dma_new(sst);
-	if (err)
+	if (err)  {
 		dev_warn(dev, "sst_dma_new failed %d\n", err);
+		goto dma_err;
+	}
 
 	return sst;
 
+dma_err:
+	free_irq(sst->irq, sst);
 irq_err:
 	if (sst->ops->free)
 		sst->ops->free(sst);
-- 
2.21.0.593.g511ec345e18-goog
