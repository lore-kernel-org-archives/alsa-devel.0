From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: Introduce compatible string for imx8qm" to the asoc tree
Date: Wed, 21 Aug 2019 13:15:32 +0100 (BST)
Message-ID: <20190821121532.B2DC62742FCD@ypsilon.sirena.org.uk>
References: <20190814082911.665-3-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814082911.665-3-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com, perex@perex.cz, robh+dt@kernel.org, shengjiu.wang@nxp.com, viorel.suman@nxp.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: Introduce compatible string for imx8qm

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From c1fe93581ae9d85c3a783b5fad21912bb88a0f34 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 14 Aug 2019 11:29:11 +0300
Subject: [PATCH] ASoC: dt-bindings: Introduce compatible string for imx8qm

Register map for i.MX8QM is similar with i.MX6 series. Integration
of SAI IP into i.MX8QM SOC features a FIFO size of 64 X 32 bits samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20190814082911.665-3-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index e61c0dc1fc0b..0dc83cc4a236 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -9,7 +9,8 @@ Required properties:
 
   - compatible		: Compatible list, contains "fsl,vf610-sai",
 			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
-			  "fsl,imx7ulp-sai" or "fsl,imx8mq-sai".
+			  "fsl,imx7ulp-sai", "fsl,imx8mq-sai" or
+			  "fsl,imx8qm-sai".
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.20.1
