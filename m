From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/4] ASoC: mc13783: Delete unneeded test before
	of_node_put
Date: Tue, 7 Oct 2014 15:29:55 -0300
Message-ID: <1412706598-18796-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 by alsa0.perex.cz (Postfix) with ESMTP id D113126046C
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:30:34 +0200 (CEST)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

of_node_put() supports NULL as its argument, so the initial test is not
necessary.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/mc13783.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 2c1f1b0..388f90a 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -784,8 +784,7 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 			mc13783_dai_async, ARRAY_SIZE(mc13783_dai_async));
 
 out:
-	if (np)
-		of_node_put(np);
+	of_node_put(np);
 	return ret;
 }
 
-- 
1.9.1
