From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 4/4] ASoC: rx1950: Fix clkdiv for 16khz and
	48khz
Date: Tue,  7 Sep 2010 17:04:18 +0300
Message-ID: <1283868258-26493-5-git-send-email-anarsoul@gmail.com>
References: <1283868258-26493-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EF14103821
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 16:16:25 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2233229ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2010 07:16:24 -0700 (PDT)
In-Reply-To: <1283868258-26493-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Philipp Zabel <philipp.zabel@gmail.com>, anarsoul@gmail.com
List-Id: alsa-devel@alsa-project.org

Usage of 256 as clkdiv gives better rounding error (<1%)
for 16khz and 48khz

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/s3c24xx/rx1950_uda1380.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
index 9552296..ffd5cf2 100644
--- a/sound/soc/s3c24xx/rx1950_uda1380.c
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -171,9 +171,9 @@ static int rx1950_hw_params(struct snd_pcm_substream *substream,
 	case 16000:
 	case 48000:
 		clk_source = S3C24XX_CLKSRC_PCLK;
-		fs_mode = S3C2410_IISMOD_384FS;
-		div = s3c24xx_i2s_get_clockrate() / (384 * rate);
-		if (s3c24xx_i2s_get_clockrate() % (384 * rate) > (182 * rate))
+		fs_mode = S3C2410_IISMOD_256FS;
+		div = s3c24xx_i2s_get_clockrate() / (256 * rate);
+		if (s3c24xx_i2s_get_clockrate() % (256 * rate) > (128 * rate))
 			div++;
 		break;
 	case 44100:
-- 
1.7.2.2
