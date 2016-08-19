From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 3/3] ASoC: fsl_asrc: Remove unneeded driver
	registration message
Date: Fri, 19 Aug 2016 10:31:01 -0300
Message-ID: <1471613461-21654-3-git-send-email-fabio.estevam@nxp.com>
References: <1471613461-21654-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0081.outbound.protection.outlook.com [104.47.32.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A31C267527
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 15:33:06 +0200 (CEST)
In-Reply-To: <1471613461-21654-1-git-send-email-fabio.estevam@nxp.com>
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

There is no need to announce that the driver has been successfully
probed, so remove the unneeded message.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index a37339a..b7157ce 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -933,8 +933,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "driver registered\n");
-
 	return 0;
 }
 
-- 
1.9.1
