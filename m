From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: kirkwood-i2s: Use devm_clk_get() for
	extclk
Date: Mon, 15 Jul 2013 16:42:50 +0100
Message-ID: <1373902970-935-3-git-send-email-broonie@kernel.org>
References: <1373902970-935-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 09603261687
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 17:43:02 +0200 (CEST)
In-Reply-To: <1373902970-935-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 4c9dad3..44412ea 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -498,10 +498,9 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	priv->extclk = clk_get(&pdev->dev, "extclk");
+	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
 	if (!IS_ERR(priv->extclk)) {
 		if (priv->extclk == priv->clk) {
-			clk_put(priv->extclk);
 			priv->extclk = ERR_PTR(-EINVAL);
 		} else {
 			dev_info(&pdev->dev, "found external clock\n");
@@ -529,10 +528,8 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return 0;
 	dev_err(&pdev->dev, "snd_soc_register_component failed\n");
 
-	if (!IS_ERR(priv->extclk)) {
+	if (!IS_ERR(priv->extclk))
 		clk_disable_unprepare(priv->extclk);
-		clk_put(priv->extclk);
-	}
 	clk_disable_unprepare(priv->clk);
 
 	return err;
@@ -544,10 +541,8 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_component(&pdev->dev);
 
-	if (!IS_ERR(priv->extclk)) {
+	if (!IS_ERR(priv->extclk))
 		clk_disable_unprepare(priv->extclk);
-		clk_put(priv->extclk);
-	}
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
-- 
1.8.3.2
