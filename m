From: Ben Dooks <ben-alsa@fluff.org>
Subject: S3C2412: suspend and resume support
Date: Tue, 20 Nov 2007 12:33:34 +0000
Message-ID: <20071120123334.GA27701@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kira.home.fluff.org (87-194-8-8.bethere.co.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CD1424A09
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 13:33:34 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Devel List <alsa-devel@alsa-project.org>, Liam Girwood <liam.girdwood@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Vincent Sanders <vince@simtec.co.uk>
List-Id: alsa-devel@alsa-project.org

Support for suspend/resume for the S3C2412 ASoC IIS
core driver.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urpN -X linux-2.6.24-rc3-asoc1/Documentation/dontdiff linux-2.6.24-rc3-asoc1/sound/soc/s3c24xx/s3c2412-i2s.c linux-2.6.24-rc3-asoc2/sound/soc/s3c24xx/s3c2412-i2s.c
--- linux-2.6.24-rc3-asoc1/sound/soc/s3c24xx/s3c2412-i2s.c	2007-11-19 21:28:16.000000000 +0000
+++ linux-2.6.24-rc3-asoc2/sound/soc/s3c24xx/s3c2412-i2s.c	2007-11-20 12:29:46.000000000 +0000
@@ -79,6 +79,10 @@ struct s3c2412_i2s_info {
 	struct clk	*iis_clk;
 	struct clk	*iis_pclk;
 	struct clk	*iis_cclk;
+
+	u32		 suspend_iismod;
+	u32		 suspend_iiscon;
+	u32		 suspend_iispsr;
 };
 
 static struct s3c2412_i2s_info s3c2412_i2s;
@@ -381,7 +385,7 @@ static int s3c2412_i2s_trigger(struct sn
 	case SNDRV_PCM_TRIGGER_START:
 		/* On start, ensure that the FIFOs are cleared and reset. */
 
-		writel(capture ? S3C2412_IISFIC_RXFLUSH : S3C2412_IISFIC_TXFLUSH,
+		writel(capture ? S3C2412_IISFIC_RXFLUSH : S3C2412_IISFIC_TXFLUSH  ,
 		       s3c2412_i2s.regs + S3C2412_IISFIC);
 
 		/* clear again, just in case */
@@ -645,6 +649,63 @@ static int s3c2412_i2s_probe(struct plat
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
@@ -655,6 +716,8 @@ struct snd_soc_cpu_dai s3c2412_i2s_dai =
 	.id	= 0,
 	.type	= SND_SOC_DAI_I2S,
 	.probe	= s3c2412_i2s_probe,
+	.suspend= s3c2412_i2s_suspend,
+	.resume = s3c2412_i2s_resume,
 	.playback = {
 		.channels_min	= 2,
 		.channels_max	= 2,
