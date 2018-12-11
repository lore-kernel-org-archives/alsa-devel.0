From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-scu-card: tidyup
	"convert-rate/channels" parsing" to the asoc tree
Date: Tue, 11 Dec 2018 20:36:47 +0000 (GMT)
Message-ID: <20181211203647.2C2D7112540E@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CC973267BDC
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 21:36:48 +0100 (CET)
In-Reply-To: 
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

   ASoC: simple-scu-card: tidyup "convert-rate/channels" parsing

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

>From 09ee833679761f4995daaa6fd6200c77b8fcdaef Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 11 Dec 2018 03:25:18 +0000
Subject: [PATCH] ASoC: simple-scu-card: tidyup "convert-rate/channels" parsing

simple-scu-card.c is supporting "convert-rate/channels" which is
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
 sound/soc/generic/simple-scu-card.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/generic/simple-scu-card.c b/sound/soc/generic/simple-scu-card.c
index 1c6382fa54a0..3c4e28995872 100644
--- a/sound/soc/generic/simple-scu-card.c
+++ b/sound/soc/generic/simple-scu-card.c
@@ -26,6 +26,7 @@ struct simple_card_data {
 		struct asoc_simple_dai dai;
 		struct snd_soc_dai_link_component codecs;
 		struct snd_soc_dai_link_component platform;
+		struct asoc_simple_card_data adata;
 	} *dai_props;
 	struct snd_soc_dai_link *dai_link;
 	struct asoc_simple_card_data adata;
@@ -86,7 +87,11 @@ static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					struct snd_pcm_hw_params *params)
 {
 	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct simple_dai_props *dai_props = simple_priv_to_props(priv, rtd->num);
 
+	asoc_simple_card_convert_fixup(&dai_props->adata, params);
+
+	/* overwrite by top level adata if exist */
 	asoc_simple_card_convert_fixup(&priv->adata, params);
 
 	return 0;
@@ -177,6 +182,8 @@ static int asoc_simple_card_dai_link_of(struct device_node *link,
 						     "prefix");
 	}
 
+	asoc_simple_card_parse_convert(dev, link, prefix, &dai_props->adata);
+
 	ret = asoc_simple_card_of_parse_tdm(np, &dai_props->dai);
 	if (ret)
 		return ret;
-- 
2.19.0.rc2
