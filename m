From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt8173-rt5650-rt5514: use
	modern dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:13 +0100 (BST)
Message-ID: <20190606212713.24582440046@finisterre.sirena.org.uk>
References: <8736knmksk.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0B6EF89809
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:13 +0200 (CEST)
In-Reply-To: <8736knmksk.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: mediatek: mt8173-rt5650-rt5514: use modern dai_link style

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

>From 1fcd25641d440495b26518c97fd6e3665a7df135 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:08:38 +0900
Subject: [PATCH] ASoC: mediatek: mt8173-rt5650-rt5514: use modern dai_link
 style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../mediatek/mt8173/mt8173-rt5650-rt5514.c    | 51 ++++++++++---------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index da5b58ce791b..8717e87bfe26 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -98,51 +98,51 @@ static int mt8173_rt5650_rt5514_init(struct snd_soc_pcm_runtime *runtime)
 				      &mt8173_rt5650_rt5514_jack);
 }
 
-static struct snd_soc_dai_link_component mt8173_rt5650_rt5514_codecs[] = {
-	{
-		.dai_name = "rt5645-aif1",
-	},
-	{
-		.dai_name = "rt5514-aif1",
-	},
-};
-
 enum {
 	DAI_LINK_PLAYBACK,
 	DAI_LINK_CAPTURE,
 	DAI_LINK_CODEC_I2S,
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
+SND_SOC_DAILINK_DEFS(codec,
+	DAILINK_COMP_ARRAY(COMP_CPU("I2S")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5645-aif1"),
+			   COMP_CODEC(NULL, "rt5514-aif1")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 /* Digital audio interface glue - connects codec <---> CPU */
 static struct snd_soc_dai_link mt8173_rt5650_rt5514_dais[] = {
 	/* Front End DAI links */
 	[DAI_LINK_PLAYBACK] = {
 		.name = "rt5650_rt5514 Playback",
 		.stream_name = "rt5650_rt5514 Playback",
-		.cpu_dai_name = "DL1",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback),
 	},
 	[DAI_LINK_CAPTURE] = {
 		.name = "rt5650_rt5514 Capture",
 		.stream_name = "rt5650_rt5514 Capture",
-		.cpu_dai_name = "VUL",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dynamic = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture),
 	},
 	/* Back End DAI links */
 	[DAI_LINK_CODEC_I2S] = {
 		.name = "Codec",
-		.cpu_dai_name = "I2S",
 		.no_pcm = 1,
-		.codecs = mt8173_rt5650_rt5514_codecs,
-		.num_codecs = 2,
 		.init = mt8173_rt5650_rt5514_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
@@ -150,6 +150,7 @@ static struct snd_soc_dai_link mt8173_rt5650_rt5514_dais[] = {
 		.ignore_pmdown_time = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(codec),
 	},
 };
 
@@ -189,27 +190,27 @@ static int mt8173_rt5650_rt5514_dev_probe(struct platform_device *pdev)
 	}
 
 	for_each_card_prelinks(card, i, dai_link) {
-		if (dai_link->platform_name)
+		if (dai_link->platforms->name)
 			continue;
-		dai_link->platform_of_node = platform_node;
+		dai_link->platforms->of_node = platform_node;
 	}
 
-	mt8173_rt5650_rt5514_codecs[0].of_node =
+	mt8173_rt5650_rt5514_dais[DAI_LINK_CODEC_I2S].codecs[0].of_node =
 		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 0);
-	if (!mt8173_rt5650_rt5514_codecs[0].of_node) {
+	if (!mt8173_rt5650_rt5514_dais[DAI_LINK_CODEC_I2S].codecs[0].of_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
-	mt8173_rt5650_rt5514_codecs[1].of_node =
+	mt8173_rt5650_rt5514_dais[DAI_LINK_CODEC_I2S].codecs[1].of_node =
 		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 1);
-	if (!mt8173_rt5650_rt5514_codecs[1].of_node) {
+	if (!mt8173_rt5650_rt5514_dais[DAI_LINK_CODEC_I2S].codecs[1].of_node) {
 		dev_err(&pdev->dev,
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
 	mt8173_rt5650_rt5514_codec_conf[0].of_node =
-		mt8173_rt5650_rt5514_codecs[1].of_node;
+		mt8173_rt5650_rt5514_dais[DAI_LINK_CODEC_I2S].codecs[1].of_node;
 
 	card->dev = &pdev->dev;
 
-- 
2.20.1
