From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ad1980: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:38:24 +0000
Message-ID: <E1elDNI-0004Hf-OG@debutante>
References: <871si9xpew.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D3E9C267AA4
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:38:26 +0100 (CET)
In-Reply-To: <871si9xpew.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ad1980: replace codec to component

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

>From db53c016644c0d33579c60cc10b5152bbf9706ff Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:26:20 +0000
Subject: [PATCH] ASoC: ad1980: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad1980.c | 87 ++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index ce89bfb42094..16dab3f00a1c 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -205,9 +205,9 @@ static struct snd_soc_dai_driver ad1980_dai = {
 #define AD1980_VENDOR_ID 0x41445300
 #define AD1980_VENDOR_MASK 0xffffff00
 
-static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
+static int ad1980_reset(struct snd_soc_component *component, int try_warm)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+	struct snd_ac97 *ac97 = snd_soc_component_get_drvdata(component);
 	unsigned int retry_cnt = 0;
 	int ret;
 
@@ -223,16 +223,16 @@ static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 		 * case the first nibble of data is eaten by the addr. (Tag is
 		 * always 16 bit)
 		 */
-		snd_soc_write(codec, AC97_AD_SERIAL_CFG, 0x9900);
+		snd_soc_component_write(component, AC97_AD_SERIAL_CFG, 0x9900);
 
 	} while (retry_cnt++ < 10);
 
-	dev_err(codec->dev, "Failed to reset: AC97 link error\n");
+	dev_err(component->dev, "Failed to reset: AC97 link error\n");
 
 	return -EIO;
 }
 
-static int ad1980_soc_probe(struct snd_soc_codec *codec)
+static int ad1980_soc_probe(struct snd_soc_component *component)
 {
 	struct snd_ac97 *ac97;
 	struct regmap *regmap;
@@ -240,10 +240,10 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	u16 vendor_id2;
 	u16 ext_status;
 
-	ac97 = snd_soc_new_ac97_codec(codec, 0, 0);
+	ac97 = snd_soc_new_ac97_component(component, 0, 0);
 	if (IS_ERR(ac97)) {
 		ret = PTR_ERR(ac97);
-		dev_err(codec->dev, "Failed to register AC97 codec: %d\n", ret);
+		dev_err(component->dev, "Failed to register AC97 component: %d\n", ret);
 		return ret;
 	}
 
@@ -253,72 +253,66 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 		goto err_free_ac97;
 	}
 
-	snd_soc_codec_init_regmap(codec, regmap);
-	snd_soc_codec_set_drvdata(codec, ac97);
+	snd_soc_component_init_regmap(component, regmap);
+	snd_soc_component_set_drvdata(component, ac97);
 
-	ret = ad1980_reset(codec, 0);
+	ret = ad1980_reset(component, 0);
 	if (ret < 0)
 		goto reset_err;
 
-	vendor_id2 = snd_soc_read(codec, AC97_VENDOR_ID2);
+	vendor_id2 = snd_soc_component_read32(component, AC97_VENDOR_ID2);
 	if (vendor_id2 == 0x5374) {
-		dev_warn(codec->dev,
+		dev_warn(component->dev,
 			"Found AD1981 - only 2/2 IN/OUT Channels supported\n");
 	}
 
 	/* unmute captures and playbacks volume */
-	snd_soc_write(codec, AC97_MASTER, 0x0000);
-	snd_soc_write(codec, AC97_PCM, 0x0000);
-	snd_soc_write(codec, AC97_REC_GAIN, 0x0000);
-	snd_soc_write(codec, AC97_CENTER_LFE_MASTER, 0x0000);
-	snd_soc_write(codec, AC97_SURROUND_MASTER, 0x0000);
+	snd_soc_component_write(component, AC97_MASTER, 0x0000);
+	snd_soc_component_write(component, AC97_PCM, 0x0000);
+	snd_soc_component_write(component, AC97_REC_GAIN, 0x0000);
+	snd_soc_component_write(component, AC97_CENTER_LFE_MASTER, 0x0000);
+	snd_soc_component_write(component, AC97_SURROUND_MASTER, 0x0000);
 
 	/*power on LFE/CENTER/Surround DACs*/
-	ext_status = snd_soc_read(codec, AC97_EXTENDED_STATUS);
-	snd_soc_write(codec, AC97_EXTENDED_STATUS, ext_status&~0x3800);
+	ext_status = snd_soc_component_read32(component, AC97_EXTENDED_STATUS);
+	snd_soc_component_write(component, AC97_EXTENDED_STATUS, ext_status&~0x3800);
 
 	return 0;
 
 reset_err:
-	snd_soc_codec_exit_regmap(codec);
+	snd_soc_component_exit_regmap(component);
 err_free_ac97:
-	snd_soc_free_ac97_codec(ac97);
+	snd_soc_free_ac97_component(ac97);
 	return ret;
 }
 
-static int ad1980_soc_remove(struct snd_soc_codec *codec)
+static void ad1980_soc_remove(struct snd_soc_component *component)
 {
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
+	struct snd_ac97 *ac97 = snd_soc_component_get_drvdata(component);
 
-	snd_soc_codec_exit_regmap(codec);
-	snd_soc_free_ac97_codec(ac97);
-	return 0;
+	snd_soc_component_exit_regmap(component);
+	snd_soc_free_ac97_component(ac97);
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_ad1980 = {
-	.probe = 	ad1980_soc_probe,
-	.remove = 	ad1980_soc_remove,
-
-	.component_driver = {
-		.controls		= ad1980_snd_ac97_controls,
-		.num_controls		= ARRAY_SIZE(ad1980_snd_ac97_controls),
-		.dapm_widgets		= ad1980_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ad1980_dapm_widgets),
-		.dapm_routes		= ad1980_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(ad1980_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_ad1980 = {
+	.probe			= ad1980_soc_probe,
+	.remove			= ad1980_soc_remove,
+	.controls		= ad1980_snd_ac97_controls,
+	.num_controls		= ARRAY_SIZE(ad1980_snd_ac97_controls),
+	.dapm_widgets		= ad1980_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ad1980_dapm_widgets),
+	.dapm_routes		= ad1980_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(ad1980_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int ad1980_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev,
-			&soc_codec_dev_ad1980, &ad1980_dai, 1);
-}
-
-static int ad1980_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_ad1980, &ad1980_dai, 1);
 }
 
 static struct platform_driver ad1980_codec_driver = {
@@ -327,7 +321,6 @@ static struct platform_driver ad1980_codec_driver = {
 	},
 
 	.probe = ad1980_probe,
-	.remove = ad1980_remove,
 };
 
 module_platform_driver(ad1980_codec_driver);
-- 
2.16.1
