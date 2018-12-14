From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: tidyup
	convert_rate/channel method" to the asoc tree
Date: Fri, 14 Dec 2018 12:37:28 +0000 (GMT)
Message-ID: <20181214123728.48A7911258A1@debutante.sirena.org.uk>
References: <877egc9751.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C3554267AA7
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:37:28 +0100 (CET)
In-Reply-To: <877egc9751.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card: tidyup convert_rate/channel method

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

>From dd82410f7e939f00591c415d62915a89ac2fb8f0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 14 Dec 2018 11:35:20 +0900
Subject: [PATCH] ASoC: simple-card: tidyup convert_rate/channel method

Current simple-card is handling "convert_rate/channel"
by many ways. But, it is not useful and readable.
We want to do is that allow having it everywere.
This patch support it.
It will be overwrote if lower node has it.

sound {
	simple-audio-card,convert_channels = <xxx>; // initial

	simple-audio-card,dai-link {
		convert_channels = <xxx>; // overwrite
		cpu {
			convert_channels = <xxx>; // overwrite
		};
		codec {
			convert_channels = <xxx>; // overwrite
		};
	};
};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 8593d51e0c6c..fb18e5148aad 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -30,7 +30,6 @@ struct simple_card_data {
 	struct asoc_simple_jack mic_jack;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_dai *dais;
-	struct asoc_simple_card_data adata;
 	struct snd_soc_codec_conf *codec_conf;
 };
 
@@ -163,9 +162,6 @@ static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	asoc_simple_card_convert_fixup(&dai_props->adata, params);
 
-	/* overwrite by top level adata if exist */
-	asoc_simple_card_convert_fixup(&priv->adata, params);
-
 	return 0;
 }
 
@@ -267,7 +263,9 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 						     "prefix");
 	}
 
+	asoc_simple_card_parse_convert(dev, top,  PREFIX, &dai_props->adata);
 	asoc_simple_card_parse_convert(dev, node, prefix, &dai_props->adata);
+	asoc_simple_card_parse_convert(dev, np,   NULL,   &dai_props->adata);
 
 	ret = asoc_simple_card_of_parse_tdm(np, dai);
 	if (ret)
@@ -460,8 +458,6 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	if (ret < 0)
 		return ret;
 
-	asoc_simple_card_parse_convert(dev, top, PREFIX, &priv->adata);
-
 	/* Single/Muti DAI link(s) & New style of DT node */
 	loop		= 1;
 	link_idx	= 0;
-- 
2.19.0.rc2
