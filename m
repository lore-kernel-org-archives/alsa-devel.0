From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: Use 'np' variable" to the asoc
	tree
Date: Wed, 17 Aug 2016 12:24:44 +0100
Message-ID: <E1bZyxg-00061A-Tl@debutante>
References: <1471392054-17700-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 28DB42669E9
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 13:25:01 +0200 (CEST)
In-Reply-To: <1471392054-17700-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: Use 'np' variable

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

>From 6ea9c7ddd96d88e6cc391e63b5ed2fcfe41d5725 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 16 Aug 2016 21:00:54 -0300
Subject: [PATCH] ASoC: fsl_sai: Use 'np' variable

The 'np' variable is already assigned to 'pdev->dev.of_node', so use
it to improve readability.

No functional change.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 2147994ab46f..9fadf7e31c5f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -801,8 +801,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	sai->pdev = pdev;
 
-	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai") ||
-	    of_device_is_compatible(pdev->dev.of_node, "fsl,imx6ul-sai"))
+	if (of_device_is_compatible(np, "fsl,imx6sx-sai") ||
+	    of_device_is_compatible(np, "fsl,imx6ul-sai"))
 		sai->sai_on_imx = true;
 
 	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
@@ -883,7 +883,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	}
 
 	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
-	    of_device_is_compatible(pdev->dev.of_node, "fsl,imx6ul-sai")) {
+	    of_device_is_compatible(np, "fsl,imx6ul-sai")) {
 		gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
 		if (IS_ERR(gpr)) {
 			dev_err(&pdev->dev, "cannot find iomuxc registers\n");
-- 
2.8.1
