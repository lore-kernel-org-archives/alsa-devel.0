From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Move registers cache to
	common driver data structure" to the asoc tree
Date: Wed, 13 Feb 2019 11:53:36 +0000 (GMT)
Message-ID: <20190213115336.1222B1128158@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C95AF267497
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 12:53:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Move registers cache to common driver data structure

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 81bcbf2c72948d36ba431ac0812d7d7c3d8da0ce Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 12 Feb 2019 19:03:27 +0100
Subject: [PATCH] ASoC: samsung: i2s: Move registers cache to common driver
 data structure

There is no need to keep the PM suspend/resume register cache separate
for each DAI as those registers are common, move related i2s_dai data
structure to the driver's common data structure.  This will allow us
to simplify the code a little eventually and to make it easier to follow.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d8414d781f83..72f0cb7abb30 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -86,9 +86,6 @@ struct i2s_dai {
 	struct snd_dmaengine_dai_dma_data idma_playback;
 	dma_filter_fn filter;
 	u32	quirks;
-	u32	suspend_i2smod;
-	u32	suspend_i2scon;
-	u32	suspend_i2spsr;
 	const struct samsung_i2s_variant_regs *variant_regs;
 
 	spinlock_t *lock;
@@ -120,6 +117,11 @@ struct samsung_i2s_priv {
 	/* Rate of RCLK source clock */
 	unsigned long rclk_srcrate;
 
+	/* Cache of selected I2S registers for system suspend */
+	u32 suspend_i2smod;
+	u32 suspend_i2scon;
+	u32 suspend_i2spsr;
+
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
@@ -1205,9 +1207,9 @@ static int i2s_runtime_suspend(struct device *dev)
 	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 
-	i2s->suspend_i2smod = readl(i2s->addr + I2SMOD);
-	i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
-	i2s->suspend_i2spsr = readl(i2s->addr + I2SPSR);
+	priv->suspend_i2smod = readl(i2s->addr + I2SMOD);
+	priv->suspend_i2scon = readl(i2s->addr + I2SCON);
+	priv->suspend_i2spsr = readl(i2s->addr + I2SPSR);
 
 	if (priv->op_clk)
 		clk_disable_unprepare(priv->op_clk);
@@ -1234,9 +1236,9 @@ static int i2s_runtime_resume(struct device *dev)
 		}
 	}
 
-	writel(i2s->suspend_i2scon, i2s->addr + I2SCON);
-	writel(i2s->suspend_i2smod, i2s->addr + I2SMOD);
-	writel(i2s->suspend_i2spsr, i2s->addr + I2SPSR);
+	writel(priv->suspend_i2scon, i2s->addr + I2SCON);
+	writel(priv->suspend_i2smod, i2s->addr + I2SMOD);
+	writel(priv->suspend_i2spsr, i2s->addr + I2SPSR);
 
 	return 0;
 }
-- 
2.20.1
