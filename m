From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: s2c24xx-i2s: remove redundant error message
Date: Wed, 02 Nov 2016 12:11:47 +0100
Message-ID: <1478085107-30865-1-git-send-email-s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: broonie@kernel.org
Cc: krzk@kernel.org, m.szyprowski@samsung.com, alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, sbkim73@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

There is no need to report the resource request error in
the driver as it is already handled within devm_ioremap_resource().
While at it also drop a redundant variable initialization.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/s3c24xx-i2s.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index bc5809a..07f5091 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -426,13 +426,9 @@ static int s3c24xx_i2s_resume(struct snd_soc_dai *cpu_dai)
 static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret = 0;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Can't get IO resource.\n");
-		return -ENOENT;
-	}
 	s3c24xx_i2s.regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(s3c24xx_i2s.regs))
 		return PTR_ERR(s3c24xx_i2s.regs);
-- 
1.9.1
