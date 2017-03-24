From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: fix simple_dai clk lookup"
	to the asoc tree
Date: Fri, 24 Mar 2017 19:16:34 +0000
Message-ID: <E1crUhO-00066s-7j@debutante>
References: <20170323140526.14699-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D6D826756F
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 20:16:43 +0100 (CET)
In-Reply-To: <20170323140526.14699-1-l.stach@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: fix simple_dai clk lookup

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

>From 971edb0a0087b65bd3726d23b2dffff405d48f72 Mon Sep 17 00:00:00 2001
From: Lucas Stach <l.stach@pengutronix.de>
Date: Thu, 23 Mar 2017 15:05:26 +0100
Subject: [PATCH] ASoC: simple-card: fix simple_dai clk lookup

The clock needs to be stored in the simple_dai structure, so it can
be enabled later on. This has been broken during the conversion to use
devm_* functions for the clk lookup.

Fixes: e984fd61e860 (ASoC: simple-card: use devm_get_clk_from_child())
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 4924575d2e95..343b291fc372 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -115,6 +115,7 @@ int asoc_simple_card_parse_clk(struct device *dev,
 	clk = devm_get_clk_from_child(dev, node, NULL);
 	if (!IS_ERR(clk)) {
 		simple_dai->sysclk = clk_get_rate(clk);
+		simple_dai->clk = clk;
 	} else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
 		simple_dai->sysclk = val;
 	} else {
-- 
2.11.0
