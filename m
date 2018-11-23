From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: audio-graph-scu-card: tidyup
	"convert-rate/channels" parsing" to the asoc tree
Date: Fri, 23 Nov 2018 14:11:57 +0000 (GMT)
Message-ID: <20181123141157.BE24A440078@finisterre.ee.mobilebroadband>
References: <87r2felyz9.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CE65C267972
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:11:59 +0100 (CET)
In-Reply-To: <87r2felyz9.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: audio-graph-scu-card: tidyup "convert-rate/channels" parsing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7f07a39acf0591fd3823abc1af3c5456e708b77e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Nov 2018 00:56:53 +0000
Subject: [PATCH] ASoC: audio-graph-scu-card: tidyup "convert-rate/channels"
 parsing

audio-graph-scu-card.c is supporting "convert-rate/channels" which is
used for DPCM.
But, sound card might have multi codecs, and each codec might need
each convert-rate/channels.

This patch supports each codec's convert-rate/channles support.
top node convert-rate/channels will overwrite settings if exist.

It can't support each codec's convert-rate/channels if sound card had
multi codecs without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-scu-card.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
index fdc61f1c1d79..0f13f11e0d88 100644
--- a/sound/soc/generic/audio-graph-scu-card.c
+++ b/sound/soc/generic/audio-graph-scu-card.c
@@ -29,6 +29,7 @@ struct graph_card_data {
 		struct asoc_simple_dai dai;
 		struct snd_soc_dai_link_component codecs;
 		struct snd_soc_dai_link_component platform;
+		struct asoc_simple_card_data adata;
 	} *dai_props;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_card_data adata;
@@ -85,7 +86,11 @@ static int asoc_graph_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					       struct snd_pcm_hw_params *params)
 {
 	struct graph_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct graph_dai_props *dai_props = graph_priv_to_props(priv, rtd->num);
+
+	asoc_simple_card_convert_fixup(&dai_props->adata, params);
 
+	/* overwrite by top level adata if exist */
 	asoc_simple_card_convert_fixup(&priv->adata, params);
 
 	return 0;
@@ -170,6 +175,8 @@ static int asoc_graph_card_dai_link_of(struct device_node *ep,
 						     PREFIX "prefix");
 	}
 
+	asoc_simple_card_parse_convert(dev, node, PREFIX, &dai_props->adata);
+
 	ret = asoc_simple_card_of_parse_tdm(ep, &dai_props->dai);
 	if (ret)
 		return ret;
-- 
2.19.1
