From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 1/8] ASoC: fsl_esai: Add indentation for
	binding doc to increase readability
Date: Tue,  7 Oct 2014 12:29:04 -0700
Message-ID: <4695fdade8e76d91b7647471590bc96d970d15a9.1412708790.git.nicoleotsuka@gmail.com>
References: <cover.1412708790.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BBFD26050A
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 21:29:35 +0200 (CEST)
Received: by mail-pd0-f182.google.com with SMTP id y10so5574823pdj.13
 for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2014 12:29:34 -0700 (PDT)
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
 .../devicetree/bindings/sound/fsl,esai.txt         | 44 +++++++++++-----------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
index 52f5b6b..d3b6b5f 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
@@ -7,37 +7,39 @@ other DSPs. It has up to six transmitters and four receivers.
 
 Required properties:
 
-  - compatible : Compatible list, must contain "fsl,imx35-esai" or
-		 "fsl,vf610-esai"
+  - compatible		: Compatible list, must contain "fsl,imx35-esai" or
+			  "fsl,vf610-esai"
 
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
 
-  - clocks: Contains an entry for each entry in clock-names.
+  - clocks		: Contains an entry for each entry in clock-names.
 
-  - clock-names : Includes the following entries:
-	"core"		The core clock used to access registers
-	"extal"		The esai baud clock for esai controller used to derive
-			HCK, SCK and FS.
-	"fsys"		The system clock derived from ahb clock used to derive
-			HCK, SCK and FS.
+  - clock-names		: Includes the following entries:
+	"core"		  The core clock used to access registers
+	"extal"		  The esai baud clock for esai controller used to
+			  derive HCK, SCK and FS.
+	"fsys"		  The system clock derived from ahb clock used to
+			  derive HCK, SCK and FS.
 
-  - fsl,fifo-depth: The number of elements in the transmit and receive FIFOs.
-    This number is the maximum allowed value for TFCR[TFWM] or RFCR[RFWM].
+  - fsl,fifo-depth	: The number of elements in the transmit and receive
+			  FIFOs. This number is the maximum allowed value for
+			  TFCR[TFWM] or RFCR[RFWM].
 
   - fsl,esai-synchronous: This is a boolean property. If present, indicating
-    that ESAI would work in the synchronous mode, which means all the settings
-    for Receiving would be duplicated from Transmition related registers.
+			  that ESAI would work in the synchronous mode, which
+			  means all the settings for Receiving would be
+			  duplicated from Transmition related registers.
 
-  - big-endian : If this property is absent, the native endian mode will
-    be in use as default, or the big endian mode will be in use for all the
-    device registers.
+  - big-endian		: If this property is absent, the native endian mode
+			  will be in use as default, or the big endian mode
+			  will be in use for all the device registers.
 
 Example:
 
-- 
1.9.1
