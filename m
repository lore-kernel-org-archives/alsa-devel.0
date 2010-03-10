From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 08/20] ASoC: S3C64XX: I2S: Move RATE and FMT
	defines to header
Date: Wed, 10 Mar 2010 16:48:57 +0900
Message-ID: <1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DD7D24346
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 08:58:03 +0100 (CET)
In-Reply-To: <1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
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

In order for the RATE and FMT defines to be reuseable in future by the
i2sv4 driver, move the MACROs out to the header file.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |    9 ---------
 sound/soc/s3c24xx/s3c64xx-i2s.h |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 39563ed..6552894 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -127,15 +127,6 @@ static int s3c64xx_i2s_probe(struct platform_device *pdev,
 }
 
 
-#define S3C64XX_I2S_RATES \
-	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
-	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
-	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
-
-#define S3C64XX_I2S_FMTS \
-	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |\
-	 SNDRV_PCM_FMTBIT_S24_LE)
-
 static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops = {
 	.set_sysclk	= s3c64xx_i2s_set_sysclk,	
 };
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
index e350d28..53d2a0a 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.h
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.h
@@ -27,6 +27,15 @@ struct clk;
 #define S3C64XX_CLKSRC_MUX	S3C_I2SV2_CLKSRC_AUDIOBUS
 #define S3C64XX_CLKSRC_CDCLK    S3C_I2SV2_CLKSRC_CDCLK
 
+#define S3C64XX_I2S_RATES \
+	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
+	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+
+#define S3C64XX_I2S_FMTS \
+	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |\
+	 SNDRV_PCM_FMTBIT_S24_LE)
+
 extern struct snd_soc_dai s3c64xx_i2s_dai[];
 
 extern struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai);
-- 
1.6.2.5
