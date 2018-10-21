From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-i2s: move code from
	startup/shutdown hooks into pm_runtime hooks" to the asoc tree
Date: Sun, 21 Oct 2018 17:58:56 +0200 (CEST)
Message-ID: <20181021155856.B0FA1440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E3D02677D1
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2018 17:58:58 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-i2s: move code from startup/shutdown hooks into pm_runtime hooks

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

>From 7f91e2af1a4a2c34fc2e8fb046c722e1a9c85399 Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sun, 21 Oct 2018 08:39:11 -0700
Subject: [PATCH] ASoC: sun4i-i2s: move code from startup/shutdown hooks into
 pm_runtime hooks

startup() and shutdown() hooks are called for both substreams,
so stopping either substream when another is running breaks the
latter.

E.g. playback breaks if capture is stopped when playback is running.

Move code from startup() and shutdown() to resume() and suspend()
hooks respectively to fix this issue

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 61 +++++++++++++++----------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index c63d226e2436..d5ec1a20499d 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -644,40 +644,6 @@ static int sun4i_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int sun4i_i2s_startup(struct snd_pcm_substream *substream,
-			     struct snd_soc_dai *dai)
-{
-	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	/* Enable the whole hardware block */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
-			   SUN4I_I2S_CTRL_GL_EN, SUN4I_I2S_CTRL_GL_EN);
-
-	/* Enable the first output line */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
-			   SUN4I_I2S_CTRL_SDO_EN_MASK,
-			   SUN4I_I2S_CTRL_SDO_EN(0));
-
-
-	return clk_prepare_enable(i2s->mod_clk);
-}
-
-static void sun4i_i2s_shutdown(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
-{
-	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	clk_disable_unprepare(i2s->mod_clk);
-
-	/* Disable our output lines */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
-			   SUN4I_I2S_CTRL_SDO_EN_MASK, 0);
-
-	/* Disable the whole hardware block */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
-			   SUN4I_I2S_CTRL_GL_EN, 0);
-}
-
 static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 				unsigned int freq, int dir)
 {
@@ -695,8 +661,6 @@ static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 	.hw_params	= sun4i_i2s_hw_params,
 	.set_fmt	= sun4i_i2s_set_fmt,
 	.set_sysclk	= sun4i_i2s_set_sysclk,
-	.shutdown	= sun4i_i2s_shutdown,
-	.startup	= sun4i_i2s_startup,
 	.trigger	= sun4i_i2s_trigger,
 };
 
@@ -869,6 +833,21 @@ static int sun4i_i2s_runtime_resume(struct device *dev)
 		goto err_disable_clk;
 	}
 
+	/* Enable the whole hardware block */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_GL_EN, SUN4I_I2S_CTRL_GL_EN);
+
+	/* Enable the first output line */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_SDO_EN_MASK,
+			   SUN4I_I2S_CTRL_SDO_EN(0));
+
+	ret = clk_prepare_enable(i2s->mod_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable module clock\n");
+		goto err_disable_clk;
+	}
+
 	return 0;
 
 err_disable_clk:
@@ -880,6 +859,16 @@ static int sun4i_i2s_runtime_suspend(struct device *dev)
 {
 	struct sun4i_i2s *i2s = dev_get_drvdata(dev);
 
+	clk_disable_unprepare(i2s->mod_clk);
+
+	/* Disable our output lines */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_SDO_EN_MASK, 0);
+
+	/* Disable the whole hardware block */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_GL_EN, 0);
+
 	regcache_cache_only(i2s->regmap, true);
 
 	clk_disable_unprepare(i2s->bus_clk);
-- 
2.19.0
