From: mac.chiang@intel.com
Subject: [PATCH] ASoC: max98357a: avoid speaker pop when
	playback startup
Date: Wed, 19 Jun 2019 13:47:28 +0800
Message-ID: <1560923248-1016-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D310AF808AF
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2019 07:47:30 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: mac.chiang@intel.com, broonie@kernel.org, lgirdwood@gmail.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mac Chiang <mac.chiang@intel.com>

Loud speaker pop happens during playback even when in slience
playback. Specify Max98357a amp delay times to make sure
clocks are always earlier than sdmode on.

Signed-off-by: Mac Chiang <mac.chiang@intel.com>
---
 .../devicetree/bindings/sound/max98357a.txt        |  4 ++
 sound/soc/codecs/max98357a.c                       | 50 ++++++++++++++++++----
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/max98357a.txt b/Documentation/devicetree/bindings/sound/max98357a.txt
index 28645a2..4bce14c 100644
--- a/Documentation/devicetree/bindings/sound/max98357a.txt
+++ b/Documentation/devicetree/bindings/sound/max98357a.txt
@@ -9,6 +9,10 @@ Optional properties:
 - sdmode-gpios : GPIO specifier for the chip's SD_MODE pin.
         If this option is not specified then driver does not manage
         the pin state (e.g. chip is always on).
+- sdmode-delay : specify delay time for SD_MODE pin.
+        If this option is specified, which means it's required i2s clocks
+        ready before SD_MODE is unmuted in order to avoid the speaker pop noise.
+        It's observed that 5ms is sufficient.
 
 Example:
 
diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d037a3e..2141fb4 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -27,24 +27,43 @@
 #include <sound/soc-dai.h>
 #include <sound/soc-dapm.h>
 
+struct max98357a_priv {
+	struct delayed_work enable_sdmode_work;
+	struct gpio_desc *sdmode;
+	unsigned int sdmode_delay;
+};
+
+static void max98357a_enable_sdmode_work(struct work_struct *work)
+{
+	struct max98357a_priv *max98357a =
+	container_of(work, struct max98357a_priv,
+			enable_sdmode_work.work);
+
+	gpiod_set_value(max98357a->sdmode, 1);
+}
+
 static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 		int cmd, struct snd_soc_dai *dai)
 {
-	struct gpio_desc *sdmode = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_component *component = dai->component;
+	struct max98357a_priv *max98357a = snd_soc_component_get_drvdata(component);
 
-	if (!sdmode)
+	if (!max98357a->sdmode)
 		return 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		gpiod_set_value(sdmode, 1);
+		queue_delayed_work(system_power_efficient_wq,
+				&max98357a->enable_sdmode_work,
+				msecs_to_jiffies(max98357a->sdmode_delay));
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		gpiod_set_value(sdmode, 0);
+		cancel_delayed_work_sync(&max98357a->enable_sdmode_work);
+		gpiod_set_value(max98357a->sdmode, 0);
 		break;
 	}
 
@@ -61,19 +80,32 @@ static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 
 static int max98357a_component_probe(struct snd_soc_component *component)
 {
-	struct gpio_desc *sdmode;
+	struct max98357a_priv *max98357a = snd_soc_component_get_drvdata(component);
+
+	max98357a->sdmode = devm_gpiod_get_optional(component->dev,
+						"sdmode", GPIOD_OUT_LOW);
 
-	sdmode = devm_gpiod_get_optional(component->dev, "sdmode", GPIOD_OUT_LOW);
-	if (IS_ERR(sdmode))
-		return PTR_ERR(sdmode);
+	if (IS_ERR(max98357a->sdmode))
+		return PTR_ERR(max98357a->sdmode);
 
-	snd_soc_component_set_drvdata(component, sdmode);
+	snd_soc_component_set_drvdata(component, max98357a);
+
+	INIT_DELAYED_WORK(&max98357a->enable_sdmode_work,
+				max98357a_enable_sdmode_work);
 
 	return 0;
 }
 
+static void max98357a_component_remove(struct snd_soc_component *component)
+{
+	struct max98357a_priv *max98357a = snd_soc_component_get_drvdata(component);
+
+	cancel_delayed_work_sync(&max98357a->enable_sdmode_work);
+}
+
 static const struct snd_soc_component_driver max98357a_component_driver = {
 	.probe			= max98357a_component_probe,
+	.remove			= max98357a_component_remove,
 	.dapm_widgets		= max98357a_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
 	.dapm_routes		= max98357a_dapm_routes,
-- 
2.7.4
