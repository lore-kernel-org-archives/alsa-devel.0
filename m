From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v3 1/9] ASoC: rt5514: Switch to snd_soc_register_codec
Date: Thu, 17 Aug 2017 12:44:09 +0800
Message-ID: <20170817044417.22069-2-jeffy.chen@rock-chips.com>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Currently we are using devm_snd_soc_register_component, which would
use legacy dai name.

Switch to snd_soc_register_codec to use dai driver name.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 sound/soc/codecs/rt5514-spi.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 640193d845be..ad6bc51dd82a 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -277,8 +277,10 @@ static struct snd_soc_platform_driver rt5514_spi_platform = {
 	.ops = &rt5514_spi_pcm_ops,
 };
 
-static const struct snd_soc_component_driver rt5514_spi_dai_component = {
-	.name		= "rt5514-spi-dai",
+static const struct snd_soc_codec_driver rt5514_spi_dai_codec = {
+	.component_driver = {
+		.name = "rt5514-spi-dai",
+	},
 };
 
 /**
@@ -426,9 +428,8 @@ static int rt5514_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = devm_snd_soc_register_component(&spi->dev,
-					      &rt5514_spi_dai_component,
-					      &rt5514_spi_dai, 1);
+	ret = snd_soc_register_codec(&spi->dev, &rt5514_spi_dai_codec,
+				     &rt5514_spi_dai, 1);
 	if (ret < 0) {
 		dev_err(&spi->dev, "Failed to register component.\n");
 		return ret;
@@ -437,6 +438,13 @@ static int rt5514_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
+static int rt5514_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+
+	return 0;
+}
+
 static const struct of_device_id rt5514_of_match[] = {
 	{ .compatible = "realtek,rt5514", },
 	{},
@@ -449,6 +457,7 @@ static struct spi_driver rt5514_spi_driver = {
 		.of_match_table = of_match_ptr(rt5514_of_match),
 	},
 	.probe = rt5514_spi_probe,
+	.remove = rt5514_spi_remove,
 };
 module_spi_driver(rt5514_spi_driver);
 
-- 
2.11.0
