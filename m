From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Fix power management" to the
	asoc tree
Date: Thu,  6 Dec 2018 20:25:51 +0000 (GMT)
Message-ID: <20181206202551.7230A11252F7@debutante.sirena.org.uk>
References: <20181204181951.GC1136@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C2CE267CBE
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 21:25:52 +0100 (CET)
In-Reply-To: <20181204181951.GC1136@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Fix power management

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

>From 3f456881f66f4c9e89a74a7ad675b08626c79517 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Tue, 4 Dec 2018 19:19:51 +0100
Subject: [PATCH] ASoC: max9867: Fix power management

Implement set_bias_level to drive shutdown bit, so device is
put to sleep when unused.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 72 ++++++++++++++++++++++++--------------
 sound/soc/codecs/max9867.h |  2 +-
 2 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 1b155f40b106..c454de434d76 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -248,17 +248,6 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int max9867_prepare(struct snd_pcm_substream *substream,
-			 struct snd_soc_dai *dai)
-{
-	struct snd_soc_component *component = dai->component;
-	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
-
-	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
-	return 0;
-}
-
 static int max9867_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
@@ -361,7 +350,6 @@ static int max9867_dai_set_fmt(struct snd_soc_dai *codec_dai,
 static const struct snd_soc_dai_ops max9867_dai_ops = {
 	.set_fmt = max9867_dai_set_fmt,
 	.set_sysclk	= max9867_set_dai_sysclk,
-	.prepare	= max9867_prepare,
 	.digital_mute	= max9867_mute,
 	.hw_params = max9867_dai_hw_params,
 };
@@ -392,27 +380,59 @@ static struct snd_soc_dai_driver max9867_dai[] = {
 	}
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int max9867_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int max9867_suspend(struct snd_soc_component *component)
 {
-	struct max9867_priv *max9867 = dev_get_drvdata(dev);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
-	/* Drop down to power saving mode when system is suspended */
-	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-		MAX9867_SHTDOWN_MASK, ~MAX9867_SHTDOWN_MASK);
 	return 0;
 }
 
-static int max9867_resume(struct device *dev)
+static int max9867_resume(struct snd_soc_component *component)
 {
-	struct max9867_priv *max9867 = dev_get_drvdata(dev);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
 
-	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
 	return 0;
 }
+#else
+#define max9867_suspend	NULL
+#define max9867_resume	NULL
 #endif
 
+static int max9867_set_bias_level(struct snd_soc_component *component,
+				  enum snd_soc_bias_level level)
+{
+	int err;
+	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
+
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
+			err = regcache_sync(max9867->regmap);
+			if (err)
+				return err;
+
+			err = regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
+						 MAX9867_SHTDOWN, MAX9867_SHTDOWN);
+			if (err)
+				return err;
+		}
+		break;
+	case SND_SOC_BIAS_OFF:
+		err = regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
+					 MAX9867_SHTDOWN, 0);
+		if (err)
+			return err;
+
+		regcache_mark_dirty(max9867->regmap);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver max9867_component = {
 	.controls		= max9867_snd_controls,
 	.num_controls		= ARRAY_SIZE(max9867_snd_controls),
@@ -420,6 +440,9 @@ static const struct snd_soc_component_driver max9867_component = {
 	.num_dapm_routes	= ARRAY_SIZE(max9867_audio_map),
 	.dapm_widgets		= max9867_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(max9867_dapm_widgets),
+	.suspend		= max9867_suspend,
+	.resume			= max9867_resume,
+	.set_bias_level		= max9867_set_bias_level,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
@@ -514,15 +537,10 @@ static const struct of_device_id max9867_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, max9867_of_match);
 
-static const struct dev_pm_ops max9867_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(max9867_suspend, max9867_resume)
-};
-
 static struct i2c_driver max9867_i2c_driver = {
 	.driver = {
 		.name = "max9867",
 		.of_match_table = of_match_ptr(max9867_of_match),
-		.pm = &max9867_pm_ops,
 	},
 	.probe  = max9867_i2c_probe,
 	.id_table = max9867_i2c_id,
diff --git a/sound/soc/codecs/max9867.h b/sound/soc/codecs/max9867.h
index 55cd9976ff47..d9170850c96e 100644
--- a/sound/soc/codecs/max9867.h
+++ b/sound/soc/codecs/max9867.h
@@ -67,7 +67,7 @@
 #define MAX9867_MICCONFIG    0x15
 #define MAX9867_MODECONFIG   0x16
 #define MAX9867_PWRMAN       0x17
-#define MAX9867_SHTDOWN_MASK (1<<7)
+#define MAX9867_SHTDOWN      0x80
 #define MAX9867_REVISION     0xff
 
 #define MAX9867_CACHEREGNUM 10
-- 
2.19.0.rc2
