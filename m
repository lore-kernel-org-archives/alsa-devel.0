From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: soc-core: adjust for graph on snd_soc_of_parse_card_name" to the asoc tree
Date: Fri, 11 Nov 2016 15:28:48 +0000
Message-ID: <E1c5Dl2-00028V-KU@finisterre>
References: <87mvi34c51.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87mvi34c51.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: adjust for graph on snd_soc_of_parse_card_name

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

>From 8f5ebb1bee15b5720741a98414767bb86f6c2b23 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Date: Fri, 11 Nov 2016 01:17:27 +0000
Subject: [PATCH] ASoC: soc-core: adjust for graph on
 snd_soc_of_parse_card_name

It is assuming that the card related information is located on
"card" node, but graph case doesn't have it.
This patch adds node parameter to adjust for graph support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/sound/soc.h  |  7 +++++--
 sound/soc/soc-core.c | 11 ++++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 346223b38e0d..8457aab9eab0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1642,8 +1642,11 @@ static inline struct snd_soc_platform *snd_soc_kcontrol_platform(
 int snd_soc_util_init(void);
 void snd_soc_util_exit(void);
 
-int snd_soc_of_parse_card_name(struct snd_soc_card *card,
-			       const char *propname);
+#define snd_soc_of_parse_card_name(card, propname) \
+	snd_soc_of_parse_card_name_from_node(card, NULL, propname)
+int snd_soc_of_parse_card_name_from_node(struct snd_soc_card *card,
+					 struct device_node *np,
+					 const char *propname);
 int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 					  const char *propname);
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e4c90806fa10..17132fb57930 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3424,10 +3424,10 @@ void snd_soc_unregister_codec(struct device *dev)
 EXPORT_SYMBOL_GPL(snd_soc_unregister_codec);
 
 /* Retrieve a card's name from device tree */
-int snd_soc_of_parse_card_name(struct snd_soc_card *card,
-			       const char *propname)
+int snd_soc_of_parse_card_name_from_node(struct snd_soc_card *card,
+					 struct device_node *np,
+					 const char *propname)
 {
-	struct device_node *np;
 	int ret;
 
 	if (!card->dev) {
@@ -3435,7 +3435,8 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 		return -EINVAL;
 	}
 
-	np = card->dev->of_node;
+	if (!np)
+		np = card->dev->of_node;
 
 	ret = of_property_read_string_index(np, propname, 0, &card->name);
 	/*
@@ -3452,7 +3453,7 @@ int snd_soc_of_parse_card_name(struct snd_soc_card *card,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_of_parse_card_name);
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_card_name_from_node);
 
 static const struct snd_soc_dapm_widget simple_widgets[] = {
 	SND_SOC_DAPM_MIC("Microphone", NULL),
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
