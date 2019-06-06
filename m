From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt8173-rt5650: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:14 +0100 (BST)
Message-ID: <20190606212714.496F3440049@finisterre.sirena.org.uk>
References: <875zpjmkt6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18028F8980A
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:15 +0200 (CEST)
In-Reply-To: <875zpjmkt6.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt8173-rt5650: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 166b3f052d3e6b7afd3759797cbd4e4d5fdaef17 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:08:16 +0900
Subject: [PATCH] ASoC: mediatek: mt8173-rt5650: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650.c | 74 +++++++++++++----------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index 7edf250c8fb1..ef6f23675286 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -144,17 +144,6 @@ static int mt8173_rt5650_init(struct snd_soc_pcm_runtime *runtime)
 				      &mt8173_rt5650_jack);
 }
 
-static struct snd_soc_dai_link_component mt8173_rt5650_codecs[] = {
-	{
-		/* Playback */
-		.dai_name = "rt5645-aif1",
-	},
-	{
-		/* Capture */
-		.dai_name = "rt5645-aif1",
-	},
-};
-
 enum {
 	DAI_LINK_PLAYBACK,
 	DAI_LINK_CAPTURE,
@@ -163,46 +152,63 @@ enum {
 	DAI_LINK_HDMI_I2S,
 };
 
+SND_SOC_DAILINK_DEFS(playback,
+	DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture,
+	DAILINK_COMP_ARRAY(COMP_CPU("VUL")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(hdmi_pcm,
+	DAILINK_COMP_ARRAY(COMP_CPU("HDMI")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(codec,
+	DAILINK_COMP_ARRAY(COMP_CPU("I2S")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5645-aif1"), /* Playback */
+			   COMP_CODEC(NULL, "rt5645-aif1")),/* Capture */
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(hdmi_be,
+	DAILINK_COMP_ARRAY(COMP_CPU("HDMIO")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "i2s-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 /* Digital audio interface glue - connects codec <---> CPU */
 static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 	/* Front End DAI links */
 	[DAI_LINK_PLAYBACK] = {
 		.name = "rt5650 Playback",
 		.stream_name = "rt5650 Playback",
-		.cpu_dai_name = "DL1",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback),
 	},
 	[DAI_LINK_CAPTURE] = {
 		.name = "rt5650 Capture",
 		.stream_name = "rt5650 Capture",
-		.cpu_dai_name = "VUL",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dynamic = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture),
 	},
 	[DAI_LINK_HDMI] = {
 		.name = "HDMI",
 		.stream_name = "HDMI PCM",
-		.cpu_dai_name = "HDMI",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(hdmi_pcm),
 	},
 	/* Back End DAI links */
 	[DAI_LINK_CODEC_I2S] = {
 		.name = "Codec",
-		.cpu_dai_name = "I2S",
 		.no_pcm = 1,
-		.codecs = mt8173_rt5650_codecs,
-		.num_codecs = 2,
 		.init = mt8173_rt5650_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
@@ -210,13 +216,13 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.ignore_pmdown_time = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(codec),
 	},
 	[DAI_LINK_HDMI_I2S] = {
 		.name = "HDMI BE",
-		.cpu_dai_name = "HDMIO",
 		.no_pcm = 1,
-		.codec_dai_name = "i2s-hifi",
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(hdmi_be),
 	},
 };
 
@@ -250,19 +256,20 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 	}
 
 	for_each_card_prelinks(card, i, dai_link) {
-		if (dai_link->platform_name)
+		if (dai_link->platforms->name)
 			continue;
-		dai_link->platform_of_node = platform_node;
+		dai_link->platforms->of_node = platform_node;
 	}
 
-	mt8173_rt5650_codecs[0].of_node =
+	mt8173_rt5650_dais[DAI_LINK_CODEC_I2S].codecs[0].of_node =
 		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 0);
-	if (!mt8173_rt5650_codecs[0].of_node) {
+	if (!mt8173_rt5650_dais[DAI_LINK_CODEC_I2S].codecs[0].of_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
-	mt8173_rt5650_codecs[1].of_node = mt8173_rt5650_codecs[0].of_node;
+	mt8173_rt5650_dais[DAI_LINK_CODEC_I2S].codecs[1].of_node =
+		mt8173_rt5650_dais[DAI_LINK_CODEC_I2S].codecs[0].of_node;
 
 	np = of_get_child_by_name(pdev->dev.of_node, "codec-capture");
 	if (np) {
@@ -274,7 +281,8 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 				__func__, ret);
 			return ret;
 		}
-		mt8173_rt5650_codecs[1].dai_name = codec_capture_dai;
+		mt8173_rt5650_dais[DAI_LINK_CODEC_I2S].codecs[1].dai_name =
+			codec_capture_dai;
 	}
 
 	if (device_property_present(&pdev->dev, "mediatek,mclk")) {
@@ -288,9 +296,9 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 		}
 	}
 
-	mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codec_of_node =
+	mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codecs->of_node =
 		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 1);
-	if (!mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codec_of_node) {
+	if (!mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codecs->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
-- 
2.20.1
