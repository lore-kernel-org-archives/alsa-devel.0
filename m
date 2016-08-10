From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_card_canonicalize_cpu()" to the asoc tree
Date: Wed, 10 Aug 2016 21:03:58 +0100
Message-ID: <E1bXZjK-0000S6-Gd@debutante>
References: <871t1xid8e.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <871t1xid8e.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_card_canonicalize_cpu()

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

>From 983cebd602af8c2bf9d5830f15fb4e18fb38f994 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Aug 2016 02:20:19 +0000
Subject: [PATCH] ASoC: simple-card-utils: add
 asoc_simple_card_canonicalize_cpu()

simple-card needs remove dai_link->cpu_dai_name if it CPU was
single DAI.
This patch makes this method simple style standard.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 ++
 sound/soc/generic/simple-card-utils.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index a71d46a95ca8..f760f559393e 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -62,5 +62,7 @@ int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 			      struct asoc_simple_dai *simple_dai);
 
 int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link);
+void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
+				      int is_single_links);
 
 #endif /* __SIMPLE_CARD_CORE_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 189eadddfad3..c5d32dad48b2 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -206,6 +206,23 @@ int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link)
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_canonicalize_dailink);
 
+void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
+				       int is_single_links)
+{
+	/*
+	 * In soc_bind_dai_link() will check cpu name after
+	 * of_node matching if dai_link has cpu_dai_name.
+	 * but, it will never match if name was created by
+	 * fmt_single_name() remove cpu_dai_name if cpu_args
+	 * was 0. See:
+	 *	fmt_single_name()
+	 *	fmt_multiple_name()
+	 */
+	if (is_single_links)
+		dai_link->cpu_dai_name = NULL;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_canonicalize_cpu);
+
 /* Module information */
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_DESCRIPTION("ALSA SoC Simple Card Utils");
-- 
2.8.1
