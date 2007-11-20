From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Support suspend and resume of the I2S
	interface on s3c24xx.
Date: Tue, 20 Nov 2007 09:25:26 +0000
Message-ID: <1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 54D8424A28
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:45:41 +0100 (CET)
In-Reply-To: <1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: liam.girdwood@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <graeme@openmoko.com>
List-Id: alsa-devel@alsa-project.org

From: Graeme Gregory <graeme@openmoko.com>

Signed-off-by: Graeme Gregory <graeme@openmoko.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-i2s.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index cd89c41..fee7925 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -75,6 +75,10 @@ static struct s3c24xx_pcm_dma_params s3c24xx_i2s_pcm_stereo_in = {
 struct s3c24xx_i2s_info {
 	void __iomem	*regs;
 	struct clk	*iis_clk;
+	u32		iiscon;
+	u32		iismod;
+	u32		iisfcon;
+	u32		iispsr;
 };
 static struct s3c24xx_i2s_info s3c24xx_i2s;
 
@@ -405,6 +409,38 @@ static int s3c24xx_i2s_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+int s3c24xx_i2s_suspend(struct platform_device *pdev,
+		struct snd_soc_cpu_dai *cpu_dai)
+{
+	s3c24xx_i2s.iiscon = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
+	s3c24xx_i2s.iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
+	s3c24xx_i2s.iisfcon = readl(s3c24xx_i2s.regs + S3C2410_IISFCON);
+	s3c24xx_i2s.iispsr = readl(s3c24xx_i2s.regs + S3C2410_IISPSR);
+
+	clk_disable(s3c24xx_i2s.iis_clk);
+
+	return 0;
+}
+
+int s3c24xx_i2s_resume(struct platform_device *pdev,
+		struct snd_soc_cpu_dai *cpu_dai)
+{
+	clk_enable(s3c24xx_i2s.iis_clk);
+
+	writel(s3c24xx_i2s.iiscon, s3c24xx_i2s.regs + S3C2410_IISCON);
+	writel(s3c24xx_i2s.iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
+	writel(s3c24xx_i2s.iisfcon, s3c24xx_i2s.regs + S3C2410_IISFCON);
+	writel(s3c24xx_i2s.iispsr, s3c24xx_i2s.regs + S3C2410_IISPSR);
+
+	return 0;
+}
+#else
+#define s3c24xx_i2s_suspend NULL
+#define s3c24xx_i2s_resume NULL
+#endif
+
+
 #define S3C24XX_I2S_RATES \
 	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
 	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
@@ -415,6 +451,8 @@ struct snd_soc_cpu_dai s3c24xx_i2s_dai = {
 	.id = 0,
 	.type = SND_SOC_DAI_I2S,
 	.probe = s3c24xx_i2s_probe,
+	.suspend = s3c24xx_i2s_suspend,
+	.resume = s3c24xx_i2s_resume,
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
-- 
1.5.3.5
