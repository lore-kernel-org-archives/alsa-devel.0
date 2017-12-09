From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V3 1/2] dt-bindings: bcm283x: Fix register
	ranges of bcm2835-i2s
Date: Sat,  9 Dec 2017 12:26:34 +0100
Message-ID: <1512818795-1441-2-git-send-email-stefan.wahren@i2se.com>
References: <1512818795-1441-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id B6056266C72
 for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2017 12:27:40 +0100 (CET)
In-Reply-To: <1512818795-1441-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@martin.sperl.org, Matthias Reichl <hias@horus.com>, phil@raspberrypi.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
the bcm2835-i2s requires a clock as DT property. Unfortunately
the necessary DT change has never been applied. While we are at it
also fix the first PCM register range to cover the PCM_GRAY register.

This patch only fixes the affected dt-bindings.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 4 ++--
 Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
index baf9b34..b6a8cc0 100644
--- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
+++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
@@ -74,8 +74,8 @@ Example:
 
 bcm2835_i2s: i2s@7e203000 {
 	compatible = "brcm,bcm2835-i2s";
-	reg = <	0x7e203000 0x20>,
-	      < 0x7e101098 0x02>;
+	reg = <	0x7e203000 0x24>;
+	clocks = <&clocks BCM2835_CLOCK_PCM>;
 
 	dmas = <&dma 2>,
 	       <&dma 3>;
diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
index 65783de..7bb0362 100644
--- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
@@ -2,9 +2,8 @@
 
 Required properties:
 - compatible: "brcm,bcm2835-i2s"
-- reg: A list of base address and size entries:
-	* The first entry should cover the PCM registers
-	* The second entry should cover the PCM clock registers
+- reg: Should contain PCM registers location and length.
+- clocks: the (PCM) clock to use
 - dmas: List of DMA controller phandle and DMA request line ordered pairs.
 - dma-names: Identifier string for each DMA request line in the dmas property.
   These strings correspond 1:1 with the ordered pairs in dmas.
@@ -16,8 +15,8 @@ Example:
 
 bcm2835_i2s: i2s@7e203000 {
 	compatible = "brcm,bcm2835-i2s";
-	reg = <0x7e203000 0x20>,
-	      <0x7e101098 0x02>;
+	reg = <0x7e203000 0x24>;
+	clocks = <&clocks BCM2835_CLOCK_PCM>;
 
 	dmas = <&dma 2>,
 	       <&dma 3>;
-- 
2.7.4
