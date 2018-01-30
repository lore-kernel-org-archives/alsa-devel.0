From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 3/7] ASoC: simple_card_utils: Set clock
	frequency
Date: Tue, 30 Jan 2018 12:08:45 +0100
Message-ID: <20180130110844.GD18123@lenoch>
References: <20180130110604.GA18123@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id A4D6B2671F2
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 12:08:46 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23994711AbeA3LIqR1yW0 (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Tue, 30 Jan 2018 12:08:46 +0100
Content-Disposition: inline
In-Reply-To: <20180130110604.GA18123@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/generic/simple-card-utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 3751a07de6aa..6b0cadc56933 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -185,6 +185,10 @@ int asoc_simple_card_parse_clk(struct device *dev,
 	 */
 	clk = devm_get_clk_from_child(dev, node, NULL);
 	if (!IS_ERR(clk)) {
+		if (!of_property_read_u32(node, "clock-frequency", &val)) {
+			if (clk_set_rate(clk, val))
+				dev_err(dev, "failed to set frequency %d\n", val);
+		}
 		simple_dai->sysclk = clk_get_rate(clk);
 
 		asoc_simple_card_clk_register(simple_dai, clk);
-- 
2.15.1
