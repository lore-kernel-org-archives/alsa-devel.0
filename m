From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/17] Reinitialise DMA on every resume
Date: Thu, 10 Jan 2008 13:17:11 +0000
Message-ID: <1199971035-13553-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-12-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 970622458A
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:19 +0100 (CET)
In-Reply-To: <1199971035-13553-12-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Graeme Gregory <graeme@openmoko.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Graeme Gregory <graeme@openmoko.com>

This one changes the DMA initialisation as it turns out the DMA driver
in s3c24xx doesnt store registers between suspend/resume so you have
to re-initialise the channels on every resume.

Signed-off-by: Graeme Gregory <graeme@openmoko.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-pcm.c |   48 ++++++++++++++++++++------------------
 1 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index 4107a87..e9f3b60 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -49,7 +49,9 @@ static const struct snd_pcm_hardware s3c24xx_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
 				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				    SNDRV_PCM_INFO_MMAP |
-				    SNDRV_PCM_INFO_MMAP_VALID,
+				    SNDRV_PCM_INFO_MMAP_VALID |
+				    SNDRV_PCM_INFO_PAUSE |
+				    SNDRV_PCM_INFO_RESUME,
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
 				    SNDRV_PCM_FMTBIT_U16_LE |
 				    SNDRV_PCM_FMTBIT_U8 |
@@ -176,28 +178,6 @@ static int s3c24xx_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	/* channel needs configuring for mem=>device, increment memory addr,
-	 * sync to pclk, half-word transfers to the IIS-FIFO. */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		s3c2410_dma_devconfig(prtd->params->channel,
-				S3C2410_DMASRC_MEM, S3C2410_DISRCC_INC |
-				S3C2410_DISRCC_APB, prtd->params->dma_addr);
-
-		s3c2410_dma_config(prtd->params->channel,
-				prtd->params->dma_size,
-				S3C2410_DCON_SYNC_PCLK | 
-				S3C2410_DCON_HANDSHAKE);
-	} else {
-		s3c2410_dma_config(prtd->params->channel,
-				prtd->params->dma_size,
-				S3C2410_DCON_HANDSHAKE | 
-				S3C2410_DCON_SYNC_PCLK);
-
-		s3c2410_dma_devconfig(prtd->params->channel,
-					S3C2410_DMASRC_HW, 0x3,
-					prtd->params->dma_addr);
-	}
-
 	s3c2410_dma_set_buffdone_fn(prtd->params->channel,
 				    s3c24xx_audio_buffdone);
 
@@ -246,6 +226,28 @@ static int s3c24xx_pcm_prepare(struct snd_pcm_substream *substream)
 	if (!prtd->params)
 	 	return 0;
 
+	/* channel needs configuring for mem=>device, increment memory addr,
+	 * sync to pclk, half-word transfers to the IIS-FIFO. */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		s3c2410_dma_devconfig(prtd->params->channel,
+				S3C2410_DMASRC_MEM, S3C2410_DISRCC_INC |
+				S3C2410_DISRCC_APB, prtd->params->dma_addr);
+
+		s3c2410_dma_config(prtd->params->channel,
+				prtd->params->dma_size,
+				S3C2410_DCON_SYNC_PCLK |
+				S3C2410_DCON_HANDSHAKE);
+	} else {
+		s3c2410_dma_config(prtd->params->channel,
+				prtd->params->dma_size,
+				S3C2410_DCON_HANDSHAKE |
+				S3C2410_DCON_SYNC_PCLK);
+
+		s3c2410_dma_devconfig(prtd->params->channel,
+					S3C2410_DMASRC_HW, 0x3,
+					prtd->params->dma_addr);
+	}
+
 	/* flush the DMA channel */
 	s3c2410_dma_ctrl(prtd->params->channel, S3C2410_DMAOP_FLUSH);
 	prtd->dma_loaded = 0;
-- 
1.5.3.8
