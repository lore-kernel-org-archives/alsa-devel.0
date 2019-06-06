From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: omap-abe-twl6040: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:46 +0100 (BST)
Message-ID: <20190606212646.376C4440049@finisterre.sirena.org.uk>
References: <875zpjjrg8.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1E08F8974C
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:46 +0200 (CEST)
In-Reply-To: <875zpjjrg8.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: ti: omap-abe-twl6040: use modern dai_link style

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

>From bc9dfc4cb1d817726774c1ab57c8f866a5e109db Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:13:06 +0900
Subject: [PATCH] ASoC: ti: omap-abe-twl6040: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/omap-abe-twl6040.c | 36 +++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ti/omap-abe-twl6040.c b/sound/soc/ti/omap-abe-twl6040.c
index fed45b41f9d3..3522ea7aa8d9 100644
--- a/sound/soc/ti/omap-abe-twl6040.c
+++ b/sound/soc/ti/omap-abe-twl6040.c
@@ -35,6 +35,18 @@
 #include "omap-mcpdm.h"
 #include "../codecs/twl6040.h"
 
+SND_SOC_DAILINK_DEFS(link0,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC("twl6040-codec",
+				      "twl6040-legacy")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(link1,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec",
+				      "dmic-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
 struct abe_twl6040 {
 	struct snd_soc_card card;
 	struct snd_soc_dai_link dai_links[2];
@@ -255,10 +267,14 @@ static int omap_abe_probe(struct platform_device *pdev)
 
 	priv->dai_links[0].name = "DMIC";
 	priv->dai_links[0].stream_name = "TWL6040";
-	priv->dai_links[0].cpu_of_node = dai_node;
-	priv->dai_links[0].platform_of_node = dai_node;
-	priv->dai_links[0].codec_dai_name = "twl6040-legacy";
-	priv->dai_links[0].codec_name = "twl6040-codec";
+	priv->dai_links[0].cpus = link0_cpus;
+	priv->dai_links[0].num_cpus = 1;
+	priv->dai_links[0].cpus->of_node = dai_node;
+	priv->dai_links[0].platforms = link0_platforms;
+	priv->dai_links[0].num_platforms = 1;
+	priv->dai_links[0].platforms->of_node = dai_node;
+	priv->dai_links[0].codecs = link0_codecs;
+	priv->dai_links[0].num_codecs = 1;
 	priv->dai_links[0].init = omap_abe_twl6040_init;
 	priv->dai_links[0].ops = &omap_abe_ops;
 
@@ -267,10 +283,14 @@ static int omap_abe_probe(struct platform_device *pdev)
 		num_links = 2;
 		priv->dai_links[1].name = "TWL6040";
 		priv->dai_links[1].stream_name = "DMIC Capture";
-		priv->dai_links[1].cpu_of_node = dai_node;
-		priv->dai_links[1].platform_of_node = dai_node;
-		priv->dai_links[1].codec_dai_name = "dmic-hifi";
-		priv->dai_links[1].codec_name = "dmic-codec";
+		priv->dai_links[1].cpus = link1_cpus;
+		priv->dai_links[1].num_cpus = 1;
+		priv->dai_links[1].cpus->of_node = dai_node;
+		priv->dai_links[1].platforms = link1_platforms;
+		priv->dai_links[1].num_platforms = 1;
+		priv->dai_links[1].platforms->of_node = dai_node;
+		priv->dai_links[1].codecs = link1_codecs;
+		priv->dai_links[1].num_codecs = 1;
 		priv->dai_links[1].init = omap_abe_dmic_init;
 		priv->dai_links[1].ops = &omap_abe_dmic_ops;
 	} else {
-- 
2.20.1
