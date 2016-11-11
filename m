From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_prefix" to the asoc tree
Date: Fri, 11 Nov 2016 15:28:53 +0000
Message-ID: <E1c5Dl7-00029Y-Md@finisterre>
References: <87insr4c3i.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87insr4c3i.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_prefix

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

>From b6defcca0a604129155ae472b116a2e1688d8995 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Date: Fri, 11 Nov 2016 01:19:03 +0000
Subject: [PATCH] ASoC: soc-core: adjust for graph on
 snd_soc_of_parse_audio_prefix

It is assuming that the card related information is located on
"card" node, but graph case doesn't have it.
This patch adds node parameter to adjust for graph support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/sound/soc.h  | 6 +++++-
 sound/soc/soc-core.c | 9 ++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6dffa9540a30..346223b38e0d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1651,7 +1651,11 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *rx_mask,
 			      unsigned int *slots,
 			      unsigned int *slot_width);
-void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
+#define snd_soc_of_parse_audio_prefix(card, codec_conf, of_node, propname) \
+	snd_soc_of_parse_audio_prefix_from_node(card, NULL, codec_conf, \
+						of_node, propname)
+void snd_soc_of_parse_audio_prefix_from_node(struct snd_soc_card *card,
+				   struct device_node *np,
 				   struct snd_soc_codec_conf *codec_conf,
 				   struct device_node *of_node,
 				   const char *propname);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 81b604151f26..e4c90806fa10 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3595,15 +3595,18 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_tdm_slot);
 
-void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
+void snd_soc_of_parse_audio_prefix_from_node(struct snd_soc_card *card,
+				   struct device_node *np,
 				   struct snd_soc_codec_conf *codec_conf,
 				   struct device_node *of_node,
 				   const char *propname)
 {
-	struct device_node *np = card->dev->of_node;
 	const char *str;
 	int ret;
 
+	if (!np)
+		np = card->dev->of_node;
+
 	ret = of_property_read_string(np, propname, &str);
 	if (ret < 0) {
 		/* no prefix is not error */
@@ -3613,7 +3616,7 @@ void snd_soc_of_parse_audio_prefix(struct snd_soc_card *card,
 	codec_conf->of_node	= of_node;
 	codec_conf->name_prefix	= str;
 }
-EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_prefix);
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_prefix_from_node);
 
 int snd_soc_of_parse_audio_routing_from_node(struct snd_soc_card *card,
 				   struct device_node *np,
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
