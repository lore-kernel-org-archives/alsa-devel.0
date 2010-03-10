From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 16/20] ASoC: S3C64XX: I2S: Use s3c2412 defines
Date: Wed, 10 Mar 2010 17:12:26 +0900
Message-ID: <1268208746-22748-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D11810382A
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 09:23:01 +0100 (CET)
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

Now that the fields are defined for s3c2412, use them and avoid having
multiple copies of same defines.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/regs-i2s-v2.h |    3 ---
 sound/soc/s3c24xx/s3c64xx-i2s.c |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/s3c24xx/regs-i2s-v2.h b/sound/soc/s3c24xx/regs-i2s-v2.h
index f612468..ad06937 100644
--- a/sound/soc/s3c24xx/regs-i2s-v2.h
+++ b/sound/soc/s3c24xx/regs-i2s-v2.h
@@ -73,9 +73,6 @@
 #define S3C64XX_IISMOD_BLC_24BIT	(2 << 13)
 #define S3C64XX_IISMOD_BLC_MASK		(3 << 13)
 
-#define S3C64XX_IISMOD_IMS_PCLK		(0 << 10)
-#define S3C64XX_IISMOD_IMS_SYSMUX	(1 << 10)
-
 #define S3C2412_IISMOD_IMS_SYSMUX	(1 << 10)
 #define S3C2412_IISMOD_SLAVE		(1 << 11)
 #define S3C2412_IISMOD_MODE_TXONLY	(0 << 8)
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 9343349..1a29564 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -62,11 +62,11 @@ static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 
 	switch (clk_id) {
 	case S3C64XX_CLKSRC_PCLK:
-		iismod &= ~S3C64XX_IISMOD_IMS_SYSMUX;
+		iismod &= ~S3C2412_IISMOD_IMS_SYSMUX;
 		break;
 
 	case S3C64XX_CLKSRC_MUX:
-		iismod |= S3C64XX_IISMOD_IMS_SYSMUX;
+		iismod |= S3C2412_IISMOD_IMS_SYSMUX;
 		break;
 
 	case S3C64XX_CLKSRC_CDCLK:
-- 
1.6.2.5
