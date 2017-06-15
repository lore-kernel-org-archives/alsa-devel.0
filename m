From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_card_convert_fixup()" to the asoc tree
Date: Thu, 15 Jun 2017 18:20:52 +0100
Message-ID: <E1dLYRw-0001jx-LV@debutante>
References: <871sqmnlwa.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <871sqmnlwa.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_card_convert_fixup()

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

>From 13bb1cc0ad205b2aeeb8d2ea5c790a396135283d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Jun 2017 00:24:09 +0000
Subject: [PATCH] ASoC: simple-card-utils: add asoc_simple_card_convert_fixup()

Current simple/audio scu card drivers are supporting same
convert-rate/convert-channels on DT, but doesn't use same function
for it.
Encapsulation is one of simple card util's purpose.
Let's add asoc_simple_card_parse_convert/asoc_simple_card_convert_fixup

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     | 10 +++++++++
 sound/soc/generic/simple-card-utils.c | 40 +++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 2679312228b3..cc318ccd6a2d 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -22,6 +22,11 @@ struct asoc_simple_dai {
 	struct clk *clk;
 };
 
+struct asoc_simple_card_data {
+	u32 convert_rate;
+	u32 convert_channels;
+};
+
 int asoc_simple_card_parse_daifmt(struct device *dev,
 				  struct device_node *node,
 				  struct device_node *codec,
@@ -90,4 +95,9 @@ void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
 
 int asoc_simple_card_clean_reference(struct snd_soc_card *card);
 
+void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
+				      struct snd_pcm_hw_params *params);
+void asoc_simple_card_parse_convert(struct device *dev, char *prefix,
+				    struct asoc_simple_card_data *data);
+
 #endif /* __SIMPLE_CARD_UTILS_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 2ad7633292bf..948a18842e64 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -13,6 +13,46 @@
 #include <linux/of_graph.h>
 #include <sound/simple_card_utils.h>
 
+void asoc_simple_card_convert_fixup(struct asoc_simple_card_data *data,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	if (data->convert_rate)
+		rate->min =
+		rate->max = data->convert_rate;
+
+	if (data->convert_channels)
+		channels->min =
+		channels->max = data->convert_channels;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_convert_fixup);
+
+void asoc_simple_card_parse_convert(struct device *dev, char *prefix,
+				    struct asoc_simple_card_data *data)
+{
+	struct device_node *np = dev->of_node;
+	char prop[128];
+
+	if (!prefix)
+		prefix = "";
+
+	/* sampling rate convert */
+	snprintf(prop, sizeof(prop), "%s%s", prefix, "convert-rate");
+	of_property_read_u32(np, prop, &data->convert_rate);
+
+	/* channels transfer */
+	snprintf(prop, sizeof(prop), "%s%s", prefix, "convert-channels");
+	of_property_read_u32(np, prop, &data->convert_channels);
+
+	dev_dbg(dev, "convert_rate     %d\n", data->convert_rate);
+	dev_dbg(dev, "convert_channels %d\n", data->convert_channels);
+}
+EXPORT_SYMBOL_GPL(asoc_simple_card_parse_convert);
+
 int asoc_simple_card_parse_daifmt(struct device *dev,
 				  struct device_node *node,
 				  struct device_node *codec,
-- 
2.11.0
