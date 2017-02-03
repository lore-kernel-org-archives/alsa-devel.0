From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: x86: Explicit specify 32bit DMA
Date: Fri,  3 Feb 2017 17:43:58 +0100
Message-ID: <20170203164400.12983-3-tiwai@suse.de>
References: <20170203164400.12983-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BA04F266B55
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 17:44:03 +0100 (CET)
In-Reply-To: <20170203164400.12983-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

LPE audio is capable only up to 32bit address, as it seems.
Then we should limit the DMA addresses accordingly via dma-mapping
API.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 32a21422e6f5..9e08132fd332 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
+#include <linux/dma-mapping.h>
 #include <asm/cacheflush.h>
 #include <sound/core.h>
 #include <sound/asoundef.h>
@@ -1823,8 +1824,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	struct resource *res_mmio;
 	int i, ret;
 
-	dev_dbg(&pdev->dev, "dma_mask: %p\n", pdev->dev.dma_mask);
-
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
 		dev_err(&pdev->dev, "%s: quit: pdata not allocated by i915!!\n", __func__);
@@ -1905,6 +1904,11 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	/* setup the ops for playabck */
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 			    &snd_intelhad_playback_ops);
+
+	/* only 32bit addressable */
+	dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+
 	/* allocate dma pages for ALSA stream operations
 	 * memory allocated is based on size, not max value
 	 * thus using same argument for max & size
-- 
2.11.0
