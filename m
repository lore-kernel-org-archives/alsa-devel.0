From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: tegra_alc5632: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:17 +0100 (BST)
Message-ID: <20190606212617.D7792440049@finisterre.sirena.org.uk>
References: <874l53gy1w.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91335F89760
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:18 +0200 (CEST)
In-Reply-To: <874l53gy1w.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: tegra: tegra_alc5632: use modern dai_link style

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

>From af297e6f2c6731373a270537b00956c816a43aa7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:18:46 +0900
Subject: [PATCH] ASoC: tegra: tegra_alc5632: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra_alc5632.c | 37 +++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index 98d87801d57a..5a63249ae812 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -124,15 +124,20 @@ static int tegra_alc5632_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+SND_SOC_DAILINK_DEFS(pcm,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "alc5632-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link tegra_alc5632_dai = {
 	.name = "ALC5632",
 	.stream_name = "ALC5632 PCM",
-	.codec_dai_name = "alc5632-hifi",
 	.init = tegra_alc5632_asoc_init,
 	.ops = &tegra_alc5632_asoc_ops,
 	.dai_fmt = SND_SOC_DAIFMT_I2S
 			   | SND_SOC_DAIFMT_NB_NF
 			   | SND_SOC_DAIFMT_CBS_CFS,
+	SND_SOC_DAILINK_REG(pcm),
 };
 
 static struct snd_soc_card snd_soc_tegra_alc5632 = {
@@ -174,26 +179,26 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	tegra_alc5632_dai.codec_of_node = of_parse_phandle(
+	tegra_alc5632_dai.codecs->of_node = of_parse_phandle(
 			pdev->dev.of_node, "nvidia,audio-codec", 0);
 
-	if (!tegra_alc5632_dai.codec_of_node) {
+	if (!tegra_alc5632_dai.codecs->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'nvidia,audio-codec' missing or invalid\n");
 		ret = -EINVAL;
 		goto err;
 	}
 
-	tegra_alc5632_dai.cpu_of_node = of_parse_phandle(np,
+	tegra_alc5632_dai.cpus->of_node = of_parse_phandle(np,
 			"nvidia,i2s-controller", 0);
-	if (!tegra_alc5632_dai.cpu_of_node) {
+	if (!tegra_alc5632_dai.cpus->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'nvidia,i2s-controller' missing or invalid\n");
 		ret = -EINVAL;
 		goto err_put_codec_of_node;
 	}
 
-	tegra_alc5632_dai.platform_of_node = tegra_alc5632_dai.cpu_of_node;
+	tegra_alc5632_dai.platforms->of_node = tegra_alc5632_dai.cpus->of_node;
 
 	ret = tegra_asoc_utils_init(&alc5632->util_data, &pdev->dev);
 	if (ret)
@@ -211,12 +216,12 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
 err_fini_utils:
 	tegra_asoc_utils_fini(&alc5632->util_data);
 err_put_cpu_of_node:
-	of_node_put(tegra_alc5632_dai.cpu_of_node);
-	tegra_alc5632_dai.cpu_of_node = NULL;
-	tegra_alc5632_dai.platform_of_node = NULL;
+	of_node_put(tegra_alc5632_dai.cpus->of_node);
+	tegra_alc5632_dai.cpus->of_node = NULL;
+	tegra_alc5632_dai.platforms->of_node = NULL;
 err_put_codec_of_node:
-	of_node_put(tegra_alc5632_dai.codec_of_node);
-	tegra_alc5632_dai.codec_of_node = NULL;
+	of_node_put(tegra_alc5632_dai.codecs->of_node);
+	tegra_alc5632_dai.codecs->of_node = NULL;
 err:
 	return ret;
 }
@@ -230,11 +235,11 @@ static int tegra_alc5632_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&machine->util_data);
 
-	of_node_put(tegra_alc5632_dai.cpu_of_node);
-	tegra_alc5632_dai.cpu_of_node = NULL;
-	tegra_alc5632_dai.platform_of_node = NULL;
-	of_node_put(tegra_alc5632_dai.codec_of_node);
-	tegra_alc5632_dai.codec_of_node = NULL;
+	of_node_put(tegra_alc5632_dai.cpus->of_node);
+	tegra_alc5632_dai.cpus->of_node = NULL;
+	tegra_alc5632_dai.platforms->of_node = NULL;
+	of_node_put(tegra_alc5632_dai.codecs->of_node);
+	tegra_alc5632_dai.codecs->of_node = NULL;
 
 	return 0;
 }
-- 
2.20.1
