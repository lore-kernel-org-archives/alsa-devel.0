From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 04/17] ASoC: S3C2412: Failing to get the I2S
	clock is an error
Date: Tue, 28 Apr 2009 16:23:29 +0100
Message-ID: <1240932222-3718-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 04D64103850
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 17:23:44 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c2412-i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index b7e0b3f..168a088 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -120,7 +120,7 @@ static int s3c2412_i2s_probe(struct platform_device *pdev,
 
 	s3c2412_i2s.iis_cclk = clk_get(&pdev->dev, "i2sclk");
 	if (s3c2412_i2s.iis_cclk == NULL) {
-		pr_debug("failed to get i2sclk clock\n");
+		pr_err("failed to get i2sclk clock\n");
 		iounmap(s3c2412_i2s.regs);
 		return -ENODEV;
 	}
-- 
1.6.2.4
