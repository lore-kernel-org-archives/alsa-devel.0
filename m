From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v7 1/9] ASoC: mediatek: Add HDMI dai-links in
	the mt8173-rt5650-rt5676 machine driver
Date: Wed, 20 Apr 2016 10:59:56 +0200
Message-ID: <1461142804-26728-2-git-send-email-p.zabel@pengutronix.de>
References: <1461142804-26728-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 19513264F45
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 11:00:10 +0200 (CEST)
In-Reply-To: <1461142804-26728-1-git-send-email-p.zabel@pengutronix.de>
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

From: Koro Chen <koro.chen@mediatek.com>

This creates pcmC0D2p for the HDMI playback in the same card.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../bindings/sound/mt8173-rt5650-rt5676.txt        |  5 ++--
 sound/soc/mediatek/Kconfig                         |  1 +
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          | 27 ++++++++++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
index f205ce9..ac28cdb 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
@@ -1,15 +1,16 @@
-MT8173 with RT5650 RT5676 CODECS
+MT8173 with RT5650 RT5676 CODECS and HDMI via I2S
 
 Required properties:
 - compatible : "mediatek,mt8173-rt5650-rt5676"
 - mediatek,audio-codec: the phandles of rt5650 and rt5676 codecs
+			and of the hdmi encoder node
 - mediatek,platform: the phandle of MT8173 ASoC platform
 
 Example:
 
 	sound {
 		compatible = "mediatek,mt8173-rt5650-rt5676";
-		mediatek,audio-codec = <&rt5650 &rt5676>;
+		mediatek,audio-codec = <&rt5650 &rt5676 &hdmi0>;
 		mediatek,platform = <&afe>;
 	};
 
diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index f7e789e..3abf51c 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -43,6 +43,7 @@ config SND_SOC_MT8173_RT5650_RT5676
 	depends on SND_SOC_MEDIATEK && I2C
 	select SND_SOC_RT5645
 	select SND_SOC_RT5677
+	select SND_SOC_HDMI_CODEC
 	help
 	  This adds ASoC driver for Mediatek MT8173 boards
 	  with the RT5650 and RT5676 codecs.
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index 5c4c58c..bb59392 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
@@ -134,7 +134,9 @@ static struct snd_soc_dai_link_component mt8173_rt5650_rt5676_codecs[] = {
 enum {
 	DAI_LINK_PLAYBACK,
 	DAI_LINK_CAPTURE,
+	DAI_LINK_HDMI,
 	DAI_LINK_CODEC_I2S,
+	DAI_LINK_HDMI_I2S,
 	DAI_LINK_INTERCODEC
 };
 
@@ -161,6 +163,16 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
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
@@ -177,6 +189,13 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
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
 	/* rt5676 <-> rt5650 intercodec link: Sets rt5676 I2S2 as master */
 	[DAI_LINK_INTERCODEC] = {
 		.name = "rt5650_rt5676 intercodec",
@@ -251,6 +270,14 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 	mt8173_rt5650_rt5676_dais[DAI_LINK_INTERCODEC].codec_of_node =
 		mt8173_rt5650_rt5676_codecs[1].of_node;
 
+	mt8173_rt5650_rt5676_dais[DAI_LINK_HDMI_I2S].codec_of_node =
+		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 2);
+	if (!mt8173_rt5650_rt5676_dais[DAI_LINK_HDMI_I2S].codec_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'audio-codec' missing or invalid\n");
+		return -EINVAL;
+	}
+
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-- 
2.8.0.rc3
