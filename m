From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: support
	snd_soc_dai_link_component style for codec" to the asoc tree
Date: Fri, 31 Aug 2018 16:37:25 +0100 (BST)
Message-ID: <20180831153725.0AFBA11226FE@debutante.sirena.org.uk>
References: <87y3cnkzmb.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A43C12679D8
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:37:25 +0200 (CEST)
In-Reply-To: <87y3cnkzmb.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-scu-card: support snd_soc_dai_link_component style for codec

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

>From 2289cc1c78574653d30b80696327646ba340babf Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 31 Aug 2018 03:08:51 +0000
Subject: [PATCH] ASoC: simple-scu-card: support snd_soc_dai_link_component
 style for codec

Current ASoC is supporting snd_soc_dai_link_component for binding,
it is more useful than current legacy style.
Currently only codec is supporting it as multicodec (= codecs).
CPU will support multi style in the future.
We want to have it on Platform too in the future.

If all Codec/CPU/Platform are replaced into snd_soc_dai_link_component
style, we can remove legacy complex style.
This patch supports snd_soc_dai_link_component style
for simple-scu-card for codec.

[current]
struct snd_soc_dai_link {
	...
	*cpu_name;
	*cpu_of_node;
	*cpu_dai_name;

	*codec_name;
	*codec_of_node;
	*codec_dai_name;
	*codecs;
	num_codecs;

	*platform_name;
	*platform_of_node;
	...
}

[in the future]
struct snd_soc_dai_link {
	...
	*cpus
	num_cpus;

	*codecs;
	num_codecs;

	*platform;
	...
}

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 09be02e7416f..91efc8653746 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -24,6 +24,7 @@ struct simple_card_data {
 	struct snd_soc_codec_conf codec_conf;
 	struct simple_dai_props {
 		struct asoc_simple_dai dai;
+		struct snd_soc_dai_link_component codecs;
 	} *dai_props;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_card_data adata;
@@ -103,11 +104,13 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 
 	if (is_fe) {
 		int is_single_links = 0;
+		struct snd_soc_dai_link_component *codecs;
 
 		/* BE is dummy */
-		dai_link->codec_of_node		= NULL;
-		dai_link->codec_dai_name	= "snd-soc-dummy-dai";
-		dai_link->codec_name		= "snd-soc-dummy";
+		codecs			= dai_link->codecs;
+		codecs->of_node		= NULL;
+		codecs->dai_name	= "snd-soc-dummy-dai";
+		codecs->name		= "snd-soc-dummy";
 
 		/* FE settings */
 		dai_link->dynamic		= 1;
@@ -149,13 +152,13 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 
 		ret = asoc_simple_card_set_dailink_name(dev, dai_link,
 							"be.%s",
-							dai_link->codec_dai_name);
+							dai_link->codecs->dai_name);
 		if (ret < 0)
 			return ret;
 
 		snd_soc_of_parse_audio_prefix(card,
 					      &priv->codec_conf,
-					      dai_link->codec_of_node,
+					      dai_link->codecs->of_node,
 					      PREFIX "prefix");
 	}
 
@@ -236,7 +239,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct snd_soc_card *card;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	int num, ret;
+	int num, ret, i;
 
 	/* Allocate the private data */
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -250,6 +253,17 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	if (!dai_props || !dai_link)
 		return -ENOMEM;
 
+	/*
+	 * Use snd_soc_dai_link_component instead of legacy style
+	 * It is codec only. but cpu/platform will be supported in the future.
+	 * see
+	 *	soc-core.c :: snd_soc_init_multicodec()
+	 */
+	for (i = 0; i < num; i++) {
+		dai_link[i].codecs	= &dai_props[i].codecs;
+		dai_link[i].num_codecs	= 1;
+	}
+
 	priv->dai_props				= dai_props;
 	priv->dai_link				= dai_link;
 
-- 
2.19.0.rc1
