From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_card_clean_reference()" to the asoc tree
Date: Wed, 10 Aug 2016 21:03:49 +0100
Message-ID: <E1bXZjB-0000PH-7V@debutante>
References: <87wpjpgylx.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87wpjpgylx.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_card_clean_reference()

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

>From 0f4e0711b735a148cb6da0e6f91253b62fc2c5b2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Aug 2016 02:21:25 +0000
Subject: [PATCH] ASoC: simple-card-utils: add
 asoc_simple_card_clean_reference()

simple-card needs to decrease the reference count of the device nodes.
This patch makes this method simple style standard.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 ++
 sound/soc/generic/simple-card-utils.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index f760f559393e..403ec92164fc 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -65,4 +65,6 @@ int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link);
 void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
 				      int is_single_links);
 
+int asoc_simple_card_clean_reference(struct snd_soc_card *card);
+
 #endif /* __SIMPLE_CARD_CORE_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index c5d32dad48b2..1cb39309f5d5 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -223,6 +223,21 @@ void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_canonicalize_cpu);
 
+int asoc_simple_card_clean_reference(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *dai_link;
+	int num_links;
+
+	for (num_links = 0, dai_link = card->dai_link;
+	     num_links < card->num_links;
+	     num_links++, dai_link++) {
+		of_node_put(dai_link->cpu_of_node);
+		of_node_put(dai_link->codec_of_node);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_clean_reference);
+
 /* Module information */
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_DESCRIPTION("ALSA SoC Simple Card Utils");
-- 
2.8.1
