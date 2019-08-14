From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/2] ASoC: dt-bindings: Introduce compatible string for imx8qm
Date: Wed, 14 Aug 2019 11:29:11 +0300
Message-ID: <20190814082911.665-3-daniel.baluta@nxp.com>
References: <20190814082911.665-1-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814082911.665-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, festevam@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org, shengjiu.wang@nxp.com, viorel.suman@nxp.com, linux-imx@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

Register map for i.MX8QM is similar with i.MX6 series. Integration
of SAI IP into i.MX8QM SOC features a FIFO size of 64 X 32 bits samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
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
2.17.1
