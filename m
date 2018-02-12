From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uniphier: evea: replace codec to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:33:21 +0000
Message-ID: <E1elDIP-0003bT-JZ@debutante>
References: <874ln5uvb2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E23ED267627
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:33:23 +0100 (CET)
In-Reply-To: <874ln5uvb2.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: uniphier: evea: replace codec to component

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

>From f12df6614bee36c11ba0b3fb2d74b7d47b955434 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:47:19 +0000
Subject: [PATCH] ASoC: uniphier: evea: replace codec to component

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
 sound/soc/uniphier/evea.c | 67 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index 0cc9efff1d9a..cad7e60de21d 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -220,8 +220,8 @@ static void evea_update_switch_all(struct evea_priv *evea)
 static int evea_get_switch_lin(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct evea_priv *evea = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = evea->switch_lin;
 
@@ -231,8 +231,8 @@ static int evea_get_switch_lin(struct snd_kcontrol *kcontrol,
 static int evea_set_switch_lin(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct evea_priv *evea = snd_soc_component_get_drvdata(component);
 
 	if (evea->switch_lin == ucontrol->value.integer.value[0])
 		return 0;
@@ -245,8 +245,8 @@ static int evea_set_switch_lin(struct snd_kcontrol *kcontrol,
 static int evea_get_switch_lo(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct evea_priv *evea = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = evea->switch_lo;
 
@@ -256,8 +256,8 @@ static int evea_get_switch_lo(struct snd_kcontrol *kcontrol,
 static int evea_set_switch_lo(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct evea_priv *evea = snd_soc_component_get_drvdata(component);
 
 	if (evea->switch_lo == ucontrol->value.integer.value[0])
 		return 0;
@@ -270,8 +270,8 @@ static int evea_set_switch_lo(struct snd_kcontrol *kcontrol,
 static int evea_get_switch_hp(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct evea_priv *evea = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = evea->switch_hp;
 
@@ -281,8 +281,8 @@ static int evea_get_switch_hp(struct snd_kcontrol *kcontrol,
 static int evea_set_switch_hp(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct evea_priv *evea = snd_soc_component_get_drvdata(component);
 
 	if (evea->switch_hp == ucontrol->value.integer.value[0])
 		return 0;
@@ -301,9 +301,9 @@ static const struct snd_kcontrol_new eva_controls[] = {
 			    evea_get_switch_hp, evea_set_switch_hp),
 };
 
-static int evea_codec_probe(struct snd_soc_codec *codec)
+static int evea_codec_probe(struct snd_soc_component *component)
 {
-	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+	struct evea_priv *evea = snd_soc_component_get_drvdata(component);
 
 	evea->switch_lin = 1;
 	evea->switch_lo = 1;
@@ -315,9 +315,9 @@ static int evea_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int evea_codec_suspend(struct snd_soc_codec *codec)
+static int evea_codec_suspend(struct snd_soc_component *component)
 {
-	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+	struct evea_priv *evea = snd_soc_component_get_drvdata(component);
 
 	evea_set_power_state_off(evea);
 
@@ -331,9 +331,9 @@ static int evea_codec_suspend(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int evea_codec_resume(struct snd_soc_codec *codec)
+static int evea_codec_resume(struct snd_soc_component *component)
 {
-	struct evea_priv *evea = snd_soc_codec_get_drvdata(codec);
+	struct evea_priv *evea = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = clk_prepare_enable(evea->clk);
@@ -376,19 +376,20 @@ static int evea_codec_resume(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static struct snd_soc_codec_driver soc_codec_evea = {
-	.probe   = evea_codec_probe,
-	.suspend = evea_codec_suspend,
-	.resume  = evea_codec_resume,
-
-	.component_driver = {
-		.dapm_widgets = evea_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(evea_widgets),
-		.dapm_routes = evea_routes,
-		.num_dapm_routes = ARRAY_SIZE(evea_routes),
-		.controls = eva_controls,
-		.num_controls = ARRAY_SIZE(eva_controls),
-	},
+static struct snd_soc_component_driver soc_codec_evea = {
+	.probe			= evea_codec_probe,
+	.suspend		= evea_codec_suspend,
+	.resume			= evea_codec_resume,
+	.dapm_widgets		= evea_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(evea_widgets),
+	.dapm_routes		= evea_routes,
+	.num_dapm_routes	= ARRAY_SIZE(evea_routes),
+	.controls		= eva_controls,
+	.num_controls		= ARRAY_SIZE(eva_controls),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static struct snd_soc_dai_driver soc_dai_evea[] = {
@@ -505,7 +506,7 @@ static int evea_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, evea);
 
-	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_evea,
+	ret = devm_snd_soc_register_component(&pdev->dev, &soc_codec_evea,
 				     soc_dai_evea, ARRAY_SIZE(soc_dai_evea));
 	if (ret)
 		goto err_out_reset_adamv;
@@ -534,8 +535,6 @@ static int evea_remove(struct platform_device *pdev)
 {
 	struct evea_priv *evea = platform_get_drvdata(pdev);
 
-	snd_soc_unregister_codec(&pdev->dev);
-
 	reset_control_assert(evea->rst_adamv);
 	reset_control_assert(evea->rst_exiv);
 	reset_control_assert(evea->rst);
-- 
2.16.1
