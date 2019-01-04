From: Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH v2 1/2] ASoC: micfil: Add bindings for MICFIL
	DAI
Date: Fri, 4 Jan 2019 09:17:37 +0000
Message-ID: <1546593445-10509-2-git-send-email-cosmin.samoila@nxp.com>
References: <1546593445-10509-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50059.outbound.protection.outlook.com [40.107.5.59])
 by alsa0.perex.cz (Postfix) with ESMTP id A5389267AAA
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 10:17:39 +0100 (CET)
In-Reply-To: <1546593445-10509-1-git-send-email-cosmin.samoila@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, "gabrielcsmo@gmail.com" <gabrielcsmo@gmail.com>
Cc: Cosmin Samoila <cosmin.samoila@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

Document the bindings for MICFIL DAI.

Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
---
 .../devicetree/bindings/sound/fsl,micfil.txt       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,micfil.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,micfil.txt b/Documentation/devicetree/bindings/sound/fsl,micfil.txt
new file mode 100644
index 0000000..53e227b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,micfil.txt
@@ -0,0 +1,32 @@
+NXP MICFIL Digital Audio Interface (MICFIL).
+
+The MICFIL digital interface provides a 16-bit audio signal from a PDM
+microphone bitstream in a configurable output sampling rate.
+
+Required properties:
+
+  - compatible		: Compatible list, contains "fsl,imx8mm-micfil"
+
+  - reg			: Offset and length of the register set for the device.
+
+  - interrupts		: Contains the micfil interrupts.
+
+  - clocks		: Must contain an entry for each entry in clock-names.
+
+  - clock-names		: Must include the "ipg_clk" for register access and
+			  "ipg_clk_app" for internal micfil clock.
+
+  - dmas		: Generic dma devicetree binding as described in
+			  Documentation/devicetree/bindings/dma/dma.txt.
+
+Example:
+micfil: micfil@30080000 {
+	compatible = "fsl,imx8mm-micfil";
+	reg = <0x0 0x30080000 0x0 0x10000>;
+	interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clk IMX8MM_CLK_PDM_IPG>,
+		 <&clk IMX8MM_CLK_PDM_ROOT>;
+	clock-names = "ipg_clk", "ipg_clk_app";
+	dmas = <&sdma2 24 26 0x80000000>;
+};
-- 
2.7.4
