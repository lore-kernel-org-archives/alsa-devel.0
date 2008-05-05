From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] soc - S3C2410 pcm - Update for changed
	s3c2410 DMA API change
Date: Mon,  5 May 2008 13:13:58 +0100
Message-ID: <1209989640-2870-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7247243C8
	for <alsa-devel@alsa-project.org>;
	Mon,  5 May 2008 14:14:02 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, "ing. Davide Rizzo" <davide@elpa.it>
List-Id: alsa-devel@alsa-project.org

From: ing. Davide Rizzo <davide@elpa.it>

S3C2410 pcm doesn't work.
s3c2410_dma_request() now returns the channel number and not 0 if OK.
Davide

This patch to update to a s3c2410_dma_request return value change

Signed-off-by: Davide Rizzo <davide@elpa.it>
Acked-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index 6c70a81..7806ae6 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -171,7 +171,7 @@ static int s3c24xx_pcm_hw_params(struct snd_pcm_substream *substream,
 		ret = s3c2410_dma_request(prtd->params->channel,
 					  prtd->params->client, NULL);
 
-		if (ret) {
+		if (ret < 0) {
 			DBG(KERN_ERR "failed to get dma channel\n");
 			return ret;
 		}
-- 
1.5.5.1
