From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_card_of_parse_routing()" to the asoc tree
Date: Thu, 15 Jun 2017 18:20:42 +0100
Message-ID: <E1dLYRm-0001hN-C0@debutante>
References: <87wp8em7ae.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87wp8em7ae.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_card_of_parse_routing()

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

>From 3296d07826ebc698113832acb426f037e9b3b253 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Jun 2017 00:25:02 +0000
Subject: [PATCH] ASoC: simple-card-utils: add
 asoc_simple_card_of_parse_routing()

Current simple card drivers are parsing routing on each own driver.
Encapsulation is one of simple card util's purpose.
Let's add asoc_simple_card_of_parse_routing for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  4 ++++
 sound/soc/generic/simple-card-utils.c | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index cc318ccd6a2d..889c8ff86369 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -100,4 +100,8 @@ void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
 void asoc_simple_card_parse_convert(struct device *dev, char *prefix,
 				    struct asoc_simple_card_data *data);
 
+int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
+				      char *prefix,
+				      int optional);
+
 #endif /* __SIMPLE_CARD_UTILS_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 948a18842e64..a2b6d95bc2f9 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -375,6 +375,28 @@ int asoc_simple_card_clean_reference(struct snd_soc_card *card)
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_clean_reference);
 
+int asoc_simple_card_of_parse_routing(struct snd_soc_card *card,
+				      char *prefix,
+				      int optional)
+{
+	struct device_node *node = card->dev->of_node;
+	char prop[128];
+
+	if (!prefix)
+		prefix = "";
+
+	snprintf(prop, sizeof(prop), "%s%s", prefix, "routing");
+
+	if (!of_property_read_bool(node, prop)) {
+		if (optional)
+			return 0;
+		return -EINVAL;
+	}
+
+	return snd_soc_of_parse_audio_routing(card, prop);
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_of_parse_routing);
+
 /* Module information */
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_DESCRIPTION("ALSA SoC Simple Card Utils");
-- 
2.11.0
