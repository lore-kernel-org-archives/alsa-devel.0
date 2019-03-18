From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: rename
	simple_get_conversion() to simple_parse_convert()" to the asoc tree
Date: Mon, 18 Mar 2019 14:51:00 +0000 (GMT)
Message-ID: <20190318145100.D41A4112887B@debutante.sirena.org.uk>
References: <874l80ztkm.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51DC8F80792
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 15:51:02 +0100 (CET)
In-Reply-To: <874l80ztkm.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: rename simple_get_conversion() to simple_parse_convert()

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

>From cdc444721b0eea6817d1003add2f99414dc8028d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Mar 2019 13:50:08 +0900
Subject: [PATCH] ASoC: simple-card: rename simple_get_conversion() to
 simple_parse_convert()

use same naming rule

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 7147bba45a2a..5238c912cecd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -172,9 +172,9 @@ static int simple_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static void simple_get_conversion(struct device *dev,
-				  struct device_node *np,
-				  struct asoc_simple_card_data *adata)
+static void simple_parse_convert(struct device *dev,
+				 struct device_node *np,
+				 struct asoc_simple_card_data *adata)
 {
 	struct device_node *top = dev->of_node;
 	struct device_node *node = of_get_parent(np);
@@ -295,7 +295,7 @@ static int simple_dai_link_of_dpcm(struct simple_priv *priv,
 					     "prefix");
 	}
 
-	simple_get_conversion(dev, np, &dai_props->adata);
+	simple_parse_convert(dev, np, &dai_props->adata);
 
 	asoc_simple_card_canonicalize_platform(dai_link);
 
@@ -471,7 +471,7 @@ static int simple_for_each_link(struct simple_priv *priv,
 		/* get convert-xxx property */
 		memset(&adata, 0, sizeof(adata));
 		for_each_child_of_node(node, np)
-			simple_get_conversion(dev, np, &adata);
+			simple_parse_convert(dev, np, &adata);
 
 		/* loop for all CPU/Codec node */
 		for_each_child_of_node(node, np) {
-- 
2.20.1
