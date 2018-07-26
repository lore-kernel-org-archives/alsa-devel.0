From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: sirf: Fix potential NULL pointer
	dereference
Date: Thu, 26 Jul 2018 15:49:10 -0500
Message-ID: <20180726204910.GA1635@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com
 [192.185.192.34])
 by alsa0.perex.cz (Postfix) with ESMTP id B655226776E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 22:49:17 +0200 (CEST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id CC5CCD1D
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 15:49:13 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Barry Song <baohua@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

There is a potential execution path in which function
platform_get_resource() returns NULL. If this happens,
we will end up having a NULL pointer dereference.

Fix this by replacing devm_ioremap with devm_ioremap_resource,
which has the NULL check and the memory region request.

This code was detected with the help of Coccinelle.

Cc: stable@vger.kernel.org
Fixes: 2bd8d1d5cf89 ("ASoC: sirf: Add audio usp interface driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/sirf/sirf-usp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sirf/sirf-usp.c b/sound/soc/sirf/sirf-usp.c
index 77e7dcf..d70fcd4 100644
--- a/sound/soc/sirf/sirf-usp.c
+++ b/sound/soc/sirf/sirf-usp.c
@@ -370,10 +370,9 @@ static int sirf_usp_pcm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, usp);
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap(&pdev->dev, mem_res->start,
-		resource_size(mem_res));
-	if (base == NULL)
-		return -ENOMEM;
+	base = devm_ioremap_resource(&pdev->dev, mem_res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 	usp->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					    &sirf_usp_regmap_config);
 	if (IS_ERR(usp->regmap))
-- 
2.7.4
