From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: add convert channels
	support" to the asoc tree
Date: Sat, 05 Mar 2016 21:24:55 +0900
Message-ID: <E1acBGR-0003HY-7x@finisterre>
References: <874mcx734l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 90EFD261481
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:24:58 +0100 (CET)
In-Reply-To: <874mcx734l.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: add convert channels support

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

>From f90432fc6ec41c5bb1d7b75edc1f2bc58799ece3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Feb 2016 05:51:44 +0000
Subject: [PATCH] ASoC: rsrc-card: add convert channels support

Renesas sound device has CTU (= Channel Transfer Unit), and
sound card needs its support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/renesas,rsrc-card.txt           |  1 +
 sound/soc/sh/rcar/rsrc-card.c                      | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
index 2b2caa281ce3..5abebf7898d9 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
@@ -30,6 +30,7 @@ Optional subnode properties:
 - frame-inversion			: bool property. Add this if the
 					  dai-link uses frame clock inversion.
 - convert-rate				: platform specified sampling rate convert
+- convert-channels			: platform specified channel size convert
 - audio-prefix				: see audio-routing
 - audio-routing				: A list of the connections between audio components.
 					  Each entry is a pair of strings, the first being the connection's sink,
diff --git a/sound/soc/sh/rcar/rsrc-card.c b/sound/soc/sh/rcar/rsrc-card.c
index 545e94245e62..1bc7ecfc42a9 100644
--- a/sound/soc/sh/rcar/rsrc-card.c
+++ b/sound/soc/sh/rcar/rsrc-card.c
@@ -66,6 +66,7 @@ struct rsrc_card_priv {
 	struct snd_soc_dai_link *dai_link;
 	int dai_num;
 	u32 convert_rate;
+	u32 convert_channels;
 };
 
 #define rsrc_priv_to_dev(priv) ((priv)->snd_card.dev)
@@ -144,11 +145,16 @@ static int rsrc_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	struct rsrc_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_interval *rate = hw_param_interval(params,
 						      SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
 
-	if (!priv->convert_rate)
-		return 0;
+	if (priv->convert_rate)
+		rate->min =
+		rate->max = priv->convert_rate;
 
-	rate->min = rate->max = priv->convert_rate;
+	if (priv->convert_channels)
+		channels->min =
+		channels->max = priv->convert_channels;
 
 	return 0;
 }
@@ -436,9 +442,13 @@ static int rsrc_card_parse_of(struct device_node *node,
 	/* sampling rate convert */
 	of_property_read_u32(node, "convert-rate", &priv->convert_rate);
 
-	dev_dbg(dev, "New rsrc-audio-card: %s (%d)\n",
-		priv->snd_card.name ? priv->snd_card.name : "",
-		priv->convert_rate);
+	/* channels transfer */
+	of_property_read_u32(node, "convert-channels", &priv->convert_channels);
+
+	dev_dbg(dev, "New rsrc-audio-card: %s\n",
+		priv->snd_card.name ? priv->snd_card.name : "");
+	dev_dbg(dev, "SRC : convert_rate     %d\n", priv->convert_rate);
+	dev_dbg(dev, "CTU : convert_channels %d\n", priv->convert_channels);
 
 	ret = rsrc_card_dai_link_of(node, priv);
 	if (ret < 0)
-- 
2.7.0
