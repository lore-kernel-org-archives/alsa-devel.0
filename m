From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] beyond ARRAY_SIZE of s3c64xx_i2s
Date: Wed, 20 May 2009 17:09:50 +0200
Message-ID: <4A141D3E.7030609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 37007245B0
	for <alsa-devel@alsa-project.org>;
	Wed, 20 May 2009 17:09:55 +0200 (CEST)
Received: by ewy23 with SMTP id 23so603385ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 20 May 2009 08:09:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Do not go beyond ARRAY_SIZE of s3c64xx_i2s

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
In this case you are Maintainer, correct?

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 33c5de7..f2d3021 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -126,7 +126,7 @@ static int s3c64xx_i2s_probe(struct platform_device *pdev,
 
 	dev_dbg(dev, "%s: probing dai %d\n", __func__, pdev->id);
 
-	if (pdev->id < 0 || pdev->id > ARRAY_SIZE(s3c64xx_i2s)) {
+	if (pdev->id < 0 || pdev->id >= ARRAY_SIZE(s3c64xx_i2s)) {
 		dev_err(dev, "id %d out of range\n", pdev->id);
 		return -EINVAL;
 	}
