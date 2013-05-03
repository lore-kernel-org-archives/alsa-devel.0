From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/6] ASoC: omap-mcbsp: Remove redundant
	platform_set_drvdata()
Date: Fri,  3 May 2013 14:39:20 +0530
Message-ID: <1367572164-19523-2-git-send-email-sachin.kamat@linaro.org>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 by alsa0.perex.cz (Postfix) with ESMTP id F3D0726166B
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:28:18 +0200 (CEST)
Received: by mail-pb0-f52.google.com with SMTP id xa7so814806pbc.39
 for <alsa-devel@alsa-project.org>; Fri, 03 May 2013 02:28:16 -0700 (PDT)
In-Reply-To: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/omap-mcbsp.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index eadbfb6..7483efb 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -814,8 +814,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
 
 	clk_put(mcbsp->fclk);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5
