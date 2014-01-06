From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 04/11] ASoC: fsl: Don't set unused struct
	snd_pcm_hardware fields
Date: Mon,  6 Jan 2014 14:19:09 +0100
Message-ID: <1389014356-7014-4-git-send-email-lars@metafoo.de>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 471DE2610A8
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 14:18:57 +0100 (CET)
In-Reply-To: <1389014356-7014-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolin Chen <b42378@freescale.com>, Timur Tabi <timur@tabi.org>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Timur Tabi <timur@tabi.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Nicolin Chen <b42378@freescale.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
---
Changes since v1:
	* Don't clear supported formats field, as formats supported by the DMA are
	  more restrictive than those supported by DAI. Note that this won't have
	  any effect though until the last patch in this series has been applied
---
 sound/soc/fsl/fsl_dma.c     | 7 -------
 sound/soc/fsl/imx-pcm-dma.c | 3 ---
 sound/soc/fsl/imx-pcm-fiq.c | 3 ---
 sound/soc/fsl/mpc5200_dma.c | 4 ----
 4 files changed, 17 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index d570f8c..6bb0ea5 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -55,10 +55,6 @@
 			    SNDRV_PCM_FMTBIT_S32_BE     | \
 			    SNDRV_PCM_FMTBIT_U32_LE     | \
 			    SNDRV_PCM_FMTBIT_U32_BE)
-
-#define FSLDMA_PCM_RATES (SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000 | \
-			  SNDRV_PCM_RATE_CONTINUOUS)
-
 struct dma_object {
 	struct snd_soc_platform_driver dai;
 	dma_addr_t ssi_stx_phys;
@@ -140,9 +136,6 @@ static const struct snd_pcm_hardware fsl_dma_hardware = {
 				  SNDRV_PCM_INFO_JOINT_DUPLEX |
 				  SNDRV_PCM_INFO_PAUSE,
 	.formats		= FSLDMA_PCM_FORMATS,
-	.rates  		= FSLDMA_PCM_RATES,
-	.rate_min       	= 5512,
-	.rate_max       	= 192000,
 	.period_bytes_min       = 512,  	/* A reasonable limit */
 	.period_bytes_max       = (u32) -1,
 	.periods_min    	= NUM_DMA_LINKS,
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index c5e47f8..2585ae4 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -41,9 +41,6 @@ static const struct snd_pcm_hardware imx_pcm_hardware = {
 		SNDRV_PCM_INFO_PAUSE |
 		SNDRV_PCM_INFO_RESUME,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	.rate_min = 8000,
-	.channels_min = 2,
-	.channels_max = 2,
 	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
 	.period_bytes_min = 128,
 	.period_bytes_max = 65535, /* Limited by SDMA engine */
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index c75d43b..6553202 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -162,9 +162,6 @@ static struct snd_pcm_hardware snd_imx_hardware = {
 		SNDRV_PCM_INFO_PAUSE |
 		SNDRV_PCM_INFO_RESUME,
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	.rate_min = 8000,
-	.channels_min = 2,
-	.channels_max = 2,
 	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
 	.period_bytes_min = 128,
 	.period_bytes_max = 16 * 1024,
diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 71bf2f2..f2b5d75 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -200,10 +200,6 @@ static const struct snd_pcm_hardware psc_dma_hardware = {
 		SNDRV_PCM_INFO_BATCH,
 	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
 		SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,
-	.rate_min = 8000,
-	.rate_max = 48000,
-	.channels_min = 1,
-	.channels_max = 2,
 	.period_bytes_max	= 1024 * 1024,
 	.period_bytes_min	= 32,
 	.periods_min		= 2,
-- 
1.8.0
