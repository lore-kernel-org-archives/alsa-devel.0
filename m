From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uniphier: Fix double reset assersion when transitioning to suspend state" to the asoc tree
Date: Tue, 20 Aug 2019 13:54:54 +0100 (BST)
Message-ID: <20190820125454.23AD32742ABD@ypsilon.sirena.org.uk>
References: <1566281764-14059-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566281764-14059-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jaswinder.singh@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uniphier: Fix double reset assersion when transitioning to suspend state

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From c372a35550c8d60f673b20210eea58a06d6d38cb Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 20 Aug 2019 15:16:04 +0900
Subject: [PATCH] ASoC: uniphier: Fix double reset assersion when transitioning
 to suspend state

When transitioning to supend state, uniphier_aio_dai_suspend() is called
and asserts reset lines and disables clocks.

However, if there are two or more DAIs, uniphier_aio_dai_suspend() are
called multiple times, and double reset assersion will cause.

This patch defines the counter that has the number of DAIs at first, and
whenever uniphier_aio_dai_suspend() are called, it decrements the
counter. And only if the counter is zero, it asserts reset lines and
disables clocks.

In the same way, uniphier_aio_dai_resume() are called, it increments the
counter after deasserting reset lines and enabling clocks.

Fixes: 139a34200233 ("ASoC: uniphier: add support for UniPhier AIO CPU DAI driver")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1566281764-14059-1-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-cpu.c | 31 +++++++++++++++++++++----------
 sound/soc/uniphier/aio.h     |  1 +
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index ee90e6c3937c..2ae582a99b63 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -424,8 +424,11 @@ int uniphier_aio_dai_suspend(struct snd_soc_dai *dai)
 {
 	struct uniphier_aio *aio = uniphier_priv(dai);
 
-	reset_control_assert(aio->chip->rst);
-	clk_disable_unprepare(aio->chip->clk);
+	aio->chip->num_wup_aios--;
+	if (!aio->chip->num_wup_aios) {
+		reset_control_assert(aio->chip->rst);
+		clk_disable_unprepare(aio->chip->clk);
+	}
 
 	return 0;
 }
@@ -439,13 +442,15 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 	if (!aio->chip->active)
 		return 0;
 
-	ret = clk_prepare_enable(aio->chip->clk);
-	if (ret)
-		return ret;
+	if (!aio->chip->num_wup_aios) {
+		ret = clk_prepare_enable(aio->chip->clk);
+		if (ret)
+			return ret;
 
-	ret = reset_control_deassert(aio->chip->rst);
-	if (ret)
-		goto err_out_clock;
+		ret = reset_control_deassert(aio->chip->rst);
+		if (ret)
+			goto err_out_clock;
+	}
 
 	aio_iecout_set_enable(aio->chip, true);
 	aio_chip_init(aio->chip);
@@ -458,7 +463,7 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 
 		ret = aio_init(sub);
 		if (ret)
-			goto err_out_clock;
+			goto err_out_reset;
 
 		if (!sub->setting)
 			continue;
@@ -466,11 +471,16 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 		aio_port_reset(sub);
 		aio_src_reset(sub);
 	}
+	aio->chip->num_wup_aios++;
 
 	return 0;
 
+err_out_reset:
+	if (!aio->chip->num_wup_aios)
+		reset_control_assert(aio->chip->rst);
 err_out_clock:
-	clk_disable_unprepare(aio->chip->clk);
+	if (!aio->chip->num_wup_aios)
+		clk_disable_unprepare(aio->chip->clk);
 
 	return ret;
 }
@@ -619,6 +629,7 @@ int uniphier_aio_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->rst);
 
 	chip->num_aios = chip->chip_spec->num_dais;
+	chip->num_wup_aios = chip->num_aios;
 	chip->aios = devm_kcalloc(dev,
 				  chip->num_aios, sizeof(struct uniphier_aio),
 				  GFP_KERNEL);
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index ca6ccbae0ee8..a7ff7e556429 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -285,6 +285,7 @@ struct uniphier_aio_chip {
 
 	struct uniphier_aio *aios;
 	int num_aios;
+	int num_wup_aios;
 	struct uniphier_aio_pll *plls;
 	int num_plls;
 
-- 
2.20.1
