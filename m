From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 1/4] ASoC: mxs-saif: fix clock prepare and
	enable unbalance issue
Date: Fri, 20 Jul 2012 17:20:24 +0800
Message-ID: <1342776027-31758-2-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 by alsa0.perex.cz (Postfix) with ESMTP id B5C262602AE
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 11:31:26 +0200 (CEST)
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

Currently we directly call a clock_enable in trigger function without
a clk_prepare as pair first.
This will cause system hang immediately when run capture because
the clock was not prepared(playback does not hang because the clock was
prepared already by get_mclk before), a warning message in clock framework
may cause a deadlock to reclaim clock lock (see: pl011_console_write).

Here we prepare clock first in hw_param, then enable it in trigger
function to guarantee the balance.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 sound/soc/mxs/mxs-saif.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index aba71bf..fdbb36a 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -394,9 +394,14 @@ static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
+	struct mxs_saif *master_saif;
 	u32 scr, stat;
 	int ret;
 
+	master_saif = mxs_saif_get_master(saif);
+	if (!master_saif)
+		return -EINVAL;
+
 	/* mclk should already be set */
 	if (!saif->mclk && saif->mclk_in_use) {
 		dev_err(cpu_dai->dev, "set mclk first\n");
@@ -420,6 +425,11 @@ static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* prepare clk in hw_param, enable in trigger */
+	clk_prepare(saif->clk);
+	if (saif != master_saif)
+		clk_prepare(master_saif->clk);
+
 	scr = __raw_readl(saif->base + SAIF_CTRL);
 
 	scr &= ~BM_SAIF_CTRL_WORD_LENGTH;
-- 
1.7.0.4
