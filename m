From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: Add a bit of resource unwinding in
	the S3C IISv4 driver
Date: Fri, 13 Aug 2010 20:35:01 +0100
Message-ID: <1281728107-25386-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100813193305.GB3778@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B8F521038C8
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 21:35:13 +0200 (CEST)
In-Reply-To: <20100813193305.GB3778@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

There's much more needed but this'll get us started.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
index a13415a..a962847 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
@@ -187,7 +187,18 @@ err:
 
 static __devexit int s3c64xx_i2sv4_dev_remove(struct platform_device *pdev)
 {
+	struct s3c_i2sv2_info *i2s = &s3c64xx_i2sv4;
+	struct resource *res;
+
 	snd_soc_unregister_dai(&pdev->dev);
+	clk_put(i2s->iis_cclk);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
+	else
+		dev_warn(&pdev->dev, "Unable to get I2S SFR address\n");
+		
 	return 0;
 }
 
-- 
1.7.1
