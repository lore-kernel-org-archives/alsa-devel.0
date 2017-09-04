From: Charles Keepax <ckeepax-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
Subject: [PATCH 1/7] ASoC: arizona: Add new common Arizona init function
Date: Mon, 4 Sep 2017 16:41:48 +0100
Message-ID: <20170904154154.4395-2-ckeepax@opensource.cirrus.com>
References: <20170904154154.4395-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170904154154.4395-1-ckeepax-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Currently the driver has quite a few small initialisation functions, in
preparation for some refactoring add a new function arizona_init_common.
This will be used bus probe level initialisation that is common across
Arizona devices. For now just move the notifier chain initialisation in
there.

Signed-off-by: Charles Keepax <ckeepax-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
---
 sound/soc/codecs/arizona.c | 7 ++-----
 sound/soc/codecs/arizona.h | 3 ++-
 sound/soc/codecs/cs47l24.c | 3 ++-
 sound/soc/codecs/wm5102.c  | 3 ++-
 sound/soc/codecs/wm5110.c  | 3 ++-
 sound/soc/codecs/wm8997.c  | 4 ++--
 sound/soc/codecs/wm8998.c  | 3 ++-
 7 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a1149f6a8450..ba5f57a58219 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -293,16 +293,13 @@ int arizona_init_gpio(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(arizona_init_gpio);
 
-int arizona_init_notifiers(struct snd_soc_codec *codec)
+int arizona_init_common(struct arizona *arizona)
 {
-	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct arizona *arizona = priv->arizona;
-
 	BLOCKING_INIT_NOTIFIER_HEAD(&arizona->notifier);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(arizona_init_notifiers);
+EXPORT_SYMBOL_GPL(arizona_init_common);
 
 const char * const arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS] = {
 	"None",
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 1822e3b3de80..292073ca3bd9 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -313,7 +313,8 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 int arizona_init_spk(struct snd_soc_codec *codec);
 int arizona_init_gpio(struct snd_soc_codec *codec);
 int arizona_init_mono(struct snd_soc_codec *codec);
-int arizona_init_notifiers(struct snd_soc_codec *codec);
+
+int arizona_init_common(struct arizona *arizona);
 
 int arizona_init_spk_irqs(struct arizona *arizona);
 int arizona_free_spk_irqs(struct arizona *arizona);
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index e09fc8f037f1..fdcc7318993b 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1130,7 +1130,6 @@ static int cs47l24_codec_probe(struct snd_soc_codec *codec)
 
 	arizona_init_gpio(codec);
 	arizona_init_mono(codec);
-	arizona_init_notifiers(codec);
 
 	ret = wm_adsp2_codec_probe(&priv->core.adsp[1], codec);
 	if (ret)
@@ -1288,6 +1287,8 @@ static int cs47l24_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	arizona_init_common(arizona);
+
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		goto err_dsp_irq;
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 72486bf072f2..8354bdf7fc15 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1951,7 +1951,6 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	arizona_init_gpio(codec);
-	arizona_init_notifiers(codec);
 
 	snd_soc_component_disable_pin(component, "HAPTICS");
 
@@ -2098,6 +2097,8 @@ static int wm5102_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	arizona_init_common(arizona);
+
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		goto err_dsp_irq;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 858a24fc28e8..0437df60be77 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2290,7 +2290,6 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 
 	arizona_init_gpio(codec);
 	arizona_init_mono(codec);
-	arizona_init_notifiers(codec);
 
 	for (i = 0; i < WM5110_NUM_ADSP; ++i) {
 		ret = wm_adsp2_codec_probe(&priv->core.adsp[i], codec);
@@ -2454,6 +2453,8 @@ static int wm5110_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	arizona_init_common(arizona);
+
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		goto err_dsp_irq;
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 49401a8aae64..91c3c3e052d1 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1068,8 +1068,6 @@ static int wm8997_codec_probe(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
-	arizona_init_notifiers(codec);
-
 	snd_soc_component_disable_pin(component, "HAPTICS");
 
 	priv->core.arizona->dapm = dapm;
@@ -1168,6 +1166,8 @@ static int wm8997_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	arizona_init_common(arizona);
+
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 44f447136e22..27a8e1e75f28 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1330,7 +1330,6 @@ static int wm8998_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 
 	arizona_init_gpio(codec);
-	arizona_init_notifiers(codec);
 
 	snd_soc_component_disable_pin(component, "HAPTICS");
 
@@ -1423,6 +1422,8 @@ static int wm8998_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
+	arizona_init_common(arizona);
+
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
 		return ret;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
