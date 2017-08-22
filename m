From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v5 3/9] ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp
Date: Tue, 22 Aug 2017 15:57:22 +0800
Message-ID: <20170822075729.8438-4-jeffy.chen@rock-chips.com>
References: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170822075729.8438-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de
Cc: briannorris@chromium.org, mengdong.lin@linux.intel.com, mka@chromium.org, lars@metafoo.de, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Currently we are using codec name for rt5514 dsp dai link, use codec
of_node instead.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 sound/soc/rockchip/rk3399_gru_sound.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 70876d3c34e6..9b7e28703bfb 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -242,8 +242,6 @@ enum {
 	DAILINK_RT5514_DSP,
 };
 
-#define DAILINK_ENTITIES	(DAILINK_DA7219 + 1)
-
 static struct snd_soc_dai_link rockchip_dailinks[] = {
 	[DAILINK_MAX98357A] = {
 		.name = "MAX98357A",
@@ -277,8 +275,7 @@ static struct snd_soc_dai_link rockchip_dailinks[] = {
 	[DAILINK_RT5514_DSP] = {
 		.name = "RT5514 DSP",
 		.stream_name = "Wake on Voice",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_dai_name = "rt5514-dsp-cpu-dai",
 	},
 };
 
@@ -295,17 +292,10 @@ static struct snd_soc_card rockchip_sound_card = {
 	.num_controls = ARRAY_SIZE(rockchip_controls),
 };
 
-static int rockchip_sound_match_stub(struct device *dev, void *data)
-{
-	return 1;
-}
-
 static int rockchip_sound_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &rockchip_sound_card;
 	struct device_node *cpu_node;
-	struct device *dev;
-	struct device_driver *drv;
 	int i, ret;
 
 	cpu_node = of_parse_phandle(pdev->dev.of_node, "rockchip,cpu", 0);
@@ -314,7 +304,7 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	for (i = 0; i < DAILINK_ENTITIES; i++) {
+	for (i = 0; i < ARRAY_SIZE(rockchip_dailinks); i++) {
 		rockchip_dailinks[i].platform_of_node = cpu_node;
 		rockchip_dailinks[i].cpu_of_node = cpu_node;
 
@@ -327,26 +317,6 @@ static int rockchip_sound_probe(struct platform_device *pdev)
 		}
 	}
 
-	/**
-	 * To acquire the spi driver of the rt5514 and set the dai-links names
-	 * for soc_bind_dai_link
-	 */
-	drv = driver_find("rt5514", &spi_bus_type);
-	if (!drv) {
-		dev_err(&pdev->dev, "Can not find the rt5514 driver at the spi bus\n");
-		return -EINVAL;
-	}
-
-	dev = driver_find_device(drv, NULL, NULL, rockchip_sound_match_stub);
-	if (!dev) {
-		dev_err(&pdev->dev, "Can not find the rt5514 device\n");
-		return -ENODEV;
-	}
-
-	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
-
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-- 
2.11.0
