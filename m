From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: mxs-saif: Use a signed integer for error
	value
Date: Tue, 8 Jan 2013 10:27:13 -0200
Message-ID: <1357648033-8101-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C14C265197
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 13:27:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

saif->id and saif->master_id are unsigned, so they can not be negative.

Fix the following warning when building with W=1 option:

sound/soc/mxs/mxs-saif.c: In function 'mxs_saif_probe':
sound/soc/mxs/mxs-saif.c:676:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
sound/soc/mxs/mxs-saif.c:688:3: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
sound/soc/mxs/mxs-saif.c:692:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]

Use a signed variable 'ret' to handle the error values.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-saif.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 752675d..a920206 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -672,9 +672,9 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	if (!saif)
 		return -ENOMEM;
 
-	saif->id = of_alias_get_id(np, "saif");
-	if (saif->id < 0)
-		return saif->id;
+	ret = of_alias_get_id(np, "saif");
+	if (ret < 0)
+		return ret;
 	/*
 	 * If there is no "fsl,saif-master" phandle, it's a saif
 	 * master.  Otherwise, it's a slave and its phandle points
@@ -684,12 +684,12 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	if (!master) {
 		saif->master_id = saif->id;
 	} else {
-		saif->master_id = of_alias_get_id(master, "saif");
-		if (saif->master_id < 0)
-			return saif->master_id;
+		ret = of_alias_get_id(master, "saif");
+		if (ret < 0)
+			return ret;
 	}
 
-	if (saif->master_id < 0 || saif->master_id >= ARRAY_SIZE(mxs_saif)) {
+	if (saif->master_id >= ARRAY_SIZE(mxs_saif)) {
 		dev_err(&pdev->dev, "get wrong master id\n");
 		return -EINVAL;
 	}
-- 
1.7.9.5
