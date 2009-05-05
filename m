From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/18] ASoC: Make S3C64xx clock export function
	to return struct clk
Date: Tue,  5 May 2009 11:02:16 +0100
Message-ID: <1241517751-2634-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D4522451A
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:35 +0200 (CEST)
In-Reply-To: <20090505100123.GB2050@rakim.wolfsonmicro.main>
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

This makes the interface usable with the s3c-iis-v2 rate calculator
and consistent with S3C2412.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |    7 +++----
 sound/soc/s3c24xx/s3c64xx-i2s.h |    4 +++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 7679f7b..cb11f78 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -108,14 +108,13 @@ static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
-
-unsigned long s3c64xx_i2s_get_clockrate(struct snd_soc_dai *dai)
+struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai)
 {
 	struct s3c_i2sv2_info *i2s = to_info(dai);
 
-	return clk_get_rate(i2s->iis_cclk);
+	return i2s->iis_cclk;
 }
-EXPORT_SYMBOL_GPL(s3c64xx_i2s_get_clockrate);
+EXPORT_SYMBOL_GPL(s3c64xx_i2s_get_clock);
 
 static int s3c64xx_i2s_probe(struct platform_device *pdev,
 			     struct snd_soc_dai *dai)
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
index 597822a..02148ce 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.h
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.h
@@ -15,6 +15,8 @@
 #ifndef __SND_SOC_S3C24XX_S3C64XX_I2S_H
 #define __SND_SOC_S3C24XX_S3C64XX_I2S_H __FILE__
 
+struct clk;
+
 #include "s3c-i2s-v2.h"
 
 #define S3C64XX_DIV_BCLK	S3C_I2SV2_DIV_BCLK
@@ -26,6 +28,6 @@
 
 extern struct snd_soc_dai s3c64xx_i2s_dai[];
 
-extern unsigned long s3c64xx_i2s_get_clockrate(struct snd_soc_dai *cpu_dai);
+extern struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai);
 
 #endif /* __SND_SOC_S3C24XX_S3C64XX_I2S_H */
-- 
1.6.2.4
