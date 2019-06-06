From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: omap-twl4030: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:45 +0100 (BST)
Message-ID: <20190606212645.A14E0440046@finisterre.sirena.org.uk>
References: <874l53jrg3.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88DAFF897B5
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:46 +0200 (CEST)
In-Reply-To: <874l53jrg3.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: ti: omap-twl4030: use modern dai_link style

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

>From d6db366a411c7e3ecc13096c58a290593be7a804 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:13:11 +0900
Subject: [PATCH] ASoC: ti: omap-twl4030: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/omap-twl4030.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/sound/soc/ti/omap-twl4030.c b/sound/soc/ti/omap-twl4030.c
index cccc316743fa..ddd24b2809b8 100644
--- a/sound/soc/ti/omap-twl4030.c
+++ b/sound/soc/ti/omap-twl4030.c
@@ -209,26 +209,30 @@ static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 }
 
 /* Digital audio interface glue - connects codec <--> CPU */
+SND_SOC_DAILINK_DEFS(hifi,
+	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.2")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.2")));
+
+SND_SOC_DAILINK_DEFS(voice,
+	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.3")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("twl4030-codec", "twl4030-voice")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.3")));
+
 static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
 	{
 		.name = "TWL4030 HiFi",
 		.stream_name = "TWL4030 HiFi",
-		.cpu_dai_name = "omap-mcbsp.2",
-		.codec_dai_name = "twl4030-hifi",
-		.platform_name = "omap-mcbsp.2",
-		.codec_name = "twl4030-codec",
 		.init = omap_twl4030_init,
 		.ops = &omap_twl4030_ops,
+		SND_SOC_DAILINK_REG(hifi),
 	},
 	{
 		.name = "TWL4030 Voice",
 		.stream_name = "TWL4030 Voice",
-		.cpu_dai_name = "omap-mcbsp.3",
-		.codec_dai_name = "twl4030-voice",
-		.platform_name = "omap-mcbsp.3",
-		.codec_name = "twl4030-codec",
 		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
 			   SND_SOC_DAIFMT_CBM_CFM,
+		SND_SOC_DAILINK_REG(voice),
 	},
 };
 
@@ -272,21 +276,21 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "McBSP node is not provided\n");
 			return -EINVAL;
 		}
-		omap_twl4030_dai_links[0].cpu_dai_name  = NULL;
-		omap_twl4030_dai_links[0].cpu_of_node = dai_node;
+		omap_twl4030_dai_links[0].cpus->dai_name  = NULL;
+		omap_twl4030_dai_links[0].cpus->of_node = dai_node;
 
-		omap_twl4030_dai_links[0].platform_name  = NULL;
-		omap_twl4030_dai_links[0].platform_of_node = dai_node;
+		omap_twl4030_dai_links[0].platforms->name  = NULL;
+		omap_twl4030_dai_links[0].platforms->of_node = dai_node;
 
 		dai_node = of_parse_phandle(node, "ti,mcbsp-voice", 0);
 		if (!dai_node) {
 			card->num_links = 1;
 		} else {
-			omap_twl4030_dai_links[1].cpu_dai_name  = NULL;
-			omap_twl4030_dai_links[1].cpu_of_node = dai_node;
+			omap_twl4030_dai_links[1].cpus->dai_name  = NULL;
+			omap_twl4030_dai_links[1].cpus->of_node = dai_node;
 
-			omap_twl4030_dai_links[1].platform_name  = NULL;
-			omap_twl4030_dai_links[1].platform_of_node = dai_node;
+			omap_twl4030_dai_links[1].platforms->name  = NULL;
+			omap_twl4030_dai_links[1].platforms->of_node = dai_node;
 		}
 
 		priv->jack_detect = of_get_named_gpio(node,
-- 
2.20.1
