From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: Add support for PA gpio
	pin" to the asoc tree
Date: Sat, 12 Dec 2015 23:07:20 +0000
Message-ID: <E1a7tG4-0002ay-Q9@finisterre>
References: <1449859439-30875-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 03E7F2606F8
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:07:30 +0100 (CET)
In-Reply-To: <1449859439-30875-2-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-codec: Add support for PA gpio pin

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 405926276bfb316915c16e57a3943eb2cf4dd8fa Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 11 Dec 2015 19:43:57 +0100
Subject: [PATCH] ASoC: sun4i-codec: Add support for PA gpio pin

Add support for PA gpio pin for controlling an external amplifier as used
on some Allwinner boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      |  3 ++
 sound/soc/sunxi/sun4i-codec.c                      | 35 ++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
index c92966b..0dce690 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -14,6 +14,9 @@ Required properties:
    - "apb": the parent APB clock for this controller
    - "codec": the parent module clock
 
+Optional properties:
+- allwinner,pa-gpios: gpio to enable external amplifier
+
 Example:
 codec: codec@01c22c00 {
 	#sound-dai-cells = <0>;
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 519ccb3..e6cc6a1 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -28,6 +28,7 @@
 #include <linux/of_address.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -103,6 +104,7 @@ struct sun4i_codec {
 	struct regmap	*regmap;
 	struct clk	*clk_apb;
 	struct clk	*clk_module;
+	struct gpio_desc *gpio_pa;
 
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
@@ -709,6 +711,26 @@ static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 	return link;
 };
 
+static int sun4i_codec_spk_event(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *k, int event)
+{
+	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(w->dapm->card);
+
+	if (scodec->gpio_pa)
+		gpiod_set_value_cansleep(scodec->gpio_pa,
+					 !!SND_SOC_DAPM_EVENT_ON(event));
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget sun4i_codec_card_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Speaker", sun4i_codec_spk_event),
+};
+
+static const struct snd_soc_dapm_route sun4i_codec_card_dapm_routes[] = {
+	{ "Speaker", NULL, "Power Amplifier" },
+};
+
 static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 {
 	struct snd_soc_card *card;
@@ -723,6 +745,10 @@ static struct snd_soc_card *sun4i_codec_create_card(struct device *dev)
 
 	card->dev		= dev;
 	card->name		= "sun4i-codec";
+	card->dapm_widgets	= sun4i_codec_card_dapm_widgets;
+	card->num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_card_dapm_widgets);
+	card->dapm_routes	= sun4i_codec_card_dapm_routes;
+	card->num_dapm_routes	= ARRAY_SIZE(sun4i_codec_card_dapm_routes);
 
 	return card;
 };
@@ -774,6 +800,15 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	scodec->gpio_pa = devm_gpiod_get_optional(&pdev->dev, "allwinner,pa",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(scodec->gpio_pa)) {
+		ret = PTR_ERR(scodec->gpio_pa);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to get pa gpio: %d\n", ret);
+		return ret;
+	}
+
 	/* DMA configuration for TX FIFO */
 	scodec->playback_dma_data.addr = res->start + SUN4I_CODEC_DAC_TXDATA;
 	scodec->playback_dma_data.maxburst = 4;
-- 
2.6.4
