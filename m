From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm2000: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:51:41 +0000
Message-ID: <E1elDa9-0006QK-Lf@debutante>
References: <87d11t5q3g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DCA12680F6
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:51:47 +0100 (CET)
In-Reply-To: <87d11t5q3g.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm2000: replace codec to component

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

>From e5449affbf96cceaa042e33b0d1e5db0bd6ecf3c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:59:05 +0000
Subject: [PATCH] ASoC: wm2000: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm2000.c | 78 ++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index abfa052c07d8..c5ae07234a00 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -607,8 +607,8 @@ static int wm2000_anc_set_mode(struct wm2000_priv *wm2000)
 static int wm2000_anc_mode_get(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(component->dev);
 
 	ucontrol->value.integer.value[0] = wm2000->anc_active;
 
@@ -618,8 +618,8 @@ static int wm2000_anc_mode_get(struct snd_kcontrol *kcontrol,
 static int wm2000_anc_mode_put(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(component->dev);
 	unsigned int anc_active = ucontrol->value.integer.value[0];
 	int ret;
 
@@ -640,8 +640,8 @@ static int wm2000_anc_mode_put(struct snd_kcontrol *kcontrol,
 static int wm2000_speaker_get(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(component->dev);
 
 	ucontrol->value.integer.value[0] = wm2000->spk_ena;
 
@@ -651,8 +651,8 @@ static int wm2000_speaker_get(struct snd_kcontrol *kcontrol,
 static int wm2000_speaker_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(component->dev);
 	unsigned int val = ucontrol->value.integer.value[0];
 	int ret;
 
@@ -683,8 +683,8 @@ static const struct snd_kcontrol_new wm2000_controls[] = {
 static int wm2000_anc_power_event(struct snd_soc_dapm_widget *w,
 				  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(component->dev);
 	int ret;
 
 	mutex_lock(&wm2000->lock);
@@ -724,16 +724,16 @@ static const struct snd_soc_dapm_route wm2000_audio_map[] = {
 };
 
 #ifdef CONFIG_PM
-static int wm2000_suspend(struct snd_soc_codec *codec)
+static int wm2000_suspend(struct snd_soc_component *component)
 {
-	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(component->dev);
 
 	return wm2000_anc_transition(wm2000, ANC_OFF);
 }
 
-static int wm2000_resume(struct snd_soc_codec *codec)
+static int wm2000_resume(struct snd_soc_component *component)
 {
-	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(component->dev);
 
 	return wm2000_anc_set_mode(wm2000);
 }
@@ -782,9 +782,9 @@ static const struct regmap_config wm2000_regmap = {
 	.readable_reg = wm2000_readable_reg,
 };
 
-static int wm2000_probe(struct snd_soc_codec *codec)
+static int wm2000_probe(struct snd_soc_component *component)
 {
-	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(component->dev);
 
 	/* This will trigger a transition to standby mode by default */
 	wm2000_anc_set_mode(wm2000);
@@ -792,27 +792,28 @@ static int wm2000_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int wm2000_remove(struct snd_soc_codec *codec)
+static void wm2000_remove(struct snd_soc_component *component)
 {
-	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(component->dev);
 
-	return wm2000_anc_transition(wm2000, ANC_OFF);
+	wm2000_anc_transition(wm2000, ANC_OFF);
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm2000 = {
-	.probe = wm2000_probe,
-	.remove = wm2000_remove,
-	.suspend = wm2000_suspend,
-	.resume = wm2000_resume,
-
-	.component_driver = {
-		.controls		= wm2000_controls,
-		.num_controls		= ARRAY_SIZE(wm2000_controls),
-		.dapm_widgets		= wm2000_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm2000_dapm_widgets),
-		.dapm_routes		= wm2000_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(wm2000_audio_map),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm2000 = {
+	.probe			= wm2000_probe,
+	.remove			= wm2000_remove,
+	.suspend		= wm2000_suspend,
+	.resume			= wm2000_resume,
+	.controls		= wm2000_controls,
+	.num_controls		= ARRAY_SIZE(wm2000_controls),
+	.dapm_widgets		= wm2000_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm2000_dapm_widgets),
+	.dapm_routes		= wm2000_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(wm2000_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int wm2000_i2c_probe(struct i2c_client *i2c,
@@ -916,7 +917,8 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 
 	wm2000_reset(wm2000);
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm2000, NULL, 0);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+					&soc_component_dev_wm2000, NULL, 0);
 
 err_supplies:
 	regulator_bulk_disable(WM2000_NUM_SUPPLIES, wm2000->supplies);
@@ -926,13 +928,6 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int wm2000_i2c_remove(struct i2c_client *i2c)
-{
-	snd_soc_unregister_codec(&i2c->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id wm2000_i2c_id[] = {
 	{ "wm2000", 0 },
 	{ }
@@ -944,7 +939,6 @@ static struct i2c_driver wm2000_i2c_driver = {
 		.name = "wm2000",
 	},
 	.probe = wm2000_i2c_probe,
-	.remove = wm2000_i2c_remove,
 	.id_table = wm2000_i2c_id,
 };
 
-- 
2.16.1
