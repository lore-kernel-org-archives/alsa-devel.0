From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/4] ASoC: tegra: Use NULL instead of 0 for
	pointers
Date: Thu, 24 Jan 2013 14:51:17 +0530
Message-ID: <1359019278-1199-4-git-send-email-sachin.kamat@linaro.org>
References: <1359019278-1199-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 126D42615D0
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 10:30:23 +0100 (CET)
Received: by mail-pa0-f54.google.com with SMTP id bi5so5370875pad.13
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 01:30:23 -0800 (PST)
In-Reply-To: <1359019278-1199-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, swarren@nvidia.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Fixes the following sparse warnings:
sound/soc/tegra/tegra30_ahub.c:583:16: warning:
Using plain integer as NULL pointer
sound/soc/tegra/tegra30_ahub.c:600:16: warning:
Using plain integer as NULL pointer

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra30_ahub.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index f354dc3..dd146f1 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -580,7 +580,7 @@ err_clk_put_apbif:
 	clk_put(ahub->clk_apbif);
 err_clk_put_d_audio:
 	clk_put(ahub->clk_d_audio);
-	ahub = 0;
+	ahub = NULL;
 err:
 	return ret;
 }
@@ -597,7 +597,7 @@ static int tegra30_ahub_remove(struct platform_device *pdev)
 	clk_put(ahub->clk_apbif);
 	clk_put(ahub->clk_d_audio);
 
-	ahub = 0;
+	ahub = NULL;
 
 	return 0;
 }
-- 
1.7.4.1
