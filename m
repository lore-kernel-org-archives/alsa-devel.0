From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: i2s: add 8 channels capture
	support" to the asoc tree
Date: Fri, 23 Oct 2015 08:08:53 +0900
Message-ID: <E1ZpOyb-0008Hb-WB@finisterre>
References: <1444308009-29088-2-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ABA4266AB0
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:03 +0200 (CEST)
In-Reply-To: <1444308009-29088-2-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: i2s: add 8 channels capture support

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

>From 4c9c018b2ac72e6ffaeae472723023dc4fd99a88 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 8 Oct 2015 20:40:07 +0800
Subject: [PATCH] ASoC: rockchip: i2s: add 8 channels capture support

support max 8 channels capture, please add property
'rockchip,capture-channels' in dts to enable this,
if not, support 2 channels capture default.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 40 +++++++++++++++++++++++++++++++++++++--
 sound/soc/rockchip/rockchip_i2s.h | 10 ++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index b936102..f07833b 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -245,8 +245,34 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	regmap_update_bits(i2s->regmap, I2S_TXCR, I2S_TXCR_VDW_MASK, val);
-	regmap_update_bits(i2s->regmap, I2S_RXCR, I2S_RXCR_VDW_MASK, val);
+	switch (params_channels(params)) {
+	case 8:
+		val |= I2S_CHN_8;
+		break;
+	case 6:
+		val |= I2S_CHN_6;
+		break;
+	case 4:
+		val |= I2S_CHN_4;
+		break;
+	case 2:
+		val |= I2S_CHN_2;
+		break;
+	default:
+		dev_err(i2s->dev, "invalid channel: %d\n",
+			params_channels(params));
+		return -EINVAL;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		regmap_update_bits(i2s->regmap, I2S_RXCR,
+				   I2S_RXCR_VDW_MASK | I2S_RXCR_CSR_MASK,
+				   val);
+	else
+		regmap_update_bits(i2s->regmap, I2S_TXCR,
+				   I2S_TXCR_VDW_MASK | I2S_TXCR_CSR_MASK,
+				   val);
+
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_TDL_MASK,
 			   I2S_DMACR_TDL(16));
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
@@ -415,10 +441,12 @@ static const struct regmap_config rockchip_i2s_regmap_config = {
 
 static int rockchip_i2s_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct rk_i2s_dev *i2s;
 	struct resource *res;
 	void __iomem *regs;
 	int ret;
+	int val;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s) {
@@ -475,6 +503,14 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
+	/* refine capture channels */
+	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
+		if (val >= 2 && val <= 8)
+			rockchip_i2s_dai.capture.channels_max = val;
+		else
+			rockchip_i2s_dai.capture.channels_max = 2;
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &rockchip_i2s_component,
 					      &rockchip_i2s_dai, 1);
diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index 93f456f..a54ee35 100644
--- a/sound/soc/rockchip/rockchip_i2s.h
+++ b/sound/soc/rockchip/rockchip_i2s.h
@@ -49,6 +49,9 @@
  * RXCR
  * receive operation control register
 */
+#define I2S_RXCR_CSR_SHIFT	15
+#define I2S_RXCR_CSR(x)		(x << I2S_RXCR_CSR_SHIFT)
+#define I2S_RXCR_CSR_MASK	(3 << I2S_RXCR_CSR_SHIFT)
 #define I2S_RXCR_HWT		BIT(14)
 #define I2S_RXCR_SJM_SHIFT	12
 #define I2S_RXCR_SJM_R		(0 << I2S_RXCR_SJM_SHIFT)
@@ -207,6 +210,13 @@ enum {
 	ROCKCHIP_DIV_BCLK,
 };
 
+/* channel select */
+#define I2S_CSR_SHIFT	15
+#define I2S_CHN_2	(0 << I2S_CSR_SHIFT)
+#define I2S_CHN_4	(1 << I2S_CSR_SHIFT)
+#define I2S_CHN_6	(2 << I2S_CSR_SHIFT)
+#define I2S_CHN_8	(3 << I2S_CSR_SHIFT)
+
 /* I2S REGS */
 #define I2S_TXCR	(0x0000)
 #define I2S_RXCR	(0x0004)
-- 
2.6.1
