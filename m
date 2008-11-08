From: Christian Pellegrin <chripell@gmail.com>
Subject: [PATCH] ALSA SOC driver for s3c24xx: 8 bit sound fix
Date: Sat,  8 Nov 2008 08:44:16 +0100
Message-ID: <12261302562876-git-send-email-chripell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id CBD7A103867
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 08:44:09 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so1436969fgg.44
	for <alsa-devel@alsa-project.org>; Fri, 07 Nov 2008 23:44:09 -0800 (PST)
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
Cc: Christian Pellegrin <chripell@fsfe.org>, linux-arm-kernel@lists.arm.linux.org.uk, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org


fixes playing/recording of 8 bit audio files.

Generated on  20081108  against v2.6.27

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 sound/soc/s3c24xx/s3c24xx-i2s.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index ba4476b..c18977b 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -261,10 +261,17 @@ static int s3c24xx_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
+		iismod &= ~S3C2410_IISMOD_16BIT;
+		((struct s3c24xx_pcm_dma_params *)
+		  rtd->dai->cpu_dai->dma_data)->dma_size = 1;
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
 		iismod |= S3C2410_IISMOD_16BIT;
+		((struct s3c24xx_pcm_dma_params *)
+		  rtd->dai->cpu_dai->dma_data)->dma_size = 2;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	writel(iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
--
1.4.4.4
