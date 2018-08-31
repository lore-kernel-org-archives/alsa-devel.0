From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-util: support
	snd_soc_dai_link_component style for platform" to the asoc tree
Date: Fri, 31 Aug 2018 16:32:04 +0100 (BST)
Message-ID: <20180831153205.048DD11226FE@debutante.sirena.org.uk>
References: <87pnxzkzjt.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CFC22679BC
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:32:05 +0200 (CEST)
In-Reply-To: <87pnxzkzjt.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card-util: support snd_soc_dai_link_component style for platform

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

>From 868cdb4690699b04ca4d09b1e0178dfc680dbd8e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 31 Aug 2018 03:10:20 +0000
Subject: [PATCH] ASoC: simple-card-util: support snd_soc_dai_link_component
 style for platform

Current ASoC is supporting snd_soc_dai_link_component for binding,
it is more useful than current legacy style.
Currently only codec is supporting it as multicodec (= codecs).
CPU will support multi style in the future.
We want to have it on Platform too in the future.

If all Codec/CPU/Platform are replaced into snd_soc_dai_link_component
style, we can remove legacy complex style.
This patch supports snd_soc_dai_link_component style
for simple-card-util for platform.

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
 include/sound/simple_card_utils.h     |  2 +-
 sound/soc/generic/simple-card-utils.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 3b5bd6e76f88..fb0318f9b10f 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -75,7 +75,7 @@ void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai);
 				   &dai_link->codec_dai_name,			\
 				   list_name, cells_name, NULL)
 #define asoc_simple_card_parse_platform(node, dai_link, list_name, cells_name)	\
-	asoc_simple_card_parse_dai(node, NULL,					\
+	asoc_simple_card_parse_dai(node, dai_link->platform,					\
 		&dai_link->platform_of_node,					\
 		NULL, list_name, cells_name, NULL)
 int asoc_simple_card_parse_dai(struct device_node *node,
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index e7057be957e1..644cd62ba027 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -376,10 +376,15 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_init_dai);
 int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link)
 {
 	/* Assumes platform == cpu */
-	if (!dai_link->platform_of_node)
-		dai_link->platform_of_node = dai_link->cpu_of_node;
-
+	if (dai_link->platform) {
+		if (!dai_link->platform->of_node)
+			dai_link->platform->of_node = dai_link->cpu_of_node;
+	} else {
+		if (!dai_link->platform_of_node)
+			dai_link->platform_of_node = dai_link->cpu_of_node;
+	}
 	return 0;
+
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_canonicalize_dailink);
 
-- 
2.19.0.rc1
