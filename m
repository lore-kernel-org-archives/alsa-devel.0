From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add
	asoc_simple_card_init_dai()" to the asoc tree
Date: Tue, 09 Aug 2016 13:44:00 +0100
Message-ID: <E1bX6O0-0003Z2-Ge@debutante>
References: <87lh067b57.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A2B0267D07
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 14:44:07 +0200 (CEST)
In-Reply-To: <87lh067b57.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card-utils: add asoc_simple_card_init_dai()

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

>From 21ba62f849a20accf7d41e3056ea8913bc23cfb1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 9 Aug 2016 05:48:30 +0000
Subject: [PATCH] ASoC: simple-card-utils: add asoc_simple_card_init_dai()

simple-card is supporting clock/tdm slot initialization.
This patch makes this method simple style standard.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 ++
 sound/soc/generic/simple-card-utils.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 62b392695d2d..13168e029232 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -58,4 +58,6 @@ int asoc_simple_card_parse_dai(struct device_node *node,
 				  const char *cells_name,
 				  int *is_single_links);
 
+int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
+			      struct asoc_simple_dai *simple_dai);
 #endif /* __SIMPLE_CARD_CORE_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 27e6d038a902..33abe1f7014e 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -164,6 +164,35 @@ int asoc_simple_card_parse_dai(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_dai);
 
+int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
+			      struct asoc_simple_dai *simple_dai)
+{
+	int ret;
+
+	if (simple_dai->sysclk) {
+		ret = snd_soc_dai_set_sysclk(dai, 0, simple_dai->sysclk, 0);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dai->dev, "simple-card: set_sysclk error\n");
+			return ret;
+		}
+	}
+
+	if (simple_dai->slots) {
+		ret = snd_soc_dai_set_tdm_slot(dai,
+					       simple_dai->tx_slot_mask,
+					       simple_dai->rx_slot_mask,
+					       simple_dai->slots,
+					       simple_dai->slot_width);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(dai->dev, "simple-card: set_tdm_slot error\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_init_dai);
+
 /* Module information */
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_DESCRIPTION("ALSA SoC Simple Card Utils");
-- 
2.8.1
