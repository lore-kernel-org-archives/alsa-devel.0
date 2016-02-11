From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 12/14] ASoC: qcom: apq8016: set the correct max register for regmap
Date: Thu, 11 Feb 2016 12:18:27 +0000
Message-ID: <1455193107-1974-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455193007-1481-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455193007-1481-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Now that we are ready to access wrdma registers, set the max register
and other regmap related configs to use correct values.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 00b6c9d..82e16b2 100644
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
 
@@ -399,8 +427,9 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
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
1.9.1
