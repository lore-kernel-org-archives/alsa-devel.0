From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 3/4] ASoC: fsl: eukrea-tlv320: Delete unneeded
	test before of_node_put
Date: Tue, 7 Oct 2014 15:29:57 -0300
Message-ID: <1412706598-18796-3-git-send-email-fabio.estevam@freescale.com>
References: <1412706598-18796-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0135.outbound.protection.outlook.com [157.56.110.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 62CAE26049A
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:30:38 +0200 (CEST)
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
 sound/soc/fsl/eukrea-tlv320.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index eb093d5..dd931fa 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -217,8 +217,7 @@ static int eukrea_tlv320_probe(struct platform_device *pdev)
 err:
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
-	if (np)
-		of_node_put(ssi_np);
+	of_node_put(ssi_np);
 
 	return ret;
 }
-- 
1.9.1
