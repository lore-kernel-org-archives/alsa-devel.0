From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] ASoC: simple-card: fix simple_dai clk lookup
Date: Thu, 23 Mar 2017 15:05:26 +0100
Message-ID: <20170323140526.14699-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 1E9B826721E
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 15:05:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patchwork-lst@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The clock needs to be stored in the simple_dai structure, so it can
be enabled later on. This has been broken during the conversion to use
devm_* functions for the clk lookup.

Fixes: e984fd61e860 (ASoC: simple-card: use devm_get_clk_from_child())
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
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
