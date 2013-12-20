From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/19] ASoC: fsl: Don't set unused struct
	snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 14:20:12 +0100
Message-ID: <1387545625-19240-6-git-send-email-lars@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id ABA14265665
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:19:37 +0100 (CET)
In-Reply-To: <1387545625-19240-1-git-send-email-lars@metafoo.de>
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
 sound/soc/fsl/fsl_dma.c     | 26 --------------------------
 sound/soc/fsl/imx-pcm-dma.c |  4 ----
 sound/soc/fsl/imx-pcm-fiq.c |  4 ----
 sound/soc/fsl/mpc5200_dma.c |  6 ------
 4 files changed, 40 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index d570f8c..2326831 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -37,28 +37,6 @@
 #include "fsl_dma.h"
 #include "fsl_ssi.h"	/* For the offset of stx0 and srx0 */
 
-/*
- * The formats that the DMA controller supports, which is anything
- * that is 8, 16, or 32 bits.
- */
-#define FSLDMA_PCM_FORMATS (SNDRV_PCM_FMTBIT_S8 	| \
-			    SNDRV_PCM_FMTBIT_U8 	| \
-			    SNDRV_PCM_FMTBIT_S16_LE     | \
-			    SNDRV_PCM_FMTBIT_S16_BE     | \
-			    SNDRV_PCM_FMTBIT_U16_LE     | \
-			    SNDRV_PCM_FMTBIT_U16_BE     | \
-			    SNDRV_PCM_FMTBIT_S24_LE     | \
-			    SNDRV_PCM_FMTBIT_S24_BE     | \
-			    SNDRV_PCM_FMTBIT_U24_LE     | \
-			    SNDRV_PCM_FMTBIT_U24_BE     | \
-			    SNDRV_PCM_FMTBIT_S32_LE     | \
-			    SNDRV_PCM_FMTBIT_S32_BE     | \
-			    SNDRV_PCM_FMTBIT_U32_LE     | \
-			    SNDRV_PCM_FMTBIT_U32_BE)
-
-#define FSLDMA_PCM_RATES (SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000 | \
-			  SNDRV_PCM_RATE_CONTINUOUS)
-
 struct dma_object {
 	struct snd_soc_platform_driver dai;
 	dma_addr_t ssi_stx_phys;
@@ -139,10 +117,6 @@ static const struct snd_pcm_hardware fsl_dma_hardware = {
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_JOINT_DUPLEX |
 				  SNDRV_PCM_INFO_PAUSE,
-	.formats		= FSLDMA_PCM_FORMATS,
-	.rates  		= FSLDMA_PCM_RATES,
-	.rate_min       	= 5512,
-	.rate_max       	= 192000,
 	.period_bytes_min       = 512,  	/* A reasonable limit */
 	.period_bytes_max       = (u32) -1,
 	.periods_min    	= NUM_DMA_LINKS,
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index c5e47f8..0849b7b 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -40,10 +40,6 @@ static const struct snd_pcm_hardware imx_pcm_hardware = {
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_PAUSE |
 		SNDRV_PCM_INFO_RESUME,
-	.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	.rate_min = 8000,
-	.channels_min = 2,
-	.channels_max = 2,
 	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
 	.period_bytes_min = 128,
 	.period_bytes_max = 65535, /* Limited by SDMA engine */
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index c75d43b..0d668bd 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -161,10 +161,6 @@ static struct snd_pcm_hardware snd_imx_hardware = {
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_PAUSE |
 		SNDRV_PCM_INFO_RESUME,
-	.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	.rate_min = 8000,
-	.channels_min = 2,
-	.channels_max = 2,
 	.buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
 	.period_bytes_min = 128,
 	.period_bytes_max = 16 * 1024,
diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 71bf2f2..30d52e7 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -198,12 +198,6 @@ static const struct snd_pcm_hardware psc_dma_hardware = {
 	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_BATCH,
-	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
-		SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,
-	.rate_min = 8000,
-	.rate_max = 48000,
-	.channels_min = 1,
-	.channels_max = 2,
 	.period_bytes_max	= 1024 * 1024,
 	.period_bytes_min	= 32,
 	.periods_min		= 2,
-- 
1.8.0
