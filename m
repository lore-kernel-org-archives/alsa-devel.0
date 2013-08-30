From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH 1/2] ASoC: fsl: Add wrapping for dev_dbg() in
	fsl_spdif.c
Date: Fri, 30 Aug 2013 17:38:08 +0800
Message-ID: <7c26687b556e1b4fc33ea5771de7b64e45a02d38.1377855239.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 68B342655DD
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2013 11:26:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

Add wrapping '\n' for dev_dbg() in fsl_spdif.c

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index e93dc0d..98741e9 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1071,9 +1071,9 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 			break;
 	}
 
-	dev_dbg(&pdev->dev, "use rxtx%d as tx clock source for %dHz sample rate",
+	dev_dbg(&pdev->dev, "use rxtx%d as tx clock source for %dHz sample rate\n",
 			spdif_priv->txclk_src[index], rate[index]);
-	dev_dbg(&pdev->dev, "use divisor %d for %dHz sample rate",
+	dev_dbg(&pdev->dev, "use divisor %d for %dHz sample rate\n",
 			spdif_priv->txclk_div[index], rate[index]);
 
 	return 0;
-- 
1.7.1
