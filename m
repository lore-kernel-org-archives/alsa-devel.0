From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-card: support
	snd_soc_dai_link_component style for platform" to the asoc tree
Date: Fri, 31 Aug 2018 16:29:43 +0100 (BST)
Message-ID: <20180831152943.F006711226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9103F267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:29:44 +0200 (CEST)
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

   ASoC: audio-graph-card: support snd_soc_dai_link_component style for platform

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

>From 46c73187f2986e40b427485bb8f4401aa9143ed0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 31 Aug 2018 03:10:58 +0000
Subject: [PATCH] ASoC: audio-graph-card: support snd_soc_dai_link_component
 style for platform

Current ASoC is supporting snd_soc_dai_link_component for binding,
it is more useful than current legacy style.
Currently only codec is supporting it as multicodec (= codecs).
CPU will support multi style in the future.
We want to have it on Platform too in the future.

If all Codec/CPU/Platform are replaced into snd_soc_dai_link_component
style, we can remove legacy complex style.
This patch supports snd_soc_dai_link_component style
for audio-graph-card for platform.

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
 sound/soc/generic/audio-graph-card.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 5b2ecf8c2652..fb6635f8d5d7 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -26,6 +26,7 @@ struct graph_card_data {
 		struct asoc_simple_dai cpu_dai;
 		struct asoc_simple_dai codec_dai;
 		struct snd_soc_dai_link_component codecs; /* single codec */
+		struct snd_soc_dai_link_component platform;
 		unsigned int mclk_fs;
 	} *dai_props;
 	unsigned int mclk_fs;
@@ -325,6 +326,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	for (i = 0; i < num; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
+		dai_link[i].platform	= &dai_props[i].platform;
 	}
 
 	priv->pa_gpio = devm_gpiod_get_optional(dev, "pa", GPIOD_OUT_LOW);
-- 
2.19.0.rc1
