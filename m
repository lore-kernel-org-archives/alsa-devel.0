From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Use platform_of_node for
	machine drivers" to the asoc tree
Date: Thu, 09 Jul 2015 12:20:29 +0100
Message-ID: <E1ZD9sT-0005qy-ML@debutante>
References: <1436410287-61097-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E657266142
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 13:20:42 +0200 (CEST)
In-Reply-To: <1436410287-61097-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Use platform_of_node for machine drivers

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

>From 94319ba10ecabc8f28129566d1f5793e3e7a0a79 Mon Sep 17 00:00:00 2001
From: Koro Chen <koro.chen@mediatek.com>
Date: Thu, 9 Jul 2015 10:51:27 +0800
Subject: [PATCH] ASoC: mediatek: Use platform_of_node for machine drivers

This replaces the platform_name in snd_soc_dai_link by device tree node.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/mt8173-max98090.txt     |  2 ++
 .../bindings/sound/mt8173-rt5650-rt5676.txt           |  2 ++
 sound/soc/mediatek/mt8173-max98090.c                  | 17 +++++++++++++----
 sound/soc/mediatek/mt8173-rt5650-rt5676.c             | 19 +++++++++++++++----
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8173-max98090.txt b/Documentation/devicetree/bindings/sound/mt8173-max98090.txt
index 829bd26d17f8..519e97c8f1b8 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-max98090.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-max98090.txt
@@ -3,11 +3,13 @@ MT8173 with MAX98090 CODEC
 Required properties:
 - compatible : "mediatek,mt8173-max98090"
 - mediatek,audio-codec: the phandle of the MAX98090 audio codec
+- mediatek,platform: the phandle of MT8173 ASoC platform
 
 Example:
 
 	sound {
 		compatible = "mediatek,mt8173-max98090";
 		mediatek,audio-codec = <&max98090>;
+		mediatek,platform = <&afe>;
 	};
 
diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
index 61e98c976bd4..f205ce9e31dd 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650-rt5676.txt
@@ -3,11 +3,13 @@ MT8173 with RT5650 RT5676 CODECS
 Required properties:
 - compatible : "mediatek,mt8173-rt5650-rt5676"
 - mediatek,audio-codec: the phandles of rt5650 and rt5676 codecs
+- mediatek,platform: the phandle of MT8173 ASoC platform
 
 Example:
 
 	sound {
 		compatible = "mediatek,mt8173-rt5650-rt5676";
 		mediatek,audio-codec = <&rt5650 &rt5676>;
+		mediatek,platform = <&afe>;
 	};
 
diff --git a/sound/soc/mediatek/mt8173-max98090.c b/sound/soc/mediatek/mt8173-max98090.c
index 4d44b5803e55..2d2536af141f 100644
--- a/sound/soc/mediatek/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173-max98090.c
@@ -103,7 +103,6 @@ static struct snd_soc_dai_link mt8173_max98090_dais[] = {
 		.name = "MAX98090 Playback",
 		.stream_name = "MAX98090 Playback",
 		.cpu_dai_name = "DL1",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
@@ -114,7 +113,6 @@ static struct snd_soc_dai_link mt8173_max98090_dais[] = {
 		.name = "MAX98090 Capture",
 		.stream_name = "MAX98090 Capture",
 		.cpu_dai_name = "VUL",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
@@ -125,7 +123,6 @@ static struct snd_soc_dai_link mt8173_max98090_dais[] = {
 	{
 		.name = "Codec",
 		.cpu_dai_name = "I2S",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.no_pcm = 1,
 		.codec_dai_name = "HiFi",
 		.init = mt8173_max98090_init,
@@ -152,9 +149,21 @@ static struct snd_soc_card mt8173_max98090_card = {
 static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8173_max98090_card;
-	struct device_node *codec_node;
+	struct device_node *codec_node, *platform_node;
 	int ret, i;
 
+	platform_node = of_parse_phandle(pdev->dev.of_node,
+					 "mediatek,platform", 0);
+	if (!platform_node) {
+		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < card->num_links; i++) {
+		if (mt8173_max98090_dais[i].platform_name)
+			continue;
+		mt8173_max98090_dais[i].platform_of_node = platform_node;
+	}
+
 	codec_node = of_parse_phandle(pdev->dev.of_node,
 				      "mediatek,audio-codec", 0);
 	if (!codec_node) {
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index 094055323059..6f52eca05e26 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
@@ -138,7 +138,6 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
 		.name = "rt5650_rt5676 Playback",
 		.stream_name = "rt5650_rt5676 Playback",
 		.cpu_dai_name = "DL1",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
@@ -149,7 +148,6 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
 		.name = "rt5650_rt5676 Capture",
 		.stream_name = "rt5650_rt5676 Capture",
 		.cpu_dai_name = "VUL",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
@@ -161,7 +159,6 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5676_dais[] = {
 	{
 		.name = "Codec",
 		.cpu_dai_name = "I2S",
-		.platform_name = "11220000.mt8173-afe-pcm",
 		.no_pcm = 1,
 		.codecs = mt8173_rt5650_rt5676_codecs,
 		.num_codecs = 2,
@@ -209,7 +206,21 @@ static struct snd_soc_card mt8173_rt5650_rt5676_card = {
 static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mt8173_rt5650_rt5676_card;
-	int ret;
+	struct device_node *platform_node;
+	int i, ret;
+
+	platform_node = of_parse_phandle(pdev->dev.of_node,
+					 "mediatek,platform", 0);
+	if (!platform_node) {
+		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < card->num_links; i++) {
+		if (mt8173_rt5650_rt5676_dais[i].platform_name)
+			continue;
+		mt8173_rt5650_rt5676_dais[i].platform_of_node = platform_node;
+	}
 
 	mt8173_rt5650_rt5676_codecs[0].of_node =
 		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 0);
-- 
2.1.4
