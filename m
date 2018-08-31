From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: support
	snd_soc_dai_link_component style for platform" to the asoc tree
Date: Fri, 31 Aug 2018 16:31:57 +0100 (BST)
Message-ID: <20180831153157.4BE3E11226FE@debutante.sirena.org.uk>
References: <87o9djkzjg.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ED55A267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:31:57 +0200 (CEST)
In-Reply-To: <87o9djkzjg.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card: support snd_soc_dai_link_component style for platform

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

>From e58f41e41185c6906bd11c73c4e76aa5fc3ea685 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 31 Aug 2018 03:10:33 +0000
Subject: [PATCH] ASoC: simple-card: support snd_soc_dai_link_component style
 for platform

Current ASoC is supporting snd_soc_dai_link_component for binding,
it is more useful than current legacy style.
Currently only codec is supporting it as multicodec (= codecs).
CPU will support multi style in the future.
We want to have it on Platform too in the future.

If all Codec/CPU/Platform are replaced into snd_soc_dai_link_component
style, we can remove legacy complex style.
This patch supports snd_soc_dai_link_component style
for simple-card for platform.

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
 sound/soc/generic/simple-card.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 67a56f32f983..5a3f59aa4ba5 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -21,6 +21,7 @@ struct simple_card_data {
 		struct asoc_simple_dai cpu_dai;
 		struct asoc_simple_dai codec_dai;
 		struct snd_soc_dai_link_component codecs; /* single codec */
+		struct snd_soc_dai_link_component platform;
 		unsigned int mclk_fs;
 	} *dai_props;
 	unsigned int mclk_fs;
@@ -391,6 +392,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	for (i = 0; i < num; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
+		dai_link[i].platform	= &dai_props[i].platform;
 	}
 
 	priv->dai_props			= dai_props;
@@ -416,6 +418,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	} else {
 		struct asoc_simple_card_info *cinfo;
 		struct snd_soc_dai_link_component *codecs;
+		struct snd_soc_dai_link_component *platform;
 
 		cinfo = dev->platform_data;
 		if (!cinfo) {
@@ -436,10 +439,12 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		codecs->name		= cinfo->codec;
 		codecs->dai_name	= cinfo->codec_dai.name;
 
+		platform		= dai_link->platform;
+		platform->name		= cinfo->platform;
+
 		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
 		dai_link->name		= cinfo->name;
 		dai_link->stream_name	= cinfo->name;
-		dai_link->platform_name	= cinfo->platform;
 		dai_link->cpu_dai_name	= cinfo->cpu_dai.name;
 		dai_link->dai_fmt	= cinfo->daifmt;
 		dai_link->init		= asoc_simple_card_dai_init;
-- 
2.19.0.rc1
