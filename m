From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 20/21] ASoC: Convert WM2000 into a standard
	CODEC driver
Date: Sat,  3 Dec 2011 21:33:28 +0000
Message-ID: <1322948009-27658-20-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFFF0243E8
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:40 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We've been able to handle external amps for a while now.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig  |    6 +-
 sound/soc/codecs/Makefile |    4 +-
 sound/soc/codecs/wm2000.c |  145 +++++++++++++++++++++------------------------
 sound/soc/codecs/wm2000.h |    2 -
 4 files changed, 73 insertions(+), 84 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 88ea1ba..087cc12 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -298,6 +298,9 @@ config SND_SOC_WM0010
 config SND_SOC_WM1250_EV1
 	tristate
 
+config SND_SOC_WM2000
+	tristate
+
 config SND_SOC_WM5100
 	tristate
 
@@ -434,8 +437,5 @@ config SND_SOC_MAX9877
 config SND_SOC_TPA6130A2
 	tristate
 
-config SND_SOC_WM2000
-	tristate
-
 config SND_SOC_WM9090
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 0e4869f..15f187a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -51,6 +51,7 @@ snd-soc-uda1380-objs := uda1380.o
 snd-soc-wl1273-objs := wl1273.o
 snd-soc-wm0010-objs := wm0010.o
 snd-soc-wm1250-ev1-objs := wm1250-ev1.o
+snd-soc-wm2000-objs := wm2000.o
 snd-soc-wm5100-objs := wm5100.o wm5100-tables.o
 snd-soc-wm8350-objs := wm8350.o
 snd-soc-wm8400-objs := wm8400.o
@@ -99,7 +100,6 @@ snd-soc-wm-hubs-objs := wm_hubs.o
 # Amp
 snd-soc-max9877-objs := max9877.o
 snd-soc-tpa6130a2-objs := tpa6130a2.o
-snd-soc-wm2000-objs := wm2000.o
 snd-soc-wm9090-objs := wm9090.o
 
 obj-$(CONFIG_SND_SOC_88PM860X)	+= snd-soc-88pm860x.o
@@ -155,6 +155,7 @@ obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WL1273)	+= snd-soc-wl1273.o
 obj-$(CONFIG_SND_SOC_WM0010)	+= snd-soc-wm0010.o
 obj-$(CONFIG_SND_SOC_WM1250_EV1) += snd-soc-wm1250-ev1.o
+obj-$(CONFIG_SND_SOC_WM2000)	+= snd-soc-wm2000.o
 obj-$(CONFIG_SND_SOC_WM5100)	+= snd-soc-wm5100.o
 obj-$(CONFIG_SND_SOC_WM8350)	+= snd-soc-wm8350.o
 obj-$(CONFIG_SND_SOC_WM8400)	+= snd-soc-wm8400.o
@@ -203,5 +204,4 @@ obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
 obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
-obj-$(CONFIG_SND_SOC_WM2000)	+= snd-soc-wm2000.o
 obj-$(CONFIG_SND_SOC_WM9090)	+= snd-soc-wm9090.o
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index a5f57ce..c288090 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -67,8 +67,6 @@ struct wm2000_priv {
 	char *anc_download;
 };
 
