From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: support
	snd_soc_dai_link_component style for codec" to the asoc tree
Date: Fri, 31 Aug 2018 16:37:19 +0100 (BST)
Message-ID: <20180831153719.DDBC011226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 48C48267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:37:20 +0200 (CEST)
In-Reply-To: 
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

   ASoC: audio-graph-card: support snd_soc_dai_link_component style for codec

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

>From 8e6746db2e66c30e59a49ac15eb0c54d51acfb4b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 31 Aug 2018 03:09:05 +0000
Subject: [PATCH] ASoC: audio-graph-card: support snd_soc_dai_link_component
 style for codec

Current ASoC is supporting snd_soc_dai_link_component for binding,
it is more useful than current legacy style.
Currently only codec is supporting it as multicodec (= codecs).
CPU will support multi style in the future.
We want to have it on Platform too in the future.

If all Codec/CPU/Platform are replaced into snd_soc_dai_link_component
style, we can remove legacy complex style.
This patch supports snd_soc_dai_link_component style
for audio-graph-card for codec.

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
 sound/soc/generic/audio-graph-card.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 2094d2c8919f..5b2ecf8c2652 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -25,6 +25,7 @@ struct graph_card_data {
 	struct graph_dai_props {
 		struct asoc_simple_dai cpu_dai;
 		struct asoc_simple_dai codec_dai;
+		struct snd_soc_dai_link_component codecs; /* single codec */
 		unsigned int mclk_fs;
 	} *dai_props;
 	unsigned int mclk_fs;
@@ -213,7 +214,7 @@ static int asoc_graph_card_dai_link_of(struct device_node *cpu_port,
 	ret = asoc_simple_card_set_dailink_name(dev, dai_link,
 						"%s-%s",
 						dai_link->cpu_dai_name,
-						dai_link->codec_dai_name);
+						dai_link->codecs->dai_name);
 	if (ret < 0)
 		goto dai_link_of_err;
 
@@ -299,7 +300,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	struct graph_dai_props *dai_props;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_card *card;
-	int num, ret;
+	int num, ret, i;
 
 	/* Allocate the private data and the DAI link array */
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -315,6 +316,17 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
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
 	priv->pa_gpio = devm_gpiod_get_optional(dev, "pa", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->pa_gpio)) {
 		ret = PTR_ERR(priv->pa_gpio);
-- 
2.19.0.rc1
