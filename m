From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH] ASoC: stm32: sai: add power management
Date: Thu, 21 Mar 2019 16:34:56 +0100
Message-ID: <1553182496-25569-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add support of low power modes to STM32 SAI driver.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c     | 80 ++++++++++++++++++++++++++++++++++++++-----
 sound/soc/stm/stm32_sai.h     |  2 ++
 sound/soc/stm/stm32_sai_sub.c | 45 ++++++++++++++++++------
 3 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index d68d62f12df5..7550d5f08be3 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
 
 #include <sound/dmaengine_pcm.h>
@@ -44,20 +45,41 @@ static const struct of_device_id stm32_sai_ids[] = {
 	{}
 };
 
-static int stm32_sai_sync_conf_client(struct stm32_sai_data *sai, int synci)
+static int stm32_sai_pclk_disable(struct device *dev)
+{
+	struct stm32_sai_data *sai = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(sai->pclk);
+
+	return 0;
+}
+
+static int stm32_sai_pclk_enable(struct device *dev)
 {
+	struct stm32_sai_data *sai = dev_get_drvdata(dev);
 	int ret;
 
-	/* Enable peripheral clock to allow GCR register access */
 	ret = clk_prepare_enable(sai->pclk);
 	if (ret) {
 		dev_err(&sai->pdev->dev, "failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
+	return 0;
+}
+
+static int stm32_sai_sync_conf_client(struct stm32_sai_data *sai, int synci)
+{
+	int ret;
+
+	/* Enable peripheral clock to allow GCR register access */
+	ret = stm32_sai_pclk_enable(&sai->pdev->dev);
+	if (ret)
+		return ret;
+
 	writel_relaxed(FIELD_PREP(SAI_GCR_SYNCIN_MASK, (synci - 1)), sai->base);
 
-	clk_disable_unprepare(sai->pclk);
+	stm32_sai_pclk_disable(&sai->pdev->dev);
 
 	return 0;
 }
@@ -68,11 +90,9 @@ static int stm32_sai_sync_conf_provider(struct stm32_sai_data *sai, int synco)
 	int ret;
 
 	/* Enable peripheral clock to allow GCR register access */
-	ret = clk_prepare_enable(sai->pclk);
-	if (ret) {
-		dev_err(&sai->pdev->dev, "failed to enable clock: %d\n", ret);
+	ret = stm32_sai_pclk_enable(&sai->pdev->dev);
+	if (ret)
 		return ret;
-	}
 
 	dev_dbg(&sai->pdev->dev, "Set %pOFn%s as synchro provider\n",
 		sai->pdev->dev.of_node,
@@ -83,13 +103,13 @@ static int stm32_sai_sync_conf_provider(struct stm32_sai_data *sai, int synco)
 		dev_err(&sai->pdev->dev, "%pOFn%s already set as sync provider\n",
 			sai->pdev->dev.of_node,
 			prev_synco == STM_SAI_SYNC_OUT_A ? "A" : "B");
-		clk_disable_unprepare(sai->pclk);
+			stm32_sai_pclk_disable(&sai->pdev->dev);
 		return -EINVAL;
 	}
 
 	writel_relaxed(FIELD_PREP(SAI_GCR_SYNCOUT_MASK, synco), sai->base);
 
-	clk_disable_unprepare(sai->pclk);
+	stm32_sai_pclk_disable(&sai->pdev->dev);
 
 	return 0;
 }
@@ -195,12 +215,54 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	return devm_of_platform_populate(&pdev->dev);
 }
 
+#ifdef CONFIG_PM_SLEEP
+/*
+ * When pins are shared by two sai sub instances, pins have to be defined
+ * in sai parent node. In this case, pins state is not managed by alsa fw.
+ * These pins are managed in suspend/resume callbacks.
+ */
+static int stm32_sai_suspend(struct device *dev)
+{
+	struct stm32_sai_data *sai = dev_get_drvdata(dev);
+	int ret;
+
+	ret = stm32_sai_pclk_enable(dev);
+	if (ret)
+		return ret;
+
+	sai->gcr = readl_relaxed(sai->base);
+	stm32_sai_pclk_disable(dev);
+
+	return pinctrl_pm_select_sleep_state(dev);
+}
+
+static int stm32_sai_resume(struct device *dev)
+{
+	struct stm32_sai_data *sai = dev_get_drvdata(dev);
+	int ret;
+
+	ret = stm32_sai_pclk_enable(dev);
+	if (ret)
+		return ret;
+
+	writel_relaxed(sai->gcr, sai->base);
+	stm32_sai_pclk_disable(dev);
+
+	return pinctrl_pm_select_default_state(dev);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops stm32_sai_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_sai_suspend, stm32_sai_resume)
+};
+
 MODULE_DEVICE_TABLE(of, stm32_sai_ids);
 
 static struct platform_driver stm32_sai_driver = {
 	.driver = {
 		.name = "st,stm32-sai",
 		.of_match_table = stm32_sai_ids,
+		.pm = &stm32_sai_pm_ops,
 	},
 	.probe = stm32_sai_probe,
 };
