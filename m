From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH] s3c2412-i2s: Fix dai registration
Date: Mon, 30 Apr 2012 13:17:21 +0200
Message-ID: <201204301317.21519.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s15407518.onlinehome-server.info
	(s15407518.onlinehome-server.info [82.165.136.167])
	by alsa0.perex.cz (Postfix) with ESMTP id 9092B244A8
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 13:17:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sbkim73@samsung.com, lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As s3c2412-i2s is using the s3c_i2sv2 it should call the more specialised
s3c_i2sv2_register_dai instead of simply calling snd_soc_register_dai.

Without this call the snd_soc_dai_ops structure isn't initialised correctly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 sound/soc/samsung/s3c2412-i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 7218507..79fbeea 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -166,7 +166,7 @@ static struct snd_soc_dai_driver s3c2412_i2s_dai = {
 
 static __devinit int s3c2412_iis_dev_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_dai(&pdev->dev, &s3c2412_i2s_dai);
+	return s3c_i2sv2_register_dai(&pdev->dev, -1, &s3c2412_i2s_dai);
 }
 
 static __devexit int s3c2412_iis_dev_remove(struct platform_device *pdev)
-- 
1.7.5.4
