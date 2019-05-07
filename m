From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: max98357a: release GPIO when component
	removing
Date: Tue,  7 May 2019 13:11:40 +0800
Message-ID: <20190507051140.240245-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc49.google.com (mail-yw1-xc49.google.com
 [IPv6:2607:f8b0:4864:20::c49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79C9AF89671
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 07:12:24 +0200 (CEST)
Received: by mail-yw1-xc49.google.com with SMTP id v123so29617166ywf.16
 for <alsa-devel@alsa-project.org>; Mon, 06 May 2019 22:12:24 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, tiwai@suse.com
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Component's probe() gets GPIO for "sdmode-gpios" via
devm_gpiod_get_optional().  The GPIO binds to the device.

When the component get removed but the device does not, the GPIO
still binds to the device.  Then, when the component be probed
again, devm_gpiod_get_optional() returns EBUSY.

Release the GPIO proactively when component is removing.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/max98357a.c | 42 ++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d037a3e4d323..b11c6cb81f55 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -27,24 +27,28 @@
 #include <sound/soc-dai.h>
 #include <sound/soc-dapm.h>
 
+struct max98357a_priv {
+	struct gpio_desc *sdmode;
+};
+
 static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 		int cmd, struct snd_soc_dai *dai)
 {
-	struct gpio_desc *sdmode = snd_soc_dai_get_drvdata(dai);
+	struct max98357a_priv *max98357a = snd_soc_dai_get_drvdata(dai);
 
-	if (!sdmode)
+	if (!max98357a->sdmode)
 		return 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		gpiod_set_value(sdmode, 1);
+		gpiod_set_value(max98357a->sdmode, 1);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		gpiod_set_value(sdmode, 0);
+		gpiod_set_value(max98357a->sdmode, 0);
 		break;
 	}
 
@@ -61,19 +65,31 @@ static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 
 static int max98357a_component_probe(struct snd_soc_component *component)
 {
-	struct gpio_desc *sdmode;
+	struct max98357a_priv *max98357a =
+			snd_soc_component_get_drvdata(component);
 
-	sdmode = devm_gpiod_get_optional(component->dev, "sdmode", GPIOD_OUT_LOW);
-	if (IS_ERR(sdmode))
-		return PTR_ERR(sdmode);
+	max98357a->sdmode = devm_gpiod_get_optional(component->dev,
+					"sdmode", GPIOD_OUT_LOW);
+	if (IS_ERR(max98357a->sdmode))
+		return PTR_ERR(max98357a->sdmode);
 
-	snd_soc_component_set_drvdata(component, sdmode);
+	snd_soc_component_set_drvdata(component, max98357a);
 
 	return 0;
 }
 
+static void max98357a_component_remove(struct snd_soc_component *component)
+{
+	struct max98357a_priv *max98357a =
+			snd_soc_component_get_drvdata(component);
+
+	if (max98357a->sdmode)
+		devm_gpiod_put(component->dev, max98357a->sdmode);
+}
+
 static const struct snd_soc_component_driver max98357a_component_driver = {
 	.probe			= max98357a_component_probe,
+	.remove			= max98357a_component_remove,
 	.dapm_widgets		= max98357a_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
 	.dapm_routes		= max98357a_dapm_routes,
@@ -112,6 +128,14 @@ static struct snd_soc_dai_driver max98357a_dai_driver = {
 
 static int max98357a_platform_probe(struct platform_device *pdev)
 {
+	struct max98357a_priv *max98357a;
+
+	max98357a = devm_kzalloc(&pdev->dev, sizeof(*max98357a), GFP_KERNEL);
+	if (!max98357a)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, max98357a);
+
 	return devm_snd_soc_register_component(&pdev->dev,
 			&max98357a_component_driver,
 			&max98357a_dai_driver, 1);
-- 
2.21.0.1020.gf2820cf01a-goog
