From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: zx296702-i2s: Fix resource leak when
	unload module
Date: Sat, 29 Aug 2015 23:09:30 +0800
Message-ID: <1440860970.28601.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 84DEC260671
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 17:09:35 +0200 (CEST)
Received: by padhm10 with SMTP id hm10so36242178pad.3
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 08:09:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Jun Nie <jun.nie@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use devm_* API to fix leaks in current code.
1. Use devm_kzalloc to fix memory leak for zx_i2s when unload the module.
2. Use devm_snd_soc_register_component to ensure component is unregistered
   when unload the module.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/zte/zx296702-i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/zte/zx296702-i2s.c b/sound/soc/zte/zx296702-i2s.c
index 1930c42..1cad93d 100644
--- a/sound/soc/zte/zx296702-i2s.c
+++ b/sound/soc/zte/zx296702-i2s.c
@@ -380,7 +380,7 @@ static int zx_i2s_probe(struct platform_device *pdev)
 	struct zx_i2s_info *zx_i2s;
 	int ret;
 
-	zx_i2s =  kzalloc(sizeof(*zx_i2s), GFP_KERNEL);
+	zx_i2s = devm_kzalloc(&pdev->dev, sizeof(*zx_i2s), GFP_KERNEL);
 	if (!zx_i2s)
 		return -ENOMEM;
 
@@ -401,8 +401,8 @@ static int zx_i2s_probe(struct platform_device *pdev)
 	writel_relaxed(0, zx_i2s->reg_base + ZX_I2S_FIFO_CTRL);
 	platform_set_drvdata(pdev, zx_i2s);
 
-	ret = snd_soc_register_component(&pdev->dev, &zx_i2s_component,
-					 &zx_i2s_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &zx_i2s_component,
+					      &zx_i2s_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Register DAI failed: %d\n", ret);
 		return ret;
-- 
2.1.0
