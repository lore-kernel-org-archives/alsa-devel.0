From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 16/17] S3C2412: suspend and resume support
Date: Thu, 10 Jan 2008 13:17:14 +0000
Message-ID: <1199971035-13553-16-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-15-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 6508C24586
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:19 +0100 (CET)
In-Reply-To: <1199971035-13553-15-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Ben Dooks <ben-alsa@fluff.org>, Ben Dooks <ben-linux@fluff.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Ben Dooks <ben-alsa@fluff.org>

Support for suspend/resume for the S3C2412 ASoC IIS
core driver.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c2412-i2s.c |   63 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 11fee8b..4520385 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -80,6 +80,10 @@ struct s3c2412_i2s_info {
 	struct clk	*iis_clk;
 	struct clk	*iis_pclk;
 	struct clk	*iis_cclk;
+
+	u32		 suspend_iismod;
+	u32		 suspend_iiscon;
+	u32		 suspend_iispsr;
 };
 
 static struct s3c2412_i2s_info s3c2412_i2s;
@@ -642,6 +646,63 @@ static int s3c2412_i2s_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int s3c2412_i2s_suspend(struct platform_device *dev,
+			      struct snd_soc_cpu_dai *dai)
+{
+	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
+	u32 iismod;
+
+	if (dai->active) {
+		i2s->suspend_iismod = readl(i2s->regs + S3C2412_IISMOD);
+		i2s->suspend_iiscon = readl(i2s->regs + S3C2412_IISCON);
+		i2s->suspend_iispsr = readl(i2s->regs + S3C2412_IISPSR);
+
+		/* some basic suspend checks */
+
+		iismod = readl(i2s->regs + S3C2412_IISMOD);
+
+		if (iismod & S3C2412_IISCON_RXDMA_ACTIVE)
+			dev_warn(&dev->dev, "%s: RXDMA active?\n", __func__);
+
+		if (iismod & S3C2412_IISCON_TXDMA_ACTIVE)
+			dev_warn(&dev->dev, "%s: TXDMA active?\n", __func__);
+
+		if (iismod & S3C2412_IISCON_IIS_ACTIVE)
+			dev_warn(&dev->dev, "%s: IIS active\n", __func__);
+	}
+
+	return 0;
+}
+
+static int s3c2412_i2s_resume(struct platform_device *pdev,
+			      struct snd_soc_cpu_dai *dai)
+{
+	struct s3c2412_i2s_info *i2s = &s3c2412_i2s;
+
+	dev_info(&pdev->dev, "dai_active %d, IISMOD %08x, IISCON %08x\n",
+		 dai->active, i2s->suspend_iismod, i2s->suspend_iiscon);
+
+	if (dai->active) {
+		writel(i2s->suspend_iiscon, i2s->regs + S3C2412_IISCON);
+		writel(i2s->suspend_iismod, i2s->regs + S3C2412_IISMOD);
+		writel(i2s->suspend_iispsr, i2s->regs + S3C2412_IISPSR);
+
+		writel(S3C2412_IISFIC_RXFLUSH | S3C2412_IISFIC_TXFLUSH,
+		       i2s->regs + S3C2412_IISFIC);
+
+		ndelay(250);
+		writel(0x0, i2s->regs + S3C2412_IISFIC);
+
+	}
+
+	return 0;
+}
+#else
+#define s3c2412_i2s_suspend NULL
+#define s3c2412_i2s_resume  NULL
+#endif /* CONFIG_PM */
+
 #define S3C2412_I2S_RATES \
 	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
 	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
@@ -652,6 +713,8 @@ struct snd_soc_cpu_dai s3c2412_i2s_dai = {
 	.id	= 0,
 	.type	= SND_SOC_DAI_I2S,
 	.probe	= s3c2412_i2s_probe,
+	.suspend= s3c2412_i2s_suspend,
+	.resume = s3c2412_i2s_resume,
 	.playback = {
 		.channels_min	= 2,
 		.channels_max	= 2,
-- 
1.5.3.8
