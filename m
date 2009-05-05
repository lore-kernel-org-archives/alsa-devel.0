From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/18] ASoC: Fix data format configuration for
	S3C64xx IISv2 and add 24 bit
Date: Tue,  5 May 2009 11:02:17 +0100
Message-ID: <1241517751-2634-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0EDE72451B
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

The data format configuration for S3C64xx IISv2 is completely different
to that for S3C24xx. Instead of a single bit configuration in bit 0 of
IISMOD we have format selection in bits 13 and 14 and bit clock rate
selection in bits 1 and 2. While we're here add support for 24 bit
samples in S3C64xx.

At some point it may be desirable to expose the bit clock rate selection
to users but given the limited configuration options that may not be
required.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c  |   22 +++++++++++++++++++++-
 sound/soc/s3c24xx/s3c64xx-i2s.c |    3 ++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 3b9201c..54f4119 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -280,7 +280,7 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
  */
 #define IISMOD_MASTER_MASK (1 << 11)
 #define IISMOD_SLAVE (1 << 11)
-#define IISMOD_MASTER (0x0)
+#define IISMOD_MASTER (0 << 11)
 #endif
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -341,6 +341,7 @@ static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
 	iismod = readl(i2s->regs + S3C2412_IISMOD);
 	pr_debug("%s: r: IISMOD: %x\n", __func__, iismod);
 
+#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		iismod |= S3C2412_IISMOD_8BIT;
@@ -349,6 +350,25 @@ static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
 		iismod &= ~S3C2412_IISMOD_8BIT;
 		break;
 	}
+#endif
+
+#ifdef CONFIG_PLAT_S3C64XX
+	iismod &= ~0x606;
+	/* Sample size */
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		/* 8 bit sample, 16fs BCLK */
+		iismod |= 0x2004;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		/* 16 bit sample, 32fs BCLK */
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		/* 24 bit sample, 48fs BCLK */
+		iismod |= 0x4002;
+		break;
+	}
+#endif
 
 	writel(iismod, i2s->regs + S3C2412_IISMOD);
 	pr_debug("%s: w: IISMOD: %x\n", __func__, iismod);
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index cb11f78..e0f4a16 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -146,7 +146,8 @@ static int s3c64xx_i2s_probe(struct platform_device *pdev,
 	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
 #define S3C64XX_I2S_FMTS \
-	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE)
+	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |\
+	 SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops = {
 	.set_sysclk	= s3c64xx_i2s_set_sysclk,	
-- 
1.6.2.4
