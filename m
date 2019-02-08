From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: i2s: add power management" to the asoc tree
Date: Fri,  8 Feb 2019 13:11:09 +0000 (GMT)
Message-ID: <20190208131109.9EBC41127F30@debutante.sirena.org.uk>
References: <1549622994-13810-2-git-send-email-olivier.moysan@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549622994-13810-2-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: i2s: add power management

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

>From 307cce4a0017f94c6266050487c117660d66104e Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Fri, 8 Feb 2019 11:49:53 +0100
Subject: [PATCH] ASoC: stm32: i2s: add power management

Add suspend and resume sleep callbacks,
to support system low power modes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 6d0bf78d114d..dbe23a709d24 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -186,8 +186,9 @@ enum i2s_datlen {
 #define STM32_I2S_IS_SLAVE(x)		((x)->ms_flg == I2S_MS_SLAVE)
 
 /**
+ * struct stm32_i2s_data - private data of I2S
  * @regmap_conf: I2S register map configuration pointer
- * @egmap: I2S register map pointer
+ * @regmap: I2S register map pointer
  * @pdev: device data pointer
  * @dai_drv: DAI driver pointer
  * @dma_data_tx: dma configuration data for tx channel
@@ -596,8 +597,8 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 		}
 
-		ret = regmap_update_bits(i2s->regmap, STM32_I2S_CR1_REG,
-					 I2S_CR1_CSTART, I2S_CR1_CSTART);
+		ret = regmap_write_bits(i2s->regmap, STM32_I2S_CR1_REG,
+					I2S_CR1_CSTART, I2S_CR1_CSTART);
 		if (ret < 0) {
 			dev_err(cpu_dai->dev, "Error %d starting I2S\n", ret);
 			return ret;
@@ -703,6 +704,7 @@ static const struct regmap_config stm32_h7_i2s_regmap_conf = {
 	.volatile_reg = stm32_i2s_volatile_reg,
 	.writeable_reg = stm32_i2s_writeable_reg,
 	.fast_io = true,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static const struct snd_soc_dai_ops stm32_i2s_pcm_dai_ops = {
@@ -929,10 +931,35 @@ static int stm32_i2s_remove(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, stm32_i2s_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_i2s_suspend(struct device *dev)
+{
+	struct stm32_i2s_data *i2s = dev_get_drvdata(dev);
+
+	regcache_cache_only(i2s->regmap, true);
+	regcache_mark_dirty(i2s->regmap);
+
+	return 0;
+}
+
+static int stm32_i2s_resume(struct device *dev)
+{
+	struct stm32_i2s_data *i2s = dev_get_drvdata(dev);
+
+	regcache_cache_only(i2s->regmap, false);
+	return regcache_sync(i2s->regmap);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops stm32_i2s_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_i2s_suspend, stm32_i2s_resume)
+};
+
 static struct platform_driver stm32_i2s_driver = {
 	.driver = {
 		.name = "st,stm32-i2s",
 		.of_match_table = stm32_i2s_ids,
+		.pm = &stm32_i2s_pm_ops,
 	},
 	.probe = stm32_i2s_probe,
 	.remove = stm32_i2s_remove,
-- 
2.20.1
