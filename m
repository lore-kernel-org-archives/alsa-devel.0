From: Mark Brown <broonie@kernel.org>
Subject: Applied "mfd: arizona: Remove audio related device tree code" to the asoc tree
Date: Wed, 20 Sep 2017 18:14:07 +0100
Message-ID: <E1duiZb-0003Ac-LF@debutante>
References: <20170904154154.4395-5-ckeepax@opensource.cirrus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904154154.4395-5-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>broonie@kernel.orglee.jones@linaro.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   mfd: arizona: Remove audio related device tree code

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

>From 6000c99ee6e9876cb33275c752937d99f77cdb95 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 4 Sep 2017 16:41:51 +0100
Subject: [PATCH] mfd: arizona: Remove audio related device tree code

This code has now been moved to the audio subsystem so is no longer
required in the MFD code.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/arizona-core.c | 132 +--------------------------------------------
 1 file changed, 1 insertion(+), 131 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 8d46e3ad9529..77875250abe5 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -797,12 +797,7 @@ EXPORT_SYMBOL_GPL(arizona_of_get_type);
 static int arizona_of_get_core_pdata(struct arizona *arizona)
 {
 	struct arizona_pdata *pdata = &arizona->pdata;
-	struct property *prop;
-	const __be32 *cur;
-	u32 val;
-	u32 pdm_val[ARIZONA_MAX_PDM_SPK];
 	int ret, i;
-	int count = 0;
 
 	pdata->reset = of_get_named_gpio(arizona->dev->of_node, "wlf,reset", 0);
 	if (pdata->reset == -EPROBE_DEFER) {
@@ -836,64 +831,6 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
 			ret);
 	}
 
-	of_property_for_each_u32(arizona->dev->of_node, "wlf,inmode", prop,
-				 cur, val) {
-		if (count == ARRAY_SIZE(pdata->inmode))
-			break;
-
-		pdata->inmode[count] = val;
-		count++;
-	}
-
-	count = 0;
-	of_property_for_each_u32(arizona->dev->of_node, "wlf,dmic-ref", prop,
-				 cur, val) {
-		if (count == ARRAY_SIZE(pdata->dmic_ref))
-			break;
-
-		pdata->dmic_ref[count] = val;
-		count++;
-	}
-
-	count = 0;
-	of_property_for_each_u32(arizona->dev->of_node, "wlf,out-mono", prop,
-				 cur, val) {
-		if (count == ARRAY_SIZE(pdata->out_mono))
-			break;
-
-		pdata->out_mono[count] = !!val;
-		count++;
-	}
-
-	count = 0;
-	of_property_for_each_u32(arizona->dev->of_node,
-				 "wlf,max-channels-clocked",
-				 prop, cur, val) {
-		if (count == ARRAY_SIZE(pdata->max_channels_clocked))
-			break;
-
-		pdata->max_channels_clocked[count] = val;
-		count++;
-	}
-
-	ret = of_property_read_u32_array(arizona->dev->of_node,
-					 "wlf,spk-fmt",
-					 pdm_val,
-					 ARRAY_SIZE(pdm_val));
-
-	if (ret >= 0)
-		for (count = 0; count < ARRAY_SIZE(pdata->spk_fmt); ++count)
-			pdata->spk_fmt[count] = pdm_val[count];
-
-	ret = of_property_read_u32_array(arizona->dev->of_node,
-					 "wlf,spk-mute",
-					 pdm_val,
-					 ARRAY_SIZE(pdm_val));
-
-	if (ret >= 0)
-		for (count = 0; count < ARRAY_SIZE(pdata->spk_mute); ++count)
-			pdata->spk_mute[count] = pdm_val[count];
-
 	return 0;
 }
 
@@ -1026,7 +963,7 @@ int arizona_dev_init(struct arizona *arizona)
 	const char * const mclk_name[] = { "mclk1", "mclk2" };
 	struct device *dev = arizona->dev;
 	const char *type_name = NULL;
