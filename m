From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v8] ASoC: mediatek: Add HDMI dai-links to the
	mt8173-rt5650 machine driver
Date: Tue,  5 Jul 2016 11:26:21 +0200
Message-ID: <1467710781-23590-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C2A5E265325
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 11:26:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: PC Liao <pc.liao@mediatek.com>

This patch adds HDMI audio output support to the MT8173 RT5650 machine
driver.

Signed-off-by: PC Liao <pc.liao@mediatek.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v7:
 - Rebased onto asoc/for-next
---
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |  5 +++--
 sound/soc/mediatek/Kconfig                         |  1 +
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          | 26 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
index f250fc7..29dce2a 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
@@ -1,8 +1,9 @@
-MT8173 with RT5650 CODECS
+MT8173 with RT5650 CODECS and HDMI via I2S
 
 Required properties:
 - compatible : "mediatek,mt8173-rt5650"
 - mediatek,audio-codec: the phandles of rt5650 codecs
+                        and of the hdmi encoder node
 - mediatek,platform: the phandle of MT8173 ASoC platform
 
 Optional subnodes:
@@ -20,7 +21,7 @@ Example:
 
 	sound {
 		compatible = "mediatek,mt8173-rt5650";
-		mediatek,audio-codec = <&rt5650>;
+		mediatek,audio-codec = <&rt5650 &hdmi0>;
 		mediatek,platform = <&afe>;
 		mediatek,mclk = <0>;
 		codec-capture {
diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 2fbe543..05cf809 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -46,6 +46,7 @@ config SND_SOC_MT8173_RT5650
 	tristate "ASoC Audio driver for MT8173 with RT5650 codec"
 	depends on SND_SOC_MT8173 && I2C
 	select SND_SOC_RT5645
+	select SND_SOC_HDMI_CODEC
 	help
 	  This adds ASoC driver for Mediatek MT8173 boards
 	  with the RT5650 audio codec.
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index d478976..ba65f41 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -169,7 +169,9 @@ static struct snd_soc_dai_link_component mt8173_rt5650_codecs[] = {
 enum {
 	DAI_LINK_PLAYBACK,
 	DAI_LINK_CAPTURE,
+	DAI_LINK_HDMI,
 	DAI_LINK_CODEC_I2S,
+	DAI_LINK_HDMI_I2S,
 };
 
 /* Digital audio interface glue - connects codec <---> CPU */
@@ -195,6 +197,16 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.dynamic = 1,
 		.dpcm_capture = 1,
 	},
+	[DAI_LINK_HDMI] = {
+		.name = "HDMI",
+		.stream_name = "HDMI PCM",
+		.cpu_dai_name = "HDMI",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	},
 	/* Back End DAI links */
 	[DAI_LINK_CODEC_I2S] = {
 		.name = "Codec",
@@ -210,6 +222,13 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 	},
+	[DAI_LINK_HDMI_I2S] = {
+		.name = "HDMI BE",
+		.cpu_dai_name = "HDMIO",
+		.no_pcm = 1,
+		.codec_dai_name = "i2s-hifi",
+		.dpcm_playback = 1,
+	},
 };
 
 static struct snd_soc_card mt8173_rt5650_card = {
@@ -284,6 +303,13 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 		}
 	}
 
+	mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codec_of_node =
+		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 1);
+	if (!mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codec_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'audio-codec' missing or invalid\n");
+		return -EINVAL;
+	}
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-- 
2.8.1
