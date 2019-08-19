From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 01/21] ASoC: sun4i-i2s: Register regmap and PCM before our component
Date: Mon, 19 Aug 2019 21:25:08 +0200
Message-ID: <67e303f37f141ef73ce9ed47d7f831b63c694424.1566242458.git-series.maxime.ripard@bootlin.com>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, codekipper@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

So far the regmap and the dmaengine PCM are registered after our component
has been, which means that our driver isn't properly initialised by then.

Let's fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 7fa5c61169db..85c3b2c8cd77 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1148,11 +1148,9 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &sun4i_i2s_component,
-					      &sun4i_i2s_dai, 1);
+	ret = sun4i_i2s_init_regmap_fields(&pdev->dev, i2s);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not register DAI\n");
+		dev_err(&pdev->dev, "Could not initialise regmap fields\n");
 		goto err_suspend;
 	}
 
@@ -1162,9 +1160,11 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = sun4i_i2s_init_regmap_fields(&pdev->dev, i2s);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &sun4i_i2s_component,
+					      &sun4i_i2s_dai, 1);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not initialise regmap fields\n");
+		dev_err(&pdev->dev, "Could not register DAI\n");
 		goto err_suspend;
 	}
 
-- 
git-series 0.9.1
