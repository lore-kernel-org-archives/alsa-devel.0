From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH] asoc: bfin: use dev_err to print error log
	instead of dev_dbg
Date: Thu, 21 Jun 2012 13:51:58 -0400
Message-ID: <1340301118-3800-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C424103E5D
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 06:06:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, uclinux-dist-devel@blackfin.uclinux.org
Cc: Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/blackfin/bf6xx-sport.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf6xx-sport.c b/sound/soc/blackfin/bf6xx-sport.c
index f19a72b..318c5ba 100644
--- a/sound/soc/blackfin/bf6xx-sport.c
+++ b/sound/soc/blackfin/bf6xx-sport.c
@@ -256,9 +256,9 @@ static irqreturn_t sport_err_irq(int irq, void *dev_id)
 	struct device *dev = &sport->pdev->dev;
 
 	if (sport->tx_regs->spctl & SPORT_CTL_DERRPRI)
-		dev_dbg(dev, "sport error: TUVF\n");
+		dev_err(dev, "sport error: TUVF\n");
 	if (sport->rx_regs->spctl & SPORT_CTL_DERRPRI)
-		dev_dbg(dev, "sport error: ROVF\n");
+		dev_err(dev, "sport error: ROVF\n");
 
 	return IRQ_HANDLED;
 }
-- 
1.7.0.4
