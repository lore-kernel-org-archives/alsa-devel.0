From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/18] ASoC: Fix error message formatting in
	s3c64xx-i2s driver
Date: Tue,  5 May 2009 11:02:14 +0100
Message-ID: <1241517751-2634-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C979B24513
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:34 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 1345fbd..7679f7b 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -215,7 +215,7 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 
 	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
 	if (IS_ERR(i2s->iis_cclk)) {
-		dev_err(&pdev->dev, "failed to get audio-bus");
+		dev_err(&pdev->dev, "failed to get audio-bus\n");
 		ret = PTR_ERR(i2s->iis_cclk);
 		goto err;
 	}
-- 
1.6.2.4
