From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/17] ASoC: Enforce symmetric rates for
	S3C64xx I2S interface
Date: Tue, 28 Apr 2009 16:23:30 +0100
Message-ID: <1240932222-3718-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA91810389C
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:23:46 +0200 (CEST)
In-Reply-To: <20090428152256.GB2244@rakim.wolfsonmicro.main>
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

There is only one LRCLK pin on each interface.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index a84c4be..c335248 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -171,6 +171,7 @@ struct snd_soc_dai s3c64xx_i2s_dai[] = {
 			 .formats	= S3C64XX_I2S_FMTS,
 		 },
 		.ops = &s3c64xx_i2s_dai_ops,
+		.symmetric_rates = 1,
 	},
 	{
 		.name		= "s3c64xx-i2s",
@@ -189,6 +190,7 @@ struct snd_soc_dai s3c64xx_i2s_dai[] = {
 			 .formats	= S3C64XX_I2S_FMTS,
 		 },
 		.ops = &s3c64xx_i2s_dai_ops,
+		.symmetric_rates = 1,
 	},
 };
 EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
-- 
1.6.2.4
