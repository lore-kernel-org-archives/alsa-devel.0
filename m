From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: tidyup prefix for
	snd_soc_codec_conf" to the asoc tree
Date: Fri, 14 Dec 2018 12:37:26 +0000 (GMT)
Message-ID: <20181214123726.7112611258A1@debutante.sirena.org.uk>
References: <875zvw974w.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 233E72678D5
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:37:27 +0100 (CET)
In-Reply-To: <875zvw974w.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: tidyup prefix for snd_soc_codec_conf

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From cfc652a73331c3b465e3f8dd39a3d6b71e6b3a66 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 14 Dec 2018 11:35:24 +0900
Subject: [PATCH] ASoC: simple-card: tidyup prefix for snd_soc_codec_conf

Current simple-card is handling "prefix" by many ways.
But, it is not useful and readable.
We want to do is that allow having it everywere.
This patch supports it.
It will be overwrote if lower node has it.

sound {
	simple-audio-card,prefix = "xxx"; // initial

	simple-audio-card,dai-link {
		prefix = "xxx"; // overwrite
		cpu {
			...
		};
		codec {
			prefix = "xxx"; // overwrite
		};
	};
};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index fb18e5148aad..37e001cf9cd1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -177,8 +177,9 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, link_idx);
 	struct simple_dai_props *dai_props = simple_priv_to_props(priv, link_idx);
-	struct snd_soc_card *card = simple_priv_to_card(priv);
 	struct asoc_simple_dai *dai;
+	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
+
 	char prop[128];
 	char *prefix = "";
 	int ret;
@@ -189,10 +190,8 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 
 	if (is_fe) {
 		int is_single_links = 0;
-		struct snd_soc_dai_link_component *codecs;
 
 		/* BE is dummy */
-		codecs			= dai_link->codecs;
 		codecs->of_node		= NULL;
 		codecs->dai_name	= "snd-soc-dummy-dai";
 		codecs->name		= "snd-soc-dummy";
@@ -248,19 +247,17 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 
 		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
 							"be.%s",
-							dai_link->codecs->dai_name);
+							codecs->dai_name);
 		if (ret < 0)
 			return ret;
 
 		/* check "prefix" from top node */
-		snd_soc_of_parse_audio_prefix(card, cconf,
-					      dai_link->codecs->of_node,
+		snd_soc_of_parse_node_prefix(top, cconf, codecs->of_node,
 					      PREFIX "prefix");
-		/* check "prefix" from each node if top doesn't have */
-		if (!cconf->of_node)
-			snd_soc_of_parse_node_prefix(np, cconf,
-						     dai_link->codecs->of_node,
-						     "prefix");
+		snd_soc_of_parse_node_prefix(node, cconf, codecs->of_node,
+					     "prefix");
+		snd_soc_of_parse_node_prefix(np, cconf, codecs->of_node,
+					     "prefix");
 	}
 
 	asoc_simple_card_parse_convert(dev, top,  PREFIX, &dai_props->adata);
-- 
2.19.0.rc2
