From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 7/8] ASoC: imx-spdif: Add indentation for binding doc to increase readability
Date: Tue,  7 Oct 2014 12:29:10 -0700
Message-ID: <ebb43d3fff01a0399e181acb03fd29f1612b23c0.1412708790.git.nicoleotsuka@gmail.com>
References: <cover.1412708790.git.nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1412708790.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1412708790.git.nicoleotsuka@gmail.com>
References: <cover.1412708790.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

This patch simply adds indentations for DT binding doc to increase readability
without changing any contents.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 .../devicetree/bindings/sound/imx-audio-spdif.txt  | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
index 7d13479..da84a44 100644
--- a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
@@ -2,23 +2,25 @@ Freescale i.MX audio complex with S/PDIF transceiver
 
 Required properties:
 
-  - compatible : "fsl,imx-audio-spdif"
+  - compatible		: "fsl,imx-audio-spdif"
 
-  - model : The user-visible name of this sound complex
+  - model		: The user-visible name of this sound complex
 
-  - spdif-controller : The phandle of the i.MX S/PDIF controller
+  - spdif-controller	: The phandle of the i.MX S/PDIF controller
 
 
 Optional properties:
 
-  - spdif-out : This is a boolean property. If present, the transmitting
-    function of S/PDIF will be enabled, indicating there's a physical
-    S/PDIF out connector/jack on the board or it's connecting to some
-    other IP block, such as an HDMI encoder/display-controller.
+  - spdif-out		: This is a boolean property. If present, the
+			  transmitting function of S/PDIF will be enabled,
+			  indicating there's a physical S/PDIF out connector
+			  or jack on the board or it's connecting to some
+			  other IP block, such as an HDMI encoder or
+			  display-controller.
 
-  - spdif-in : This is a boolean property. If present, the receiving
-    function of S/PDIF will be enabled, indicating there's a physical
-    S/PDIF in connector/jack on the board.
+  - spdif-in		: This is a boolean property. If present, the receiving
+			  function of S/PDIF will be enabled, indicating there
+			  is a physical S/PDIF in connector/jack on the board.
 
 * Note: At least one of these two properties should be set in the DT binding.
 
-- 
1.9.1
