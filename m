From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 2/8] ASoC: fsl_spdif: Add indentation for
	binding doc to increase readability
Date: Tue,  7 Oct 2014 12:29:05 -0700
Message-ID: <b2f1493f287141c01f6db5aae23e084730c02b49.1412708790.git.nicoleotsuka@gmail.com>
References: <cover.1412708790.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AA8726050F
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 21:29:36 +0200 (CEST)
Received: by mail-pa0-f53.google.com with SMTP id kq14so7559779pab.26
 for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2014 12:29:35 -0700 (PDT)
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

This patch simply adds indentations for DT binding doc to increase readability
without changing any contents.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 .../devicetree/bindings/sound/fsl,spdif.txt        | 37 +++++++++++-----------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
index 3e9e82c8..b5ee32e 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
@@ -6,32 +6,31 @@ a fibre cable.
 
 Required properties:
 
-  - compatible : Compatible list, must contain "fsl,imx35-spdif".
+  - compatible		: Compatible list, must contain "fsl,imx35-spdif".
 
-  - reg : Offset and length of the register set for the device.
+  - reg			: Offset and length of the register set for the device.
 
-  - interrupts : Contains the spdif interrupt.
+  - interrupts		: Contains the spdif interrupt.
 
-  - dmas : Generic dma devicetree binding as described in
-  Documentation/devicetree/bindings/dma/dma.txt.
+  - dmas		: Generic dma devicetree binding as described in
+			  Documentation/devicetree/bindings/dma/dma.txt.
 
-  - dma-names : Two dmas have to be defined, "tx" and "rx".
+  - dma-names		: Two dmas have to be defined, "tx" and "rx".
 
-  - clocks : Contains an entry for each entry in clock-names.
+  - clocks		: Contains an entry for each entry in clock-names.
 
-  - clock-names : Includes the following entries:
-	"core"		The core clock of spdif controller
-	"rxtx<0-7>"	Clock source list for tx and rx clock.
-			This clock list should be identical to
-			the source list connecting to the spdif
-			clock mux in "SPDIF Transceiver Clock
-			Diagram" of SoC reference manual. It
-			can also be referred to TxClk_Source
-			bit of register SPDIF_STC.
+  - clock-names		: Includes the following entries:
+	"core"		  The core clock of spdif controller.
+	"rxtx<0-7>"	  Clock source list for tx and rx clock.
+			  This clock list should be identical to the source
+			  list connecting to the spdif clock mux in "SPDIF
+			  Transceiver Clock Diagram" of SoC reference manual.
+			  It can also be referred to TxClk_Source bit of
+			  register SPDIF_STC.
 
-   - big-endian : If this property is absent, the native endian mode will
-   be in use as default, or the big endian mode will be in use for all the
-   device registers.
+   - big-endian		: If this property is absent, the native endian mode
+			  will be in use as default, or the big endian mode
+			  will be in use for all the device registers.
 
 Example:
 
-- 
1.9.1
