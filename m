From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 1/3] ASoC: multi-component - Fix S3C compile
	error
Date: Thu, 15 Jul 2010 17:58:46 +0900
Message-ID: <1279184328-31746-1-git-send-email-sw.youn@samsung.com>
References: <git send-email --to alsa-devel@alsa-project.org --cc "Liam
	Girdwood <lrg@slimlogic.co.uk>" --cc "Mark Brown
	<broonie@opensource.wolfsonmicro.com>" --cc "Jassi Brar
	<jassisinghbrar@gmail.com>" --cc "Seungwhan Youn
	<claude.youn@gmail.com>" 000*>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 384AB1037FC
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 11:09:47 +0200 (CEST)
In-Reply-To: <git send-email --to alsa-devel@alsa-project.org --cc "Liam
	Girdwood <lrg@slimlogic.co.uk>" --cc "Mark Brown
	<broonie@opensource.wolfsonmicro.com>" --cc "Jassi Brar
	<jassisinghbrar@gmail.com>" --cc "Seungwhan Youn
	<claude.youn@gmail.com>" 000*>
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch fix compile error on using S3C I2S.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index ad92e10..5017e31 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -56,11 +56,11 @@ static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 
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
@@ -90,7 +90,7 @@ struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai)
 	struct s3c_i2sv2_info *i2s = snd_soc_dai_get_drvdata(dai);
 	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
 
-	if (iismod & S3C64XX_IISMOD_IMS_SYSMUX)
+	if (iismod & S3C2412_IISMOD_IMS_SYSMUX)
 		return i2s->iis_cclk;
 	else
 		return i2s->iis_pclk;
-- 
1.6.2.5
