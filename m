From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] soc - s3c24xx - Improve diagnostic output
Date: Tue, 22 Apr 2008 16:12:51 +0100
Message-ID: <1208877172-16537-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208877172-16537-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64F63245CC
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 17:12:54 +0200 (CEST)
In-Reply-To: <1208877172-16537-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Tim Niemeyer <tim.niemeyer@mastersword.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Niemeyer <reddog@mastersword.de>
List-Id: alsa-devel@alsa-project.org

From: Tim Niemeyer <tim.niemeyer@mastersword.de>

Add some debug messages for suspend/resume and to add a clear prefix to
s3c24xx-i2s and s3c24xx-pcm.

Signed-off-by: Tim Niemeyer <reddog@mastersword.de>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-i2s.c |    5 ++++-
 sound/soc/s3c24xx/s3c24xx-pcm.c |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 7d38f55..df71c9d 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -46,7 +46,7 @@
 
 #define S3C24XX_I2S_DEBUG 0
 #if S3C24XX_I2S_DEBUG
-#define DBG(x...) printk(KERN_DEBUG x)
+#define DBG(x...) printk(KERN_DEBUG "s3c24xx-i2s: " x)
 #else
 #define DBG(x...)
 #endif
@@ -415,6 +415,8 @@ static int s3c24xx_i2s_probe(struct platform_device *pdev)
 int s3c24xx_i2s_suspend(struct platform_device *pdev,
 		struct snd_soc_cpu_dai *cpu_dai)
 {
+	DBG("Entered %s\n", __func__);
+
 	s3c24xx_i2s.iiscon = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
 	s3c24xx_i2s.iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
 	s3c24xx_i2s.iisfcon = readl(s3c24xx_i2s.regs + S3C2410_IISFCON);
@@ -428,6 +430,7 @@ int s3c24xx_i2s_suspend(struct platform_device *pdev,
 int s3c24xx_i2s_resume(struct platform_device *pdev,
 		struct snd_soc_cpu_dai *cpu_dai)
 {
+	DBG("Entered %s\n", __func__);
 	clk_enable(s3c24xx_i2s.iis_clk);
 
 	writel(s3c24xx_i2s.iiscon, s3c24xx_i2s.regs + S3C2410_IISCON);
diff --git a/sound/soc/s3c24xx/s3c24xx-pcm.c b/sound/soc/s3c24xx/s3c24xx-pcm.c
index 29a6c82..5394a40 100644
--- a/sound/soc/s3c24xx/s3c24xx-pcm.c
+++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
@@ -39,7 +39,7 @@
 
 #define S3C24XX_PCM_DEBUG 0
 #if S3C24XX_PCM_DEBUG
-#define DBG(x...) printk(KERN_DEBUG x)
+#define DBG(x...) printk(KERN_DEBUG "s3c24xx-pcm: " x)
 #else
 #define DBG(x...)
 #endif
-- 
1.5.5
