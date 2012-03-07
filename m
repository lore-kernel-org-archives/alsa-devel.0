From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap McBSP: Clear rx_irq at probe time
	for OMAP4
Date: Wed,  7 Mar 2012 11:17:19 +0200
Message-ID: <1331111839-14778-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog127.obsmtp.com [74.125.149.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 19437103D34
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 10:17:40 +0100 (CET)
Received: by mail-lpp01m010-f52.google.com with SMTP id i5so12366245lah.39
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 01:17:39 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On OMAP4 we have one interrupt line per McBSP port.
At proble time tx, and rx irq value will be -ENXIO,
and only the tx irq will get corrected.
In omap_mcbsp_request if the rx_irq is not 0 we proceed,
and try to request the interrupt, which will fail on
OMAP4 (rx_irq == -6).
To avoid this error, clear the rx_irq at probe time
on OMAP4.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 21dbb05..c3e31de 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -958,8 +958,10 @@ int __devinit omap_mcbsp_init(struct platform_device *pdev)
 	mcbsp->rx_irq = platform_get_irq_byname(pdev, "rx");
 
 	/* From OMAP4 there will be a single irq line */
-	if (mcbsp->tx_irq == -ENXIO)
+	if (mcbsp->tx_irq == -ENXIO) {
 		mcbsp->tx_irq = platform_get_irq(pdev, 0);
+		mcbsp->rx_irq = 0;
+	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
 	if (!res) {
-- 
1.7.8.5
