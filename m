From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: Configure wakeup in later
	phase
Date: Mon,  5 Mar 2012 11:36:05 +0200
Message-ID: <1330940165-16086-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 8804F103EE8
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 10:36:12 +0100 (CET)
Received: by mail-lpp01m010-f44.google.com with SMTP id j5so5440975lag.31
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 01:36:08 -0800 (PST)
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

Configure the WAKEUPEN register at the same time we configure the rest of
the McBSP registers.
In case of OMAP3+, if the sysclock has been reconfigured we are going to
disable McBSP for the duration of the clock change, which will reset the
McBSP registers. The WAKEUPEN register need to be configured later, so
the changes will be effective during runtime.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 5f6c21d..d716793 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -173,6 +173,9 @@ void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
 		MCBSP_WRITE(mcbsp, XCCR, config->xccr);
 		MCBSP_WRITE(mcbsp, RCCR, config->rccr);
 	}
+	/* Enable wakeup behavior */
+	if (mcbsp->pdata->has_wakeup)
+		MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
 }
 
 /**
@@ -479,10 +482,6 @@ int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(mcbsp->id - 1);
 
-	/* Enable wakeup behavior */
-	if (mcbsp->pdata->has_wakeup)
-		MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
-
 	/*
 	 * Make sure that transmitter, receiver and sample-rate generator are
 	 * not running before activating IRQs.
-- 
1.7.8.5
