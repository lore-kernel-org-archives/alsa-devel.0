From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] soc - S3C2410 i2s - Add support for master
	and left justified modes
Date: Mon,  5 May 2008 13:13:59 +0100
Message-ID: <1209989640-2870-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1209989640-2870-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B84AB243CB
	for <alsa-devel@alsa-project.org>;
	Mon,  5 May 2008 14:14:02 +0200 (CEST)
In-Reply-To: <1209989640-2870-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, "ing. Davide Rizzo" <davide@elpa.it>
List-Id: alsa-devel@alsa-project.org

From: ing. Davide Rizzo <davide@elpa.it>

S3C2410 i2s driver currently manages only i2s protocol (and not left
justified one) and slave mode.
With this small patch, other modes are possible.

This patch to correctly manage codecs in slave mode and left-justified format

Signed-off-by: Davide Rizzo <davide@elpa.it>
Acked-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-i2s.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 4ebcd6a..1ed6afd 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -224,6 +224,7 @@ static int s3c24xx_i2s_set_fmt(struct snd_soc_cpu_dai *cpu_dai,
 		iismod |= S3C2410_IISMOD_SLAVE;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
+		iismod &= ~S3C2410_IISMOD_SLAVE;
 		break;
 	default:
 		return -EINVAL;
@@ -234,6 +235,7 @@ static int s3c24xx_i2s_set_fmt(struct snd_soc_cpu_dai *cpu_dai,
 		iismod |= S3C2410_IISMOD_MSB;
 		break;
 	case SND_SOC_DAIFMT_I2S:
+		iismod &= ~S3C2410_IISMOD_MSB;
 		break;
 	default:
 		return -EINVAL;
-- 
1.5.5.1
