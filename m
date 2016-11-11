From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_simple_widgets" to the asoc tree
Date: Fri, 11 Nov 2016 15:28:41 +0000
Message-ID: <E1c5Dkv-00027M-Cb@finisterre>
References: <87lgxn4c4k.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87lgxn4c4k.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>Mark Brown <broonie@kernel.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Guennadi <g.liakhovetski@gmx.de>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_simple_widgets

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

>From 1ef5bcd57be5c8b31286b7b47828064be25f266b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2016 01:18:08 +0000
Subject: [PATCH] ASoC: soc-core: adjust for graph on
 snd_soc_of_parse_audio_simple_widgets

It is assuming that the card related information is located on
"card" node, but graph case doesn't have it.
This patch adds node parameter to adjust for graph support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 8 ++++++--
 sound/soc/soc-core.c | 9 ++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8457aab9eab0..77b01c45ee8d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1647,8 +1647,12 @@ void snd_soc_util_exit(void);
 int snd_soc_of_parse_card_name_from_node(struct snd_soc_card *card,
 					 struct device_node *np,
 					 const char *propname);
-int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
-					  const char *propname);
+#define snd_soc_of_parse_audio_simple_widgets(card, propname)\
+	snd_soc_of_parse_audio_simple_widgets_from_node(card, NULL, propname)
+int snd_soc_of_parse_audio_simple_widgets_from_node(struct snd_soc_card *card,
+						    struct device_node *np,
+						    const char *propname);
+
 int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			      unsigned int *tx_mask,
 			      unsigned int *rx_mask,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 17132fb57930..6f911f4d413a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3462,14 +3462,17 @@ static const struct snd_soc_dapm_widget simple_widgets[] = {
 	SND_SOC_DAPM_SPK("Speaker", NULL),
 };
 
-int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
+int snd_soc_of_parse_audio_simple_widgets_from_node(struct snd_soc_card *card,
+					  struct device_node *np,
 					  const char *propname)
 {
-	struct device_node *np = card->dev->of_node;
 	struct snd_soc_dapm_widget *widgets;
 	const char *template, *wname;
 	int i, j, num_widgets, ret;
 
+	if (!np)
+		np = card->dev->of_node;
+
 	num_widgets = of_property_count_strings(np, propname);
 	if (num_widgets < 0) {
 		dev_err(card->dev,
@@ -3540,7 +3543,7 @@ int snd_soc_of_parse_audio_simple_widgets(struct snd_soc_card *card,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets);
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_audio_simple_widgets_from_node);
 
 static int snd_soc_of_get_slot_mask(struct device_node *np,
 				    const char *prop_name,
-- 
2.10.2
