From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rockchip: spdif: Convert to use
 devm_snd_dmaengine_pcm_register
Date: Tue, 13 Oct 2015 10:37:10 +0800
Message-ID: <1444703830.3259.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FBE6265474
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 04:37:16 +0200 (CEST)
Received: by pabve7 with SMTP id ve7so5729094pab.2
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 19:37:14 -0700 (PDT)
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
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

Use resource managed API then we can remove snd_dmaengine_pcm_unregister()
and snd_soc_unregister_component() calls in .probe error path and .remove.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/rockchip/rockchip_spdif.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 9d5c470..a38a302 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -355,16 +355,14 @@ static int rk_spdif_probe(struct platform_device *pdev)
 		goto err_pm_runtime;
 	}
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
-		goto err_pcm_register;
+		goto err_pm_runtime;
 	}
 
 	return 0;
 
-err_pcm_register:
-	snd_dmaengine_pcm_unregister(&pdev->dev);
 err_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
 
@@ -381,8 +379,6 @@ static int rk_spdif_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(spdif->mclk);
 	clk_disable_unprepare(spdif->hclk);
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
 
 	return 0;
 }
-- 
2.1.4
