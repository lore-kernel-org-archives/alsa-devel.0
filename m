From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add
	asoc_simple_card_canonicalize_dailink()" to the asoc tree
Date: Tue, 09 Aug 2016 13:43:54 +0100
Message-ID: <E1bX6Nu-0003XF-MA@debutante>
References: <87h9au7b38.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3335A267CF6
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 14:44:01 +0200 (CEST)
In-Reply-To: <87h9au7b38.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_card_canonicalize_dailink()

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

>From c262c9ab7a956b15c4c12b81472502a587d0dfcd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 9 Aug 2016 05:49:41 +0000
Subject: [PATCH] ASoC: simple-card-utils: add
 asoc_simple_card_canonicalize_dailink()

simple-card is assuming that sometimes platform and cpu are same.
This patch makes this method simple style standard.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  3 +++
 sound/soc/generic/simple-card-utils.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 13168e029232..a71d46a95ca8 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -60,4 +60,7 @@ int asoc_simple_card_parse_dai(struct device_node *node,
 
 int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 			      struct asoc_simple_dai *simple_dai);
+
+int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link);
+
 #endif /* __SIMPLE_CARD_CORE_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 33abe1f7014e..189eadddfad3 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -193,6 +193,19 @@ int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_init_dai);
 
+int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link)
+{
+	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name)
+		return -EINVAL;
+
+	/* Assumes platform == cpu */
+	if (!dai_link->platform_of_node)
+		dai_link->platform_of_node = dai_link->cpu_of_node;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_canonicalize_dailink);
+
 /* Module information */
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_DESCRIPTION("ALSA SoC Simple Card Utils");
-- 
2.8.1
