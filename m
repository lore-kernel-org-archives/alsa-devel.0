From: Mark Brown <broonie@kernel.org>
Subject: Applied "SoC: stm32: i2s: manage clock power" to the asoc tree
Date: Fri,  8 Feb 2019 13:11:07 +0000 (GMT)
Message-ID: <20190208131107.813F71127F30@debutante.sirena.org.uk>
References: <1549622994-13810-3-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1549622994-13810-3-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, perex@perex.cz, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   SoC: stm32: i2s: manage clock power

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

>From 6a68eeee0f03ab371bec7a719795f69b05be183f Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Fri, 8 Feb 2019 11:49:54 +0100
Subject: [PATCH] SoC: stm32: i2s: manage clock power

Kernel clock management:
Enable/disable I2S kernel clock on audio stream startup/shutdown.

Peripheral clock management:
Manage I2S peripheral clock power through regmap services.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 44 +++++++++++++--------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index dbe23a709d24..a25919d32187 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -545,9 +545,16 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
 
 	i2s->substream = substream;
 
+	ret = clk_prepare_enable(i2s->i2sclk);
+	if (ret < 0) {
+		dev_err(cpu_dai->dev, "Failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
 	spin_lock(&i2s->lock_fd);
 	i2s->refcount++;
 	spin_unlock(&i2s->lock_fd);
@@ -674,6 +681,8 @@ static void stm32_i2s_shutdown(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
 			   I2S_CGFR_MCKOE, (unsigned int)~I2S_CGFR_MCKOE);
+
+	clk_disable_unprepare(i2s->i2sclk);
 }
 
 static int stm32_i2s_dai_probe(struct snd_soc_dai *cpu_dai)
@@ -874,49 +883,26 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, i2s->base,
-					    i2s->regmap_conf);
+	i2s->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "pclk",
+						i2s->base, i2s->regmap_conf);
 	if (IS_ERR(i2s->regmap)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
 		return PTR_ERR(i2s->regmap);
 	}
 
-	ret = clk_prepare_enable(i2s->pclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Enable pclk failed: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(i2s->i2sclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Enable i2sclk failed: %d\n", ret);
-		goto err_pclk_disable;
-	}
-
 	ret = devm_snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
 					      i2s->dai_drv, 1);
 	if (ret)
-		goto err_clocks_disable;
+		return ret;
 
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
 					      &stm32_i2s_pcm_config, 0);
 	if (ret)
-		goto err_clocks_disable;
+		return ret;
 
 	/* Set SPI/I2S in i2s mode */
-	ret = regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
-				 I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
-	if (ret)
-		goto err_clocks_disable;
-
-	return ret;
-
-err_clocks_disable:
-	clk_disable_unprepare(i2s->i2sclk);
-err_pclk_disable:
-	clk_disable_unprepare(i2s->pclk);
-
-	return ret;
+	return regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
+				  I2S_CGFR_I2SMOD, I2S_CGFR_I2SMOD);
 }
 
 static int stm32_i2s_remove(struct platform_device *pdev)
-- 
2.20.1
