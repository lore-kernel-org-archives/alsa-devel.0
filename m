From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: add
	asoc_simple_card_get_conversion()" to the asoc tree
Date: Mon,  7 Jan 2019 12:31:15 +0000 (GMT)
Message-ID: <20190107123115.89AF11127490@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1724F267CD2
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:31:16 +0100 (CET)
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

   ASoC: simple-card: add asoc_simple_card_get_conversion()

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

>From 7e5e1f8bbaa82e6877d8bc121cb1b44cb1ce7ddf Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Dec 2018 10:46:42 +0900
Subject: [PATCH] ASoC: simple-card: add asoc_simple_card_get_conversion()

simple-card is now supporting normal sound and DPCM sound.
For DPCM sound, original sound card (= simple-scu-card) had been
supported 1 CPU : 1 Codec connection which uses hw_params_fixup()
for convert-rate/channel.
But, merged simple-card is completely forgeting about it.

To re-support 1 CPU : 1 Codec DPCM for hw_params_fixup(),
it need to judge whether it is DPCM by checking convert-rate/channel.
For this purpose, this patch adds asoc_simple_card_get_conversion()
as preparation

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 37e001cf9cd1..52048069b25a 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -165,6 +165,21 @@ static int asoc_simple_card_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
+static void asoc_simple_card_get_conversion(struct device *dev,
+					    struct device_node *np,
+					    struct asoc_simple_card_data *adata)
+{
+	struct device_node *top = dev->of_node;
+	struct device_node *node = of_get_parent(np);
+
+	asoc_simple_card_parse_convert(dev, top,  PREFIX, adata);
+	asoc_simple_card_parse_convert(dev, node, PREFIX, adata);
+	asoc_simple_card_parse_convert(dev, node, NULL,   adata);
+	asoc_simple_card_parse_convert(dev, np,   NULL,   adata);
+
+	of_node_put(node);
+}
+
 static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 					     struct device_node *node,
 					     struct device_node *np,
@@ -260,9 +275,7 @@ static int asoc_simple_card_dai_link_of_dpcm(struct device_node *top,
 					     "prefix");
 	}
 
-	asoc_simple_card_parse_convert(dev, top,  PREFIX, &dai_props->adata);
-	asoc_simple_card_parse_convert(dev, node, prefix, &dai_props->adata);
-	asoc_simple_card_parse_convert(dev, np,   NULL,   &dai_props->adata);
+	asoc_simple_card_get_conversion(dev, np, &dai_props->adata);
 
 	ret = asoc_simple_card_of_parse_tdm(np, dai);
 	if (ret)
-- 
2.20.1
