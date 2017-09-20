From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add support for setting the output volume limits" to the asoc tree
Date: Wed, 20 Sep 2017 18:14:01 +0100
Message-ID: <E1duiZV-00034c-JQ@debutante>
References: <20170904154154.4395-7-ckeepax@opensource.cirrus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904154154.4395-7-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>broonie@kernel.orglee.jones@linaro.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add support for setting the output volume limits

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

>From 85e7dd3f871b988702973c80d9ef128e10dd3dad Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 4 Sep 2017 16:41:53 +0100
Subject: [PATCH] ASoC: arizona: Add support for setting the output volume
 limits

The output volume limits allow signals to be limited to specific levels
appropriate for the hardware attached. As this is a property of the
hardware itself these will be configured through device tree.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/mfd/arizona/pdata.h |  3 +++
 sound/soc/codecs/arizona.c        | 25 +++++++++++++++++++++++++
 sound/soc/codecs/arizona.h        |  1 +
 sound/soc/codecs/cs47l24.c        |  3 +++
 sound/soc/codecs/wm5102.c         |  3 +++
 sound/soc/codecs/wm5110.c         |  3 +++
 sound/soc/codecs/wm8997.c         |  3 +++
 7 files changed, 41 insertions(+)

diff --git a/include/linux/mfd/arizona/pdata.h b/include/linux/mfd/arizona/pdata.h
index bfeecf179895..f72dc53848d7 100644
--- a/include/linux/mfd/arizona/pdata.h
+++ b/include/linux/mfd/arizona/pdata.h
@@ -174,6 +174,9 @@ struct arizona_pdata {
 	/** Mode for outputs */
 	int out_mono[ARIZONA_MAX_OUTPUT];
 
+	/** Limit output volumes */
+	unsigned int out_vol_limit[2 * ARIZONA_MAX_OUTPUT];
+
 	/** PDM speaker mute setting */
 	unsigned int spk_mute[ARIZONA_MAX_PDM_SPK];
 
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e6967385dccb..b3375e19598a 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -372,6 +372,22 @@ int arizona_init_common(struct arizona *arizona)
 }
 EXPORT_SYMBOL_GPL(arizona_init_common);
 
+int arizona_init_vol_limit(struct arizona *arizona)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(arizona->pdata.out_vol_limit); ++i) {
+		if (arizona->pdata.out_vol_limit[i])
+			regmap_update_bits(arizona->regmap,
+					   ARIZONA_DAC_VOLUME_LIMIT_1L + i * 4,
+					   ARIZONA_OUT1L_VOL_LIM_MASK,
+					   arizona->pdata.out_vol_limit[i]);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arizona_init_vol_limit);
+
 const char * const arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS] = {
 	"None",
 	"Tone Generator 1",
@@ -2810,6 +2826,15 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
 		count++;
 	}
 
+	count = 0;
+	of_property_for_each_u32(np, "wlf,out-volume-limit", prop, cur, val) {
+		if (count == ARRAY_SIZE(pdata->out_vol_limit))
+			break;
+
+		pdata->out_vol_limit[count] = val;
+		count++;
+	}
+
 	ret = of_property_read_u32_array(np, "wlf,spk-fmt",
 					 pdm_val, ARRAY_SIZE(pdm_val));
 
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 2d198fb2ce97..dfdf6d8c9687 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -315,6 +315,7 @@ int arizona_init_gpio(struct snd_soc_codec *codec);
 int arizona_init_mono(struct snd_soc_codec *codec);
 
 int arizona_init_common(struct arizona *arizona);
+int arizona_init_vol_limit(struct arizona *arizona);
 
 int arizona_init_spk_irqs(struct arizona *arizona);
 int arizona_free_spk_irqs(struct arizona *arizona);
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 0fe7d7a87ff3..94c0209977d0 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1297,6 +1297,9 @@ static int cs47l24_probe(struct platform_device *pdev)
 
 	arizona_init_common(arizona);
 
+	ret = arizona_init_vol_limit(arizona);
+	if (ret < 0)
+		goto err_dsp_irq;
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		goto err_dsp_irq;
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 5a917dd73f32..4f0481d3c7a7 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2107,6 +2107,9 @@ static int wm5102_probe(struct platform_device *pdev)
 
 	arizona_init_common(arizona);
 
+	ret = arizona_init_vol_limit(arizona);
+	if (ret < 0)
+		goto err_dsp_irq;
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		goto err_dsp_irq;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index ba1e90ca8be4..6ed1e1f9ce51 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2463,6 +2463,9 @@ static int wm5110_probe(struct platform_device *pdev)
 
 	arizona_init_common(arizona);
 
+	ret = arizona_init_vol_limit(arizona);
+	if (ret < 0)
+		goto err_dsp_irq;
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		goto err_dsp_irq;
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index c5aef9ecdecc..77f512767273 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1176,6 +1176,9 @@ static int wm8997_probe(struct platform_device *pdev)
 
 	arizona_init_common(arizona);
 
+	ret = arizona_init_vol_limit(arizona);
+	if (ret < 0)
+		return ret;
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		return ret;
-- 
2.14.1
