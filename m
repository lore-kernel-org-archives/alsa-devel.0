From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: kirkwood: armada-370-db: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:50 +0100 (BST)
Message-ID: <20190606212650.1F35D440046@finisterre.sirena.org.uk>
References: <87ftonjrh4.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC699F897C8
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:50 +0200 (CEST)
In-Reply-To: <87ftonjrh4.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: kirkwood: armada-370-db: use modern dai_link style

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

>From 1d17821f79ae0fe6960231d38aaac66eed707b5f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:12:34 +0900
Subject: [PATCH] ASoC: kirkwood: armada-370-db: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/kirkwood/armada-370-db.c | 42 +++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/sound/soc/kirkwood/armada-370-db.c b/sound/soc/kirkwood/armada-370-db.c
index 677a48d7b891..b2d735b610b8 100644
--- a/sound/soc/kirkwood/armada-370-db.c
+++ b/sound/soc/kirkwood/armada-370-db.c
@@ -58,28 +58,40 @@ static const struct snd_soc_dapm_route a370db_route[] = {
 	{ "AIN1L",	NULL,	"In Jack" },
 };
 
+SND_SOC_DAILINK_DEFS(analog,
+	DAILINK_COMP_ARRAY(COMP_CPU("i2s")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "cs42l51-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(spdif_out,
+	DAILINK_COMP_ARRAY(COMP_CPU("spdif")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "dit-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(spdif_in,
+	DAILINK_COMP_ARRAY(COMP_CPU("spdif")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "dir-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 static struct snd_soc_dai_link a370db_dai[] = {
 {
 	.name = "CS42L51",
 	.stream_name = "analog",
-	.cpu_dai_name = "i2s",
-	.codec_dai_name = "cs42l51-hifi",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &a370db_ops,
+	SND_SOC_DAILINK_REG(analog),
 },
 {
 	.name = "S/PDIF out",
 	.stream_name = "spdif-out",
-	.cpu_dai_name = "spdif",
-	.codec_dai_name = "dit-hifi",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
+	SND_SOC_DAILINK_REG(spdif_out),
 },
 {
 	.name = "S/PDIF in",
 	.stream_name = "spdif-in",
-	.cpu_dai_name = "spdif",
-	.codec_dai_name = "dir-hifi",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
+	SND_SOC_DAILINK_REG(spdif_in),
 },
 };
 
@@ -100,26 +112,26 @@ static int a370db_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
-	a370db_dai[0].cpu_of_node =
+	a370db_dai[0].cpus->of_node =
 		of_parse_phandle(pdev->dev.of_node,
 				 "marvell,audio-controller", 0);
-	a370db_dai[0].platform_of_node = a370db_dai[0].cpu_of_node;
+	a370db_dai[0].platforms->of_node = a370db_dai[0].cpus->of_node;
 
-	a370db_dai[0].codec_of_node =
+	a370db_dai[0].codecs->of_node =
 		of_parse_phandle(pdev->dev.of_node,
 				 "marvell,audio-codec", 0);
 
-	a370db_dai[1].cpu_of_node = a370db_dai[0].cpu_of_node;
-	a370db_dai[1].platform_of_node = a370db_dai[0].cpu_of_node;
+	a370db_dai[1].cpus->of_node = a370db_dai[0].cpus->of_node;
+	a370db_dai[1].platforms->of_node = a370db_dai[0].cpus->of_node;
 
-	a370db_dai[1].codec_of_node =
+	a370db_dai[1].codecs->of_node =
 		of_parse_phandle(pdev->dev.of_node,
 				 "marvell,audio-codec", 1);
 
-	a370db_dai[2].cpu_of_node = a370db_dai[0].cpu_of_node;
-	a370db_dai[2].platform_of_node = a370db_dai[0].cpu_of_node;
+	a370db_dai[2].cpus->of_node = a370db_dai[0].cpus->of_node;
+	a370db_dai[2].platforms->of_node = a370db_dai[0].cpus->of_node;
 
-	a370db_dai[2].codec_of_node =
+	a370db_dai[2].codecs->of_node =
 		of_parse_phandle(pdev->dev.of_node,
 				 "marvell,audio-codec", 2);
 
-- 
2.20.1
