From: Matt Reimer <mreimer@vpop.net>
Subject: [PATCH] Make s3c24xx_i2s_set_clkdiv() change the
	correct bits
Date: Wed, 11 Jul 2007 17:03:50 -0700
Message-ID: <11841986301448-git-send-email-mreimer@vpop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vpop.net (dns1.vpop.net [216.193.240.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 277A9103826
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 02:04:51 +0200 (CEST)
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
Cc: Matt Reimer <mreimer@vpop.net>
List-Id: alsa-devel@alsa-project.org

Make s3c24xx_i2s_set_clkdiv() change the correct bits.

Signed-off-by: Matt Reimer <mreimer@vpop.net>
---
 sound/soc/s3c24xx/s3c24xx-i2s.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 8ca314d..39f0246 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -344,11 +344,11 @@ static int s3c24xx_i2s_set_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
 	DBG("Entered %s\n", __FUNCTION__);
 
 	switch (div_id) {
-	case S3C24XX_DIV_MCLK:
+	case S3C24XX_DIV_BCLK:
 		reg = readl(s3c24xx_i2s.regs + S3C2410_IISMOD) & ~S3C2410_IISMOD_FS_MASK;
 		writel(reg | div, s3c24xx_i2s.regs + S3C2410_IISMOD);
 		break;
-	case S3C24XX_DIV_BCLK:
+	case S3C24XX_DIV_MCLK:
 		reg = readl(s3c24xx_i2s.regs + S3C2410_IISMOD) & ~(S3C2410_IISMOD_384FS);
 		writel(reg | div, s3c24xx_i2s.regs + S3C2410_IISMOD);
 		break;
-- 
1.5.1.4
