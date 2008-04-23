From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 02/11] soc - s3c24xx-i2s - Fix tab/space
	breakage
Date: Wed, 23 Apr 2008 13:07:56 +0100
Message-ID: <1208952485-20385-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208952485-20385-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E1580244CF
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 14:08:07 +0200 (CEST)
In-Reply-To: <1208952485-20385-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-i2s.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index c95ebe2..36de130 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -159,10 +159,10 @@ static void s3c24xx_snd_rxctrl(int on)
 		 * DMA engine will simply freeze randomly.
 		 */
 
-        iisfcon &= ~S3C2410_IISFCON_RXENABLE;
-        iisfcon &= ~S3C2410_IISFCON_RXDMA;
-        iiscon  |= S3C2410_IISCON_RXIDLE;
-        iiscon  &= ~S3C2410_IISCON_RXDMAEN;
+		iisfcon &= ~S3C2410_IISFCON_RXENABLE;
+		iisfcon &= ~S3C2410_IISFCON_RXDMA;
+		iiscon  |= S3C2410_IISCON_RXIDLE;
+		iiscon  &= ~S3C2410_IISCON_RXDMAEN;
 		iismod  &= ~S3C2410_IISMOD_RXMODE;
 
 		writel(iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
-- 
1.5.5.1
