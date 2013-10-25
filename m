From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ASoC: fsl_spdif: fix return value check in
	fsl_spdif_probe()
Date: Fri, 25 Oct 2013 17:29:25 +0800
Message-ID: <CAPgLHd-2d+RLDq1U=wXR72nAEH1Hr6FDcWp0eAyEkrNmfjrEaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f176.google.com (mail-ea0-f176.google.com
 [209.85.215.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F9DD26500A
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 11:29:28 +0200 (CEST)
Received: by mail-ea0-f176.google.com with SMTP id q16so431281ead.7
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 02:29:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function platform_get_resource() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/fsl/fsl_spdif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 3920c3e..e5bfafe 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1107,9 +1107,9 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (IS_ERR(res)) {
+	if (!res) {
 		dev_err(&pdev->dev, "could not determine device resources\n");
-		return PTR_ERR(res);
+		return -ENXIO;
 	}
 
 	regs = devm_ioremap_resource(&pdev->dev, res);