diff --git a/sound/soc/stm/stm32_sai.h b/sound/soc/stm/stm32_sai.h
index 08de899c766b..9c36a393ab7b 100644
--- a/sound/soc/stm/stm32_sai.h
+++ b/sound/soc/stm/stm32_sai.h
@@ -268,6 +268,7 @@ struct stm32_sai_conf {
  * @version: SOC version
  * @irq: SAI interrupt line
  * @set_sync: pointer to synchro mode configuration callback
+ * @gcr: SAI Global Configuration Register
  */
 struct stm32_sai_data {
 	struct platform_device *pdev;
@@ -279,4 +280,5 @@ struct stm32_sai_data {
 	int irq;
 	int (*set_sync)(struct stm32_sai_data *sai,
 			struct device_node *np_provider, int synco, int synci);
+	u32 gcr;
 };
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 55d802f51c15..2a90641cf164 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -168,6 +168,7 @@ static bool stm32_sai_sub_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case STM_SAI_DR_REGX:
+	case STM_SAI_SR_REGX:
 		return true;
 	default:
 		return false;
@@ -182,7 +183,6 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
 	case STM_SAI_FRCR_REGX:
 	case STM_SAI_SLOTR_REGX:
 	case STM_SAI_IMR_REGX:
-	case STM_SAI_SR_REGX:
 	case STM_SAI_CLRFR_REGX:
 	case STM_SAI_DR_REGX:
 	case STM_SAI_PDMCR_REGX:
@@ -202,6 +202,7 @@ static const struct regmap_config stm32_sai_sub_regmap_config_f4 = {
 	.volatile_reg = stm32_sai_sub_volatile_reg,
 	.writeable_reg = stm32_sai_sub_writeable_reg,
 	.fast_io = true,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static const struct regmap_config stm32_sai_sub_regmap_config_h7 = {
@@ -213,6 +214,7 @@ static const struct regmap_config stm32_sai_sub_regmap_config_h7 = {
 	.volatile_reg = stm32_sai_sub_volatile_reg,
 	.writeable_reg = stm32_sai_sub_writeable_reg,
 	.fast_io = true,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int snd_pcm_iec958_info(struct snd_kcontrol *kcontrol,
@@ -441,8 +443,8 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
 	if (!flags)
 		return IRQ_NONE;
 
-	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX, SAI_XCLRFR_MASK,
-			   SAI_XCLRFR_MASK);
+	regmap_write_bits(sai->regmap, STM_SAI_CLRFR_REGX, SAI_XCLRFR_MASK,
+			  SAI_XCLRFR_MASK);
 
 	if (!sai->substream) {
 		dev_err(&pdev->dev, "Device stopped. Spurious IRQ 0x%x\n", sr);
@@ -704,9 +706,8 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 	}
 
 	/* Enable ITs */
-
-	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX,
-			   SAI_XCLRFR_MASK, SAI_XCLRFR_MASK);
+	regmap_write_bits(sai->regmap, STM_SAI_CLRFR_REGX,
+			  SAI_XCLRFR_MASK, SAI_XCLRFR_MASK);
 
 	imr = SAI_XIMR_OVRUDRIE;
 	if (STM_SAI_IS_CAPTURE(sai)) {
@@ -738,10 +739,10 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 	 * SAI fifo threshold is set to half fifo, to keep enough space
 	 * for DMA incoming bursts.
 	 */
-	regmap_update_bits(sai->regmap, STM_SAI_CR2_REGX,
-			   SAI_XCR2_FFLUSH | SAI_XCR2_FTH_MASK,
-			   SAI_XCR2_FFLUSH |
-			   SAI_XCR2_FTH_SET(STM_SAI_FIFO_TH_HALF));
+	regmap_write_bits(sai->regmap, STM_SAI_CR2_REGX,
+			  SAI_XCR2_FFLUSH | SAI_XCR2_FTH_MASK,
+			  SAI_XCR2_FFLUSH |
+			  SAI_XCR2_FTH_SET(STM_SAI_FIFO_TH_HALF));
 
 	/* DS bits in CR1 not set for SPDIF (size forced to 24 bits).*/
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
@@ -1492,10 +1493,34 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int stm32_sai_sub_suspend(struct device *dev)
+{
+	struct stm32_sai_sub_data *sai = dev_get_drvdata(dev);
+
+	regcache_cache_only(sai->regmap, true);
+	regcache_mark_dirty(sai->regmap);
+	return 0;
+}
+
+static int stm32_sai_sub_resume(struct device *dev)
+{
+	struct stm32_sai_sub_data *sai = dev_get_drvdata(dev);
+
+	regcache_cache_only(sai->regmap, false);
+	return regcache_sync(sai->regmap);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops stm32_sai_sub_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_sai_sub_suspend, stm32_sai_sub_resume)
+};
+
 static struct platform_driver stm32_sai_sub_driver = {
 	.driver = {
 		.name = "st,stm32-sai-sub",
 		.of_match_table = stm32_sai_sub_ids,
+		.pm = &stm32_sai_sub_pm_ops,
 	},
 	.probe = stm32_sai_sub_probe,
 };
-- 
2.7.4
