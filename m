From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_card_parse_card_name()" to the asoc tree
Date: Sat, 16 Jul 2016 13:04:20 +0100
Message-ID: <E1bOOKS-0004u1-Uk@debutante>
References: <87shvnlgrh.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87shvnlgrh.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_card_parse_card_name()

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

>From fc55c9b5a2ea794c4b6be937522bcfe98be4770a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jul 2016 23:59:16 +0000
Subject: [PATCH] ASoC: simple-card-utils: add
 asoc_simple_card_parse_card_name()

simple-card needs to get its card name.
This patch makes this method simple style standard.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 ++
 sound/soc/generic/simple-card-utils.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index b88a8dcfe4ba..86088aed9002 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -30,5 +30,7 @@ int asoc_simple_card_parse_daifmt(struct device *dev,
 int asoc_simple_card_set_dailink_name(struct device *dev,
 				      struct snd_soc_dai_link *dai_link,
 				      const char *fmt, ...);
+int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
+				     char *prefix);
 
 #endif /* __SIMPLE_CARD_CORE_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 48c73660b66a..d89a9a1b2471 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -75,3 +75,23 @@ int asoc_simple_card_set_dailink_name(struct device *dev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_set_dailink_name);
+
+int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
+				     char *prefix)
+{
+	char prop[128];
+	int ret;
+
+	snprintf(prop, sizeof(prop), "%sname", prefix);
+
+	/* Parse the card name from DT */
+	ret = snd_soc_of_parse_card_name(card, prop);
+	if (ret < 0)
+		return ret;
+
+	if (!card->name && card->dai_link)
+		card->name = card->dai_link->name;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
-- 
2.8.1
