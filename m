From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: spdifrx: add power management" to the asoc tree
Date: Mon, 18 Mar 2019 14:51:16 +0000 (GMT)
Message-ID: <20190318145116.138FE1128874@debutante.sirena.org.uk>
References: <1551890888-24622-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551890888-24622-1-git-send-email-olivier.moysan@st.com>
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

   ASoC: stm32: spdifrx: add power management

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

>From f68c2a682d444296403d1aa6e73b3de0681fdcea Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 6 Mar 2019 17:48:08 +0100
Subject: [PATCH] ASoC: stm32: spdifrx: add power management

Add suspend and resume sleep callbacks to STM32 SPDIFRX driver,
to support system low power modes.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_spdifrx.c | 42 ++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 373df4f24be1..b4c3d983e195 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -471,6 +472,8 @@ static int stm32_spdifrx_get_ctrl_data(struct stm32_spdifrx_data *spdifrx)
 	memset(spdifrx->cs, 0, SPDIFRX_CS_BYTES_NB);
 	memset(spdifrx->ub, 0, SPDIFRX_UB_BYTES_NB);
 
+	pinctrl_pm_select_default_state(&spdifrx->pdev->dev);
+
 	ret = stm32_spdifrx_dma_ctrl_start(spdifrx);
 	if (ret < 0)
 		return ret;
@@ -502,6 +505,7 @@ static int stm32_spdifrx_get_ctrl_data(struct stm32_spdifrx_data *spdifrx)
 
 end:
 	clk_disable_unprepare(spdifrx->kclk);
+	pinctrl_pm_select_sleep_state(&spdifrx->pdev->dev);
 
 	return ret;
 }
@@ -611,10 +615,15 @@ static bool stm32_spdifrx_readable_reg(struct device *dev, unsigned int reg)
 
 static bool stm32_spdifrx_volatile_reg(struct device *dev, unsigned int reg)
 {
-	if (reg == STM32_SPDIFRX_DR)
+	switch (reg) {
+	case STM32_SPDIFRX_DR:
+	case STM32_SPDIFRX_CSR:
+	case STM32_SPDIFRX_SR:
+	case STM32_SPDIFRX_DIR:
 		return true;
-
-	return false;
+	default:
+		return false;
+	}
 }
 
 static bool stm32_spdifrx_writeable_reg(struct device *dev, unsigned int reg)
@@ -638,6 +647,7 @@ static const struct regmap_config stm32_h7_spdifrx_regmap_conf = {
 	.volatile_reg = stm32_spdifrx_volatile_reg,
 	.writeable_reg = stm32_spdifrx_writeable_reg,
 	.fast_io = true,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static irqreturn_t stm32_spdifrx_isr(int irq, void *devid)
@@ -983,10 +993,36 @@ static int stm32_spdifrx_remove(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, stm32_spdifrx_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_spdifrx_suspend(struct device *dev)
+{
+	struct stm32_spdifrx_data *spdifrx = dev_get_drvdata(dev);
+
+	regcache_cache_only(spdifrx->regmap, true);
+	regcache_mark_dirty(spdifrx->regmap);
+
+	return 0;
+}
+
+static int stm32_spdifrx_resume(struct device *dev)
+{
+	struct stm32_spdifrx_data *spdifrx = dev_get_drvdata(dev);
+
+	regcache_cache_only(spdifrx->regmap, false);
+
+	return regcache_sync(spdifrx->regmap);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops stm32_spdifrx_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_spdifrx_suspend, stm32_spdifrx_resume)
+};
+
 static struct platform_driver stm32_spdifrx_driver = {
 	.driver = {
 		.name = "st,stm32-spdifrx",
 		.of_match_table = stm32_spdifrx_ids,
+		.pm = &stm32_spdifrx_pm_ops,
 	},
 	.probe = stm32_spdifrx_probe,
 	.remove = stm32_spdifrx_remove,
-- 
2.20.1
