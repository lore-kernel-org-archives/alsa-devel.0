From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] ASoC: Fix data format configuration for
 S3C64XX IISv2
Date: Tue, 18 Aug 2009 21:56:19 +0900
Message-ID: <4A8AA4F3.3010907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id C36472469B
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 14:56:25 +0200 (CEST)
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KOK00D90P9WI5@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 18 Aug 2009 21:56:20 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KOK0085KP9VNM@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 18 Aug 2009 21:56:19 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: ben@simtec.co.uk, alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

The data format configuration for S3C64xx IISv2 was hardcoded for IISMOD
register. This patch changes to the defined values it.

And instead of bits 9 and 10 of IISMOD we should clear bits 13 and 14.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h |    5 +++++
 sound/soc/s3c24xx/s3c-i2s-v2.c                    |    6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h b/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
index 0fad757..07659da 100644
--- a/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
+++ b/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
@@ -33,6 +33,11 @@
 #define S3C2412_IISCON_RXDMA_ACTIVE	(1 << 1)
 #define S3C2412_IISCON_IIS_ACTIVE	(1 << 0)
 
+#define S3C64XX_IISMOD_BLC_16BIT	(0 << 13)
+#define S3C64XX_IISMOD_BLC_8BIT		(1 << 13)
+#define S3C64XX_IISMOD_BLC_24BIT	(2 << 13)
+#define S3C64XX_IISMOD_BLC_MASK		(3 << 13)
+
 #define S3C64XX_IISMOD_IMS_PCLK		(0 << 10)
 #define S3C64XX_IISMOD_IMS_SYSMUX	(1 << 10)
 
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 1a28317..ebfb2f6 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -357,19 +357,19 @@ static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
 #endif
 
 #ifdef CONFIG_PLAT_S3C64XX
-	iismod &= ~0x606;
+	iismod &= ~(S3C64XX_IISMOD_BLC_MASK | S3C2412_IISMOD_BCLK_MASK);
 	/* Sample size */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		/* 8 bit sample, 16fs BCLK */
-		iismod |= 0x2004;
+		iismod |= (S3C64XX_IISMOD_BLC_8BIT | S3C2412_IISMOD_BCLK_16FS);
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
 		/* 16 bit sample, 32fs BCLK */
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		/* 24 bit sample, 48fs BCLK */
-		iismod |= 0x4002;
+		iismod |= (S3C64XX_IISMOD_BLC_24BIT | S3C2412_IISMOD_BCLK_48FS);
 		break;
 	}
 #endif
-- 
1.6.0.4
