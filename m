From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ASoC: constify snd_soc_codec_driver structures
Date: Wed, 31 Aug 2016 23:52:27 +0200
Message-ID: <1472680347-19575-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Check for snd_soc_codec_driver structures that are only passed to
snd_soc_register_codec or memcpy (2nd arg), for which the corresponding
parameters are declared const.  Declare as const snd_soc_codec_driver
structures that have these properties.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct snd_soc_codec_driver i@p = { ... };

@ok@
identifier r.i;
expression e1,e2,e3;
position p;
@@
(
snd_soc_register_codec(e1,&i@p,e2,e3)
|
memcpy(e1,&i@p,e2)
)

@bad@
position p != {r.p,ok.p};
identifier r.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct snd_soc_codec_driver i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/codecs/wm0010.c     |    2 +-
 sound/soc/codecs/wm1250-ev1.c |    2 +-
 sound/soc/codecs/wm2000.c     |    2 +-
 sound/soc/codecs/wm2200.c     |    2 +-
 sound/soc/codecs/wm5100.c     |    2 +-
 sound/soc/codecs/wm5102.c     |    2 +-
 sound/soc/codecs/wm5110.c     |    2 +-
 sound/soc/codecs/wm8350.c     |    2 +-
 sound/soc/codecs/wm8400.c     |    2 +-
 sound/soc/codecs/wm8510.c     |    2 +-
 sound/soc/codecs/wm8523.c     |    2 +-
 sound/soc/codecs/wm8580.c     |    2 +-
 sound/soc/codecs/wm8711.c     |    2 +-
 sound/soc/codecs/wm8727.c     |    2 +-
 sound/soc/codecs/wm8728.c     |    2 +-
 sound/soc/codecs/wm8731.c     |    2 +-
 sound/soc/codecs/wm8737.c     |    2 +-
 sound/soc/codecs/wm8741.c     |    2 +-
 sound/soc/codecs/wm8750.c     |    2 +-
 sound/soc/codecs/wm8753.c     |    2 +-
 sound/soc/codecs/wm8770.c     |    2 +-
 sound/soc/codecs/wm8776.c     |    2 +-
 sound/soc/codecs/wm8782.c     |    2 +-
 sound/soc/codecs/wm8900.c     |    2 +-
 sound/soc/codecs/wm8903.c     |    2 +-
 sound/soc/codecs/wm8904.c     |    2 +-
 sound/soc/codecs/wm8940.c     |    2 +-
 sound/soc/codecs/wm8955.c     |    2 +-
 sound/soc/codecs/wm8960.c     |    2 +-
 sound/soc/codecs/wm8961.c     |    2 +-
 sound/soc/codecs/wm8962.c     |    2 +-
 sound/soc/codecs/wm8971.c     |    2 +-
 sound/soc/codecs/wm8974.c     |    2 +-
 sound/soc/codecs/wm8978.c     |    2 +-
 sound/soc/codecs/wm8983.c     |    2 +-
 sound/soc/codecs/wm8985.c     |    2 +-
 sound/soc/codecs/wm8990.c     |    2 +-
 sound/soc/codecs/wm8991.c     |    2 +-
 sound/soc/codecs/wm8993.c     |    2 +-
 sound/soc/codecs/wm8994.c     |    2 +-
 sound/soc/codecs/wm8996.c     |    2 +-
 sound/soc/codecs/wm8997.c     |    2 +-
 sound/soc/codecs/wm8998.c     |    2 +-
 sound/soc/codecs/wm9081.c     |    2 +-
 sound/soc/codecs/wm9090.c     |    2 +-
 sound/soc/codecs/wm9705.c     |    2 +-
 sound/soc/codecs/wm9712.c     |    2 +-
 sound/soc/codecs/wm9713.c     |    2 +-
 48 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 4ef6919..0eb5dcf 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -789,7 +789,7 @@ static int wm0010_set_sysclk(struct snd_soc_codec *codec, int source,
 
 static int wm0010_probe(struct snd_soc_codec *codec);
 
-static struct snd_soc_codec_driver soc_codec_dev_wm0010 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm0010 = {
 	.probe = wm0010_probe,
 	.set_bias_level = wm0010_set_bias_level,
 	.set_sysclk = wm0010_set_sysclk,
diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index caf5012..cf5f058 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -141,7 +141,7 @@ static struct snd_soc_dai_driver wm1250_ev1_dai = {
 	.ops = &wm1250_ev1_ops,
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm1250_ev1 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm1250_ev1 = {
 	.component_driver = {
 		.dapm_widgets		= wm1250_ev1_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(wm1250_ev1_dapm_widgets),
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 199a3d8..23cde3a 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -799,7 +799,7 @@ static int wm2000_remove(struct snd_soc_codec *codec)
 	return wm2000_anc_transition(wm2000, ANC_OFF);
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm2000 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm2000 = {
 	.probe = wm2000_probe,
 	.remove = wm2000_remove,
 	.suspend = wm2000_suspend,
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index d913d0e..606bf88 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2103,7 +2103,7 @@ static struct snd_soc_dai_driver wm2200_dai = {
 	.ops = &wm2200_dai_ops,
 };
 
-static struct snd_soc_codec_driver soc_codec_wm2200 = {
+static const struct snd_soc_codec_driver soc_codec_wm2200 = {
 	.probe = wm2200_probe,
 
 	.idle_bias_off = true,
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 8cbdf17..278467d 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2381,7 +2381,7 @@ static int wm5100_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm5100 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm5100 = {
 	.probe =	wm5100_probe,
 	.remove =	wm5100_remove,
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 2d6c19d..ed03ed27 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2000,7 +2000,7 @@ static struct regmap *wm5102_get_regmap(struct device *dev)
 	return priv->core.arizona->regmap;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm5102 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm5102 = {
 	.probe = wm5102_codec_probe,
 	.remove = wm5102_codec_remove,
 	.get_regmap = wm5102_get_regmap,
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index fa35e19..53d35fe 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2357,7 +2357,7 @@ static struct regmap *wm5110_get_regmap(struct device *dev)
 	return priv->core.arizona->regmap;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
 	.probe = wm5110_codec_probe,
 	.remove = wm5110_codec_remove,
 	.get_regmap = wm5110_get_regmap,
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 18bc4ca..2efc5b4 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1587,7 +1587,7 @@ static struct regmap *wm8350_get_regmap(struct device *dev)
 	return wm8350->regmap;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8350 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8350 = {
 	.probe =	wm8350_codec_probe,
 	.remove =	wm8350_codec_remove,
 	.get_regmap =	wm8350_get_regmap,
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 4551e54..6c59fb9 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1332,7 +1332,7 @@ static struct regmap *wm8400_get_regmap(struct device *dev)
 	return wm8400->regmap;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
 	.probe =	wm8400_codec_probe,
 	.remove =	wm8400_codec_remove,
 	.get_regmap =	wm8400_get_regmap,
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 7f93adf..119ceac 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -581,7 +581,7 @@ static int wm8510_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8510 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8510 = {
 	.probe =	wm8510_probe,
 	.set_bias_level = wm8510_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 0bb189a..deb2e07 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -413,7 +413,7 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8523 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8523 = {
 	.probe =	wm8523_probe,
 	.set_bias_level = wm8523_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 2e69270..faa7287 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -899,7 +899,7 @@ static int wm8580_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8580 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8580 = {
 	.probe =	wm8580_probe,
 	.remove =	wm8580_remove,
 	.set_bias_level = wm8580_set_bias_level,
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 4e8ebef..2b376c9 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -367,7 +367,7 @@ static int wm8711_probe(struct snd_soc_codec *codec)
 
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8711 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8711 = {
 	.probe =	wm8711_probe,
 	.set_bias_level = wm8711_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
index b01e64e..7fde077 100644
--- a/sound/soc/codecs/wm8727.c
+++ b/sound/soc/codecs/wm8727.c
@@ -53,7 +53,7 @@ static struct snd_soc_dai_driver wm8727_dai = {
 		},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8727 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8727 = {
 	.component_driver = {
 		.dapm_widgets		= wm8727_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(wm8727_dapm_widgets),
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index dcd64b3..797cc6e 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -211,7 +211,7 @@ static struct snd_soc_dai_driver wm8728_dai = {
 	.ops = &wm8728_dai_ops,
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8728 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8728 = {
 	.set_bias_level = wm8728_set_bias_level,
 	.suspend_bias_off = true,
 
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 545fc9a..4f9a1eb 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -628,7 +628,7 @@ err_regulator_enable:
 	return ret;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
 	.set_bias_level = wm8731_set_bias_level,
 	.suspend_bias_off = true,
 
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index 728c42c..f0cb1c4 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -573,7 +573,7 @@ err_get:
 	return ret;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8737 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8737 = {
 	.probe		= wm8737_probe,
 	.set_bias_level = wm8737_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 3e43272..565d477 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -497,7 +497,7 @@ static int wm8741_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8741 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8741 = {
 	.probe =	wm8741_probe,
 	.remove =	wm8741_remove,
 	.resume =	wm8741_resume,
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index a96a145..0da2bba 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -708,7 +708,7 @@ static int wm8750_probe(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8750 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8750 = {
 	.probe =	wm8750_probe,
 	.set_bias_level = wm8750_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 1bb272c..9bdf544 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1478,7 +1478,7 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8753 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8753 = {
 	.probe =	wm8753_probe,
 	.resume =	wm8753_resume,
 	.set_bias_level = wm8753_set_bias_level,
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 8783a5f..d6edcbb 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -608,7 +608,7 @@ err_reg_enable:
 	return ret;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8770 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8770 = {
 	.probe = wm8770_probe,
 	.set_bias_level = wm8770_set_bias_level,
 	.idle_bias_off = true,
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index f17a3a8..ae30480 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -425,7 +425,7 @@ static int wm8776_probe(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8776 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8776 = {
 	.probe = 	wm8776_probe,
 	.set_bias_level = wm8776_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 1e9c495..bcda210 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -50,7 +50,7 @@ static struct snd_soc_dai_driver wm8782_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8782 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8782 = {
 	.component_driver = {
 		.dapm_widgets		= wm8782_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(wm8782_dapm_widgets),
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 724cec4..c77b49a 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1208,7 +1208,7 @@ static int wm8900_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8900 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8900 = {
 	.probe =	wm8900_probe,
 	.suspend =	wm8900_suspend,
 	.resume =	wm8900_resume,
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index c19ba7c..837c8b9 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1874,7 +1874,7 @@ static void wm8903_free_gpio(struct wm8903_priv *wm8903)
 }
 #endif
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
 	.resume =	wm8903_resume,
 	.set_bias_level = wm8903_set_bias_level,
 	.seq_notifier = wm8903_seq_notifier,
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index edd7a77..4fd350e8 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2086,7 +2086,7 @@ static int wm8904_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8904 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8904 = {
 	.probe =	wm8904_probe,
 	.remove =	wm8904_remove,
 	.set_bias_level = wm8904_set_bias_level,
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 3c9febc..b593562 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -723,7 +723,7 @@ static int wm8940_probe(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8940 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8940 = {
 	.probe =	wm8940_probe,
 	.set_bias_level = wm8940_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 575075d..1edc7b1 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -940,7 +940,7 @@ err_enable:
 	return ret;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8955 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8955 = {
 	.probe =	wm8955_probe,
 	.set_bias_level = wm8955_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index d7f444f..be32443 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1264,7 +1264,7 @@ static int wm8960_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8960 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8960 = {
 	.probe =	wm8960_probe,
 	.set_bias_level = wm8960_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 4b51761..e23ceac 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -882,7 +882,7 @@ static int wm8961_resume(struct snd_soc_codec *codec)
 #define wm8961_resume NULL
 #endif
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8961 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8961 = {
 	.probe =	wm8961_probe,
 	.resume =	wm8961_resume,
 	.set_bias_level = wm8961_set_bias_level,
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index f3109da..392b920 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3479,7 +3479,7 @@ static int wm8962_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8962 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8962 = {
 	.probe =	wm8962_probe,
 	.remove =	wm8962_remove,
 	.set_bias_level = wm8962_set_bias_level,
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 214fa13..887d31c 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -649,7 +649,7 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
 	.probe =	wm8971_probe,
 	.set_bias_level = wm8971_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index fbda6e3..d414ddd 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -676,7 +676,7 @@ static int wm8974_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
 	.probe = 	wm8974_probe,
 	.set_bias_level = wm8974_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 910b36f..90b2d41 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -993,7 +993,7 @@ static int wm8978_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8978 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8978 = {
 	.probe =	wm8978_probe,
 	.suspend =	wm8978_suspend,
 	.resume =	wm8978_resume,
diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 9609fc0..bfdbe72 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -976,7 +976,7 @@ static struct snd_soc_dai_driver wm8983_dai = {
 	.symmetric_rates = 1
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8983 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8983 = {
 	.probe = wm8983_probe,
 	.set_bias_level = wm8983_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index bcf3473..05344f9 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1105,7 +1105,7 @@ static struct snd_soc_dai_driver wm8985_dai = {
 	.symmetric_rates = 1
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8985 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8985 = {
 	.probe = wm8985_probe,
 	.set_bias_level = wm8985_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index a412fd0..a894500 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1294,7 +1294,7 @@ static int wm8990_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8990 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8990 = {
 	.probe =	wm8990_probe,
 	.set_bias_level = wm8990_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 5822d10..9843790 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -1232,7 +1232,7 @@ static struct snd_soc_dai_driver wm8991_dai = {
 	.ops = &wm8991_ops
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8991 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8991 = {
 	.set_bias_level = wm8991_set_bias_level,
 	.suspend_bias_off = true,
 
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 8668c4c..195f7bf 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1613,7 +1613,7 @@ static const struct regmap_config wm8993_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(wm8993_reg_defaults),
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8993 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8993 = {
 	.probe = 	wm8993_probe,
 	.suspend =	wm8993_suspend,
 	.resume =	wm8993_resume,
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index a18aecb..3896523 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4439,7 +4439,7 @@ static struct regmap *wm8994_get_regmap(struct device *dev)
 	return control->regmap;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
 	.probe =	wm8994_codec_probe,
 	.remove =	wm8994_codec_remove,
 	.suspend =	wm8994_codec_suspend,
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index abacf6c..5eba8ff 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2684,7 +2684,7 @@ static int wm8996_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8996 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8996 = {
 	.probe =	wm8996_probe,
 	.remove =	wm8996_remove,
 	.set_bias_level = wm8996_set_bias_level,
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index cf23a6b..2f2821b 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1095,7 +1095,7 @@ static struct regmap *wm8997_get_regmap(struct device *dev)
 	return priv->core.arizona->regmap;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8997 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8997 = {
 	.probe = wm8997_codec_probe,
 	.remove = wm8997_codec_remove,
 	.get_regmap =   wm8997_get_regmap,
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index edaa4cf..bcc2e10 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1361,7 +1361,7 @@ static struct regmap *wm8998_get_regmap(struct device *dev)
 	return priv->core.arizona->regmap;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm8998 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm8998 = {
 	.probe = wm8998_codec_probe,
 	.remove = wm8998_codec_remove,
 	.get_regmap = wm8998_get_regmap,
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 30eaf4c..856867e 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1274,7 +1274,7 @@ static int wm9081_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
 	.probe = 	wm9081_probe,
 
 	.set_sysclk = wm9081_set_sysclk,
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 5d73729..5a13138 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -550,7 +550,7 @@ static int wm9090_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm9090 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm9090 = {
 	.probe = 	wm9090_probe,
 	.set_bias_level = wm9090_set_bias_level,
 	.suspend_bias_off = true,
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index c88492d..dcdd055 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -352,7 +352,7 @@ static int wm9705_soc_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
 	.probe = 	wm9705_soc_probe,
 	.remove = 	wm9705_soc_remove,
 	.suspend =	wm9705_soc_suspend,
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index e5aafdd..557709e 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -669,7 +669,7 @@ static int wm9712_soc_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
 	.probe = 	wm9712_soc_probe,
 	.remove = 	wm9712_soc_remove,
 	.resume =	wm9712_soc_resume,
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 255a7c2..e4301dd 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1235,7 +1235,7 @@ static int wm9713_soc_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
+static const struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
 	.probe = 	wm9713_soc_probe,
 	.remove = 	wm9713_soc_remove,
 	.suspend =	wm9713_soc_suspend,

