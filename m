From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmic: Fix clock parenting" to the asoc tree
Date: Thu, 12 Apr 2018 13:24:56 +0100
Message-ID: <E1f6bHc-0000fn-PU@debutante>
References: <20180412082315.17302-1-peter.ujfalusi@ti.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180412082315.17302-1-peter.ujfalusi@ti.com>
Sender: stable-owner@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgMark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, t-kristo@ti.com, alsa-devel@alsa-project.orgstable@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmic: Fix clock parenting

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

>From 573eda59c772d11fc2b56d525dfb698b0f87ddb3 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Thu, 12 Apr 2018 11:23:15 +0300
Subject: [PATCH] ASoC: dmic: Fix clock parenting

In 4.16 the clock hierarchy got changed by
a5c82a09d876 ARM: dts: omap4: add clkctrl nodes

The fck of dmic is no longer a mux clock, it's parent is.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org # 4.16+
---
 sound/soc/omap/omap-dmic.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 09db2aec12a3..b2f5d2fa354d 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -281,7 +281,7 @@ static int omap_dmic_dai_trigger(struct snd_pcm_substream *substream,
 static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
 				 unsigned int freq)
 {
-	struct clk *parent_clk;
+	struct clk *parent_clk, *mux;
 	char *parent_clk_name;
 	int ret = 0;
 
@@ -329,14 +329,21 @@ static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
 		return -ENODEV;
 	}
 
+	mux = clk_get_parent(dmic->fclk);
+	if (IS_ERR(mux)) {
+		dev_err(dmic->dev, "can't get fck mux parent\n");
+		clk_put(parent_clk);
+		return -ENODEV;
+	}
+
 	mutex_lock(&dmic->mutex);
 	if (dmic->active) {
 		/* disable clock while reparenting */
 		pm_runtime_put_sync(dmic->dev);
-		ret = clk_set_parent(dmic->fclk, parent_clk);
+		ret = clk_set_parent(mux, parent_clk);
 		pm_runtime_get_sync(dmic->dev);
 	} else {
-		ret = clk_set_parent(dmic->fclk, parent_clk);
+		ret = clk_set_parent(mux, parent_clk);
 	}
 	mutex_unlock(&dmic->mutex);
 
@@ -349,6 +356,7 @@ static int omap_dmic_select_fclk(struct omap_dmic *dmic, int clk_id,
 	dmic->fclk_freq = freq;
 
 err_busy:
+	clk_put(mux);
 	clk_put(parent_clk);
 
 	return ret;
-- 
2.17.0