-	unsigned int reg, val, mask;
+	unsigned int reg, val;
 	int (*apply_patch)(struct arizona *) = NULL;
 	const struct mfd_cell *subdevs = NULL;
 	int n_subdevs, ret, i;
@@ -1429,73 +1366,6 @@ int arizona_dev_init(struct arizona *arizona)
 				   ARIZONA_MICB1_RATE, val);
 	}
 
-	for (i = 0; i < ARIZONA_MAX_INPUT; i++) {
-		/* Default for both is 0 so noop with defaults */
-		val = arizona->pdata.dmic_ref[i]
-			<< ARIZONA_IN1_DMIC_SUP_SHIFT;
-		if (arizona->pdata.inmode[i] & ARIZONA_INMODE_DMIC)
-			val |= 1 << ARIZONA_IN1_MODE_SHIFT;
-
-		switch (arizona->type) {
-		case WM8998:
-		case WM1814:
-			regmap_update_bits(arizona->regmap,
-				ARIZONA_ADC_DIGITAL_VOLUME_1L + (i * 8),
-				ARIZONA_IN1L_SRC_SE_MASK,
-				(arizona->pdata.inmode[i] & ARIZONA_INMODE_SE)
-					<< ARIZONA_IN1L_SRC_SE_SHIFT);
-
-			regmap_update_bits(arizona->regmap,
-				ARIZONA_ADC_DIGITAL_VOLUME_1R + (i * 8),
-				ARIZONA_IN1R_SRC_SE_MASK,
-				(arizona->pdata.inmode[i] & ARIZONA_INMODE_SE)
-					<< ARIZONA_IN1R_SRC_SE_SHIFT);
-
-			mask = ARIZONA_IN1_DMIC_SUP_MASK |
-				ARIZONA_IN1_MODE_MASK;
-			break;
-		default:
-			if (arizona->pdata.inmode[i] & ARIZONA_INMODE_SE)
-				val |= 1 << ARIZONA_IN1_SINGLE_ENDED_SHIFT;
-
-			mask = ARIZONA_IN1_DMIC_SUP_MASK |
-				ARIZONA_IN1_MODE_MASK |
-				ARIZONA_IN1_SINGLE_ENDED_MASK;
-			break;
-		}
-
-		regmap_update_bits(arizona->regmap,
-				   ARIZONA_IN1L_CONTROL + (i * 8),
-				   mask, val);
-	}
-
-	for (i = 0; i < ARIZONA_MAX_OUTPUT; i++) {
-		/* Default is 0 so noop with defaults */
-		if (arizona->pdata.out_mono[i])
-			val = ARIZONA_OUT1_MONO;
-		else
-			val = 0;
-
-		regmap_update_bits(arizona->regmap,
-				   ARIZONA_OUTPUT_PATH_CONFIG_1L + (i * 8),
-				   ARIZONA_OUT1_MONO, val);
-	}
-
-	for (i = 0; i < ARIZONA_MAX_PDM_SPK; i++) {
-		if (arizona->pdata.spk_mute[i])
-			regmap_update_bits(arizona->regmap,
-					   ARIZONA_PDM_SPK1_CTRL_1 + (i * 2),
-					   ARIZONA_SPK1_MUTE_ENDIAN_MASK |
-					   ARIZONA_SPK1_MUTE_SEQ1_MASK,
-					   arizona->pdata.spk_mute[i]);
-
-		if (arizona->pdata.spk_fmt[i])
-			regmap_update_bits(arizona->regmap,
-					   ARIZONA_PDM_SPK1_CTRL_2 + (i * 2),
-					   ARIZONA_SPK1_FMT_MASK,
-					   arizona->pdata.spk_fmt[i]);
-	}
-
 	pm_runtime_set_active(arizona->dev);
 	pm_runtime_enable(arizona->dev);
 
-- 
2.14.1
