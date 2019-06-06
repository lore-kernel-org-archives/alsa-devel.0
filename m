From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel: mikroe-proto: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:42 +0100 (BST)
Message-ID: <20190606212642.4E102440046@finisterre.sirena.org.uk>
References: <87v9xjicuw.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63F38F897AE
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:43 +0200 (CEST)
In-Reply-To: <87v9xjicuw.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel: mikroe-proto: use modern dai_link style

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

>From ed00d6ccde62a7deafdfbf22d37725945890e536 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:13:38 +0900
Subject: [PATCH] ASoC: atmel: mikroe-proto: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/mikroe-proto.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/mikroe-proto.c b/sound/soc/atmel/mikroe-proto.c
index d47aaa5bf75a..255168a9df5b 100644
--- a/sound/soc/atmel/mikroe-proto.c
+++ b/sound/soc/atmel/mikroe-proto.c
@@ -66,6 +66,7 @@ static struct snd_soc_card snd_proto = {
 static int snd_proto_probe(struct platform_device *pdev)
 {
 	struct snd_soc_dai_link *dai;
+	struct snd_soc_dai_link_component *comp;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *codec_np, *cpu_np;
 	struct device_node *bitclkmaster = NULL;
@@ -87,12 +88,24 @@ static int snd_proto_probe(struct platform_device *pdev)
 	if (!dai)
 		return -ENOMEM;
 
+	/* for cpus/codecs/platforms */
+	comp = devm_kzalloc(&pdev->dev, 3 * sizeof(*comp), GFP_KERNEL);
+	if (!comp)
+		return -ENOMEM;
+
 	snd_proto.dai_link = dai;
 	snd_proto.num_links = 1;
 
+	dai->cpus = &comp[0];
+	dai->num_cpus = 1;
+	dai->codecs = &comp[1];
+	dai->num_codecs = 1;
+	dai->platforms = &comp[2];
+	dai->num_platforms = 1;
+
 	dai->name = "WM8731";
 	dai->stream_name = "WM8731 HiFi";
-	dai->codec_dai_name = "wm8731-hifi";
+	dai->codecs->dai_name = "wm8731-hifi";
 	dai->init = &snd_proto_init;
 
 	codec_np = of_parse_phandle(np, "audio-codec", 0);
@@ -100,15 +113,15 @@ static int snd_proto_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "audio-codec node missing\n");
 		return -EINVAL;
 	}
-	dai->codec_of_node = codec_np;
+	dai->codecs->of_node = codec_np;
 
 	cpu_np = of_parse_phandle(np, "i2s-controller", 0);
 	if (!cpu_np) {
 		dev_err(&pdev->dev, "i2s-controller missing\n");
 		return -EINVAL;
 	}
-	dai->cpu_of_node = cpu_np;
-	dai->platform_of_node = cpu_np;
+	dai->cpus->of_node = cpu_np;
+	dai->platforms->of_node = cpu_np;
 
 	dai_fmt = snd_soc_of_parse_daifmt(np, NULL,
 					  &bitclkmaster, &framemaster);
-- 
2.20.1
