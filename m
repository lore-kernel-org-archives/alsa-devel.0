From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: ad193x: Add support to disable
	on-chip PLL" to the asoc tree
Date: Mon, 18 Feb 2019 18:49:30 +0000 (GMT)
Message-ID: <20190218184930.F3E631128008@debutante.sirena.org.uk>
References: <20190218160954.13929-6-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 112EA26555A
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 19:49:32 +0100 (CET)
In-Reply-To: <20190218160954.13929-6-codrin.ciubotariu@microchip.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, Codrin.Ciubotariu@microchip.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: ad193x: Add support to disable on-chip PLL

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

>From 59529473751e987e28c926838f70aaef588b83b0 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Mon, 18 Feb 2019 16:10:36 +0000
Subject: [PATCH] ASoC: codecs: ad193x: Add support to disable on-chip PLL

The on-chip PLL can be disabled if on the MCLKI pin we have an external
clock at 512 x fs. This clock can be used as direct internal clock for
ADCs or DACs.
To support this, we add an extra clock id that can be configured
using the set_sysclk() callback.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 26 +++++++++++++++++++++++++-
 sound/soc/codecs/ad193x.h |  8 ++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index f8cf182518a3..96d7cb2e4a56 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -100,6 +100,15 @@ static const struct snd_soc_dapm_widget ad193x_adc_widgets[] = {
 	SND_SOC_DAPM_INPUT("ADC2IN"),
 };
 
+static int ad193x_check_pll(struct snd_soc_dapm_widget *source,
+			    struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
+	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
+
+	return !!ad193x->sysclk;
+}
+
 static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "DAC", NULL, "SYSCLK" },
 	{ "DAC Output", NULL, "DAC" },
@@ -108,7 +117,7 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "DAC2OUT", NULL, "DAC Output" },
 	{ "DAC3OUT", NULL, "DAC Output" },
 	{ "DAC4OUT", NULL, "DAC Output" },
-	{ "SYSCLK", NULL, "PLL_PWR" },
+	{ "SYSCLK", NULL, "PLL_PWR", &ad193x_check_pll },
 };
 
 static const struct snd_soc_dapm_route ad193x_adc_audio_paths[] = {
@@ -276,7 +285,22 @@ static int ad193x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_component *component = codec_dai->component;
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct ad193x_priv *ad193x = snd_soc_component_get_drvdata(component);
+
+	if (clk_id == AD193X_SYSCLK_MCLK) {
+		/* MCLK must be 512 x fs */
+		if (dir == SND_SOC_CLOCK_OUT || freq != 24576000)
+			return -EINVAL;
+
+		regmap_update_bits(ad193x->regmap, AD193X_PLL_CLK_CTRL1,
+				   AD193X_PLL_SRC_MASK,
+				   AD193X_PLL_DAC_SRC_MCLK |
+				   AD193X_PLL_CLK_SRC_MCLK);
+
+		snd_soc_dapm_sync(dapm);
+		return 0;
+	}
 	switch (freq) {
 	case 12288000:
 	case 18432000:
diff --git a/sound/soc/codecs/ad193x.h b/sound/soc/codecs/ad193x.h
index 8b1e65f928d2..27d6afbd7dfb 100644
--- a/sound/soc/codecs/ad193x.h
+++ b/sound/soc/codecs/ad193x.h
@@ -31,6 +31,11 @@ int ad193x_probe(struct device *dev, struct regmap *regmap,
 #define AD193X_PLL_INPUT_512    (2 << 1)
 #define AD193X_PLL_INPUT_768    (3 << 1)
 #define AD193X_PLL_CLK_CTRL1    0x01
+#define AD193X_PLL_SRC_MASK	0x03
+#define AD193X_PLL_DAC_SRC_PLL  0
+#define AD193X_PLL_DAC_SRC_MCLK 1
+#define AD193X_PLL_CLK_SRC_PLL  (0 << 1)
+#define AD193X_PLL_CLK_SRC_MCLK	(1 << 1)
 #define AD193X_DAC_CTRL0        0x02
 #define AD193X_DAC_POWERDOWN           0x01
 #define AD193X_DAC_SERFMT_MASK		0xC0
@@ -96,4 +101,7 @@ int ad193x_probe(struct device *dev, struct regmap *regmap,
 
 #define AD193X_NUM_REGS          17
 
+#define AD193X_SYSCLK_PLL	0
+#define AD193X_SYSCLK_MCLK	1
+
 #endif
-- 
2.20.1
