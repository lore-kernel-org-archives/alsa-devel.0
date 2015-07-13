From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti-sas: Fix checking return value for
	ERR_PTR" to the asoc tree
Date: Mon, 13 Jul 2015 12:16:55 +0100
Message-ID: <E1ZEbjD-0006d0-TB@debutante>
References: <1436765134.21490.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C73826167A
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 13:17:02 +0200 (CEST)
In-Reply-To: <1436765134.21490.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti-sas: Fix checking return value for ERR_PTR

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e27d9ee6e709db070145847f9b5f52008f6eab84 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 13 Jul 2015 13:25:34 +0800
Subject: [PATCH] ASoC: sti-sas: Fix checking return value for ERR_PTR

Both devm_regmap_init and syscon_regmap_lookup_by_phandle return ERR_PTR
on failure.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sti-sas.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 32db2c25a33f..4168b88ba3b1 100644
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
2.1.4
