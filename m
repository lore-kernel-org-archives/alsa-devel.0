From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use common PREFIX for each DT property" to the asoc tree
Date: Mon, 13 Jun 2016 16:47:51 +0100
Message-ID: <E1bCU5f-000315-5F@finisterre>
References: <87d1o2sj6z.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87d1o2sj6z.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use common PREFIX for each DT property

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

>From 548563fa3e430ce61db79aa11331da6e5f535a3b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 31 May 2016 08:59:01 +0000
Subject: [PATCH] ASoC: simple-card: use common PREFIX for each DT property

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 4e39c0fa78c9..b6e6d9a12ec2 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -40,6 +40,8 @@ struct simple_card_data {
 #define simple_priv_to_link(priv, i) ((priv)->snd_card.dai_link + i)
 #define simple_priv_to_props(priv, i) ((priv)->dai_props + i)
 
+#define PREFIX	"simple-audio-card,"
+
 static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -344,7 +346,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 
 	/* For single DAI link & old style of DT node */
 	if (is_top_level_node)
-		prefix = "simple-audio-card,";
+		prefix = PREFIX;
 
 	snprintf(prop, sizeof(prop), "%scpu", prefix);
 	cpu = of_get_child_by_name(node, prop);
@@ -453,26 +455,26 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		return -EINVAL;
 
 	/* Parse the card name from DT */
-	snd_soc_of_parse_card_name(&priv->snd_card, "simple-audio-card,name");
+	snd_soc_of_parse_card_name(&priv->snd_card, PREFIX "name");
 
 	/* The off-codec widgets */
-	if (of_property_read_bool(node, "simple-audio-card,widgets")) {
+	if (of_property_read_bool(node, PREFIX "widgets")) {
 		ret = snd_soc_of_parse_audio_simple_widgets(&priv->snd_card,
-					"simple-audio-card,widgets");
+					PREFIX "widgets");
 		if (ret)
 			return ret;
 	}
 
 	/* DAPM routes */
-	if (of_property_read_bool(node, "simple-audio-card,routing")) {
+	if (of_property_read_bool(node, PREFIX "routing")) {
 		ret = snd_soc_of_parse_audio_routing(&priv->snd_card,
-					"simple-audio-card,routing");
+					PREFIX "routing");
 		if (ret)
 			return ret;
 	}
 
 	/* Factor to mclk, used in hw_params() */
-	ret = of_property_read_u32(node, "simple-audio-card,mclk-fs", &val);
+	ret = of_property_read_u32(node, PREFIX "mclk-fs", &val);
 	if (ret == 0)
 		priv->mclk_fs = val;
 
@@ -480,7 +482,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 		priv->snd_card.name : "");
 
 	/* Single/Muti DAI link(s) & New style of DT node */
-	if (of_get_child_by_name(node, "simple-audio-card,dai-link")) {
+	if (of_get_child_by_name(node, PREFIX "dai-link")) {
 		struct device_node *np = NULL;
 		int i = 0;
 
@@ -502,13 +504,13 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 	}
 
 	priv->gpio_hp_det = of_get_named_gpio_flags(node,
-				"simple-audio-card,hp-det-gpio", 0, &flags);
+				PREFIX "hp-det-gpio", 0, &flags);
 	priv->gpio_hp_det_invert = !!(flags & OF_GPIO_ACTIVE_LOW);
 	if (priv->gpio_hp_det == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
 	priv->gpio_mic_det = of_get_named_gpio_flags(node,
-				"simple-audio-card,mic-det-gpio", 0, &flags);
+				PREFIX "mic-det-gpio", 0, &flags);
 	priv->gpio_mic_det_invert = !!(flags & OF_GPIO_ACTIVE_LOW);
 	if (priv->gpio_mic_det == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
@@ -543,7 +545,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	int num_links, ret;
 
 	/* Get the number of DAI links */
-	if (np && of_get_child_by_name(np, "simple-audio-card,dai-link"))
+	if (np && of_get_child_by_name(np, PREFIX "dai-link"))
 		num_links = of_get_child_count(np);
 	else
 		num_links = 1;
-- 
2.8.1
