From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 1/4] ASoC: simple-card-utils: remove
 asoc_simple_card_clk_register()
Date: Wed, 21 Nov 2018 02:08:59 +0000
Message-ID: <87va4rp4vj.wl-kuninori.morimoto.gx@renesas.com>
References: <87wop7p4wk.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410138.outbound.protection.outlook.com [40.107.141.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 6353526796E
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 03:09:07 +0100 (CET)
In-Reply-To: <87wop7p4wk.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <35C5A329CF7ED4458EC5262DB46F4FC5@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

asoc_simple_card_clk_register() is used but only 1 user,
and very pointless code. Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/simple-card-utils.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index a191d59..dcac45dad 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -151,12 +151,6 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
 
-static void asoc_simple_card_clk_register(struct asoc_simple_dai *dai,
-					  struct clk *clk)
-{
-	dai->clk = clk;
-}
-
 int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
 {
 	return clk_prepare_enable(dai->clk);
@@ -200,7 +194,7 @@ int asoc_simple_card_parse_clk(struct device *dev,
 	if (!IS_ERR(clk)) {
 		simple_dai->sysclk = clk_get_rate(clk);
 
-		asoc_simple_card_clk_register(simple_dai, clk);
+		simple_dai->clk = clk;
 	} else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
 		simple_dai->sysclk = val;
 	} else {
-- 
2.7.4
