From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcbsp: Enable TX/RX under and
	overflow interrupts" to the asoc tree
Date: Fri, 12 Aug 2016 13:29:49 +0100
Message-ID: <E1bYBav-0002iM-34@debutante>
References: <20160812105210.15075-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EFBD2680F1
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 14:30:08 +0200 (CEST)
In-Reply-To: <20160812105210.15075-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: liam.r.girdwood@linux.intel.com, akramh@aq1systems.com, alsa-devel@alsa-project.org, broonie@kernel.org, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap-mcbsp: Enable TX/RX under and overflow interrupts

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

>From 4e85e7776eba5f6d5a3b8b43f34001a73c5d08a1 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 12 Aug 2016 13:52:10 +0300
Subject: [PATCH] ASoC: omap-mcbsp: Enable TX/RX under and overflow interrupts

FIFO under or overflow can cause channel swaps and data loss. Reporting
them can help to identify such events.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
