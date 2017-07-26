From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Handle return value of clk_prepare_enable." to the asoc tree
Date: Wed, 26 Jul 2017 15:17:03 +0100
Message-ID: <E1daN7X-0003WH-3Z@debutante>
References: <1500977674-27960-5-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-5-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.combroonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Handle return value of clk_prepare_enable.

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From f5c97c7b0438bec0aad9738af1baa698dae5bc09 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 25 Jul 2017 15:44:31 +0530
Subject: [PATCH] ASoC: samsung: i2s: Handle return value of
 clk_prepare_enable.

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index c9f87f7bae99..daf7b892c967 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -551,7 +551,9 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 				goto err;
 			}
 
-			clk_prepare_enable(i2s->op_clk);
+			ret = clk_prepare_enable(i2s->op_clk);
+			if (ret)
+				goto err;
 			i2s->rclk_srcrate = clk_get_rate(i2s->op_clk);
 
 			/* Over-ride the other's */
@@ -1133,10 +1135,19 @@ static int i2s_runtime_suspend(struct device *dev)
 static int i2s_runtime_resume(struct device *dev)
 {
 	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	int ret;
 
-	clk_prepare_enable(i2s->clk);
-	if (i2s->op_clk)
-		clk_prepare_enable(i2s->op_clk);
+	ret = clk_prepare_enable(i2s->clk);
+	if (ret)
+		return ret;
+
+	if (i2s->op_clk) {
+		ret = clk_prepare_enable(i2s->op_clk);
+		if (ret) {
+			clk_disable_unprepare(i2s->clk);
+			return ret;
+		}
+	}
 
 	writel(i2s->suspend_i2scon, i2s->addr + I2SCON);
 	writel(i2s->suspend_i2smod, i2s->addr + I2SMOD);
-- 
2.13.2
