From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt2701-wm8960: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:16 +0100 (BST)
Message-ID: <20190606212716.126BC440046@finisterre.sirena.org.uk>
References: <87a7evmktq.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8366F89769
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:16 +0200 (CEST)
In-Reply-To: <87a7evmktq.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: mediatek: mt2701-wm8960: use modern dai_link style

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

>From b664e06d530eba6c5f2f1a9571c2bc78e9fb783f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:07:57 +0900
Subject: [PATCH] ASoC: mediatek: mt2701-wm8960: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-wm8960.c | 34 +++++++++++++++--------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-wm8960.c b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
index 6bc1d3d58e64..8c4c89e4c616 100644
--- a/sound/soc/mediatek/mt2701/mt2701-wm8960.c
+++ b/sound/soc/mediatek/mt2701/mt2701-wm8960.c
@@ -44,41 +44,51 @@ static struct snd_soc_ops mt2701_wm8960_be_ops = {
 	.hw_params = mt2701_wm8960_be_ops_hw_params
 };
 
+SND_SOC_DAILINK_DEFS(playback,
+	DAILINK_COMP_ARRAY(COMP_CPU("PCMO0")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture,
+	DAILINK_COMP_ARRAY(COMP_CPU("PCM0")),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(codec,
+	DAILINK_COMP_ARRAY(COMP_CPU("I2S0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "wm8960-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link mt2701_wm8960_dai_links[] = {
 	/* FE */
 	{
 		.name = "wm8960-playback",
 		.stream_name = "wm8960-playback",
-		.cpu_dai_name = "PCMO0",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST,
 			    SND_SOC_DPCM_TRIGGER_POST},
 		.dynamic = 1,
 		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback),
 	},
 	{
 		.name = "wm8960-capture",
 		.stream_name = "wm8960-capture",
-		.cpu_dai_name = "PCM0",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST,
 			    SND_SOC_DPCM_TRIGGER_POST},
 		.dynamic = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture),
 	},
 	/* BE */
 	{
 		.name = "wm8960-codec",
-		.cpu_dai_name = "I2S0",
 		.no_pcm = 1,
-		.codec_dai_name = "wm8960-hifi",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS
 			| SND_SOC_DAIFMT_GATED,
 		.ops = &mt2701_wm8960_be_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(codec),
 	},
 };
 
@@ -107,9 +117,9 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
-		if (dai_link->platform_name)
+		if (dai_link->platforms->name)
 			continue;
-		dai_link->platform_of_node = platform_node;
+		dai_link->platforms->of_node = platform_node;
 	}
 
 	card->dev = &pdev->dev;
@@ -122,9 +132,9 @@ static int mt2701_wm8960_machine_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
-		if (dai_link->codec_name)
+		if (dai_link->codecs->name)
 			continue;
-		dai_link->codec_of_node = codec_node;
+		dai_link->codecs->of_node = codec_node;
 	}
 
 	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
-- 
2.20.1
