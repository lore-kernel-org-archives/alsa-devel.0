From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: sti-sas: Fix checking return value
	for ERR_PTR
Date: Mon, 13 Jul 2015 13:25:34 +0800
Message-ID: <1436765134.21490.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id CFD63261510
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 10:34:47 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so28448380pac.3
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 01:34:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Both devm_regmap_init and syscon_regmap_lookup_by_phandle return ERR_PTR
on failure.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/sti-sas.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 32db2c2..4168b88 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -568,17 +568,17 @@ static int sti_sas_driver_probe(struct platform_device *pdev)
 	/* Request the DAC & SPDIF registers memory region */
 	drvdata->dac.virt_regmap = devm_regmap_init(&pdev->dev, NULL, drvdata,
 						    drvdata->dev_data->regmap);
-	if (!drvdata->dac.virt_regmap) {
+	if (IS_ERR(drvdata->dac.virt_regmap)) {
 		dev_err(&pdev->dev, "audio registers not enabled\n");
-		return -EFAULT;
+		return PTR_ERR(drvdata->dac.virt_regmap);
 	}
 
 	/* Request the syscon region */
 	drvdata->dac.regmap =
 		syscon_regmap_lookup_by_phandle(pnode, "st,syscfg");
-	if (!drvdata->dac.regmap) {
+	if (IS_ERR(drvdata->dac.regmap)) {
 		dev_err(&pdev->dev, "syscon registers not available\n");
-		return -EFAULT;
+		return PTR_ERR(drvdata->dac.regmap);
 	}
 	drvdata->spdif.regmap = drvdata->dac.regmap;
 
-- 
2.1.0
