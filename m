From: jassisinghbrar@gmail.com
Subject: [PATCH 2/7] ASoC: S3C64XX: Compress and generalize the
	CPU driver
Date: Wed,  9 Dec 2009 13:29:25 +0900
Message-ID: <1260332965-11413-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id C15F1243AF
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 05:36:08 +0100 (CET)
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

From: Jassi Brar <jassi.brar@samsung.com>

The driver can be 'generalized' a bit by not hardcoding '2'(the number of
I2Sv3 controllers that the driver can handle) at many places, instead we
define a macro for it. That makes it easier to increase number of controllers
by changing the parameter at just one place, this will be useful when there is
support for newer SoCs, which have the same controller, only more in number.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |  114 ++++++++++++++-------------------------
 1 files changed, 41 insertions(+), 73 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 8feb029..93ed3aa 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -32,6 +32,11 @@
 #include "s3c-dma.h"
 #include "s3c64xx-i2s.h"
 
+/* The value should be set to maximum of the total number
+ * of I2Sv3 controllers that any supported SoC has.
+ */
+#define MAX_I2SV3	2
+
 static struct s3c2410_dma_client s3c64xx_dma_client_out = {
 	.name		= "I2S PCM Stereo out"
 };
@@ -40,37 +45,12 @@ static struct s3c2410_dma_client s3c64xx_dma_client_in = {
 	.name		= "I2S PCM Stereo in"
 };
 
-static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_out[2] = {
-	[0] = {
-		.channel	= DMACH_I2S0_OUT,
-		.client		= &s3c64xx_dma_client_out,
-		.dma_addr	= S3C64XX_PA_IIS0 + S3C2412_IISTXD,
-		.dma_size	= 4,
-	},
-	[1] = {
-		.channel	= DMACH_I2S1_OUT,
-		.client		= &s3c64xx_dma_client_out,
-		.dma_addr	= S3C64XX_PA_IIS1 + S3C2412_IISTXD,
-		.dma_size	= 4,
-	},
-};
-
-static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_in[2] = {
-	[0] = {
-		.channel	= DMACH_I2S0_IN,
-		.client		= &s3c64xx_dma_client_in,
-		.dma_addr	= S3C64XX_PA_IIS0 + S3C2412_IISRXD,
-		.dma_size	= 4,
-	},
-	[1] = {
-		.channel	= DMACH_I2S1_IN,
-		.client		= &s3c64xx_dma_client_in,
-		.dma_addr	= S3C64XX_PA_IIS1 + S3C2412_IISRXD,
-		.dma_size	= 4,
-	},
-};
+static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_out[MAX_I2SV3];
+static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_in[MAX_I2SV3];
+static struct s3c_i2sv2_info s3c64xx_i2s[MAX_I2SV3];
 
-static struct s3c_i2sv2_info s3c64xx_i2s[2];
+struct snd_soc_dai s3c64xx_i2s_dai[MAX_I2SV3];
+EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
 
 static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
 {
@@ -163,55 +143,13 @@ static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops = {
 	.set_sysclk	= s3c64xx_i2s_set_sysclk,	
 };
 
-struct snd_soc_dai s3c64xx_i2s_dai[] = {
-	{
-		.name		= "s3c64xx-i2s",
-		.id		= 0,
-		.probe		= s3c64xx_i2s_probe,
-		.playback = {
-			.channels_min	= 2,
-			.channels_max	= 2,
-			.rates		= S3C64XX_I2S_RATES,
-			.formats	= S3C64XX_I2S_FMTS,
-		},
-		.capture = {
-			 .channels_min	= 2,
-			 .channels_max	= 2,
-			 .rates		= S3C64XX_I2S_RATES,
-			 .formats	= S3C64XX_I2S_FMTS,
-		 },
-		.ops = &s3c64xx_i2s_dai_ops,
-		.symmetric_rates = 1,
-	},
-	{
-		.name		= "s3c64xx-i2s",
-		.id		= 1,
-		.probe		= s3c64xx_i2s_probe,
-		.playback = {
-			.channels_min	= 2,
-			.channels_max	= 2,
-			.rates		= S3C64XX_I2S_RATES,
-			.formats	= S3C64XX_I2S_FMTS,
-		},
-		.capture = {
-			 .channels_min	= 2,
-			 .channels_max	= 2,
-			 .rates		= S3C64XX_I2S_RATES,
-			 .formats	= S3C64XX_I2S_FMTS,
-		 },
-		.ops = &s3c64xx_i2s_dai_ops,
-		.symmetric_rates = 1,
-	},
-};
-EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
-
 static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 {
 	struct s3c_i2sv2_info *i2s;
 	struct snd_soc_dai *dai;
 	int ret;
 
-	if (pdev->id >= ARRAY_SIZE(s3c64xx_i2s)) {
+	if (pdev->id >= MAX_I2SV3) {
 		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
 		return -EINVAL;
 	}
@@ -219,10 +157,40 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 	i2s = &s3c64xx_i2s[pdev->id];
 	dai = &s3c64xx_i2s_dai[pdev->id];
 	dai->dev = &pdev->dev;
+	dai->name = "s3c64xx-i2s";
+	dai->id = pdev->id;
+	dai->symmetric_rates = 1;
+	dai->playback.channels_min = 2;
+	dai->playback.channels_max = 2;
+	dai->playback.rates = S3C64XX_I2S_RATES;
+	dai->playback.formats = S3C64XX_I2S_FMTS;
+	dai->capture.channels_min = 2;
+	dai->capture.channels_max = 2;
+	dai->capture.rates = S3C64XX_I2S_RATES;
+	dai->capture.formats = S3C64XX_I2S_FMTS;
+	dai->probe = s3c64xx_i2s_probe;
+	dai->ops = &s3c64xx_i2s_dai_ops;
 
 	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
 	i2s->dma_playback = &s3c64xx_i2s_pcm_stereo_out[pdev->id];
 
+	if (pdev->id == 0) {
+		i2s->dma_capture->channel = DMACH_I2S0_IN;
+		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISRXD;
+		i2s->dma_playback->channel = DMACH_I2S0_OUT;
+		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS0 + S3C2412_IISTXD;
+	} else {
+		i2s->dma_capture->channel = DMACH_I2S1_IN;
+		i2s->dma_capture->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISRXD;
+		i2s->dma_playback->channel = DMACH_I2S1_OUT;
+		i2s->dma_playback->dma_addr = S3C64XX_PA_IIS1 + S3C2412_IISTXD;
+	}
+
+	i2s->dma_capture->client = &s3c64xx_dma_client_in;
+	i2s->dma_capture->dma_size = 4;
+	i2s->dma_playback->client = &s3c64xx_dma_client_out;
+	i2s->dma_playback->dma_size = 4;
+
 	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
 	if (IS_ERR(i2s->iis_cclk)) {
 		dev_err(&pdev->dev, "failed to get audio-bus\n");
-- 
1.6.2.5
