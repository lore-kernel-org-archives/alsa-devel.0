From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: fsl-ssi: Add missing
 clk_disable_unprepare() on error in fsl_ssi_probe()
Date: Thu, 9 Jan 2014 22:27:31 +0800
Message-ID: <CAPgLHd-wvDcOz1Ne69g3o4b=VS7jaPU5Gu4DBMq_tBCsY0xcew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 86C0C261AB2
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:27:31 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id 6so1146341bkj.38
 for <alsa-devel@alsa-project.org>; Thu, 09 Jan 2014 06:27:31 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, robh+dt@kernel.org
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing clk_disable_unprepare() before return from
fsl_ssi_probe() in the request irq error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e18b4b3..4c6818d 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1464,7 +1464,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(&pdev->dev, "could not claim irq %u\n",
 					ssi_private->irq);
-			goto error_irqmap;
+			goto error_clk;
 		}
 	}
 
