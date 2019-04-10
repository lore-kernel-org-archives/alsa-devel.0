From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_audmix: remove "model" attribute
	from DT document" to the asoc tree
Date: Wed, 10 Apr 2019 13:26:37 +0100 (BST)
Message-ID: <20190410122637.E7ABC1128ED2@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60204F89623
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 14:26:39 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_audmix: remove "model" attribute from DT document

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 23261179da29af42d3e31c827c1a6de607891047 Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Wed, 10 Apr 2019 11:06:37 +0000
Subject: [PATCH] ASoC: fsl_audmix: remove "model" attribute from DT document

Remove "model" attribute from fsl_audmix DT document.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl,audmix.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
index 45f807ec21a5..840b7e0d6a63 100644
--- a/Documentation/devicetree/bindings/sound/fsl,audmix.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
@@ -38,9 +38,6 @@ Device driver required properties:
 			  to SAI interfaces to be provided, the first SAI in the
 			  list being used to route the AUDMIX output.
 
-  - model		: Must contain machine driver name which will configure
-			  and instantiate the appropriate audio card.
-
 Device driver configuration example:
 ======================================
   audmix: audmix@59840000 {
@@ -50,5 +47,4 @@ Device driver configuration example:
     clock-names = "ipg";
     power-domains = <&pd_audmix>;
     dais = <&sai4>, <&sai5>;
-    model = "imx-audmix";
   };
-- 
2.20.1
