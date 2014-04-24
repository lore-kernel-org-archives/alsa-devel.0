From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH] ASoC: fsl: Drop formats limitation for
	imx-pcm-dma.c
Date: Thu, 24 Apr 2014 19:33:07 +0800
Message-ID: <1398339187-12097-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 by alsa0.perex.cz (Postfix) with ESMTP id 186EF264F19
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 13:31:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, kernel@pengutronix.de, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Now ASoC core is getting the intersection of supported formats not only
from CPU and CODEC dai's but also from DMA's. However, there should be
no specific width limitation from SDMA side.

So drop it. Otherwise, we would only support S16_LE format for all i.MX
platforms.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/imx-pcm-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 2585ae4..0849b7b 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -40,7 +40,6 @@ static const struct snd_pcm_hardware imx_pcm_hardware = {
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_PAUSE |
 		SNDRV_PCM_INFO_RESUME,
-	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
 	.period_bytes_min = 128,
 	.period_bytes_max = 65535, /* Limited by SDMA engine */
-- 
1.8.4
