From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: code sync: rename asoc_simple_card_priv" to the asoc tree
Date: Fri, 28 Oct 2016 19:48:50 +0100
Message-ID: <E1c0CCw-0005xG-0g@finisterre>
References: <87pomz4c69.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pomz4c69.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>Mark Brown <broonie@kernel.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Guennadi <g.liakhovetski@gmx.de>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: code sync: rename asoc_simple_card_priv

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

>From 6910e8679ff4d256028003be2451deb31f13948e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Oct 2016 03:37:44 +0000
Subject: [PATCH] ASoC: simple-scu-card: code sync: rename
 asoc_simple_card_priv

simple sound card family are using very similar style, but because of its
historical reason, there are small differences. For example pointer style,
function name, caller postion etc...
This patch synchronized simple card style to other simple card family

This patch renames asoc_simple_card_priv to simple_card_data,
same as other simple card family.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index b8d8437ef3dd..1704b187f6ee 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -22,7 +22,7 @@
 #include <sound/soc-dai.h>
 #include <sound/simple_card_utils.h>
 
-struct asoc_simple_card_priv {
+struct simple_card_data {
 	struct snd_soc_card snd_card;
 	struct snd_soc_codec_conf codec_conf;
 	struct asoc_simple_dai *dai_props;
@@ -42,7 +42,7 @@ struct asoc_simple_card_priv {
 static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct asoc_simple_card_priv *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct asoc_simple_dai *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
@@ -52,7 +52,7 @@ static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct asoc_simple_card_priv *priv =	snd_soc_card_get_drvdata(rtd->card);
+	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct asoc_simple_dai *dai_props =
 		simple_priv_to_props(priv, rtd->num);
 
@@ -66,7 +66,7 @@ static struct snd_soc_ops asoc_simple_card_ops = {
 
 static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct asoc_simple_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *dai;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_dai *dai_props;
@@ -84,7 +84,7 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					struct snd_pcm_hw_params *params)
 {
-	struct asoc_simple_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_interval *rate = hw_param_interval(params,
 						      SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
@@ -102,7 +102,7 @@ static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 }
 
 static int asoc_simple_card_dai_link_of(struct device_node *np,
-					struct asoc_simple_card_priv *priv,
+					struct simple_card_data *priv,
 					unsigned int daifmt,
 					int idx, bool is_fe)
 {
@@ -196,7 +196,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *np,
 }
 
 static int asoc_simple_card_parse_of(struct device_node *node,
-				     struct asoc_simple_card_priv *priv)
+				     struct simple_card_data *priv)
 
 {
 	struct device *dev = simple_priv_to_dev(priv);
@@ -253,7 +253,7 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
-	struct asoc_simple_card_priv *priv;
+	struct simple_card_data *priv;
 	struct snd_soc_dai_link *links;
 	struct asoc_simple_dai *props;
 	struct device *dev = &pdev->dev;
-- 
2.10.1
