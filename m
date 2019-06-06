From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: tegra_rt5677: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:19 +0100 (BST)
Message-ID: <20190606212619.82C4A440046@finisterre.sirena.org.uk>
References: <878sufgy2c.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59FC0F89766
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:20 +0200 (CEST)
In-Reply-To: <878sufgy2c.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: tegra: tegra_rt5677: use modern dai_link style

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

>From 9b4f646a3aed26f4cb7f310013d1dda61aab9b47 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:18:30 +0900
Subject: [PATCH] ASoC: tegra: tegra_rt5677: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra_rt5677.c | 37 +++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.c
index 7081f15302cc..7edf6c7838f5 100644
--- a/sound/soc/tegra/tegra_rt5677.c
+++ b/sound/soc/tegra/tegra_rt5677.c
@@ -169,14 +169,19 @@ static int tegra_rt5677_asoc_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+SND_SOC_DAILINK_DEFS(pcm,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "rt5677-aif1")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link tegra_rt5677_dai = {
 	.name = "RT5677",
 	.stream_name = "RT5677 PCM",
-	.codec_dai_name = "rt5677-aif1",
 	.init = tegra_rt5677_asoc_init,
 	.ops = &tegra_rt5677_ops,
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
+	SND_SOC_DAILINK_REG(pcm),
 };
 
 static struct snd_soc_card snd_soc_tegra_rt5677 = {
@@ -249,24 +254,24 @@ static int tegra_rt5677_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	tegra_rt5677_dai.codec_of_node = of_parse_phandle(np,
+	tegra_rt5677_dai.codecs->of_node = of_parse_phandle(np,
 			"nvidia,audio-codec", 0);
-	if (!tegra_rt5677_dai.codec_of_node) {
+	if (!tegra_rt5677_dai.codecs->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'nvidia,audio-codec' missing or invalid\n");
 		ret = -EINVAL;
 		goto err;
 	}
 
-	tegra_rt5677_dai.cpu_of_node = of_parse_phandle(np,
+	tegra_rt5677_dai.cpus->of_node = of_parse_phandle(np,
 			"nvidia,i2s-controller", 0);
-	if (!tegra_rt5677_dai.cpu_of_node) {
+	if (!tegra_rt5677_dai.cpus->of_node) {
 		dev_err(&pdev->dev,
 			"Property 'nvidia,i2s-controller' missing or invalid\n");
 		ret = -EINVAL;
 		goto err_put_codec_of_node;
 	}
-	tegra_rt5677_dai.platform_of_node = tegra_rt5677_dai.cpu_of_node;
+	tegra_rt5677_dai.platforms->of_node = tegra_rt5677_dai.cpus->of_node;
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
 	if (ret)
@@ -284,12 +289,12 @@ static int tegra_rt5677_probe(struct platform_device *pdev)
 err_fini_utils:
 	tegra_asoc_utils_fini(&machine->util_data);
 err_put_cpu_of_node:
-	of_node_put(tegra_rt5677_dai.cpu_of_node);
-	tegra_rt5677_dai.cpu_of_node = NULL;
-	tegra_rt5677_dai.platform_of_node = NULL;
+	of_node_put(tegra_rt5677_dai.cpus->of_node);
+	tegra_rt5677_dai.cpus->of_node = NULL;
+	tegra_rt5677_dai.platforms->of_node = NULL;
 err_put_codec_of_node:
-	of_node_put(tegra_rt5677_dai.codec_of_node);
-	tegra_rt5677_dai.codec_of_node = NULL;
+	of_node_put(tegra_rt5677_dai.codecs->of_node);
+	tegra_rt5677_dai.codecs->of_node = NULL;
 err:
 	return ret;
 }
@@ -303,11 +308,11 @@ static int tegra_rt5677_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&machine->util_data);
 
-	tegra_rt5677_dai.platform_of_node = NULL;
-	of_node_put(tegra_rt5677_dai.codec_of_node);
-	tegra_rt5677_dai.codec_of_node = NULL;
-	of_node_put(tegra_rt5677_dai.cpu_of_node);
-	tegra_rt5677_dai.cpu_of_node = NULL;
+	tegra_rt5677_dai.platforms->of_node = NULL;
+	of_node_put(tegra_rt5677_dai.codecs->of_node);
+	tegra_rt5677_dai.codecs->of_node = NULL;
+	of_node_put(tegra_rt5677_dai.cpus->of_node);
+	tegra_rt5677_dai.cpus->of_node = NULL;
 
 	return 0;
 }
-- 
2.20.1
