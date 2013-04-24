From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: mxs-sgtl5000: Remove unneeded 'ret'
	variable
Date: Wed, 24 Apr 2013 13:23:14 -0300
Message-ID: <1366820595-19762-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f44.google.com (mail-yh0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CD2A261641
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 18:23:26 +0200 (CEST)
Received: by mail-yh0-f44.google.com with SMTP id b12so102944yha.3
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 09:23:25 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Variable 'ret' is not needed here, so just remove it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-sgtl5000.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index b1d9b5e..4f74b05 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -116,7 +116,7 @@ static int mxs_sgtl5000_probe_dt(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *saif_np[2], *codec_np;
-	int i, ret = 0;
+	int i;
 
 	if (!np)
 		return 1; /* no device tree */
@@ -142,7 +142,7 @@ static int mxs_sgtl5000_probe_dt(struct platform_device *pdev)
 	of_node_put(saif_np[0]);
 	of_node_put(saif_np[1]);
 
-	return ret;
+	return 0;
 }
 
 static int mxs_sgtl5000_probe(struct platform_device *pdev)
-- 
1.7.9.5
