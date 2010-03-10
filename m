From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 03/20] ASoC: S3C64XX: I2S: Make BCLK
	independent of sample size
Date: Wed, 10 Mar 2010 16:48:52 +0900
Message-ID: <1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 95C6B24350
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 08:58:03 +0100 (CET)
In-Reply-To: <1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

For some CPU-CODEC and source clock combination we might need to set
BCLK to N*Sample_size*LRCLK, where N may be even 3 or 4, not just 2.

We can simply remove the dependency of BCLK on sample size as there
is already a callback(S3C_I2SV2_DIV_BCLK) available to set required BCLK.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index fd5c842..b01f50e 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -364,19 +364,16 @@ static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
 #endif
 
 #ifdef CONFIG_PLAT_S3C64XX
-	iismod &= ~(S3C64XX_IISMOD_BLC_MASK | S3C2412_IISMOD_BCLK_MASK);
+	iismod &= ~S3C64XX_IISMOD_BLC_MASK;
 	/* Sample size */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
-		/* 8 bit sample, 16fs BCLK */
-		iismod |= (S3C64XX_IISMOD_BLC_8BIT | S3C2412_IISMOD_BCLK_16FS);
+		iismod |= S3C64XX_IISMOD_BLC_8BIT;
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
-		/* 16 bit sample, 32fs BCLK */
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
-		/* 24 bit sample, 48fs BCLK */
-		iismod |= (S3C64XX_IISMOD_BLC_24BIT | S3C2412_IISMOD_BCLK_48FS);
+		iismod |= S3C64XX_IISMOD_BLC_24BIT;
 		break;
 	}
 #endif
-- 
1.6.2.5
