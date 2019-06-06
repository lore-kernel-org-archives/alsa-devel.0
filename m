From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: imx-spdif: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:34 +0100 (BST)
Message-ID: <20190606212635.05C6A440049@finisterre.sirena.org.uk>
References: <87d0jrict8.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4D8DF8979E
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:35 +0200 (CEST)
In-Reply-To: <87d0jrict8.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsl: imx-spdif: use modern dai_link style

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

>From 8337ef4f48876dc4ea9d869a6983c659f65f55bb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:14:38 +0900
Subject: [PATCH] ASoC: fsl: imx-spdif: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-spdif.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index 4f7f210beb18..6c4dadf60355 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -15,6 +15,7 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 {
 	struct device_node *spdif_np, *np = pdev->dev.of_node;
 	struct imx_spdif_data *data;
+	struct snd_soc_dai_link_component *comp;
 	int ret = 0;
 
 	spdif_np = of_parse_phandle(np, "spdif-controller", 0);
@@ -25,17 +26,26 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
+	comp = devm_kzalloc(&pdev->dev, 3 * sizeof(*comp), GFP_KERNEL);
+	if (!data || !comp) {
 		ret = -ENOMEM;
 		goto end;
 	}
 
+	data->dai.cpus		= &comp[0];
+	data->dai.codecs	= &comp[1];
+	data->dai.platforms	= &comp[2];
+
+	data->dai.num_cpus	= 1;
+	data->dai.num_codecs	= 1;
+	data->dai.num_platforms	= 1;
+
 	data->dai.name = "S/PDIF PCM";
 	data->dai.stream_name = "S/PDIF PCM";
-	data->dai.codec_dai_name = "snd-soc-dummy-dai";
-	data->dai.codec_name = "snd-soc-dummy";
-	data->dai.cpu_of_node = spdif_np;
-	data->dai.platform_of_node = spdif_np;
+	data->dai.codecs->dai_name = "snd-soc-dummy-dai";
+	data->dai.codecs->name = "snd-soc-dummy";
+	data->dai.cpus->of_node = spdif_np;
+	data->dai.platforms->of_node = spdif_np;
 	data->dai.playback_only = true;
 	data->dai.capture_only = true;
 
-- 
2.20.1
