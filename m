From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 1/3][RFC] ASoC: pxa-ssp: Use 16-bit DMA for
	magician stereo
Date: Wed, 11 Mar 2009 19:16:58 +0100
Message-ID: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f177.google.com (mail-fx0-f177.google.com
	[209.85.220.177])
	by alsa0.perex.cz (Postfix) with ESMTP id EBA4910387E
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 19:17:08 +0100 (CET)
Received: by fxm25 with SMTP id 25so117491fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 11:17:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Please advise how this behaviour could be made configurable. I guess
the only machines that will ever need this are HTC Magician, Blueangel
and Himalaya.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 569c0a6..bc9d306 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 
 #include <asm/irq.h>
+#include <asm/mach-types.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -634,8 +635,14 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	/* select correct DMA params */
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
 		dma = 1; /* capture DMA offset is 1,3 */
-	if (chn == 2)
-		dma += 2; /* stereo DMA offset is 2, mono is 0 */
+	/* FIXME: Magician needs a way to configure 16-bit DMA for stereo */
+	if (machine_is_magician()) {
+		if (width == 32)
+			dma += 2; /* 32-bit DMA offset is 2, 16-bit is 0 */
+	} else {
+		if (chn == 2)
+			dma += 2; /* stereo DMA offset is 2, mono is 0 */
+	}
 	cpu_dai->dma_data = ssp_dma_params[cpu_dai->id][dma];
 
 	dev_dbg(&ssp->pdev->dev, "pxa_ssp_hw_params: dma %d\n", dma);
-- 
1.6.2
