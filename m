From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 2/3] ASoC: Samsung: Debug PCM
	snd_soc_dai_driver registration
Date: Fri, 10 Sep 2010 16:41:05 +0900
Message-ID: <1284104465-17287-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id CDA9A103939
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 09:57:24 +0200 (CEST)
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
Cc: sw.youn@samsung.com, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Each of the two PCM controllers need to be registered during probe
with appropriate 'name' of the dai driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-pcm.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/s3c-pcm.c
index 6174e26..d404f80 100644
--- a/sound/soc/s3c24xx/s3c-pcm.c
+++ b/sound/soc/s3c24xx/s3c-pcm.c
@@ -361,8 +361,6 @@ static struct snd_soc_dai_ops s3c_pcm_dai_ops = {
 #define S3C_PCM_RATES  SNDRV_PCM_RATE_8000_96000
 
 #define S3C_PCM_DAI_DECLARE			\
-{								\
-	.name		 = "samsung-dai",			\
 	.symmetric_rates = 1,					\
 	.ops = &s3c_pcm_dai_ops,				\
 	.playback = {						\
@@ -376,12 +374,17 @@ static struct snd_soc_dai_ops s3c_pcm_dai_ops = {
 		.channels_max	= 2,				\
 		.rates		= S3C_PCM_RATES,		\
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE,	\
-	},							\
-}
+	}
 
 struct snd_soc_dai_driver s3c_pcm_dai[] = {
-	S3C_PCM_DAI_DECLARE,
-	S3C_PCM_DAI_DECLARE,
+	[0] = {
+		.name	= "samsung-pcm.0",
+		S3C_PCM_DAI_DECLARE,
+	},
+	[1] = {
+		.name	= "samsung-pcm.1",
+		S3C_PCM_DAI_DECLARE,
+	},
 };
 EXPORT_SYMBOL_GPL(s3c_pcm_dai);
 
@@ -465,7 +468,7 @@ static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
 	}
 	clk_enable(pcm->pclk);
 
-	ret = snd_soc_register_dai(&pdev->dev, s3c_pcm_dai);
+	ret = snd_soc_register_dai(&pdev->dev, &s3c_pcm_dai[pdev->id]);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "failed to get pcm_clock\n");
 		goto err5;
-- 
1.6.2.5
