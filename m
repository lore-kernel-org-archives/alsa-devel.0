From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: Introduce a compatible string
	for MX6UL" to the asoc tree
Date: Thu, 05 May 2016 16:56:12 +0100
Message-ID: <E1ayLdM-0004gc-LB@debutante>
References: <1462401239-995-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B10412668C7
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 17:56:18 +0200 (CEST)
In-Reply-To: <1462401239-995-1-git-send-email-festevam@gmail.com>
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
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, shawnguo@kernel.org, brain@jikos.cz
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: Introduce a compatible string for MX6UL

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

>From 1593af62b694b3638edf577e3b763fa1a4ca3d76 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 4 May 2016 19:33:58 -0300
Subject: [PATCH] ASoC: fsl_sai: Introduce a compatible string for MX6UL

MX6UL may need to configure the General Purpose Register 1 (GPR1), so
it is better to add a new compatible string to differentiate.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 4 ++--
 sound/soc/fsl/fsl_sai.c                             | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 044e5d76e2dd..777b941d6cbe 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -7,8 +7,8 @@ codec/DSP interfaces.
 
 Required properties:
 
-  - compatible		: Compatible list, contains "fsl,vf610-sai" or
-			  "fsl,imx6sx-sai".
+  - compatible		: Compatible list, contains "fsl,vf610-sai",
+			  "fsl,imx6sx-sai" or "fsl,imx6ul-sai"
 
   - reg			: Offset and length of the register set for the device.
 
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 0754df771e3b..d8b673f7c577 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -797,7 +797,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	sai->pdev = pdev;
 
-	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai"))
+	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai") ||
+	    of_device_is_compatible(pdev->dev.of_node, "fsl,imx6ul-sai"))
 		sai->sai_on_imx = true;
 
 	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
@@ -898,6 +899,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", },
 	{ .compatible = "fsl,imx6sx-sai", },
+	{ .compatible = "fsl,imx6ul-sai", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_sai_ids);
-- 
2.8.1
