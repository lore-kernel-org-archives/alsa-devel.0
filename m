From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcpdm: Fix irq resource handling"
	to the asoc tree
Date: Tue, 23 Aug 2016 12:36:02 +0100
Message-ID: <E1bc9zu-0007Hv-Af@debutante>
References: <20160823072719.16880-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C3FF26655F
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 13:36:15 +0200 (CEST)
In-Reply-To: <20160823072719.16880-1-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap-mcpdm: Fix irq resource handling

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

>From a8719670687c46ed2e904c0d05fa4cd7e4950cd1 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 23 Aug 2016 10:27:19 +0300
Subject: [PATCH] ASoC: omap-mcpdm: Fix irq resource handling

Fixes: ddd17531ad908 ("ASoC: omap-mcpdm: Clean up with devm_* function")

Managed irq request will not doing any good in ASoC probe level as it is
not going to free up the irq when the driver is unbound from the sound
card.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-mcpdm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 74d6e6fdcfd0..64609c77a79d 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -394,8 +394,8 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
 	pm_runtime_get_sync(mcpdm->dev);
 	omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, 0x00);
 
-	ret = devm_request_irq(mcpdm->dev, mcpdm->irq, omap_mcpdm_irq_handler,
-				0, "McPDM", (void *)mcpdm);
+	ret = request_irq(mcpdm->irq, omap_mcpdm_irq_handler, 0, "McPDM",
+			  (void *)mcpdm);
 
 	pm_runtime_put_sync(mcpdm->dev);
 
@@ -420,6 +420,7 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)
 {
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
 
+	free_irq(mcpdm->irq, (void *)mcpdm);
 	pm_runtime_disable(mcpdm->dev);
 
 	return 0;
-- 
2.8.1
