From: Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2] ASoC: max98357a: add a delay parameter to
	avoid speaker pop/crack noise
Date: Mon, 26 Mar 2018 19:10:00 -0300
Message-ID: <20180326221000.23424-1-ezequiel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DCA9266FA1
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 00:11:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>, Mac Chiang <mac.chiang@intel.com>, Stephen Barber <smbarber@chromium.org>
List-Id: alsa-devel@alsa-project.org

From: Mac Chiang <mac.chiang@intel.com>

Currently, speaker pop/crack noise can happen during PCM playback.
This is due to the LRCLK being removed while the BCLK being
present, which as per the datasheet can cause large DC output voltage.

While on some platforms simply controlling the SD_MODE pin is enough
to remove the noise, others have a significant delay between
the BCLK and the LRCLK activation.

Therefore, this commit adds a delay in the codec driver to guarantee
clocks are both active by the time SD_MODE is asserted.

Link: https://github.com/raspberrypi/linux/issues/2212
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: Stephen Barber <smbarber@chromium.org>
[Ezequiel: make the delay a module parameter]
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
Changes on v2:
 * Got rid of spinlock around gpio set.
 * Make the delay a module parameter, and not a device tree property.

 sound/soc/codecs/max98357a.c | 65 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d469576b5a7b..7d9a0ee71487 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -27,27 +27,58 @@
 #include <sound/soc-dai.h>
 #include <sound/soc-dapm.h>
 
+/* According to the DAC datasheet, if LRCLK is removed while BCLK is present,
+ * the DAC output can cause loud pop/crack noises. This parameter specifies
+ * a delay for the SD_MODE pin assert, required to eliminate the noise.
+ */
+static unsigned int sdmode_delay;
+module_param(sdmode_delay, uint, 0444);
+MODULE_PARM_DESC(sdmode_delay, "SD_MODE pin delay.");
+
+struct max98357a_priv {
+	struct delayed_work enable_sdmode_work;
+	struct gpio_desc *sdmode;
+	int sdmode_enabled;
+};
+
+static void max98357a_enable_sdmode_work(struct work_struct *work)
+{
+	struct max98357a_priv *priv = container_of(work,
+		struct max98357a_priv, enable_sdmode_work.work);
+
+	gpiod_set_value(priv->sdmode, priv->sdmode_enabled);
+}
+
 static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 		int cmd, struct snd_soc_dai *dai)
 {
-	struct gpio_desc *sdmode = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_component *component = dai->component;
+	struct max98357a_priv *priv = snd_soc_component_get_drvdata(component);
 
-	if (!sdmode)
+	if (!priv->sdmode)
 		return 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		gpiod_set_value(sdmode, 1);
+		priv->sdmode_enabled = 1;
+		if (sdmode_delay) {
+			queue_delayed_work(system_power_efficient_wq,
+				&priv->enable_sdmode_work,
+				msecs_to_jiffies(sdmode_delay));
+			return 0;
+		}
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		gpiod_set_value(sdmode, 0);
+		priv->sdmode_enabled = 0;
+		cancel_delayed_work(&priv->enable_sdmode_work);
 		break;
 	}
 
+	gpiod_set_value(priv->sdmode, priv->sdmode_enabled);
 	return 0;
 }
 
@@ -61,19 +92,35 @@ static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 
 static int max98357a_component_probe(struct snd_soc_component *component)
 {
-	struct gpio_desc *sdmode;
+	struct max98357a_priv *priv;
 
-	sdmode = devm_gpiod_get_optional(component->dev, "sdmode", GPIOD_OUT_LOW);
-	if (IS_ERR(sdmode))
-		return PTR_ERR(sdmode);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
-	snd_soc_component_set_drvdata(component, sdmode);
+	priv->sdmode = gpiod_get_optional(component->dev,
+					  "sdmode", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->sdmode))
+		return PTR_ERR(priv->sdmode);
 
+	INIT_DELAYED_WORK(&priv->enable_sdmode_work,
+			  max98357a_enable_sdmode_work);
+	snd_soc_component_set_drvdata(component, priv);
 	return 0;
 }
 
+static void max98357a_component_remove(struct snd_soc_component *component)
+{
+	struct max98357a_priv *priv = snd_soc_component_get_drvdata(component);
+
+	cancel_delayed_work_sync(&priv->enable_sdmode_work);
+	gpiod_put(priv->sdmode);
+	kfree(priv);
+}
+
 static const struct snd_soc_component_driver max98357a_component_driver = {
 	.probe			= max98357a_component_probe,
+	.remove			= max98357a_component_remove,
 	.dapm_widgets		= max98357a_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
 	.dapm_routes		= max98357a_dapm_routes,
-- 
2.16.2
