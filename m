From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: apq8016: set the correct max
	register for regmap" to the asoc tree
Date: Sun, 21 Feb 2016 02:14:13 +0900
Message-ID: <E1aXB6j-0008Ez-CE@finisterre>
References: <1454347778-11002-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 443B4261AA3
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:14:24 +0100 (CET)
In-Reply-To: <1454347778-11002-1-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: apq8016: set the correct max register for regmap

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

>From dad8061494d2a2ce6edc2ae5ab530b0d330b2685 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 11 Feb 2016 12:18:27 +0000
Subject: [PATCH] ASoC: qcom: apq8016: set the correct max register for regmap

Now that we are ready to access wrdma registers, set the max register
and other regmap related configs to use correct values.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-cpu.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index e5101e0..91774fc 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -294,6 +294,17 @@ static bool lpass_cpu_regmap_writeable(struct device *dev, unsigned int reg)
 			return true;
 	}
 
+	for (i = 0; i < v->wrdma_channels; ++i) {
+		if (reg == LPAIF_WRDMACTL_REG(v, i + v->wrdma_channel_start))
+			return true;
+		if (reg == LPAIF_WRDMABASE_REG(v, i + v->wrdma_channel_start))
+			return true;
+		if (reg == LPAIF_WRDMABUFF_REG(v, i + v->wrdma_channel_start))
+			return true;
+		if (reg == LPAIF_WRDMAPER_REG(v, i + v->wrdma_channel_start))
+			return true;
+	}
+
 	return false;
 }
 
@@ -327,6 +338,19 @@ static bool lpass_cpu_regmap_readable(struct device *dev, unsigned int reg)
 			return true;
 	}
 
+	for (i = 0; i < v->wrdma_channels; ++i) {
+		if (reg == LPAIF_WRDMACTL_REG(v, i + v->wrdma_channel_start))
+			return true;
+		if (reg == LPAIF_WRDMABASE_REG(v, i + v->wrdma_channel_start))
+			return true;
+		if (reg == LPAIF_WRDMABUFF_REG(v, i + v->wrdma_channel_start))
+			return true;
+		if (reg == LPAIF_WRDMACURR_REG(v, i + v->wrdma_channel_start))
+			return true;
+		if (reg == LPAIF_WRDMAPER_REG(v, i + v->wrdma_channel_start))
+			return true;
+	}
+
 	return false;
 }
 
@@ -344,6 +368,10 @@ static bool lpass_cpu_regmap_volatile(struct device *dev, unsigned int reg)
 		if (reg == LPAIF_RDMACURR_REG(v, i))
 			return true;
 
+	for (i = 0; i < v->wrdma_channels; ++i)
+		if (reg == LPAIF_WRDMACURR_REG(v, i + v->wrdma_channel_start))
+			return true;
+
 	return false;
 }
 
@@ -398,8 +426,9 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
 		return PTR_ERR((void const __force *)drvdata->lpaif);
 	}
 
-	lpass_cpu_regmap_config.max_register = LPAIF_RDMAPER_REG(variant,
-						variant->rdma_channels);
+	lpass_cpu_regmap_config.max_register = LPAIF_WRDMAPER_REG(variant,
+						variant->wrdma_channels +
+						variant->wrdma_channel_start);
 
 	drvdata->lpaif_map = devm_regmap_init_mmio(&pdev->dev, drvdata->lpaif,
 			&lpass_cpu_regmap_config);
-- 
2.7.0
