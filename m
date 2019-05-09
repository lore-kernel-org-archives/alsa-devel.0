From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH v2] ASoC: max98357a: request GPIO when device
	get probed
Date: Thu,  9 May 2019 11:04:54 +0800
Message-ID: <20190509030454.216079-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com
 [IPv6:2607:f8b0:4864:20::74a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43F29F8073C
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2019 05:05:05 +0200 (CEST)
Received: by mail-qk1-x74a.google.com with SMTP id t67so716121qkd.15
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2019 20:05:05 -0700 (PDT)
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

devm_gpiod_get_optional() returns EBUSY after component rebound.

Request GPIO in max98357a_platform_probe() to support component
rebinding.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
v1:
ASoC: max98357a: manage GPIO for component rebinding
=> don't move from devm to non-devm
(https://patchwork.kernel.org/patch/10922979/)

v2:
ASoC: max98357a: release GPIO when component removing
=> only put things that really need the card in component's probe()
=> don't use devm_gpiod_put() if possible
(https://patchwork.kernel.org/patch/10932279/)

v3:
ASoC: max98357a: request GPIO when device get probed
=> remove empty function max98357a_component_probe() and
   max98357a_platform_remove()
(https://patchwork.kernel.org/patch/10936239/)

 sound/soc/codecs/max98357a.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d037a3e4d323..80080a6415b3 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -59,21 +59,7 @@ static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 	{"Speaker", NULL, "HiFi Playback"},
 };
 
-static int max98357a_component_probe(struct snd_soc_component *component)
-{
-	struct gpio_desc *sdmode;
-
-	sdmode = devm_gpiod_get_optional(component->dev, "sdmode", GPIOD_OUT_LOW);
-	if (IS_ERR(sdmode))
-		return PTR_ERR(sdmode);
-
-	snd_soc_component_set_drvdata(component, sdmode);
-
-	return 0;
-}
-
 static const struct snd_soc_component_driver max98357a_component_driver = {
-	.probe			= max98357a_component_probe,
 	.dapm_widgets		= max98357a_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
 	.dapm_routes		= max98357a_dapm_routes,
@@ -112,16 +98,20 @@ static struct snd_soc_dai_driver max98357a_dai_driver = {
 
 static int max98357a_platform_probe(struct platform_device *pdev)
 {
+	struct gpio_desc *sdmode;
+
+	sdmode = devm_gpiod_get_optional(&pdev->dev,
+				"sdmode", GPIOD_OUT_LOW);
+	if (IS_ERR(sdmode))
+		return PTR_ERR(sdmode);
+
+	dev_set_drvdata(&pdev->dev, sdmode);
+
 	return devm_snd_soc_register_component(&pdev->dev,
 			&max98357a_component_driver,
 			&max98357a_dai_driver, 1);
 }
 
-static int max98357a_platform_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id max98357a_device_id[] = {
 	{ .compatible = "maxim,max98357a" },
@@ -145,7 +135,6 @@ static struct platform_driver max98357a_platform_driver = {
 		.acpi_match_table = ACPI_PTR(max98357a_acpi_match),
 	},
 	.probe	= max98357a_platform_probe,
-	.remove = max98357a_platform_remove,
 };
 module_platform_driver(max98357a_platform_driver);
 
-- 
2.21.0.1020.gf2820cf01a-goog
