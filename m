From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 05/11] ASoC: samsung: spdif: Handle return
	value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 15:44:32 +0530
Message-ID: <1500977674-27960-6-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 1845F267174
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 12:15:42 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id d193so14089890pgc.2
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 03:15:42 -0700 (PDT)
In-Reply-To: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/samsung/spdif.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 779504f..cb59911 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -391,7 +391,9 @@ static int spdif_probe(struct platform_device *pdev)
 		ret = -ENOENT;
 		goto err0;
 	}
-	clk_prepare_enable(spdif->pclk);
+	ret = clk_prepare_enable(spdif->pclk);
+	if (ret)
+		goto err0;
 
 	spdif->sclk = devm_clk_get(&pdev->dev, "sclk_spdif");
 	if (IS_ERR(spdif->sclk)) {
@@ -399,7 +401,9 @@ static int spdif_probe(struct platform_device *pdev)
 		ret = -ENOENT;
 		goto err1;
 	}
-	clk_prepare_enable(spdif->sclk);
+	ret = clk_prepare_enable(spdif->sclk);
+	if (ret)
+		goto err1;
 
 	/* Request S/PDIF Register's memory region */
 	if (!request_mem_region(mem_res->start,
-- 
1.9.1
