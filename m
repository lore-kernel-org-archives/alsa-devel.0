From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: Export functions for
	threshold configuration
Date: Mon, 12 Mar 2012 13:01:04 +0200
Message-ID: <1331550064-28349-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id 3978624474
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 12:01:18 +0100 (CET)
Received: by mail-lpp01m010-f48.google.com with SMTP id u2so3533758lag.7
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 04:01:13 -0700 (PDT)
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

ABE has certain requirements towards the FIFO configuration in McBSP.
Make it posssible to configure the McBSP FIFO threshold from outside of
the McBSP driver stack.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

this patch is needed in preparation to add the ABE support for OMAP4+ platforms.

Regards,
Peter

 sound/soc/omap/mcbsp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index e5f4444..ca8b028 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -402,6 +402,7 @@ void omap_mcbsp_set_tx_threshold(struct omap_mcbsp *mcbsp, u16 threshold)
 	if (threshold && threshold <= mcbsp->max_tx_thres)
 		MCBSP_WRITE(mcbsp, THRSH2, threshold - 1);
 }
+EXPORT_SYMBOL_GPL(omap_mcbsp_set_tx_threshold);
 
 /*
  * omap_mcbsp_set_rx_threshold configures the receive threshold in words.
@@ -416,6 +417,7 @@ void omap_mcbsp_set_rx_threshold(struct omap_mcbsp *mcbsp, u16 threshold)
 	if (threshold && threshold <= mcbsp->max_rx_thres)
 		MCBSP_WRITE(mcbsp, THRSH1, threshold - 1);
 }
+EXPORT_SYMBOL_GPL(omap_mcbsp_set_rx_threshold);
 
 /*
  * omap_mcbsp_get_tx_delay returns the number of used slots in the McBSP FIFO
-- 
1.7.8.5
