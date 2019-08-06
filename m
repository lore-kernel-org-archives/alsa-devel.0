From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 5/5] ASoC: dt-bindings: Introduce compatible strings for 7ULP and 8MQ
Date: Tue,  6 Aug 2019 18:12:14 +0300
Message-ID: <20190806151214.6783-6-daniel.baluta@nxp.com>
References: <20190806151214.6783-1-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806151214.6783-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: l.stach@pengutronix.de, mihai.serban@gmail.com, alsa-devel@alsa-project.org, timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com, nicoleotsuka@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

For i.MX7ULP and i.MX8MQ register map is changed. Add two new compatbile
strings to differentiate this.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
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
2.17.1
