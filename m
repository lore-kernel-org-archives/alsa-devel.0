From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 2/4] ASoC: SAMSUNG: Clean-up DMA header file
Date: Fri,  7 Jan 2011 13:51:26 +0900
Message-ID: <1294375886-16904-1-git-send-email-sw.youn@samsung.com>
References: <1294375612-16776-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F97024633
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 06:16:07 +0100 (CET)
In-Reply-To: <1294375612-16776-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch moves DMA specific definitions, they doesn't need to be
shared, into 'dma.c' from 'dma.h'. And remove unnecessery definitions
on 'dma.h'.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/samsung/dma.c |    3 +++
 sound/soc/samsung/dma.h |    8 --------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 2124019..c2cdb45 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -32,6 +32,9 @@
 
 #include "dma.h"
 
+#define ST_RUNNING		(1<<0)
+#define ST_OPENED		(1<<1)
+
 static const struct snd_pcm_hardware dma_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
 				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
diff --git a/sound/soc/samsung/dma.h b/sound/soc/samsung/dma.h
index f8cd2b4..c506592 100644
--- a/sound/soc/samsung/dma.h
+++ b/sound/soc/samsung/dma.h
@@ -12,9 +12,6 @@
 #ifndef _S3C_AUDIO_H
 #define _S3C_AUDIO_H
 
-#define ST_RUNNING		(1<<0)
-#define ST_OPENED		(1<<1)
-
 struct s3c_dma_params {
 	struct s3c2410_dma_client *client;	/* stream identifier */
 	int channel;				/* Channel ID */
@@ -22,9 +19,4 @@ struct s3c_dma_params {
 	int dma_size;			/* Size of the DMA transfer */
 };
 
-#define S3C24XX_DAI_I2S			0
-
-/* platform data */
-extern struct snd_ac97_bus_ops s3c24xx_ac97_ops;
-
 #endif
-- 
1.6.2.5
