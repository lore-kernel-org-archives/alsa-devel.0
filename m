From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: wm97xx: fix uninitialized regmap pointer
	problem
Date: Fri,  2 Nov 2018 12:23:08 +0100
Message-ID: <20181102112341.753642-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F0882675BA
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2018 12:23:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

gcc notices that without either the ac97 bus or the pdata, we never
initialize the regmap pointer, which leads to an uninitialized variable
access:

sound/soc/codecs/wm9712.c: In function 'wm9712_soc_probe':
sound/soc/codecs/wm9712.c:666:2: error: 'regmap' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Since that configuration is invalid, it's better to return an error
here. I tried to avoid adding complexity to the conditions, and turned
the #ifdef into a regular if(IS_ENABLED()) check for readability.
This in turn requires moving some header file declarations out of
an #ifdef.

The same code is used in three drivers, all of which I'm changing
the same way.

Fixes: 2ed1a8e0ce8d ("ASoC: wm9712: add ac97 new bus support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/soc.h       |  2 +-
 sound/soc/codecs/wm9705.c | 10 ++++------
 sound/soc/codecs/wm9712.c | 10 ++++------
 sound/soc/codecs/wm9713.c | 10 ++++------
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 70c10a8f3e90..3e0ac310a3df 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -553,12 +553,12 @@ static inline void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 }
 #endif
 
-#ifdef CONFIG_SND_SOC_AC97_BUS
 struct snd_ac97 *snd_soc_alloc_ac97_component(struct snd_soc_component *component);
 struct snd_ac97 *snd_soc_new_ac97_component(struct snd_soc_component *component,
 	unsigned int id, unsigned int id_mask);
 void snd_soc_free_ac97_component(struct snd_ac97 *ac97);
 
+#ifdef CONFIG_SND_SOC_AC97_BUS
 int snd_soc_set_ac97_ops(struct snd_ac97_bus_ops *ops);
 int snd_soc_set_ac97_ops_of_reset(struct snd_ac97_bus_ops *ops,
 		struct platform_device *pdev);
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index ccdf088461b7..54c306707c02 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -325,8 +325,7 @@ static int wm9705_soc_probe(struct snd_soc_component *component)
 	if (wm9705->mfd_pdata) {
 		wm9705->ac97 = wm9705->mfd_pdata->ac97;
 		regmap = wm9705->mfd_pdata->regmap;
-	} else {
-#ifdef CONFIG_SND_SOC_AC97_BUS
+	} else if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {
 		wm9705->ac97 = snd_soc_new_ac97_component(component, WM9705_VENDOR_ID,
 						      WM9705_VENDOR_ID_MASK);
 		if (IS_ERR(wm9705->ac97)) {
@@ -339,7 +338,8 @@ static int wm9705_soc_probe(struct snd_soc_component *component)
 			snd_soc_free_ac97_component(wm9705->ac97);
 			return PTR_ERR(regmap);
 		}
-#endif
+	} else {
+		return -ENXIO;
 	}
 
 	snd_soc_component_set_drvdata(component, wm9705->ac97);
@@ -350,14 +350,12 @@ static int wm9705_soc_probe(struct snd_soc_component *component)
 
 static void wm9705_soc_remove(struct snd_soc_component *component)
 {
-#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9705_priv *wm9705 = snd_soc_component_get_drvdata(component);
 
-	if (!wm9705->mfd_pdata) {
+	if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS) && !wm9705->mfd_pdata) {
 		snd_soc_component_exit_regmap(component);
 		snd_soc_free_ac97_component(wm9705->ac97);
 	}
-#endif
 }
 
 static const struct snd_soc_component_driver soc_component_dev_wm9705 = {
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index e873baa9e778..01949eaba4fd 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -642,8 +642,7 @@ static int wm9712_soc_probe(struct snd_soc_component *component)
 	if (wm9712->mfd_pdata) {
 		wm9712->ac97 = wm9712->mfd_pdata->ac97;
 		regmap = wm9712->mfd_pdata->regmap;
-	} else {
-#ifdef CONFIG_SND_SOC_AC97_BUS
+	} else if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {
 		int ret;
 
 		wm9712->ac97 = snd_soc_new_ac97_component(component, WM9712_VENDOR_ID,
@@ -660,7 +659,8 @@ static int wm9712_soc_probe(struct snd_soc_component *component)
 			snd_soc_free_ac97_component(wm9712->ac97);
 			return PTR_ERR(regmap);
 		}
-#endif
+	} else {
+		return -ENXIO;
 	}
 
 	snd_soc_component_init_regmap(component, regmap);
@@ -673,14 +673,12 @@ static int wm9712_soc_probe(struct snd_soc_component *component)
 
 static void wm9712_soc_remove(struct snd_soc_component *component)
 {
-#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9712_priv *wm9712 = snd_soc_component_get_drvdata(component);
 
-	if (!wm9712->mfd_pdata) {
+	if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS) && !wm9712->mfd_pdata) {
 		snd_soc_component_exit_regmap(component);
 		snd_soc_free_ac97_component(wm9712->ac97);
 	}
-#endif
 }
 
 static const struct snd_soc_component_driver soc_component_dev_wm9712 = {
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 643863bb32e0..b2bb465c8e5a 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1214,8 +1214,7 @@ static int wm9713_soc_probe(struct snd_soc_component *component)
 	if (wm9713->mfd_pdata) {
 		wm9713->ac97 = wm9713->mfd_pdata->ac97;
 		regmap = wm9713->mfd_pdata->regmap;
-	} else {
-#ifdef CONFIG_SND_SOC_AC97_BUS
+	} else if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {
 		wm9713->ac97 = snd_soc_new_ac97_component(component, WM9713_VENDOR_ID,
 						      WM9713_VENDOR_ID_MASK);
 		if (IS_ERR(wm9713->ac97))
@@ -1225,7 +1224,8 @@ static int wm9713_soc_probe(struct snd_soc_component *component)
 			snd_soc_free_ac97_component(wm9713->ac97);
 			return PTR_ERR(regmap);
 		}
-#endif
+	} else {
+		return -ENXIO;
 	}
 
 	snd_soc_component_init_regmap(component, regmap);
@@ -1238,14 +1238,12 @@ static int wm9713_soc_probe(struct snd_soc_component *component)
 
 static void wm9713_soc_remove(struct snd_soc_component *component)
 {
-#ifdef CONFIG_SND_SOC_AC97_BUS
 	struct wm9713_priv *wm9713 = snd_soc_component_get_drvdata(component);
 
-	if (!wm9713->mfd_pdata) {
+	if (IS_ENABLED(CONFIG_SND_SOC_AC97_BUS)) {
 		snd_soc_component_exit_regmap(component);
 		snd_soc_free_ac97_component(wm9713->ac97);
 	}
-#endif
 }
 
 static const struct snd_soc_component_driver soc_component_dev_wm9713 = {
-- 
2.18.0
