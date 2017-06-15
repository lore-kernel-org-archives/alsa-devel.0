From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: use asoc_simple_card_convert_fixup()" to the asoc tree
Date: Thu, 15 Jun 2017 18:20:48 +0100
Message-ID: <E1dLYRs-0001j6-Dl@debutante>
References: <87zidam7bb.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87zidam7bb.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-scu-card: use asoc_simple_card_convert_fixup()

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

>From cd8957f588397498c12b258da9044b52598c9527 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Jun 2017 00:24:28 +0000
Subject: [PATCH] ASoC: simple-scu-card: use asoc_simple_card_convert_fixup()

Current simple/audio scu card drivers are supporting same
convert-rate/convert-channels on DT, but, doesn't use same function
for it.
Encapsulation is one of simple card util's purpose.
Let's use asoc_simple_card_parse_convert/asoc_simple_card_convert_fixup

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-scu-card.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 938f3f30eef1..44da69101097 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -27,8 +27,7 @@ struct simple_card_data {
 	struct snd_soc_codec_conf codec_conf;
 	struct asoc_simple_dai *dai_props;
 	struct snd_soc_dai_link *dai_link;
-	u32 convert_rate;
-	u32 convert_channels;
+	struct asoc_simple_card_data adata;
 };
 
 #define simple_priv_to_card(priv) (&(priv)->snd_card)
@@ -86,18 +85,8 @@ static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					struct snd_pcm_hw_params *params)
 {
 	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_interval *rate = hw_param_interval(params,
-						      SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels = hw_param_interval(params,
-						SNDRV_PCM_HW_PARAM_CHANNELS);
 
-	if (priv->convert_rate)
-		rate->min =
-		rate->max = priv->convert_rate;
-
-	if (priv->convert_channels)
-		channels->min =
-		channels->max = priv->convert_channels;
+	asoc_simple_card_convert_fixup(&priv->adata, params);
 
 	return 0;
 }
@@ -206,11 +195,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	/* sampling rate convert */
-	of_property_read_u32(node, PREFIX "convert-rate", &priv->convert_rate);
-
-	/* channels transfer */
-	of_property_read_u32(node, PREFIX "convert-channels", &priv->convert_channels);
+	asoc_simple_card_parse_convert(dev, PREFIX, &priv->adata);
 
 	/* find 1st codec */
 	np = of_get_child_by_name(node, PREFIX "codec");
@@ -237,9 +222,6 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(dev, "convert_rate     %d\n", priv->convert_rate);
-	dev_dbg(dev, "convert_channels %d\n", priv->convert_channels);
-
 	return 0;
 }
 
-- 
2.11.0
