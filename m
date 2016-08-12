From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: Enable TX/RX under and
	overflow interrupts
Date: Fri, 12 Aug 2016 13:52:10 +0300
Message-ID: <20160812105210.15075-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [198.47.19.11])
 by alsa0.perex.cz (Postfix) with ESMTP id A66B8265B61
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 12:52:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, liam.r.girdwood@linux.intel.com, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org, akramh@aq1systems.com
List-Id: alsa-devel@alsa-project.org

FIFO under or overflow can cause channel swaps and data loss. Reporting
them can help to identify such events.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 76ce33199bf9..06fec5699cc8 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -221,7 +221,8 @@ void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
 
 	/* Enable TX/RX sync error interrupts by default */
 	if (mcbsp->irq)
-		MCBSP_WRITE(mcbsp, IRQEN, RSYNCERREN | XSYNCERREN);
+		MCBSP_WRITE(mcbsp, IRQEN, RSYNCERREN | XSYNCERREN |
+			    RUNDFLEN | ROVFLEN | XUNDFLEN | XOVFLEN);
 }
 
 /**
-- 
2.9.2
