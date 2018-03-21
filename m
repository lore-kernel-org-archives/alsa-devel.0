From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH] ASoC: max98357a: Fix speaker pop when starting
	playback
Date: Wed, 21 Mar 2018 19:30:15 -0300
Message-ID: <20180321223015.32173-1-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B291E26737B
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 23:31:10 +0100 (CET)
Received: by mail-qk0-f193.google.com with SMTP id s78so7222158qkl.8
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 15:31:10 -0700 (PDT)
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
Cc: Ezequiel Garcia <ezequiel@collabora.co.uk>, alsa-devel@alsa-project.org, kernel@collabora.com, Mac Chiang <mac.chiang@intel.com>, Stephen Barber <smbarber@chromium.org>
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
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.co.uk>
---
 .../devicetree/bindings/sound/max98357a.txt        |  6 ++
 sound/soc/codecs/max98357a.c                       | 69 +++++++++++++++++++---
 2 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/max98357a.txt b/Documentation/devicetree/bindings/sound/max98357a.txt
index 28645a2ff885..de42c9f372ed 100644
--- a/Documentation/devicetree/bindings/sound/max98357a.txt
+++ b/Documentation/devicetree/bindings/sound/max98357a.txt
@@ -9,10 +9,16 @@ Optional properties:
 - sdmode-gpios : GPIO specifier for the chip's SD_MODE pin.
         If this option is not specified then driver does not manage
         the pin state (e.g. chip is always on).
+- sdmode-delay : specify a delay time for SD_MODE pin. According
+        to the DAC datasheet, if LRCLK is removed while BCLK is present,
+        the DAC output can cause loud pop/crack noises. This property
+        specifies a delay for the SD_MODE pin assert, required to
+        eliminate the noise.
 
 Example:
 
 max98357a {
 	compatible = "maxim,max98357a";
 	sdmode-gpios = <&qcom_pinmux 25 0>;
+	sdmode-delay = <5>;
 };
diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 426ed2dae6ca..9666fa3602a5 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -27,27 +27,57 @@
 #include <sound/soc-dai.h>
 #include <sound/soc-dapm.h>
 
+struct max98357a_priv {
+	struct delayed_work enable_sdmode_work;
+	struct gpio_desc *sdmode;
+	unsigned int sdmode_delay;
+	int sdmode_enabled;
+	spinlock_t sdmode_lock;
+};
+
+static void max98357a_enable_sdmode_work(struct work_struct *work)
+{
+	struct max98357a_priv *max98357a = container_of(work,
+		struct max98357a_priv, enable_sdmode_work.work);
+	unsigned long flags;
+
+	spin_lock_irqsave(&max98357a->sdmode_lock, flags);
+	gpiod_set_value(max98357a->sdmode, max98357a->sdmode_enabled);
+	spin_unlock_irqrestore(&max98357a->sdmode_lock, flags);
+}
+
 static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 		int cmd, struct snd_soc_dai *dai)
 {
-	struct gpio_desc *sdmode = snd_soc_dai_get_drvdata(dai);
+	struct snd_soc_codec *codec = dai->codec;
+	struct max98357a_priv *max98357a = snd_soc_codec_get_drvdata(codec);
+	unsigned long flags;
 
-	if (!sdmode)
+	if (!max98357a->sdmode)
 		return 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		gpiod_set_value(sdmode, 1);
+		max98357a->sdmode_enabled = 1;
+		if (max98357a->sdmode_delay) {
+			queue_delayed_work(system_power_efficient_wq,
+				&max98357a->enable_sdmode_work,
+				msecs_to_jiffies(max98357a->sdmode_delay));
+			return 0;
+		}
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		gpiod_set_value(sdmode, 0);
+		max98357a->sdmode_enabled = 0;
 		break;
 	}
 
+	spin_lock_irqsave(&max98357a->sdmode_lock, flags);
+	gpiod_set_value(max98357a->sdmode, max98357a->sdmode_enabled);
+	spin_unlock_irqrestore(&max98357a->sdmode_lock, flags);
 	return 0;
 }
 
@@ -61,19 +91,30 @@ static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
 
 static int max98357a_codec_probe(struct snd_soc_codec *codec)
 {
-	struct gpio_desc *sdmode;
+	struct max98357a_priv *max98357a = snd_soc_codec_get_drvdata(codec);
 
-	sdmode = devm_gpiod_get_optional(codec->dev, "sdmode", GPIOD_OUT_LOW);
-	if (IS_ERR(sdmode))
-		return PTR_ERR(sdmode);
+	max98357a->sdmode = devm_gpiod_get_optional(codec->dev,
+						    "sdmode", GPIOD_OUT_LOW);
+	if (IS_ERR(max98357a->sdmode))
+		return PTR_ERR(max98357a->sdmode);
 
-	snd_soc_codec_set_drvdata(codec, sdmode);
+	spin_lock_init(&max98357a->sdmode_lock);
+	INIT_DELAYED_WORK(&max98357a->enable_sdmode_work,
+			  max98357a_enable_sdmode_work);
+	return 0;
+}
+
+static int max98357a_codec_remove(struct snd_soc_codec *codec)
+{
+	struct max98357a_priv *max98357a = snd_soc_codec_get_drvdata(codec);
 
+	cancel_delayed_work_sync(&max98357a->enable_sdmode_work);
 	return 0;
 }
 
 static const struct snd_soc_codec_driver max98357a_codec_driver = {
 	.probe			= max98357a_codec_probe,
+	.remove			= max98357a_codec_remove,
 	.component_driver = {
 		.dapm_widgets		= max98357a_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
@@ -107,6 +148,16 @@ static struct snd_soc_dai_driver max98357a_dai_driver = {
 
 static int max98357a_platform_probe(struct platform_device *pdev)
 {
+	struct max98357a_priv *max98357a;
+
+	max98357a = devm_kzalloc(&pdev->dev, sizeof(*max98357a), GFP_KERNEL);
+	if (!max98357a)
+		return -ENOMEM;
+	dev_set_drvdata(&pdev->dev, max98357a);
+
+	device_property_read_u32(&pdev->dev, "sdmode-delay",
+				 &max98357a->sdmode_delay);
+
 	return snd_soc_register_codec(&pdev->dev, &max98357a_codec_driver,
 			&max98357a_dai_driver, 1);
 }
-- 
2.16.2
