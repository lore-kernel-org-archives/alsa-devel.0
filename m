From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: imx-sgtl5000: Add .remove back
Date: Mon, 30 Sep 2013 22:17:37 -0300
Message-ID: <1380590257-7516-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f169.google.com (mail-ye0-f169.google.com
 [209.85.213.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 11A1726517B
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 03:17:52 +0200 (CEST)
Received: by mail-ye0-f169.google.com with SMTP id r13so2047584yen.0
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 18:17:52 -0700 (PDT)
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
Cc: olof@lixom.net, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, p.zabel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit e8f00c1b01 (Merge remote-tracking branch 'asoc/fix/fsl' into asoc-devm) 
fixed a conflict, but missed to add the .remove function back,which causes the 
following build warning:

sound/soc/fsl/imx-sgtl5000.c:185:12: warning: 'imx_sgtl5000_remove' defined but not used [-Wunused-function]

Fix the warning by adding the .remove function back.

Reported-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 6f4bdc8..ed6ba1e 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -204,6 +204,7 @@ static struct platform_driver imx_sgtl5000_driver = {
 		.of_match_table = imx_sgtl5000_dt_ids,
 	},
 	.probe = imx_sgtl5000_probe,
+	.remove = imx_sgtl5000_remove,
 };
 module_platform_driver(imx_sgtl5000_driver);
 
-- 
1.8.1.2
