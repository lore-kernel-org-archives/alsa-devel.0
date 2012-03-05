From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: When closing the port select
	PRCM source for CLKS signal
Date: Mon,  5 Mar 2012 11:38:52 +0200
Message-ID: <1330940332-16188-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog132.obsmtp.com [74.125.149.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 03005103F12
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 10:38:54 +0100 (CET)
Received: by mail-lpp01m010-f51.google.com with SMTP id p9so69667laa.24
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 01:38:53 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

If external source for the CLKS signal selection kept after the port is no
longer in use the system might refuse to go suspend.
There is also a chance that the external clock is not running when next
time the McBSP port is started which can result errors when we try to
access McBSP registers.
Reset the CLKS source back to PRCM source unconditionally.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index d716793..21dbb05 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -548,6 +548,16 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
 
 	reg_cache = mcbsp->reg_cache;
 
+	/*
+	 * Select CLKS source from internal source unconditionally before
+	 * marking the McBSP port as free.
+	 * If the external clock source via MCBSP_CLKS pin has been selected the
+	 * system will refuse to enter idle if the CLKS pin source is not reset
+	 * back to internal source.
+	 */
+	if (!cpu_class_is_omap1())
+		omap2_mcbsp_set_clks_src(mcbsp, MCBSP_CLKS_PRCM_SRC);
+
 	spin_lock(&mcbsp->lock);
 	if (mcbsp->free)
 		dev_err(mcbsp->dev, "McBSP%d was not reserved\n", mcbsp->id);
-- 
1.7.8.5
