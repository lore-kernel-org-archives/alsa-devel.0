From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv4 4/4] Documentation: Add device tree bindings
	for Freescale SAI.
Date: Fri, 20 Dec 2013 09:03:07 +0800
Message-ID: <1387501387-2151-4-git-send-email-Li.Xiubo@freescale.com>
References: <1387501387-2151-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A82626551E
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 02:55:23 +0100 (CET)
In-Reply-To: <1387501387-2151-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This adds the Document for Freescale SAI driver under
Documentation/devicetree/bindings/sound/.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../devicetree/bindings/sound/fsl-sai.txt          | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl-sai.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
new file mode 100644
index 0000000..ca49ad1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -0,0 +1,40 @@
+Freescale Synchronous Audio Interface (SAI).
+
+The SAI is based on I2S module that used communicating with audio codecs,
+which provides a synchronous audio interface that supports fullduplex
+serial interfaces with frame synchronization such as I2S, AC97, TDM, and
+codec/DSP interfaces.
+
+
+Required properties:
+- compatible: Compatible list, contains "fsl,vf610-sai".
+- reg: Offset and length of the register set for the device.
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names : Must include the "sai" entry.
+- dmas : Generic dma devicetree binding as described in
+  Documentation/devicetree/bindings/dma/dma.txt.
+- dma-names : Two dmas have to be defined, "tx" and "rx".
+- pinctrl-names: Must contain a "default" entry.
+- pinctrl-NNN: One property must exist for each entry in pinctrl-names.
+  See ../pinctrl/pinctrl-bindings.txt for details of the property values.
+- big-endian-regs: If this property is absent, the little endian mode will
+  be in use as default, or the big endian mode will be in use for all the
+  device registers.
+- big-endian-data: If this property is absent, the little endian mode will
+  be in use as default, or the big endian mode will be in use for all the
+  fifo data.
+
+Example:
+sai2: sai@40031000 {
+	      compatible = "fsl,vf610-sai";
+	      reg = <0x40031000 0x1000>;
+	      pinctrl-names = "default";
+	      pinctrl-0 = <&pinctrl_sai2_1>;
+	      clocks = <&clks VF610_CLK_SAI2>;
+	      clock-names = "sai";
+	      dma-names = "tx", "rx";
+	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
+		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
+	      big-endian_regs;
+	      big-endian_data;
+};
-- 
1.8.4
