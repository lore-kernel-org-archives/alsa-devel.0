From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: use
	snd_soc_of_parse_audio_route/prefix for routing" to the asoc tree
Date: Thu, 16 Jul 2015 22:11:46 +0100
Message-ID: <E1ZFqRW-0002rC-Qg@finisterre>
References: <87a8uxx5nf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F38B266834
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:11:52 +0200 (CEST)
In-Reply-To: <87a8uxx5nf.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: use snd_soc_of_parse_audio_route/prefix for routing

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b7419dd73606118b8797d49b53a9fbe2e2dfa863 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:08:05 +0000
Subject: [PATCH] ASoC: rsrc-card: use snd_soc_of_parse_audio_route/prefix for
 routing

using common audio routing path method makes sense.
Let's use snd_soc_of_parse_audio_route/prefix.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/renesas,rsrc-card.txt           |  7 +++++++
 sound/soc/sh/rcar/rsrc-card.c                      | 22 ++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
index c641550..962748a 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
@@ -6,6 +6,7 @@ Required properties:
 
 - compatible				: "renesas,rsrc-card,<board>"
 					  Examples with soctypes are:
+					    - "renesas,rsrc-card"
 					    - "renesas,rsrc-card,lager"
 					    - "renesas,rsrc-card,koelsch"
 Optional properties:
@@ -29,6 +30,12 @@ Optional subnode properties:
 - frame-inversion			: bool property. Add this if the
 					  dai-link uses frame clock inversion.
 - convert-rate				: platform specified sampling rate convert
+- audio-prefix				: see audio-routing
+- audio-routing				: A list of the connections between audio components.
+					  Each entry is a pair of strings, the first being the connection's sink,
+					  the second being the connection's source. Valid names for sources.
+					  use audio-prefix if some components is using same sink/sources naming.
+					  it can be used if compatible was "renesas,rsrc-card";
 
 Required CPU/CODEC subnodes properties:
 
diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 84e9357..d61db9c 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -41,6 +41,7 @@ static const struct rsrc_card_of_data routes_of_ssi0_ak4642 = {
 static const struct of_device_id rsrc_card_of_match[] = {
 	{ .compatible = "renesas,rsrc-card,lager",	.data = &routes_of_ssi0_ak4642 },
 	{ .compatible = "renesas,rsrc-card,koelsch",	.data = &routes_of_ssi0_ak4642 },
+	{ .compatible = "renesas,rsrc-card", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rsrc_card_of_match);
@@ -242,8 +243,15 @@ static int rsrc_card_parse_links(struct device_node *np,
 		snd_soc_of_get_dai_name(np, &dai_link->codec_dai_name);
 
 		/* additional name prefix */
-		priv->codec_conf.of_node	= dai_link->codec_of_node;
-		priv->codec_conf.name_prefix	= of_data->prefix;
+		if (of_data) {
+			priv->codec_conf.of_node = dai_link->codec_of_node;
+			priv->codec_conf.name_prefix = of_data->prefix;
+		} else {
+			snd_soc_of_parse_audio_prefix(&priv->snd_card,
+						      &priv->codec_conf,
+						      dai_link->codec_of_node,
+						      "audio-prefix");
+		}
 
 		/* set dai_name */
 		snprintf(dai_props->dai_name, DAI_NAME_NUM, "be.%s",
@@ -361,8 +369,14 @@ static int rsrc_card_parse_of(struct device_node *node,
 	priv->snd_card.num_links		= num;
 	priv->snd_card.codec_conf		= &priv->codec_conf;
 	priv->snd_card.num_configs		= 1;
-	priv->snd_card.of_dapm_routes		= of_data->routes;
-	priv->snd_card.num_of_dapm_routes	= of_data->num_routes;
+
+	if (of_data) {
+		priv->snd_card.of_dapm_routes		= of_data->routes;
+		priv->snd_card.num_of_dapm_routes	= of_data->num_routes;
+	} else {
+		snd_soc_of_parse_audio_routing(&priv->snd_card,
+					       "audio-routing");
+	}
 
 	/* Parse the card name from DT */
 	snd_soc_of_parse_card_name(&priv->snd_card, "card-name");
-- 
2.1.4
