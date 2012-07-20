From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 2/4] ASoC: mxs-saif: set a base clock rate for
	EXTMASTER mode work
Date: Fri, 20 Jul 2012 17:20:25 +0800
Message-ID: <1342776027-31758-3-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BC88260304
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 11:31:27 +0200 (CEST)
In-Reply-To: <1342776027-31758-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, shawn.guo@freescale.com, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Dong Aisheng <dong.aisheng@linaro.org>

Set an initial clock rate for the saif internal logic to work
properly. This is important when working in EXTMASTER mode that
uses the other saif's BITCLK&LRCLK but it still needs a basic
clock which should be fast enough for the internal logic.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 sound/soc/mxs/mxs-saif.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index fdbb36a..b303071 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -427,8 +427,22 @@ static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
 
 	/* prepare clk in hw_param, enable in trigger */
 	clk_prepare(saif->clk);
-	if (saif != master_saif)
+	if (saif != master_saif) {
+		/*
+		* Set an initial clock rate for the saif internal logic to work
+		* properly. This is important when working in EXTMASTER mode
+		* that uses the other saif's BITCLK&LRCLK but it still needs a
+		* basic clock which should be fast enough for the internal
+		* logic.
+		*/
+		clk_enable(saif->clk);
+		ret = clk_set_rate(saif->clk, 24000000);
+		clk_disable(saif->clk);
+		if (ret)
+			return ret;
+
 		clk_prepare(master_saif->clk);
+	}
 
 	scr = __raw_readl(saif->base + SAIF_CTRL);
 
-- 
1.7.0.4
