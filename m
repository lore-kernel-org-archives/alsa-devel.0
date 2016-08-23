From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH for 4.8] ASoC: omap-mcpdm: Fix irq resource
	handling
Date: Tue, 23 Aug 2016 10:27:19 +0300
Message-ID: <20160823072719.16880-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 47BFC266A42
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 09:27:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King <linux@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

Fixes: ddd17531ad908 ("ASoC: omap-mcpdm: Clean up with devm_* function")

Managed irq request will not doing any good in ASoC probe level as it is
not going to free up the irq when the driver is unbound from the sound
card.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Russell King <linux@armlinux.org.uk>
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
2.9.2
