From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcbsp: Enable/disable sidetone
	block auto clock gating for omap3" to the asoc tree
Date: Fri, 18 Mar 2016 10:58:02 +0000
Message-ID: <E1ags6U-0004Eu-LH@debutante>
References: <1458296929-718-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E45452619BF
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 11:58:15 +0100 (CET)
In-Reply-To: <1458296929-718-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap-mcbsp: Enable/disable sidetone block auto clock gating for omap3

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d4e44f1418d71cf53d685e236a95c525089e065a Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 18 Mar 2016 12:28:49 +0200
Subject: [PATCH] ASoC: omap-mcbsp: Enable/disable sidetone block auto clock
 gating for omap3

OMAP3's McBSP2 and McBSP3 module have integrated sidetone block with
dedicated SYSCONFIG register. The sidetone is operating from the maain
McBSP module's ICLK. For normal operation the sidetone clock auto idle
support needs to be disabled when it is activated.
Note: This is not enough to avoid choppy sidetone because this AUTOIDLE
bit is controlling only the clock auto idle from the McBSP to the sidetone
block. If the McBSP_ICLK is idling, the sidetone clock is going to do the
same.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/mcbsp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index c7563e230c7d..4a16e778966b 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -260,6 +260,10 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 	if (mcbsp->pdata->enable_st_clock)
 		mcbsp->pdata->enable_st_clock(mcbsp->id, 1);
 
+	/* Disable Sidetone clock auto-gating for normal operation */
+	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
+	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w & ~(ST_AUTOIDLE));
+
 	/* Enable McBSP Sidetone */
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w | SIDETONEEN);
@@ -279,6 +283,10 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w & ~(SIDETONEEN));
 
+	/* Enable Sidetone clock auto-gating to reduce power consumption */
+	w = MCBSP_ST_READ(mcbsp, SYSCONFIG);
+	MCBSP_ST_WRITE(mcbsp, SYSCONFIG, w | ST_AUTOIDLE);
+
 	if (mcbsp->pdata->enable_st_clock)
 		mcbsp->pdata->enable_st_clock(mcbsp->id, 0);
 }
-- 
2.7.0
