From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_card_of_parse_widgets()" to the asoc tree
Date: Fri, 16 Jun 2017 18:50:16 +0100
Message-ID: <E1dLvNw-0005jt-8A@debutante>
References: <87injwiumx.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87injwiumx.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_card_of_parse_widgets()

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

>From b31f11d036e689ba9e60d581ffe8e032a6305da9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 16 Jun 2017 01:38:50 +0000
Subject: [PATCH] ASoC: simple-card-utils: add
 asoc_simple_card_of_parse_widgets()

Current simple card drivers are parsing widgets on each own driver
(only simple-card at this point, but will be supported on all drivers)
Encapsulation is one of simple card util's purpose.
Let's add asoc_simple_card_of_parse_widgets for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 ++
 sound/soc/generic/simple-card-utils.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 889c8ff86369..42c6a6ac3ce6 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -103,5 +103,7 @@ void asoc_simple_card_parse_convert(struct device *dev, char *prefix,
 int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
 				      char *prefix,
 				      int optional);
+int asoc_simple_card_of_parse_widgets(struct snd_soc_card *card,
+				      char *prefix);
 
 #endif /* __SIMPLE_CARD_UTILS_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index a2b6d95bc2f9..26d64fa40c9c 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -397,6 +397,25 @@ int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_of_parse_routing);
 
+int asoc_simple_card_of_parse_widgets(struct snd_soc_card *card,
+				      char *prefix)
+{
+	struct device_node *node = card->dev->of_node;
+	char prop[128];
+
+	if (!prefix)
+		prefix = "";
+
+	snprintf(prop, sizeof(prop), "%s%s", prefix, "widgets");
+
+	if (of_property_read_bool(node, prop))
+		return snd_soc_of_parse_audio_simple_widgets(card, prop);
+
+	/* no widgets is not error */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_of_parse_widgets);
+
 /* Module information */
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_DESCRIPTION("ALSA SoC Simple Card Utils");
-- 
2.11.0
