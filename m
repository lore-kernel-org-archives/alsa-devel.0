From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v2 1/2] ASoC: fsl_ssi: fix error path in probe
Date: Tue, 2 Dec 2014 14:55:06 +0900
Message-ID: <1417499707-3125-2-git-send-email-jiada_wang@mentor.com>
References: <1417499707-3125-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id AEE7826063A
 for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2014 06:55:13 +0100 (CET)
In-Reply-To: <1417499707-3125-1-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, festevam@gmail.com, lars@metafoo.de, arnd@arndb.de, broonie@kernel.org, mpa@pengutronix.de
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

SSI component isn't unregistered if fsl_ssi_debugfs_create() fails
in probe phase.

To fix it, this commit replaces label error_asoc_register with
error_irq.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e695517..e19ed39 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1412,7 +1412,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	ret = fsl_ssi_debugfs_create(&ssi_private->dbg_stats, &pdev->dev);
 	if (ret)
-		goto error_asoc_register;
+		goto error_irq;
 
 	/*
 	 * If codec-handle property is missing from SSI node, we assume
-- 
1.9.3
