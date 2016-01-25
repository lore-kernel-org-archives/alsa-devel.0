From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] ASoC: mxs-saif: add mclk enable/disable ops
Date: Mon, 25 Jan 2016 12:38:46 +0000
Message-ID: <1453725526-6337-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This makes normal clk_enable/disable() calls on mxs_saif_mclk work as
expected, i.e. actually turn the mclk output on or (when safe) off.
The existing mxs_saif_get/put_mclk() functions are rewritten to use
common clk operations on mxs_saif_mclk rather than accessing registers
directly.

With these changes mxs-saif can be used together with the simple-card
driver.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 sound/soc/mxs/mxs-saif.c | 144 +++++++++++++++++++++++++++++++----------------
 sound/soc/mxs/mxs-saif.h |   2 +
 2 files changed, 98 insertions(+), 48 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 13631003cb7c..bc75b37cd21d 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -204,27 +204,15 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
  */
 int mxs_saif_put_mclk(unsigned int saif_id)
 {
-	struct mxs_saif *saif = mxs_saif[saif_id];
-	u32 stat;
+	struct clk *clk;
 
-	if (!saif)
-		return -EINVAL;
+	clk = clk_get(NULL, "mxs_saif_mclk");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
-	stat = __raw_readl(saif->base + SAIF_STAT);
-	if (stat & BM_SAIF_STAT_BUSY) {
-		dev_err(saif->dev, "error: busy\n");
-		return -EBUSY;
-	}
+	clk_disable_unprepare(clk);
+	clk_put(clk);
 
-	clk_disable_unprepare(saif->clk);
-
-	/* disable MCLK output */
-	__raw_writel(BM_SAIF_CTRL_CLKGATE,
-		saif->base + SAIF_CTRL + MXS_SET_ADDR);
-	__raw_writel(BM_SAIF_CTRL_RUN,
-		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
-
-	saif->mclk_in_use = 0;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mxs_saif_put_mclk);
@@ -239,47 +227,33 @@ int mxs_saif_get_mclk(unsigned int saif_id, unsigned int mclk,
 					unsigned int rate)
 {
 	struct mxs_saif *saif = mxs_saif[saif_id];
-	u32 stat;
 	int ret;
 	struct mxs_saif *master_saif;
+	struct clk *clk;
 
 	if (!saif)
 		return -EINVAL;
 
-	/* Clear Reset */
-	__raw_writel(BM_SAIF_CTRL_SFTRST,
-		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
-
-	/* FIXME: need clear clk gate for register r/w */
-	__raw_writel(BM_SAIF_CTRL_CLKGATE,
-		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
-
 	master_saif = mxs_saif_get_master(saif);
 	if (saif != master_saif) {
 		dev_err(saif->dev, "can not get mclk from a non-master saif\n");
 		return -EINVAL;
 	}
 
-	stat = __raw_readl(saif->base + SAIF_STAT);
-	if (stat & BM_SAIF_STAT_BUSY) {
-		dev_err(saif->dev, "error: busy\n");
-		return -EBUSY;
-	}
+	clk = clk_get(NULL, "mxs_saif_mclk");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto out;
 
-	saif->mclk_in_use = 1;
 	ret = mxs_saif_set_clk(saif, mclk, rate);
-	if (ret)
-		return ret;
 
-	ret = clk_prepare_enable(saif->clk);
-	if (ret)
-		return ret;
+out:
+	clk_put(clk);
 
-	/* enable MCLK output */
-	__raw_writel(BM_SAIF_CTRL_RUN,
-		saif->base + SAIF_CTRL + MXS_SET_ADDR);
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mxs_saif_get_mclk);
 
@@ -687,18 +661,92 @@ static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#define to_mxs_saif(c) container_of(c, struct mxs_saif, div_clk.hw)
+
+static int mxs_saif_mclk_enable(struct clk_hw *hw)
+{
+	struct mxs_saif *saif = to_mxs_saif(hw);
+
+	/* Clear Reset */
+	__raw_writel(BM_SAIF_CTRL_SFTRST,
+		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+
+	/* Clear clk gate */
+	__raw_writel(BM_SAIF_CTRL_CLKGATE,
+		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+
+	/* enable MCLK output */
+	__raw_writel(BM_SAIF_CTRL_RUN,
+		saif->base + SAIF_CTRL + MXS_SET_ADDR);
+
+	saif->mclk_in_use = 1;
+
+	return 0;
+}
+
+static void mxs_saif_mclk_disable(struct clk_hw *hw)
+{
+	struct mxs_saif *saif = to_mxs_saif(hw);
+
+	if (!saif->ongoing)
+		__raw_writel(BM_SAIF_CTRL_RUN,
+			     saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+
+	saif->mclk_in_use = 0;
+}
+
+static unsigned long mxs_saif_mclk_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	return clk_divider_ops.recalc_rate(hw, parent_rate);
+}
+
+static long mxs_saif_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	return clk_divider_ops.round_rate(hw, rate, parent_rate);
+}
+
+static int mxs_saif_mclk_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	return clk_divider_ops.set_rate(hw, rate, parent_rate);
+}
+
+static const struct clk_ops mxs_saif_mclk_ops = {
+	.enable		= mxs_saif_mclk_enable,
+	.disable	= mxs_saif_mclk_disable,
+	.recalc_rate	= mxs_saif_mclk_recalc_rate,
+	.round_rate	= mxs_saif_mclk_round_rate,
+	.set_rate	= mxs_saif_mclk_set_rate,
+};
+
 static int mxs_saif_mclk_init(struct platform_device *pdev)
 {
 	struct mxs_saif *saif = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+	struct clk_init_data init;
+	struct clk_divider *div;
 	struct clk *clk;
+	const char *parent_name;
 	int ret;
 
-	clk = clk_register_divider(&pdev->dev, "mxs_saif_mclk",
-				   __clk_get_name(saif->clk), 0,
-				   saif->base + SAIF_CTRL,
-				   BP_SAIF_CTRL_BITCLK_MULT_RATE, 3,
-				   0, NULL);
+	parent_name = __clk_get_name(saif->clk);
+
+	init.name = "mxs_saif_mclk";
+	init.ops = &mxs_saif_mclk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE | CLK_IS_BASIC;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	div = &saif->div_clk;
+	div->reg = saif->base + SAIF_CTRL;
+	div->shift = BP_SAIF_CTRL_BITCLK_MULT_RATE;
+	div->width = 3;
+	div->flags = CLK_DIVIDER_POWER_OF_TWO;
+	div->hw.init = &init;
+
+	clk = clk_register(&pdev->dev, &div->hw);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
 		if (ret == -EEXIST)
diff --git a/sound/soc/mxs/mxs-saif.h b/sound/soc/mxs/mxs-saif.h
index 9a4c0b291b9e..1ad373e293ac 100644
--- a/sound/soc/mxs/mxs-saif.h
+++ b/sound/soc/mxs/mxs-saif.h
@@ -128,6 +128,8 @@ struct mxs_saif {
 		MXS_SAIF_STATE_STOPPED,
 		MXS_SAIF_STATE_RUNNING,
 	} state;
+
+	struct clk_divider div_clk;
 };
 
 extern int mxs_saif_put_mclk(unsigned int saif_id);
-- 
2.7.0
