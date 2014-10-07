From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 4/4] ASoC: simple-card: Delete unneeded test
	before of_node_put
Date: Tue, 7 Oct 2014 15:29:58 -0300
Message-ID: <1412706598-18796-4-git-send-email-fabio.estevam@freescale.com>
References: <1412706598-18796-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0144.outbound.protection.outlook.com [157.56.110.144])
 by alsa0.perex.cz (Postfix) with ESMTP id 8905A2604BC
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:30:40 +0200 (CEST)
In-Reply-To: <1412706598-18796-1-git-send-email-fabio.estevam@freescale.com>
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
 sound/soc/generic/simple-card.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index fcb431f..ecba061 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -368,12 +368,9 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 		dai_link->cpu_dai_name = NULL;
 
 dai_link_of_err:
-	if (np)
-		of_node_put(np);
-	if (bitclkmaster)
-		of_node_put(bitclkmaster);
-	if (framemaster)
-		of_node_put(framemaster);
+	of_node_put(np);
+	of_node_put(bitclkmaster);
+	of_node_put(framemaster);
 	return ret;
 }
 
@@ -464,11 +461,9 @@ static int asoc_simple_card_unref(struct platform_device *pdev)
 	     num_links < card->num_links;
 	     num_links++, dai_link++) {
 		np = (struct device_node *) dai_link->cpu_of_node;
-		if (np)
-			of_node_put(np);
+		of_node_put(np);
 		np = (struct device_node *) dai_link->codec_of_node;
-		if (np)
-			of_node_put(np);
+		of_node_put(np);
 	}
 	return 0;
 }
-- 
1.9.1
