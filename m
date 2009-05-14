From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V1 04/13] redo
	2008f137e92220b98120c4803499cdddb2b0fb06
Date: Wed, 13 May 2009 21:59:08 -0400
Message-ID: <20090514015908.28145.11860.stgit@terra>
References: <20090514015729.28145.30483.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id D806E24380
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 03:59:18 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so720053ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 18:59:18 -0700 (PDT)
In-Reply-To: <20090514015729.28145.30483.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Reapply the changes from 2008f137e92220b98120c4803499cdddb2b0fb06 to mpc5200_dma.c since the code effected by this change moved to a different file.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/fsl/mpc5200_dma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index c82ef75..6850392 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -314,7 +314,8 @@ void psc_dma_shutdown(struct snd_pcm_substream *substream,
 
 static const struct snd_pcm_hardware psc_dma_pcm_hardware = {
 	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
-		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER,
+		SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_BATCH,
 	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE |
 		   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S32_BE,
 	.rate_min = 8000,
