From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: Introduce compatible strings for 7ULP and 8MQ" to the asoc tree
Date: Wed,  7 Aug 2019 14:30:49 +0100 (BST)
Message-ID: <20190807133049.4088D2742B9E@ypsilon.sirena.org.uk>
References: <20190806151214.6783-6-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806151214.6783-6-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, angus@akkea.ca, broonie@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com, linux-kernel@vger.kernel.org, l.stach@pengutronix.deMark Brown <broonie@kernel.org>, mihai.serban@gmail.com, nicoleotsuka@gmail.comNicolin Chen <nicoleotsuka@gmail.com>, robh@kernel.org, shengjiu.wang@nxp.com, timur@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: Introduce compatible strings for 7ULP and 8MQ

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

>From 371be51a925a619f1fb149b8d7707e353d9c9f86 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 6 Aug 2019 18:12:14 +0300
Subject: [PATCH] ASoC: dt-bindings: Introduce compatible strings for 7ULP and
 8MQ

For i.MX7ULP and i.MX8MQ register map is changed. Add two new compatbile
strings to differentiate this.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/20190806151214.6783-6-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 2e726b983845..e61c0dc1fc0b 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -8,7 +8,8 @@ codec/DSP interfaces.
 Required properties:
 
   - compatible		: Compatible list, contains "fsl,vf610-sai",
-			  "fsl,imx6sx-sai" or "fsl,imx6ul-sai"
+			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
+			  "fsl,imx7ulp-sai" or "fsl,imx8mq-sai".
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.20.1