-static struct i2c_client *wm2000_i2c;
-
 static int wm2000_write(struct i2c_client *i2c, unsigned int reg,
 			unsigned int value)
 {
@@ -580,7 +578,8 @@ static int wm2000_anc_set_mode(struct wm2000_priv *wm2000)
 static int wm2000_anc_mode_get(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct wm2000_priv *wm2000 = dev_get_drvdata(&wm2000_i2c->dev);
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 
 	ucontrol->value.enumerated.item[0] = wm2000->anc_active;
 
@@ -590,7 +589,8 @@ static int wm2000_anc_mode_get(struct snd_kcontrol *kcontrol,
 static int wm2000_anc_mode_put(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct wm2000_priv *wm2000 = dev_get_drvdata(&wm2000_i2c->dev);
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 	int anc_active = ucontrol->value.enumerated.item[0];
 
 	if (anc_active > 1)
@@ -604,7 +604,8 @@ static int wm2000_anc_mode_put(struct snd_kcontrol *kcontrol,
 static int wm2000_speaker_get(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct wm2000_priv *wm2000 = dev_get_drvdata(&wm2000_i2c->dev);
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 
 	ucontrol->value.enumerated.item[0] = wm2000->spk_ena;
 
@@ -614,7 +615,8 @@ static int wm2000_speaker_get(struct snd_kcontrol *kcontrol,
 static int wm2000_speaker_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct wm2000_priv *wm2000 = dev_get_drvdata(&wm2000_i2c->dev);
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 	int val = ucontrol->value.enumerated.item[0];
 
 	if (val > 1)
@@ -637,7 +639,8 @@ static const struct snd_kcontrol_new wm2000_controls[] = {
 static int wm2000_anc_power_event(struct snd_soc_dapm_widget *w,
 				  struct snd_kcontrol *kcontrol, int event)
 {
-	struct wm2000_priv *wm2000 = dev_get_drvdata(&wm2000_i2c->dev);
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		wm2000->anc_eng_ena = 1;
@@ -650,11 +653,11 @@ static int wm2000_anc_power_event(struct snd_soc_dapm_widget *w,
 
 static const struct snd_soc_dapm_widget wm2000_dapm_widgets[] = {
 /* Externally visible pins */
-SND_SOC_DAPM_OUTPUT("WM2000 SPKN"),
-SND_SOC_DAPM_OUTPUT("WM2000 SPKP"),
+SND_SOC_DAPM_OUTPUT("SPKN"),
+SND_SOC_DAPM_OUTPUT("SPKP"),
 
-SND_SOC_DAPM_INPUT("WM2000 LINN"),
-SND_SOC_DAPM_INPUT("WM2000 LINP"),
+SND_SOC_DAPM_INPUT("LINN"),
+SND_SOC_DAPM_INPUT("LINP"),
 
 SND_SOC_DAPM_PGA_E("ANC Engine", SND_SOC_NOPM, 0, 0, NULL, 0,
 		   wm2000_anc_power_event,
@@ -662,43 +665,68 @@ SND_SOC_DAPM_PGA_E("ANC Engine", SND_SOC_NOPM, 0, 0, NULL, 0,
 };
 
 /* Target, Path, Source */
-static const struct snd_soc_dapm_route audio_map[] = {
-	{ "WM2000 SPKN", NULL, "ANC Engine" },
-	{ "WM2000 SPKP", NULL, "ANC Engine" },
-	{ "ANC Engine", NULL, "WM2000 LINN" },
-	{ "ANC Engine", NULL, "WM2000 LINP" },
+static const struct snd_soc_dapm_route wm2000_audio_map[] = {
+	{ "SPKN", NULL, "ANC Engine" },
+	{ "SPKP", NULL, "ANC Engine" },
+	{ "ANC Engine", NULL, "LINN" },
+	{ "ANC Engine", NULL, "LINP" },
 };
 
-/* Called from the machine driver */
-int wm2000_add_controls(struct snd_soc_codec *codec)
+#ifdef CONFIG_PM
+static int wm2000_suspend(struct snd_soc_codec *codec)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
+	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 
-	if (!wm2000_i2c) {
-		pr_err("WM2000 not yet probed\n");
-		return -ENODEV;
-	}
-
-	ret = snd_soc_dapm_new_controls(dapm, wm2000_dapm_widgets,
-					ARRAY_SIZE(wm2000_dapm_widgets));
-	if (ret < 0)
-		return ret;
+	return wm2000_anc_transition(wm2000, ANC_OFF);
+}
 
-	ret = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-	if (ret < 0)
-		return ret;
+static int wm2000_resume(struct snd_soc_codec *codec)
+{
+	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 
-	return snd_soc_add_controls(codec, wm2000_controls,
-			ARRAY_SIZE(wm2000_controls));
+	return wm2000_anc_set_mode(wm2000);
 }
-EXPORT_SYMBOL_GPL(wm2000_add_controls);
+#else
+#define wm2000_suspend NULL
+#define wm2000_resume NULL
+#endif
 
 static const struct regmap_config wm2000_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 };
 
+static int wm2000_probe(struct snd_soc_codec *codec)
+{
+	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+
+	/* This will trigger a transition to standby mode by default */
+	wm2000_anc_set_mode(wm2000);
+
+	return 0;
+}
+
+static int wm2000_remove(struct snd_soc_codec *codec)
+{
+	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
+
+	return wm2000_anc_transition(wm2000, ANC_OFF);
+}
+
+static struct snd_soc_codec_driver soc_codec_dev_wm2000 = {
+	.probe = wm2000_probe,
+	.remove = wm2000_remove,
+	.suspend = wm2000_suspend,
+	.resume = wm2000_resume,
+
+	.dapm_widgets = wm2000_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm2000_dapm_widgets),
+	.dapm_routes = wm2000_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wm2000_audio_map),
+	.controls = wm2000_controls,
+	.num_controls = ARRAY_SIZE(wm2000_controls),
+};
+
 static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *i2c_id)
 {
@@ -709,11 +737,6 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 	int reg, ret;
 	u16 id;
 
-	if (wm2000_i2c) {
-		dev_err(&i2c->dev, "Another WM2000 is already registered\n");
-		return -EINVAL;
-	}
-
 	wm2000 = devm_kzalloc(&i2c->dev, sizeof(struct wm2000_priv),
 			      GFP_KERNEL);
 	if (wm2000 == NULL) {
@@ -786,10 +809,10 @@ static int __devinit wm2000_i2c_probe(struct i2c_client *i2c,
 
 	wm2000_reset(wm2000);
 
-	/* This will trigger a transition to standby mode by default */
-	wm2000_anc_set_mode(wm2000);	
-
-	wm2000_i2c = i2c;
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm2000,
+				     NULL, 0);
+	if (ret != 0)
+		goto err_fw;
 
 	return 0;
 
@@ -805,42 +828,12 @@ static __devexit int wm2000_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
 
-	wm2000_anc_transition(wm2000, ANC_OFF);
-
+	snd_soc_unregister_codec(&i2c->dev);
 	regmap_exit(wm2000->regmap);
 
-	wm2000_i2c = NULL;
-
 	return 0;
 }
 
-static void wm2000_i2c_shutdown(struct i2c_client *i2c)
-{
-	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
-
-	wm2000_anc_transition(wm2000, ANC_OFF);
-}
-
-#ifdef CONFIG_PM
-static int wm2000_i2c_suspend(struct device *dev)
-{
-	struct i2c_client *i2c = to_i2c_client(dev);
-	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
-
-	return wm2000_anc_transition(wm2000, ANC_OFF);
-}
-
-static int wm2000_i2c_resume(struct device *dev)
-{
-	struct i2c_client *i2c = to_i2c_client(dev);
-	struct wm2000_priv *wm2000 = dev_get_drvdata(&i2c->dev);
-
-	return wm2000_anc_set_mode(wm2000);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(wm2000_pm, wm2000_i2c_suspend, wm2000_i2c_resume);
-
 static const struct i2c_device_id wm2000_i2c_id[] = {
 	{ "wm2000", 0 },
 	{ }
@@ -851,11 +844,9 @@ static struct i2c_driver wm2000_i2c_driver = {
 	.driver = {
 		.name = "wm2000",
 		.owner = THIS_MODULE,
-		.pm = &wm2000_pm,
 	},
 	.probe = wm2000_i2c_probe,
 	.remove = __devexit_p(wm2000_i2c_remove),
-	.shutdown = wm2000_i2c_shutdown,
 	.id_table = wm2000_i2c_id,
 };
 
diff --git a/sound/soc/codecs/wm2000.h b/sound/soc/codecs/wm2000.h
index 28a51ed..abcd82a 100644
--- a/sound/soc/codecs/wm2000.h
+++ b/sound/soc/codecs/wm2000.h
@@ -9,8 +9,6 @@
 #ifndef _WM2000_H
 #define _WM2000_H
 
-extern int wm2000_add_controls(struct snd_soc_codec *codec);
-
 #define WM2000_REG_SYS_START	    0x8000
 #define WM2000_REG_SPEECH_CLARITY   0x8fef
 #define WM2000_REG_SYS_WATCHDOG     0x8ff6
-- 
1.7.7.3
