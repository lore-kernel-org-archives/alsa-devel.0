From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH] ASoC: pxa-ssp: fix SSP port request
Date: Tue,  3 Feb 2009 21:18:26 +0100
Message-ID: <1233692306-13211-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id DD9F6103861
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 21:18:30 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so232688eyh.56
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 12:18:30 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Eric Miao <eric.miao@marvell.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

PXA2xx/3xx SSP ports start from 1, not 0. Thus, the probe function
requested the wrong SSP port. Correcting this unveiled another bug
where ssp_init tries to request the already-requested SSP port again.
So this patch replaces the ssp_init/exit calls with their internals
from mach-pxa/ssp.c, leaving out the redundant ssp_request and the
unneeded IRQ request. Effectively, that leaves us with not much more
than enabling/disabling the SSP clock.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 73cb6b4..f9c6de5 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -21,6 +21,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <asm/irq.h>
+
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
@@ -221,9 +223,9 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 	int ret = 0;
 
 	if (!cpu_dai->active) {
-		ret = ssp_init(&priv->dev, cpu_dai->id + 1, SSP_NO_IRQ);
-		if (ret < 0)
-			return ret;
+		priv->dev.port = cpu_dai->id + 1;
+		priv->dev.irq = NO_IRQ;
+		clk_enable(priv->dev.ssp->clk);
 		ssp_disable(&priv->dev);
 	}
 	return ret;
@@ -238,7 +240,7 @@ static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
 
 	if (!cpu_dai->active) {
 		ssp_disable(&priv->dev);
-		ssp_exit(&priv->dev);
+		clk_disable(priv->dev.ssp->clk);
 	}
 }
 
@@ -751,7 +753,7 @@ static int pxa_ssp_probe(struct platform_device *pdev,
 	if (!priv)
 		return -ENOMEM;
 
-	priv->dev.ssp = ssp_request(dai->id, "SoC audio");
+	priv->dev.ssp = ssp_request(dai->id + 1, "SoC audio");
 	if (priv->dev.ssp == NULL) {
 		ret = -ENODEV;
 		goto err_priv;
-- 
1.5.6.5
