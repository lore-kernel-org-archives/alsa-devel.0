From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: fsl-asoc-card: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:32 +0100 (BST)
Message-ID: <20190606212632.BC08A440049@finisterre.sirena.org.uk>
References: <877e9zicsb.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DD60F89795
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:33 +0200 (CEST)
In-Reply-To: <877e9zicsb.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsl: fsl-asoc-card: use modern dai_link style

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

>From 893f195104142c0f83e60a91ccada2653bccee2a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:15:11 +0900
Subject: [PATCH] ASoC: fsl: fsl-asoc-card: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 47 +++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 60f87a0d99f4..39ea9bda1394 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -200,32 +200,47 @@ static int be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
+SND_SOC_DAILINK_DEFS(hifi,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(hifi_fe,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(hifi_be,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_DUMMY()));
+
 static struct snd_soc_dai_link fsl_asoc_card_dai[] = {
 	/* Default ASoC DAI Link*/
 	{
 		.name = "HiFi",
 		.stream_name = "HiFi",
 		.ops = &fsl_asoc_card_ops,
+		SND_SOC_DAILINK_REG(hifi),
 	},
 	/* DPCM Link between Front-End and Back-End (Optional) */
 	{
 		.name = "HiFi-ASRC-FE",
 		.stream_name = "HiFi-ASRC-FE",
-		.codec_name = "snd-soc-dummy",
-		.codec_dai_name = "snd-soc-dummy-dai",
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.dynamic = 1,
+		SND_SOC_DAILINK_REG(hifi_fe),
 	},
 	{
 		.name = "HiFi-ASRC-BE",
 		.stream_name = "HiFi-ASRC-BE",
-		.platform_name = "snd-soc-dummy",
 		.be_hw_params_fixup = be_hw_params_fixup,
 		.ops = &fsl_asoc_card_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.no_pcm = 1,
+		SND_SOC_DAILINK_REG(hifi_be),
 	},
 };
 
@@ -616,11 +631,11 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	}
 
 	/* Normal DAI Link */
-	priv->dai_link[0].cpu_of_node = cpu_np;
-	priv->dai_link[0].codec_dai_name = codec_dai_name;
+	priv->dai_link[0].cpus->of_node = cpu_np;
+	priv->dai_link[0].codecs->dai_name = codec_dai_name;
 
 	if (!fsl_asoc_card_is_ac97(priv))
-		priv->dai_link[0].codec_of_node = codec_np;
+		priv->dai_link[0].codecs->of_node = codec_np;
 	else {
 		u32 idx;
 
@@ -631,29 +646,29 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 			goto asrc_fail;
 		}
 
-		priv->dai_link[0].codec_name =
+		priv->dai_link[0].codecs->name =
 				devm_kasprintf(&pdev->dev, GFP_KERNEL,
 					       "ac97-codec.%u",
 					       (unsigned int)idx);
-		if (!priv->dai_link[0].codec_name) {
+		if (!priv->dai_link[0].codecs->name) {
 			ret = -ENOMEM;
 			goto asrc_fail;
 		}
 	}
 
-	priv->dai_link[0].platform_of_node = cpu_np;
+	priv->dai_link[0].platforms->of_node = cpu_np;
 	priv->dai_link[0].dai_fmt = priv->dai_fmt;
 	priv->card.num_links = 1;
 
 	if (asrc_pdev) {
 		/* DPCM DAI Links only if ASRC exsits */
-		priv->dai_link[1].cpu_of_node = asrc_np;
-		priv->dai_link[1].platform_of_node = asrc_np;
-		priv->dai_link[2].codec_dai_name = codec_dai_name;
-		priv->dai_link[2].codec_of_node = codec_np;
-		priv->dai_link[2].codec_name =
-				priv->dai_link[0].codec_name;
-		priv->dai_link[2].cpu_of_node = cpu_np;
+		priv->dai_link[1].cpus->of_node = asrc_np;
+		priv->dai_link[1].platforms->of_node = asrc_np;
+		priv->dai_link[2].codecs->dai_name = codec_dai_name;
+		priv->dai_link[2].codecs->of_node = codec_np;
+		priv->dai_link[2].codecs->name =
+				priv->dai_link[0].codecs->name;
+		priv->dai_link[2].cpus->of_node = cpu_np;
 		priv->dai_link[2].dai_fmt = priv->dai_fmt;
 		priv->card.num_links = 3;
 
-- 
2.20.1
