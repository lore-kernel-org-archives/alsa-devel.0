From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 3/8] ASoC: fsl_sai: Add indentation for binding
	doc to increase readability
Date: Tue,  7 Oct 2014 12:29:06 -0700
Message-ID: <50d58e1906b2e3e8b9f5fded5758c69f5ca39bbc.1412708790.git.nicoleotsuka@gmail.com>
References: <cover.1412708790.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id A8F3B26051E
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 21:29:37 +0200 (CEST)
Received: by mail-pd0-f180.google.com with SMTP id fp1so5497257pdb.25
 for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2014 12:29:36 -0700 (PDT)
In-Reply-To: <cover.1412708790.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1412708790.git.nicoleotsuka@gmail.com>
References: <cover.1412708790.git.nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

This patch refines the DT binding doc for more readability by adding
extra blank lines and indentations.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 .../devicetree/bindings/sound/fsl-sai.txt          | 66 ++++++++++++++--------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 4956b14..044e5d7 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -5,32 +5,48 @@ which provides a synchronous audio interface that supports fullduplex
 serial interfaces with frame synchronization such as I2S, AC97, TDM, and
 codec/DSP interfaces.
 
-
 Required properties:
-- compatible: Compatible list, contains "fsl,vf610-sai" or "fsl,imx6sx-sai".
-- reg: Offset and length of the register set for the device.
-- clocks: Must contain an entry for each entry in clock-names.
-- clock-names : Must include the "bus" for register access and "mclk1" "mclk2"
-  "mclk3" for bit clock and frame clock providing.
-- dmas : Generic dma devicetree binding as described in
-  Documentation/devicetree/bindings/dma/dma.txt.
-- dma-names : Two dmas have to be defined, "tx" and "rx".
-- pinctrl-names: Must contain a "default" entry.
-- pinctrl-NNN: One property must exist for each entry in pinctrl-names.
-  See ../pinctrl/pinctrl-bindings.txt for details of the property values.
-- big-endian: Boolean property, required if all the FTM_PWM registers
-  are big-endian rather than little-endian.
-- lsb-first: Configures whether the LSB or the MSB is transmitted first for
-  the fifo data. If this property is absent, the MSB is transmitted first as
-  default, or the LSB is transmitted first.
-- fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
-  that SAI will work in the synchronous mode (sync Tx with Rx) which means
-  both the transimitter and receiver will send and receive data by following
-  receiver's bit clocks and frame sync clocks.
-- fsl,sai-asynchronous: This is a boolean property. If present, indicating
-  that SAI will work in the asynchronous mode, which means both transimitter
-  and receiver will send and receive data by following their own bit clocks
-  and frame sync clocks separately.
+
+  - compatible		: Compatible list, contains "fsl,vf610-sai" or
+			  "fsl,imx6sx-sai".
+
+  - reg			: Offset and length of the register set for the device.
+
+  - clocks		: Must contain an entry for each entry in clock-names.
+
+  - clock-names		: Must include the "bus" for register access and
+			  "mclk1", "mclk2", "mclk3" for bit clock and frame
+			  clock providing.
+  - dmas		: Generic dma devicetree binding as described in
+			  Documentation/devicetree/bindings/dma/dma.txt.
+
+  - dma-names		: Two dmas have to be defined, "tx" and "rx".
+
+  - pinctrl-names	: Must contain a "default" entry.
+
+  - pinctrl-NNN		: One property must exist for each entry in
+			  pinctrl-names. See ../pinctrl/pinctrl-bindings.txt
+			  for details of the property values.
+
+  - big-endian		: Boolean property, required if all the FTM_PWM
+			  registers are big-endian rather than little-endian.
+
+  - lsb-first		: Configures whether the LSB or the MSB is transmitted
+			  first for the fifo data. If this property is absent,
+			  the MSB is transmitted first as default, or the LSB
+			  is transmitted first.
+
+  - fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
+			  that SAI will work in the synchronous mode (sync Tx
+			  with Rx) which means both the transimitter and the
+			  receiver will send and receive data by following
+			  receiver's bit clocks and frame sync clocks.
+
+  - fsl,sai-asynchronous: This is a boolean property. If present, indicating
+			  that SAI will work in the asynchronous mode, which
+			  means both transimitter and receiver will send and
+			  receive data by following their own bit clocks and
+			  frame sync clocks separately.
 
 Note:
 - If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
-- 
1.9.1
