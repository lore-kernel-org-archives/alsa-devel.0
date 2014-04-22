From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-hdmi: Remove excess curly bracket
Date: Tue, 22 Apr 2014 10:30:33 +0300
Message-ID: <1398151833-5219-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 20A2D261A5E
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 09:30:38 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Fix the error added by commit:
ASoC: omap-hdmi: Bind the platform driver to the dai driver when loading

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 32614b49653c..537a1ec8ad61 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -330,7 +330,6 @@ static int omap_hdmi_probe(struct platform_device *pdev)
 
 	return omap_pcm_platform_register(&pdev->dev);
 }
-}
 
 static int omap_hdmi_remove(struct platform_device *pdev)
 {
-- 
1.9.2
