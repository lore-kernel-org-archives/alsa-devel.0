From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: imx-audmix: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:28 +0100 (BST)
Message-ID: <20190606212628.D4819440046@finisterre.sirena.org.uk>
References: <87wohzgy5y.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AE8CEF89786
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:29 +0200 (CEST)
In-Reply-To: <87wohzgy5y.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsl: imx-audmix: use modern dai_link style

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

>From 79782e283ed3df04bfb77129091f1d6726987f1e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:16:20 +0900
Subject: [PATCH] ASoC: fsl: imx-audmix: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-audmix.c | 45 +++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 9aaf3e5b45b9..9e1cb18859ce 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -205,6 +205,15 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < num_dai; i++) {
+		struct snd_soc_dai_link_component *dlc;
+
+		/* for CPU/Codec/Platform x 2 */
+		dlc = devm_kzalloc(&pdev->dev, 6 * sizeof(*dlc), GFP_KERNEL);
+		if (!dlc) {
+			dev_err(&pdev->dev, "failed to allocate dai_link\n");
+			return -ENOMEM;
+		}
+
 		ret = of_parse_phandle_with_args(audmix_np, "dais", NULL, i,
 						 &args);
 		if (ret < 0) {
@@ -231,13 +240,21 @@ static int imx_audmix_probe(struct platform_device *pdev)
 					       dai_name, "CPU-Capture");
 		}
 
+		priv->dai[i].cpus = &dlc[0];
+		priv->dai[i].codecs = &dlc[1];
+		priv->dai[i].platforms = &dlc[2];
+
+		priv->dai[i].num_cpus = 1;
+		priv->dai[i].num_codecs = 1;
+		priv->dai[i].num_platforms = 1;
+
 		priv->dai[i].name = dai_name;
 		priv->dai[i].stream_name = "HiFi-AUDMIX-FE";
-		priv->dai[i].codec_dai_name = "snd-soc-dummy-dai";
-		priv->dai[i].codec_name = "snd-soc-dummy";
-		priv->dai[i].cpu_of_node = args.np;
-		priv->dai[i].cpu_dai_name = dev_name(&cpu_pdev->dev);
-		priv->dai[i].platform_of_node = args.np;
+		priv->dai[i].codecs->dai_name = "snd-soc-dummy-dai";
+		priv->dai[i].codecs->name = "snd-soc-dummy";
+		priv->dai[i].cpus->of_node = args.np;
+		priv->dai[i].cpus->dai_name = dev_name(&cpu_pdev->dev);
+		priv->dai[i].platforms->of_node = args.np;
 		priv->dai[i].dynamic = 1;
 		priv->dai[i].dpcm_playback = 1;
 		priv->dai[i].dpcm_capture = (i == 0 ? 1 : 0);
@@ -252,12 +269,20 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		be_cp = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 				       "AUDMIX-Capture-%d", i);
 
+		priv->dai[num_dai + i].cpus = &dlc[3];
+		priv->dai[num_dai + i].codecs = &dlc[4];
+		priv->dai[num_dai + i].platforms = &dlc[5];
+
+		priv->dai[num_dai + i].num_cpus = 1;
+		priv->dai[num_dai + i].num_codecs = 1;
+		priv->dai[num_dai + i].num_platforms = 1;
+
 		priv->dai[num_dai + i].name = be_name;
-		priv->dai[num_dai + i].codec_dai_name = "snd-soc-dummy-dai";
-		priv->dai[num_dai + i].codec_name = "snd-soc-dummy";
-		priv->dai[num_dai + i].cpu_of_node = audmix_np;
-		priv->dai[num_dai + i].cpu_dai_name = be_name;
-		priv->dai[num_dai + i].platform_name = "snd-soc-dummy";
+		priv->dai[num_dai + i].codecs->dai_name = "snd-soc-dummy-dai";
+		priv->dai[num_dai + i].codecs->name = "snd-soc-dummy";
+		priv->dai[num_dai + i].cpus->of_node = audmix_np;
+		priv->dai[num_dai + i].cpus->dai_name = be_name;
+		priv->dai[num_dai + i].platforms->name = "snd-soc-dummy";
 		priv->dai[num_dai + i].no_pcm = 1;
 		priv->dai[num_dai + i].dpcm_playback = 1;
 		priv->dai[num_dai + i].dpcm_capture  = 1;
-- 
2.20.1
